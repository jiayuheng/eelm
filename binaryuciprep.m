function [traindata,trainlabel,testdata,testlabel]=binaryuciprep(dataname)
% function binaryuciprep read data form commom uci dataset for eelm 
% usage: [traindata,trainlabel,testdata,testlabel]=binaryuciprep(dataname)
% dataname is the name of different uci set
% data list is as follows:
% australian
% breast
% bupa
% cancer
% CT
% german
% habeman
% heart
% ionosphere
% pima
% plrx
% sonar
% spam
% SPECTF
% transfusion
% wdbc
% wpbc

% spe data and label
load('data_binary_uniform.mat');
dataset=eval(dataname);
[numsamples,numfeatures]=size(dataset);
numfeatures=numfeatures-1;
label=dataset(:,numfeatures+1);
data=dataset(:,1:numfeatures);

%normize data and label
for i=1:numfeatures
    data(:,i)=data(:,i)/max(data(:,i));
end
for i=1:numsamples
    if label(i)==-1
        label(i)=0;
    end
end


%60 % is use as trian set
idx=randperm(numsamples);
idxsep=round(numsamples*.6);

% get trian data and test data
traindata=data(idx(1:idxsep),:);
traindata=traindata';
trainlabel=label(idx(1:idxsep))';
testdata=data(idx(idxsep+1:end),:);
testdata=testdata';
testlabel=label(idx(idxsep+1:end))';

