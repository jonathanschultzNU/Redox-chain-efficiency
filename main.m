% Redox chain efficiency simulation

% see README.md for all information pertaining to this code (e.g., inputs,
% outputs, etc.)

% Clear workspace and variables
clear
clear var

%% Add paths and load input data
addpath(genpath(pwd));

% Initialize structures to store input parameters and outputs
OUT = struct();
IN = load_input_data('input.txt');
OUT.IN = IN;

%% Define constants based on input parameters

OUT.hbar_s = 6.582*10^(-16);                    % Reduced Planck's constant [eV⋅s]
OUT.k_ESdecay = 10^IN.log_kESdecay;     % Excited-state decay rate [s^-1]
OUT.k_sink = 10^IN.log_ksink;           % Sink rate [s^-1]

% Cofactor diameter calculation
OUT.d_c = 2*IN.bond_length/(2*sin(pi/(IN.atoms-1)));

% Define ranges for inter-cofactor separations and deltaG values
OUT.R = linspace(IN.R_min,IN.R_max,IN.R_points);                        % [A]
OUT.deltaG = linspace(IN.deltaG_max,IN.deltaG_min,IN.deltaG_points);    % [eV] Driving force for FET is -deltaG^(0)

% Initialize output arrays for simulation results
OUT = initialize_structures(OUT);

% Initial population vector (for ground and excited states) (eq S2)
OUT.p0 = [0; 1; 0; 0; 0; 0]; 

%% Main simulation loop over inter-cofactor separations (R) and driving forces (deltaG)

