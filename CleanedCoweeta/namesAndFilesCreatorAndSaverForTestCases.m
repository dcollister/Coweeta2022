function [testFileFolder,testSaveFolder,testFigSaveFolder,testImagesSaveFolder,testTableSaveFolder] = namesAndFilesCreatorAndSaverForTestCases(singleHomoSwitch)
    
        testFileInfoFolderHolder{1}='CollectedValues\Test1stLevel\Coweeta\Whole\FirstOrder\Riv_Single_Branch_6\Mouth\';
        testFileInfoFolderHolder{2}='CollectedValues\Test1stLevel\Coweeta\Whole\Complete\Riv_All\Homo\';
        testFileSaveFolderHolder{1}='ProcessedValues\Test1stLevel\Coweeta\Whole\FirstOrder\Riv_Single_Branch_6\Mouth\';
        testFileSaveFolderHolder{2}='ProcessedValues\Test1stLevel\Coweeta\Whole\Complete\Riv_All\Homo\';
        testFigSaveFolderHolder{1}='Figures\Test1stLevel\Riv_Single_Branch_6\Mouth\';
        testFigSaveFolderHolder{2}='Figures\Test1stLevel\Homo\';
        testImagesFolderHolder{1}='Images\Test1stLevel\Riv_Single_Branch_6\Mouth\';
        testImagesFolderHolder{2}='Images\Test1stLevel\Homo\';
        testTableFolderHolder{1}='Table\Test1stLevel\Riv_Single_Branch_6\Mouth\';
        testTableFolderHolder{2}='Table\Test1stLevel\Homo\';
        
        
        testFileFolder=testFileInfoFolderHolder{singleHomoSwitch};
            if ~exist(testFileFolder,'dir')
                mkdir(testFileFolder)
            end
            
            testSaveFolder=testFileSaveFolderHolder{singleHomoSwitch};
            if ~exist(testSaveFolder,'dir')
                mkdir(testSaveFolder)
            end
            
            testFigSaveFolder=testFigSaveFolderHolder{singleHomoSwitch};
            if ~exist(testFigSaveFolder,'dir')
                mkdir(testFigSaveFolder)
            end
            
            testImagesSaveFolder=testImagesFolderHolder{singleHomoSwitch};
            if ~exist(testImagesSaveFolder,'dir')
                mkdir(testImagesSaveFolder)
            end
            
            testTableSaveFolder=testTableFolderHolder{singleHomoSwitch};
            if ~exist(testImagesSaveFolder,'dir')
                mkdir(testTableSaveFolder)
            end