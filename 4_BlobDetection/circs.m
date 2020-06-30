function [h] = circs(x,y,r)
%CIRCS Plots circles at given center and radius
%   Uses the parametric equation of the circle and 
    hold on
    th = linspace(0,2*pi, 150);
    xunit = r * cos(th) + x;
    yunit = r * sin(th) + y;
    h = plot(yunit, xunit, 'r', 'LineWidth', 1.5);
    hold off
end

