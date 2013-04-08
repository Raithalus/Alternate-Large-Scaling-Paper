%% Intensity to Positional Error conversion for scaled x 
xx = 0.01:0.02:.99;
% for i = 1:length(Data);
%     figure, plot(xx, z(i,:))
% end
%                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            
for i = 1:length(Data);
fit(i,:)  = polyfit(xx(1,[5:31]), log(z(i,[5:31])),1)
figure, semilogy(xx(1,[5:50]),(z(i,[5:50])), 'o', xx(1,[5:50]), exp(fit(i,2)).*exp(fit(i,1)*xx(1,[5:50])))
% figure, plot(xx(1,[5:50]), log(z(i,[5:50])),'.')
end
%%



S = solve('B = x^fit(1,2) + x^fit(1,1) + xx(31)', 'x = 0.5')