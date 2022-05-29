%%https://towardsdatascience.com/directory-of-csvs-to-matlab-structure-ff761462ff2f
function configurationObject = structifyCSV(entry_path)
    configurationObject = struct;d_struct = dir(entry_path);
    for i=1:length(d_struct)
        if d_struct(i).isdir==0 && contains(d_struct(i).name,'.csv')
            d = readtable([d_struct(i).folder '\' d_struct(i).name]);
            configurationObject.(strrep(d_struct(i).name,'.csv',''))=d;
        elseif d_struct(i).isdir==1 && ~ismember(d_struct(i).name,{'.','..'}) % Go deeper
            co = structifyCSV([d_struct(i).folder '\' d_struct(i).name]);  % RECUR (1)
            configurationObject.(d_struct(i).name)=co;
        end
    end
end