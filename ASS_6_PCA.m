clc
clear
close all
%normalization?

parameters=xlsread('house_prices_data_training_data.csv');
target=parameters(:,3);
%normalize el output//price
target_norm=(target-mean(target))./std(target);
m=length(parameters);
% Assume that the input data set of the house data (column 4 to column 21) is equal to x  
x=parameters(:,4:21);
 for w=1:18
    if max(abs(x(:,w)))~=0
%normalize lel parameters
    x(:,w)=(x(:,w)-mean((x(:,w))))./std(x(:,w));
    end
 end
%Calculate the covariance matrix using “cov” function 
Corr_x=corr(x);
x_cov=cov(x);
%Matlab SVD function to identify the principal components of the House prices data set using the cov of the house data set  
[U S V] =  svd(x_cov);
%if normalization done here, k iwll get smaller// normalization ala
%correlation
% 	Use the EigenValue produced from the SVD function to find K where K is the minimum number of dimensions that can be used to describe a house. This will reduce the number of dimensions from m to K 
%EigenValues =[?_1  ?_2   ?_3…….?_m ]
%Where m  is the number of dimensions? 
%The Eigen values are the diagonal of the matrix S 

%Hint (calculate  ?= 1-(?_(i=1)^(i=K )??_i )/(?_(i=1)^(i=m )??_i ) and find K that would make ?? 0.001)
%pca
alpha=1;
K=0;
di=diag(S);
sum_n=trace(S);
while(alpha>=0.001)
     K=K+1;
    trial = di(1:K);
    sum_k=sum(trial);
    alpha=1-sum_k/sum_n;
   
end
	%Use the Eigen vectors to transform the data set to the reduced dimension data set 
%Reduced_Data=R= U(:,1:K)^T x^T

R=U(:,1:K)'*x';
%7-	Use the Eigen vector to produce an approximate data out of the reduced data by multiplying by the Eigen vectors matrix. 
x_apx=U(:,1:K)*R;   
x_apx=x_apx';

%	Estimate the error in the data produced by the dimension reduction 
%Error = 1/m ?_1??(approximate data-Reduced_Data)?

error_dataset=(1/m)*sum(sum((x-x_apx).^2));
%9-	Use linear regression to estimate house prices based on the data set produced using principal component analysis. 
R=R';
p=[ones(m,1) R];
n=length(p(1,:));
theta=zeros(n,1);
alpha=0.1;
 iter=1;
 error(iter)=(1/(2*m))*sum((p*theta-target_norm).^2);
 converged=0
 while (converged~=1)
     theta=theta-(alpha/m)*p'*(p*theta-target_norm);
     iter=iter+1
     error(iter)=(1/(2*m))*sum((p*theta-target_norm).^2);
    
      if error(iter-1)-error(iter)<0
          
    break
end 
q=(error(iter-1)-error(iter))./error(iter-1)
if q <.000001;
    converged=1;
end
  
 end

    
