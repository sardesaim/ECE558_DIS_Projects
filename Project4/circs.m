function [h] = circs(x,y,r)
%CIRCS Summary of this function goes here
%   Detailed explanation goes here
    hold on
    th = linspace(0,2*pi, 150);
    xunit = r * cos(th) + x;
    yunit = r * sin(th) + y;
    h = plot(xunit, yunit, 'r', 'LineWidth', 1.5);
    hold off
end

