function collectValues(resultsFolderName,)

project_dir = pwd();     %or give a particular directory name
mainDirContents = dir(project_dir);
mainDirContents(~[MainDirContents.isdir]) = [];   %remove non-folders
mask = ismember( {MainDirContents.name}, {'.', '..'} );
mainDirContents(mask) = [];                       %remove . and .. folders
num_subfolder = length(mainDirContents);
for subfold_idx= 1 : num_subfolder
  this_folder = fullfile( project_dir, mainDirContents(subfold_idx).name );
    fprintf('Now working with folder "%s"\n', this_folder );
    at2Contents = dir( fullfile(this_folder, '*.AT2') );
    num_at2 = length(at2Contents);
    for at2idx = 1 : num_at2
       this_at2 = fullfile( this_folder, at2Contents(at2idx).name );
       now do something with the file whose complete name is given by this_at2
    end
  end