
clc
clear
close all
parameters=xlsread('house_prices_data_training_data.csv');
x=parameters(:,4:21);
m=length(parameters);
%fprintf('%i\n', X)
%fprintf('%i\n', m)

for i=1:18
%normalization
if(max(abs(x(:,i))~=0))
    x(:,i)=(x(:,i)-mean((x(:,i))))./std(x(:,i));
end
end



%calculate the data average value 
%calculate the data standard deviation 
%assume that the system pdf is multiplication of the features pdf 

% mean=mean(X);
% fprintf('%i\n', mean)
% 
% STD=std(X)
% fprintf('%i\n', STD)
% 
% anomaly=zeros(17999,1);
% prod=1;
% anomaly_deteced=0
% for j=1:21613
%  for i=1:18
%  pdf=normpdf(X(j,i),mean(i),STD(i));
%  prod=prod*pdf;
%     if(prod>0.999 || prod<0.000001)
%     %  fprintf('anomaly_detected');
%        anomaly(j,1)=1;
%       %anomaly_deteced=anomaly_deteced+1;
%     end
%  end
% end
% 
% anomalyd=0;
% for c=1:21613
%     if(anomaly(c,1)==1)
%           anomalyd=anomalyd+1;
%     end 
% end
% fprintf('%i\n', anomalyd)

%anomaly_indices=[];

%for i=1:m
 %   if(prod>1-epsilon || prod<epsilon)
    %  fprintf('anomaly_detected');
  %    anomaly_deteced=anomaly_deteced+1;
  %  end

%end
%fprintf('%i\n', anomalyc)
epsilon=0.001;

anomaly_deteced=0;
anomaly_indices=[];
for i=1:m
   for j=1:length(x(1,:))
        if(qfunc(x(i,j))<epsilon || qfunc(x(i,j))>1-epsilon)
            anomaly_deteced=anomaly_deteced+1;
            anomaly_indices=[anomaly_indices;i,j];
        end
   end
end
            fprintf('anomaly_detected');
