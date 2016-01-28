%% example form elm homepage
% [TrainingTime, TestingTime, TrainingAccuracy, TestingAccuracy] = ELM('sinc_train', 'sinc_test', 0, 20, 'sig');
% ELM('diabetes_train', 'diabetes_test', 1, 20, 'sig')
%% data prepare for elm
clear
clc

train_data=load('diabetes_train');
traindata=train_data(:,2:size(train_data,2))';% num of samples * num of features
trainlabel=train_data(:,1)'; %1 * num of samples

test_data=load('diabetes_test');
testdata=test_data(:,2:size(test_data,2))';
testlabel=test_data(:,1)';

%% train and test elm
numhiddern=20;
numofclass=2;
[InputWeight,BiasofHiddenNeurons,OutputWeight]=elmtrain(traindata,trainlabel,numhiddern,numofclass);
[accuracy]=elmtest(testdata,testlabel,numhiddern,numofclass,InputWeight,BiasofHiddenNeurons,OutputWeight);


%% eelm train
%boostrip or not
N=20;
paraiw=[];
parabh=[];
paraow=[];
for i=1:N
   %boostrip or not
   % boostrip 
   % get X and Y from train and test label;
   X=traindata;
   Y=trainlabel;
   [InputWeight,BiasofHiddenNeurons,OutputWeight]=elmtrain(X,Y,numhiddern,numofclass);
   paraiw(:,:,i)=InputWeight;
   parabh(:,i)=BiasofHiddenNeurons;
   paraow(:,:,i)=OutputWeight;
end

%% test eelm alogorithm 
eelmtest(testdata,testlabel,numhiddern,numofclass,paraiw,parabh,paraow)
    
    
    
    
    
    
    