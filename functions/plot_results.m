function plot_results(OUT, filename)
    %% Plot results
    
    % Create a figure
    fig = figure('Visible', 'off');

    % Set the position and size of the figure
    fig.Position = [100, 100, 1500, 600];  % [left, bottom, width, height]

    % Create the first subplot (left side)
    subplot(1, 2, 1);  % 1 row, 2 columns, first subplot
    pcolor(OUT.R, -OUT.deltaG, OUT.QY);  
    shading interp;
    colorbar;
    colormap('jet');
    clim([0 1])
    xlabel('R (Å)', 'FontSize', 18);
    ylabel('-\DeltaG^{(0)}', 'FontSize', 18);
    title('Quantum yield', 'FontSize', 18);

    % Increase the font size of the x-axis and y-axis ticks
    ax1 = gca;  % Get the current axes handle
    ax1.XAxis.FontSize = 16;  % Set font size for x-axis ticks
    ax1.YAxis.FontSize = 16;  % Set font size for y-axis ticks
    ax1.YDir = 'reverse';  % Flip y-axis

    % Create the second subplot (right side)
    subplot(1, 2, 2);  % 1 row, 2 columns, second subplot
    pcolor(OUT.R, -OUT.deltaG, OUT.EE);  % Plot for the second 2D array
    shading interp;
    colorbar;
    colormap('jet');
    clim([0 1])
    xlabel('R (Å)', 'FontSize', 18);
    ylabel('-\DeltaG^{(0)}', 'FontSize', 18);
    title('Energy efficiency', 'FontSize', 18);

    % Increase the font size of the x-axis and y-axis ticks
    ax2 = gca;  % Get the current axes handle
    ax2.XAxis.FontSize = 16;  % Set font size for x-axis ticks
    ax2.YAxis.FontSize = 16;  % Set font size for y-axis ticks
    ax2.YDir = 'reverse';  % Flip y-axis

    % Set the desired size for saving (in inches)
    fig.PaperUnits = 'inches';
    fig.PaperPosition = [0, 0, 8.5, 4];  % [left, bottom, width, height] in inches

    % Save the figure as a PNG with the specified size
    print(fig, filename, '-dpng', '-r300');  % '-r300' is the resolution in DPI
    disp('Plot saved!')

    close(fig);
end