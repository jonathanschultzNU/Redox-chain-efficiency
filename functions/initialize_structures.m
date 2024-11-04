function OUT = initialize_structures(OUT)

    % Output structure for plot-related data
    OUT.PLOT = struct();
    OUT.PLOT.RATES = struct();   % Store rate matrices for plotting
    OUT.IN.SUMMARY = struct();   % Summary of key outputs

    %% Initialize output arrays for simulation results

    temp = zeros(OUT.IN.deltaG_points,...
                 OUT.IN.R_points);
    OUT.Ef = temp;                      % Final energy
    OUT.QY = temp;                      % Quantum yield
    OUT.Er = temp;                      % Energy ratio
    OUT.EE = temp;                      % Energy efficiency
    OUT.incomplete_flag = temp;         % Flag for incomplete runs 
    OUT.popcheck = temp;                % Check final population sum
    OUT.kmats = cell(OUT.IN.deltaG_points,...
                     OUT.IN.R_points);  % Rate matrices

    temp = zeros(OUT.IN.deltaG_points+1,OUT.IN.R_points+1);
    temp(2:end,1) = -OUT.deltaG';   % DeltaG values for plotting
    temp(1,2:end) = OUT.R;          % Separation distances for plotting
    OUT.PLOT.QY = temp;             % Quantum yield
    OUT.PLOT.Er = temp;             % Energy ratio
    OUT.PLOT.EE = temp;             % Energy efficiency
    OUT.PLOT.RATES.kFET = temp;     % FET rate matrix
    OUT.PLOT.RATES.kBET = temp;     % BET rate matrix
    OUT.PLOT.RATES.k2G = temp;      % 2G rate matrix
    OUT.PLOT.RATES.k3G = temp;      % 3G rate matrix
    OUT.PLOT.RATES.k4G = temp;      % 4G rate matrix

    % Initialize population tracking if enabled
    if OUT.IN.save_populations == 1
        OUT.populations = cell(OUT.IN.deltaG_points,OUT.IN.R_points);
        OUT.tspan = logspace(OUT.IN.log_ti,OUT.IN.log_tf,OUT.IN.timepoints); 
    else
        OUT.tfinal = 10^OUT.IN.log_tf;
    end

end