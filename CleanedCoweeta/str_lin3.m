function [x, y] = str_lin3(m, b, val)
y = m*val + b;
x = (val - b) / m;
