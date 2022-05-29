function []=colorAndVectorCreation()
%% Colors for Graphing
                                red = [1, 0, 0];
                                pink = [255, 192, 203]/255;
                                orange=[251, 98, 5]/255;
                                green=[94 223 12]/255;
                                myBlue=[57 168 251]/255;
                                BirthBiVarDistBotCol=[0 0 255]/255;
                                BirthBiVarDistTopCol=[0 255 255]/255;
                                gray='#8A8A8A';
                                
                                colors{1}=red;
                                colors{2}=pink;
                                colors{3}=orange;
                                colors{4}=green;
                                colors{5}=myBlue;
                                colors{6}=BirthBiVarDistBotCol;
                                colors{7}=BirthBiVarDistTopCol;
                                colors{8}=gray;
                                
                                if ~isfile('ColorsForUse.mat')
                                    save('ColorsForUse.mat')
                                else
                                end
end