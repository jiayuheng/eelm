% function [parahiddern,paraoutput]=elmtrain(traindata,trainlabel,numhiddern,numofclass)
function [InputWeight,BiasofHiddenNeurons,OutputWeight]=elmtrain(traindata,trainlabel,numhiddern,numofclass)
%% get the num of class


NumberofOutputNeurons=numofclass;
NumberofTrainingData=length(trainlabel);
NumberofInputNeurons= size(traindata,1);
%%
label=zeros(NumberofOutputNeurons, NumberofTrainingData);
for i = 1:NumberofTrainingData

    if(trainlabel(i)==0)
        label(1,i)=-1;
    end
    if(trainlabel(i)==1)
        label(2,i)=1;
    end

end

InputWeight=rand(numhiddern,NumberofInputNeurons)*2-1;%output
BiasofHiddenNeurons=rand(numhiddern,1);%output
tempH=InputWeight*traindata;
                                        
ind=ones(1,NumberofTrainingData);
BiasMatrix=BiasofHiddenNeurons(:,ind);              %   Extend the bias matrix BiasofHiddenNeurons to match the demention of H
tempH=tempH+BiasMatrix;
H = 1 ./ (1 + exp(-tempH));%sigmodi function
OutputWeight=pinv(H') * label';   
% Y=(H' * OutputWeight)'; 



% MissClassificationRate_Training=0;
% 
% 
% for i = 1 : size(traindata, 2)
%     [x, label_index_expected]=max(abs(label(:,i)));
%     [x, label_index_actual]=max(abs(Y(:,i)));
%     if label_index_actual~=label_index_expected
%         MissClassificationRate_Training=MissClassificationRate_Training+1;
%     end
% end
% 
% TrainingAccuracy=1-MissClassificationRate_Training/size(traindata,2)