count = 1;
for j = 1:numel(OUT.R)
    % Calculate distances (Rij) between states i and j (eq S5)
    R_12 = OUT.R(j);    R_23 = OUT.R(j);    R_34 = OUT.R(j);
    R_2G = OUT.R(j);
    R_3G = 2*OUT.R(j) + 1*(OUT.d_c);  
    R_4G = 3*OUT.R(j) + 2*(OUT.d_c); 
    
    % Calculate couplings (Vij) between states i and j (eq 4)
    V12 = Vij(IN.V0, IN.atoms, IN.beta, R_12);
    V23 = Vij(IN.V0, IN.atoms, IN.beta, R_23);
    V34 = Vij(IN.V0, IN.atoms, IN.beta, R_34);
    V2G = Vij(IN.V0, IN.atoms, IN.beta, R_2G);
    V3G = Vij(IN.V0, IN.atoms, IN.beta, R_3G);
    V4G = Vij(IN.V0, IN.atoms, IN.beta, R_4G);

    
    % Calculate rate prefactors for each coupling
    A12 = Aij(OUT.hbar_s, IN.lambda_c, IN.kbT, V12); 
    A23 = Aij(OUT.hbar_s, IN.lambda_c, IN.kbT, V23); 
    A34 = Aij(OUT.hbar_s, IN.lambda_c, IN.kbT, V34);
    A21 = A12;         A32 = A23;         A43 = A34;
    A2G = Aij(OUT.hbar_s, IN.lambda_c, IN.kbT, V2G); 
    A3G = Aij(OUT.hbar_s, IN.lambda_c, IN.kbT, V3G); 
    A4G = Aij(OUT.hbar_s, IN.lambda_c, IN.kbT, V4G);

    for i = 1:numel(OUT.deltaG)
         % Calculate final energy
        OUT.Ef(i,j) = IN.Ei+3*OUT.deltaG(i);  % three hops (four cofactors)
        
        % Initialize rates for each transition
        k12 = 0; k23 = 0; k34 = 0; 
        k21 = 0; k32 = 0; k43 = 0;
        k2G = 0; k3G = 0; k4G = 0;

        % Sum contributions to rates over vibrational quanta
        for n=0:IN.quanta
            k12 = k12 + kij(A12, IN.S, n, OUT.deltaG(i), IN.lambda_c, IN.vibfreq, IN.kbT);
            k23 = k23 + kij(A23, IN.S, n, OUT.deltaG(i), IN.lambda_c, IN.vibfreq, IN.kbT);
            k34 = k34 + kij(A34, IN.S, n, OUT.deltaG(i), IN.lambda_c, IN.vibfreq, IN.kbT);
            k21 = k21 + kij(A21, IN.S, n, -OUT.deltaG(i), IN.lambda_c, IN.vibfreq, IN.kbT);
            k32 = k32 + kij(A32, IN.S, n, -OUT.deltaG(i), IN.lambda_c, IN.vibfreq, IN.kbT);
            k43 = k43 + kij(A43, IN.S, n, -OUT.deltaG(i), IN.lambda_c, IN.vibfreq, IN.kbT);
            k2G = k2G + kij(A2G, IN.S, n, -IN.Ei-OUT.deltaG(i), IN.lambda_c, IN.vibfreq, IN.kbT);
            k3G = k3G + kij(A3G, IN.S, n, -IN.Ei-2*OUT.deltaG(i), IN.lambda_c, IN.vibfreq, IN.kbT);
            k4G = k4G + kij(A4G, IN.S, n, -IN.Ei-3*OUT.deltaG(i), IN.lambda_c, IN.vibfreq, IN.kbT);
        end

        % Log the rates for plotting
        OUT.PLOT.RATES.kFET(i+1,j+1) = k12;
        OUT.PLOT.RATES.kBET(i+1,j+1) = k21;
        OUT.PLOT.RATES.k2G(i+1,j+1) = k2G;
        OUT.PLOT.RATES.k3G(i+1,j+1) = k3G;
        OUT.PLOT.RATES.k4G(i+1,j+1) = k4G;
        
        % Set up rate matrix for population evolution (eq S3)
        kmat = [0, OUT.k_ESdecay, k2G, k3G, k4G, 0;
                0, -OUT.k_ESdecay-k12, k21, 0, 0, 0;
                0, k12, -k21-k23-k2G, k32, 0, 0;
                0, 0, k23, -k32-k34-k3G, k43, 0;
                0, 0, 0, k34, -k43-OUT.k_sink-k4G, 0;
                0, 0, 0, 0, OUT.k_sink, 0];
        
        % Population evolution (solve for dynamics or last time point)
        tic
        if IN.save_populations == 1
            pop = zeros(6,IN.timepoints);
            pop(:,1) = OUT.p0;
            for b = 2:IN.timepoints
                pop(:,b) = expm(kmat*OUT.tspan(b))*OUT.p0;
                pop(:,b) = pop(:,b)./sum(pop(:,b));  % ensure total population = 1 after each iteration
            end
        else
            pop = expm(kmat*OUT.tfinal)*OUT.p0;
            pop = pop./sum(pop); % Normalize population
        end
        runtime = toc;
        
        % Check if steady-state is reached
        OUT.popcheck(i,j) = sum(pop(:,end));
        if pop(6,end)+pop(1,end) < 0.999   
           OUT.incomplete_flag(i,j) = 1;
        end
        
         % Store output quantities
        OUT.QY(i,j) = pop(6,end);
        OUT.Er(i,j) = OUT.Ef(i,j)/IN.Ei;
        OUT.EE(i,j) = pop(6,end)*OUT.Er(i,j);
        OUT.kmats{i,j} = kmat;

        if IN.save_populations == 1
            OUT.populations{i,j} = pop';
        end
        
        % Print simulation progress and results
        summarize_progress(OUT,i,j,count)
        count = count+1;
    end
end

% Finalize and save results
OUT.PLOT.QY(2:end,2:end) = OUT.QY;
OUT.PLOT.Er(2:end,2:end) = OUT.Er;
OUT.PLOT.EE(2:end,2:end) = OUT.EE;

% Find the indices and values for maximum energy efficiency
OUT.SUMMARY.EE_max = max(OUT.EE(:));
[row, col] = find(OUT.EE == OUT.SUMMARY.EE_max);
OUT.SUMMARY.deltaG_EEmax = OUT.deltaG(row);
OUT.SUMMARY.R_EE_max = OUT.R(col);

% Display summary of the results
summarize_results(OUT)

% Save results to a .mat file
if IN.save_results == 1
    disp('Saving data...')
    save(strcat('./Outputs/', IN.file_name, '.mat'),'OUT','-mat');
    disp('Data saved!')
end

if IN.plot_results == 1
    plot_results(OUT, strcat('./Outputs/', IN.file_name, '.png'));
end

disp('Complete! Exiting...')
