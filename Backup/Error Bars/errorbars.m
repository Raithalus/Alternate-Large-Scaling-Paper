close all; clear all; clc;
load error.mat
%% Abs Error Bars SD of Sample Mean
n1 = 10 % Line 2.49.3
n2 = 11 % Line 9.31.2
% <B> = 
% <L> = 


for i = 1:length(L9e2)
L2e2a(i,1) = L2e2(i,1)*L2e2(i,1)
L9e2a(i,1) = L9e2(i,1)*L9e2(i,1)

L2e2b(i,1) = L2e2a(i,1)/n1
L9e2b(i,1) = L9e2a(i,1)/n2

e3abs(i,1) = sqrt(L2e2b(i,1)+L9e2b(i))


e3abs2(i,1) = e3abs(i,1)/Bmeanabs(i,1)

    
%e3abs(i,1) = sqrt(((L2e2(i)^2)/n1)+((L9e2(i)^2)/n2));
end
%% Rel Error Bars SD of Sample Mean

for i = 1:50
e3rel(i,1) = sqrt(((L2e(i)^2)/n1)+((L9e(i)^2)/n2));
e3rel2(i,1) = e3rel(i,1)/Bmeanrel(i,1)
end

%% Deltax errorbars
load z.mat
%% Smoothing data for error bar generation
for i = 1:10
Line2z2sm(:,i) = smooth(Line2z2(:,i))
end
% interp1(Line2meanzb2(4:length(Line2meanzb2)), Line2xx2(4:57), 1:floor(max(Line2meanzb2)));
%requires interpolation of each profile, not just means
%Line 2.49.3 interpolation x(um)
% for i =1:1
%    
% end
%%

for i = 4
 Line2ind2(i,:) = interp1(Line2z2sm(6:25,i), Line2xx2(6:25), 1:floor(max(Line2z2sm(:,i))))
end
 
%%
%Line 9.31.2 interpolation x(um)
for i = 1:11
    Line9ind2(i,:) = interp1(Line9z2(1:46), Line9xx2(1:46), 1:floor(max(Line9z2(i,:))))
end
%% DeltaxL errorbars3
%Line 2.49.3 interpolation x/L
for i = 1:10
    Line2ind(i,:) = interp1(Line2z(1:50), xx(1:50), 1:floor(max(Line2z(i,:))))
end
%Line 9.31.2 interpolation x/L
for i = 1:11
    Line9ind(i,:) = interp1(Line9z(1:50), xx(1:50), 1:floor(max(Line2z(i,:))))
end

