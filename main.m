%% example form elm homepage
% [TrainingTime, TestingTime, TrainingAccuracy, TestingAccuracy] = ELM('sinc_train', 'sinc_test', 0, 20, 'sig');
% ELM('diabetes_train', 'diabetes_test', 1, 20, 'sig')
%% data prepare for elm
clear
clc

train_data=load('diabetes_train');
traindata=train_data(:,2:size(train_data,2))';%  num of features *num of samples 
trainlabel=train_data(:,1)'; %1 * num of samples

test_data=load('diabetes_test');
testdata=test_data(:,2:size(test_data,2))';
testlabel=test_data(:,1)';

%% prepare data 
% the data matrix is numfeatures*numsamples; and the label vector is 1*numsamples
%step 1 separate label and data
%step 2 nomize data
%step 3 nomize label; the label is 0 or 1
%step 4 random pick train data and test data
[traindata,trainlabel,testdata,testlabel]=binaryuciprep('german');% get more information from "help binaryuciprep"
%% parameter setting
numhiddern=50;
numofclass=2;
%% train and test elm
Single=1;
if (Single ==1)
%     numhiddern=20;
%     numofclass=2;
    [InputWeight,BiasofHiddenNeurons,OutputWeight]=elmtrain(traindata,trainlabel,numhiddern,numofclass);
    [accuracy]=elmtest(traindata,trainlabel,numhiddern,numofclass,InputWeight,BiasofHiddenNeurons,OutputWeight);
    disp(['The testaccuracy of single elm is : ',num2str(accuracy)])
end


%% eelm train
%boostrip or not
N=50;
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
[eelmaccuracy,out]=eelmtest(traindata,trainlabel,numhiddern,numofclass,paraiw,parabh,paraow,N);
disp(['The trainaccuracy of eelm is : ',num2str(eelmaccuracy)])
disp(['And the num of weak classifier is : ',num2str(N)])
%% just select some of the classifiers based on diversity and see the result
%% select diversity elm and test the result by eelmtest
    % but how to select is a big issue, my method is based on diversity
    % and can choose the most diversity diversity models
    % another advantage is time saving than the ensenable elm method
    
    % baesd on output is a very direct method, but it cost lot of time.
% Theta=lasso_train(Phi,Y,lambda)
lambda=5;
Phi=out;
label=trainlabel;
[seelmaccuracy,Theta]=seelm(Phi,label,lambda); 
disp(['The trainaccuracy of seelm is : ',num2str(seelmaccuracy)])

[eelmaccuracy,testout]=eelmtest(testdata,testlabel,numhiddern,numofclass,paraiw,parabh,paraow,N);
disp(['The testaccuracy of eelm is : ',num2str(eelmaccuracy)])
Phi=testout;
label=testlabel;
[seelmaccuracy]=seelmtest(Phi,label,Theta); 
disp(['The testaccuracy of seelm is : ',num2str(seelmaccuracy)])



    
    
    