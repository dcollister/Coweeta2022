%% Found @ https://www.delftstack.com/howto/matlab/plot-frequency-distribution-curves-of-your-data-in-matlab/

%% https://www.mathworks.com/matlabcentral/fileexchange/24913-histogram-binwidth-optimization
function [statsDataPackage]=findTheKernelKenny(Our_data)
pdNormal = fitdist(Our_data,'Normal');
pdPoisson = fitdist(Our_data,'Poisson');
Our_data_pdf = [min(Our_data):max(Our_data)];
yNorm = pdf(pdNormal,Our_data_pdf);
yPoisson = pdf(pdPoisson,Our_data_pdf);

statsDataPackage={pdNormal,yNorm;pdPoisson,yPoisson};
end