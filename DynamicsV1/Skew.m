function [Y] = Skew(X)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

    Y = [   0   -X(3)  X(2);
          X(3)     0  -X(1);
         -X(2)   X(1)    0];


end
