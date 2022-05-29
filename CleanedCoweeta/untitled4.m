clear all, clc, format compact, close all 

option = menu('Choose your case: y = mx + b',...
    'Enter (x1, y1) and (x2, y2); get m and b',...
    'Enter (x1, y1) and m; get b',...
    'Enter m, b and a value; get interpolated (val, y) and (x, val)'); 

  switch option
      case 1
          x1 = input('Enter x1 = ');
          y1 = input('Enter y1 = ');
          x2 = input('Enter x2 = ');
          y2 = input('Enter y2 = ');
          [m, b] = str_lin1(x1, y1, x2, y2)         

      case 2
          x1 = input('Enter x1 = ');
          y1 = input('Enter y1 = ');
          m = input('Enter m = ');
          b = str_lin2(x1, y1, m)          

      case 3
          m = input('Enter m = ');
          b = input('Enter b = ');
          v = input('Enter val = ');
          [x, y] = str_lin3(m, b, v);
          str = ['(' num2str(v) ', ' num2str(y) ')'];
          disp(str)
          str = ['(' num2str(x) ', ' num2str(v) ')'];
          disp(str)
  end        