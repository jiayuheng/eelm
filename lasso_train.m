function Theta=lasso_train(Phi,Y,lambda)
K=size(Phi,1)-1;
H=[Phi*Phi',-1*Phi*Phi';-1*Phi*Phi',Phi*Phi'];
f=lambda*ones(2*(K+1),1)-[Phi*Y;-1*Phi*Y];
b = zeros(2*(K+1),1);
A=-1*eye(2*(K+1));
x = quadprog(H,f,A,b);

Theta=x(1:K+1)-x(K+2:end);
% test lasso:
% Y_predict=Phi'*Theta;


% 
% function Theta=lasso_train(X,Y,lambda,K)
% Phi=[];
% for i_X=1:size(X,2)%num of sample
%     phi=[];
%     for i_k=0:K
%         phi=[phi,X(i_X)^i_k];
%         
%     end
%     phi=phi';
%     Phi=[Phi,phi];
%      
% end
% H=[Phi*Phi',-1*Phi*Phi';-1*Phi*Phi',Phi*Phi'];
% f=lambda*ones(2*(K+1),1)-[Phi*Y;-1*Phi*Y];
% b = zeros(2*(K+1),1);
% A=-1*eye(2*(K+1));
% x = quadprog(H,f,A,b);
% 
% Theta=x(1:K+1)-x(K+2:end);
