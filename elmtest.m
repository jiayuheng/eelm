function [TestAccuracy]=elmtest(testdata,testlabel,numhiddern,numofclass,InputWeight,BiasofHiddenNeurons,OutputWeight)
NumberofOutputNeurons=numofclass;
NumberofTrainingData=length(testlabel);
NumberofInputNeurons= size(testdata,1);
%%
label=zeros(NumberofOutputNeurons, NumberofTrainingData);
for i = 1:NumberofTrainingData

        if(testlabel(i)==0)
            label(1,i)=-1;
        end
        if(testlabel(i)==1)
            label(2,i)=1;
        end


end

% InputWeight=rand(numhiddern,NumberofInputNeurons)*2-1;%output
% BiasofHiddenNeurons=rand(numhiddern,1);%output
tempH=InputWeight*testdata;
                                           %   Release input of training data 
ind=ones(1,NumberofTrainingData);
BiasMatrix=BiasofHiddenNeurons(:,ind);              %   Extend the bias matrix BiasofHiddenNeurons to match the demention of H
tempH=tempH+BiasMatrix;
H = 1 ./ (1 + exp(-tempH));%sigmodi function
OutputWeight=pinv(H') * label';   
Y=(H' * OutputWeight)'; 


MissClassificationRate_Training=0;


for i = 1 : size(testdata, 2)
    [x, label_index_expected]=max(abs(label(:,i)));
    [x, label_index_actual]=max(abs(Y(:,i)));
    if label_index_actual~=label_index_expected
        MissClassificationRate_Training=MissClassificationRate_Training+1;
    end
end

TestAccuracy=1-MissClassificationRate_Training/size(testdata,2);

