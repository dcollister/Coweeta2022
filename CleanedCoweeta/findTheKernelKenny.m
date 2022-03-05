%% Found @ https://www.delftstack.com/howto/matlab/plot-frequency-distribution-curves-of-your-data-in-matlab/

%% https://www.mathworks.com/matlabcentral/fileexchange/24913-histogram-binwidth-optimization
function findTheKernelKenny(agentInfoMat)
Our_data=agentInfoMat.deathDist;
pdNormal = fitdist(Our_data,'Normal');
pdPoisson = fitdist(Our_data,'Poisson');
Our_data_pdf = [min(Our_data):max(Our_data)];
yNorm = pdf(pdNormal,Our_data_pdf);
yPoisson = pdf(pdPoisson,Our_data_pdf);
 
t = tiledlayout(3,2);
nexttile
histogram(Our_data,'Normalization','pdf')
line(Our_data_pdf,yNorm)
nexttile
qqplot(Our_data,yNorm)
nexttile
histogram(Our_data,'Normalization','pdf')
line(Our_data_pdf,yPoisson)
nexttile
qqplot(Our_data,yPoisson)
nexttile
plot(x,y3)
nexttile
plot(x,y4)

t.Padding = 'compact';
t.TileSpacing = 'compact';


figure
t = tiledlayout(2,2);
histogram(Our_data,'Normalization','pdf')
line(Our_data_pdf,yNorm)
A = icdf(pdNormal,0.9);
B = icdf(pdNormal,0.1);
optN=sshist(Our_data);
% [optN, CssOut, NssOut]=sshist(Our_data);
[N,Center] = hist(Our_data);
[Nop,Cop] = hist(Our_data,optN);
[f,xi] = ksdensity(Our_data,Cop);
dNom1 = mode(diff(Center));
dNom2 = mode(diff(Cop));
t = tiledlayout(2,2);
ax1=nexttile;
histogram(Our_data,optN,'BinLimits',[min(Our_data),max(Our_data)],'Normalization','probability','BinMethod','auto');
nexttile;
histogram(Our_data,'Normalization','pdf');

plot(ax1,CssOut,N/dNom1,'.-')
ax2=nexttile;
plot(ax2,Center,N/dNom1,'.-')
title(ax1,'Default')
ax1.FontSize = 14;
ax1.XColor = 'red';
nexttile
plot(Cop,Nop/dNom2,'.-')
nexttile([1 2])
plot(xi,f*length(Our_data),'.-')

% [M,C] = hist(Our_data);
legend('','Optimum','ksdensity')
title('Frequency Distribution')
title(t,'My Title')
xlabel(t,'x-values')
ylabel(t,'y-values')
t.Padding = 'compact';
t.TileSpacing = 'compact';
end