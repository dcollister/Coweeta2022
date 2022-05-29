%https://www.mathworks.com/matlabcentral/answers/9567-is-it-possible-split-a-structure
function matlabFileGrab()
SearchContainingFolder='SimResults\';
[unfilteredStructure]=rawMatGrab(SearchContainingFolder);

filterStruc(unfilteredStructure);
% [fileLocStruct]=1
end