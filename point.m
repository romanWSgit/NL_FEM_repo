function [circle] = point(x_pos,y_pos)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
circle = rectangle('Curvature',[1 1]);
r = 0.15;
circle.Position = [(x_pos-r/2),(y_pos-r/2),r,r];
circle.EdgeColor = 'none';
circle.FaceColor = 'blue';
axis equal;


end

