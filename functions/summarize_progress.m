function summarize_progress(OUT,i,j,count)

    if OUT.IN.print_outputs == 1        % Print all
        disp(['Step number ' num2str(count) ' of ' ...
              num2str(OUT.IN.deltaG_points*OUT.IN.R_points)])
        disp(['Iteration (deltaG,R) = (' num2str(-OUT.deltaG(i)) ...
              ' eV, ' num2str(OUT.R(j)) ' A):'])
    
        if OUT.incomplete_flag(i,j) == 1
            disp('!! WARNING: steady-state not reached !!')
        end
    
        disp(['Total population at final time: ' num2str(OUT.popcheck(i,j))])
        disp(['Population distribution at final time: ' num2str(pop(:,end)')])
        disp(['    Quantum yield: ' num2str(OUT.QY(i,j))])
        disp(['     Energy ratio: ' num2str(OUT.Er(i,j))])
        disp(['Energy efficiency: ' num2str(OUT.EE(i,j))])
        disp(['          Runtime: ' num2str(runtime) ' seconds'])
        disp('-------------------------------------------')
    
    else    % Just print progress and flags
        if mod(count, 50) == 0
            disp(['Step number ' num2str(count) ' of ' num2str(OUT.IN.deltaG_points*OUT.IN.R_points)])
        elseif OUT.incomplete_flag(i,j) == 1
            disp('-------------------------------------------')
            disp(['Step number ' num2str(count) ' of ' num2str(OUT.IN.deltaG_points*OUT.IN.R_points)])
            disp(['Iteration (deltaG,R) = (' num2str(-OUT.deltaG(i)) ' eV, ' num2str(OUT.R(j)) ' A):'])
            disp('!! WARNING: steady-state not reached !!')
            disp(['Population distribution at final time: ' num2str(pop(:,end)')])
            disp('-------------------------------------------')
        end
    end

end