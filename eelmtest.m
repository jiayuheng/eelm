function [TestAccuracy,label_index_model]=eelmtest(testdata,testlabel,numhiddern,numofclass,paraiw,parabh,paraow,N)
NumberofOutputNeurons=numofclass;
NumberofTestingData=length(testlabel);
NumberofInputNeurons= size(testdata,1);
%%
label=zeros(NumberofOutputNeurons, NumberofTestingData);
for i = 1:NumberofTestingData
%     for j = 1:number_class
        if(testlabel(i)==0)
            label(1,i)=-1;
        end
        if(testlabel(i)==1)
            label(2,i)=1;
        end

%     end
end
eelmy=[];
for i=1:N
   InputWeight=paraiw(:,:,i);
   BiasofHiddenNeurons=parabh(:,i);
   OutputWeight=paraow(:,:,i);
    
    tempH=InputWeight*testdata;
                                           %   Release input of training data 
    ind=ones(1,NumberofTestingData);
    BiasMatrix=BiasofHiddenNeurons(:,ind);              %   Extend the bias matrix BiasofHiddenNeurons to match the demention of H
    tempH=tempH+BiasMatrix;
    H = 1 ./ (1 + exp(-tempH));%sigmodi function
    OutputWeight=pinv(H') * label';   
    Y=(H' * OutputWeight)'; 
    eelmy(:,:,i)=Y;
end

MissClassificationRate_Training=0;
Y=sum(eelmy,3);%test different ensemble method here

for i = 1 : size(testdata, 2)
    [x, label_index_expected]=max(abs(label(:,i)));
    [x, label_index_actual]=max(abs(Y(:,i)));
    if label_index_actual~=label_index_expected
        MissClassificationRate_Training=MissClassificationRate_Training+1;
    end
end
%% output every weak classifier
label_index_model=zeros(N,NumberofTestingData);
for i=1:N
    [x, label_index_model(i,:)]=max(abs(eelmy(:,:,i)));
end
% label
%%
TestAccuracy=1-MissClassificationRate_Training/size(testdata,2);





