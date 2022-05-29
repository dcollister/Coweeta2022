function matlabFileGrab()
   
list=dir('SimResults\**\2021*.mat')

foldersVectorholder={list.folder}.';
folders=unique({list.folder}.');

load('C:\Users\Victory Laptop\Desktop\Matlab Working Folder\IsingModel\SimResults\CoweetaCollection\');
 


end