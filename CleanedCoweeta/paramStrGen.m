function [ETstr, RTstr, PDstr, PBstr]=paramStrGen(parameterValues)

if parameterValues(1)>=100
    ETstr=strcat('ET Very Noisy.');
elseif 100>parameterValues(1) && parameterValues(1)>=1
    ETstr=strcat('ET Medium Noise.');
elseif 1>parameterValues(1) && parameterValues(1)>=0.01
    ETstr=strcat('ET Low Noise.' );
elseif 0.1>parameterValues(1)
    ETstr=strcat('ET Highly Impactful.');
end


if parameterValues(2)>=100
    RTstr=strcat(' RT Very Noisy.');
elseif 100>parameterValues(2) && parameterValues(2)>=1
    RTstr=strcat(' RT Medium Noise.');
elseif 1>parameterValues(2) && parameterValues(2)>=0.01
    RTstr=strcat(' RT Low Noise.');
elseif 0.1>parameterValues(2)
    RTstr=strcat(' RT Highly Impactful.');
end


if parameterValues(3)>=0.1
    PDstr=strcat(' Extremely Lethal Environment.');
elseif parameterValues(3)<0.1 && parameterValues(3)>=0.01
    PDstr=strcat(' Moderately Lethal Environment.');
elseif parameterValues(3)<0.01 && parameterValues(3)>=0.0001
    PDstr=strcat(' Slightly Lethal Environment.');
elseif 0.0001>parameterValues(3)
    PDstr=strcat(' Extreme Longevity.', num2str(parameterValues(3)),'.');
end


if parameterValues(4)>=0.1
    PBstr=strcat(' Extremely Fertile Agents.');
elseif parameterValues(4)<0.1 && parameterValues(4)>=0.01
    PBstr=strcat(' Moderately Fertile Agents.');
elseif parameterValues(4)<0.01 && parameterValues(4)>=0.0001
    PBstr=strcat(' Slightly Fertile Agents.');
elseif 0.0001>parameterValues(4)
    PBstr=strcat(' Highly Sterile Population.');
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% if parameterValues(1)>=100
%     ETstr=strcat('ET Very Noisy: ', num2str(parameterValues(1)),'.');
% elseif 100>parameterValues(1) && parameterValues(1)>=1
%     ETstr=strcat('ET Medium Noise: ', num2str(parameterValues(1)),'.');
% elseif 1>parameterValues(1) && parameterValues(1)>=0.01
%     ETstr=strcat('ET Low Noise: ', num2str(parameterValues(1)),'.' );
% elseif 0.1>parameterValues(1)
%     ETstr=strcat('ET Highly Impactful: ', num2str(parameterValues(1)));
% end
% 
% 
% if parameterValues(2)>=100
%     RTstr=strcat(' RT Very Noisy: ', num2str(parameterValues(2)),'.');
% elseif 100>parameterValues(2) && parameterValues(2)>=1
%     RTstr=strcat(' RT Medium Noise: ', num2str(parameterValues(2)),'.');
% elseif 1>parameterValues(2) && parameterValues(2)>=0.01
%     RTstr=strcat(' RT Low Noise: ', num2str(parameterValues(2)),'.');
% elseif 0.1>parameterValues(2)
%     RTstr=strcat(' RT Highly Impactful: ', num2str(parameterValues(2)),'.');
% end
% 
% 
% if parameterValues(3)>=0.1
%     PDstr=strcat(' Extremely Lethal Environment. PD:', num2str(parameterValues(3)),'.');
% elseif parameterValues(3)<0.1 && parameterValues(3)>=0.01
%     PDstr=strcat(' Moderately Lethal Environment. PD:: ', num2str(parameterValues(3)),'.');
% elseif parameterValues(3)<0.01 && parameterValues(3)>=0.0001
%     PDstr=strcat(' Slightly Lethal Environment. PD:: ', num2str(parameterValues(3)),'.');
% elseif 0.0001>parameterValues(3)
%     PDstr=strcat(' Extreme Longevity. PD:', num2str(parameterValues(3)),'.');
% end
% 
% 
% if parameterValues(4)>=0.1
%     PBstr=strcat(' Extremely Fertile Agents. PB:', num2str(parameterValues(4)),'.');
% elseif parameterValues(4)<0.1 && parameterValues(4)>=0.01
%     PBstr=strcat(' Moderately Fertile Agents. PB: ', num2str(parameterValues(4)),'.');
% elseif parameterValues(4)<0.01 && parameterValues(4)>=0.0001
%     PBstr=strcat(' Slightly Fertile Agents. PB: ', num2str(parameterValues(4)),'.');
% elseif 0.0001>parameterValues(4)
%     PBstr=strcat(' Highly Sterile Population. PB:', num2str(parameterValues(4)),'.');
% end