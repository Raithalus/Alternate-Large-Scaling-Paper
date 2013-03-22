%% Intensity to Positional Error conversion for scaled x 
xx = 0.01:0.02:.99;
for i = 1:length(Data);
    figure, plot(xx, z(i,:))
end
for i = 1:length(Data);
fit(i,:) = polyfit(xx(1,[5:50]), log(meanz(i,[5:50])),1)
figure, semilogy(xx(1,[5:50]), log(z(i,[5:50])), 'o', xx(1,[5:50]), exp(fit(i,2)).*exp(fit(i,1)*xx(1,[5:50])))
figure, plot(xx(1,[5:50]), log(meanz(i,[5:50])),'.')
end
%% Intensity to Positional Error conversion for absolute x
% 
% for i = 1:length(Data);
%     figure, plot(Data(1,i).absx*0.6431, Data(1,i).absBcd)
% end
% % for i = 1:length(Data);
% % fit = polyfit(Data(1,i).absx*0.6431(1,[5:50])),
% % log(Data(1,i).absBcd(1,[5:50]),1)
% % end
% 
 %%
for i=1:length(Data),
    for j=1:Bins2(i),
        data(j).z2=[data(j).z2,Data(i).absBcd(j)];
    end
    
end
for j=1:length(data),
       meanz2(j)=mean(data(j).z2);
       e2(j)=std(data(j).z2);
end