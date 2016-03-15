function [accuracy,Theta]=seelm(Phi,label,lambda)    
%     Phi=out;
    Y=label';
%     lambda=.5;

    Theta=lasso_train(Phi,Y,lambda);
    
    Y_predict=Phi'*Theta;
    Y_eelm=zeros(size(label));
    
    for i=1:length(Y_predict)
        if Y_predict(i)>.5
            Y_eelm(i)=1;
        end
    end
    
    right=0;
    for i=1:length(Y_predict)
        if Y_eelm(i)==label(i)
            right=right+1;
        end
    end
    accuracy=right/length(label);