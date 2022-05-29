function sq=getminkgrp(x,v)
% returns the group variable sequence associated with the n maxk values of x
  n=1;
  [mx,ix]=mink(x,n);
  sq=v(ix);
end