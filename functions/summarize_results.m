function summarize_results(OUT)

    % Final check for incomplete iterations
    if any(any(OUT.incomplete_flag))
       disp('!!!!! WARNING: at least one iteration has incomplete kinetics !!!!!')
    else
       disp('Normal termination (all runs reached steady-state)!')
    end

    disp('~~~~~ SUMMARY ~~~~~~')
    disp(['Maximum energy efficiency: ' num2str(OUT.SUMMARY.EE_max)])
    disp(['                     Beta: ' num2str(OUT.IN.beta)])
    disp(['                    Atoms: ' num2str(OUT.IN.atoms)])
    disp(['        Cofactor diameter: ' num2str(OUT.d_c)])
    disp(['    Huang-Rhys factor (S): ' num2str(OUT.IN.S)])
    disp(['         deltaG at max EE: ' num2str(OUT.SUMMARY.deltaG_EEmax) ' eV'])
    disp(['              R at max EE: ' num2str(OUT.SUMMARY.R_EE_max) ' A'])
    disp('-------------------------------------------')

end