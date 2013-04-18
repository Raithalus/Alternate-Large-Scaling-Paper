%% Background subtracted
load scatter.mat
figure,
for i = 1:50
    for j = 1:10
        for k = 1:11
            scatter(a(i,j), b(i,k), '.'); hold on
        end
    end
end
% set(gca,'XLim', [0 70]);
% set(gca,'YLim', [0 80]);
%% Raw without Background Subtraction
load scatter2.mat
n = 0
figure,
for i = 1:50
    for j = 1:10
        for k = 1:11
            scatter(a2(i,j), b2(i,k),'.'); hold on;
            n = n+1
            a3(n,:) = [a2(i,j), b2(i,k)]
        end
    end
end

%%



pfit = polyfit(a3(:,1), a3(:,2),1);
