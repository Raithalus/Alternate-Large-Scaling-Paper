load error.mat
%% Abs Error Bars SD of Sample Mean
n1 = 10
n2 = 11





for i = 1:length(L9e2)
L2e2a(i,1) = L2e2(i,1)^2
L9e2a(i,1) = L9e2(i,1)^2
e3abs(i,1) = sqrt((L2e2a(i)/n1)+(L9e2a(i)/n2))
    
%e3abs(i,1) = sqrt(((L2e2(i)^2)/n1)+((L9e2(i)^2)/n2));
end
%% Rel Error Bars SD of Sample Mean

for i = 1:50
e3rel(i,1) = sqrt(((L2e(i)^2)/n1)+((L9e(i)^2)/n2));
end

