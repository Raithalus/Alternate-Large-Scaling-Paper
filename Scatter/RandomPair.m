clear all;clc;close all

load 2x;
FullData=Data([1 3 4 5 6 10 11 12 13 14 18 20 21 23 24 25 26]);%      19
for i=1:length(FullData),
    Bcd(i,:)=FullData(i).relBcd;
end
figure;
i=1;j=2;n=1;
while i<length(FullData)
    scatter(Bcd(i,:),Bcd(j,:),'.');hold on;
    k(n,:)=polyfit(Bcd(i,:),Bcd(j,:),1);
    x(n,:)=Bcd(i,:);
    y(n,:)=Bcd(j,:);
    j=j+1;
    if j>length(FullData)
        i=i+1;j=i+1;
    end
    n=n+1;
end



% load 2x
% FullData2x=Data([1 3 4 5 6 10 11 12 13 14 18 19 20 21 23 24 25 26]);
% load 1x
% FullData1x=Data([1 3 4 5 6 10 11 12 13 14 18 19 20 21 23 24 25 26]);
% i=1;j=1;n=1;
% % load Background
% % b=mean([Background.relBcd]);
% b=0;
% while i<length(FullData2x)
%     scatter(FullData1x(j).relBcd-b,FullData2x(i).relBcd-b,'.');hold on;
%     k(n,:)=polyfit(FullData1x(j).relBcd-b,FullData2x(i).relBcd-b,1);
%     y(n,:)=[FullData2x(i).relBcd]-b;
%     x(n,:)=[FullData1x(j).relBcd]-b;
%     j=j+1;
%     if j>length(FullData1x)
%         i=i+1;j=1;
%     end
%     n=n+1;
% end

% while i<=length(FullData2x)
%     scatter(FullData1x(i).relBcd-b,FullData2x(i).relBcd-b,'.');hold on;
%     k(n,:)=polyfit(FullData1x(i).relBcd-b,FullData2x(i).relBcd-b,1);
%     y(n,:)=[FullData2x(i).relBcd]-b;
%     x(n,:)=[FullData1x(i).relBcd]-b;
%     i=i+1;n=n+1;
% end


% n=1;x=[];y=[];
% while n<length(FullData2x)
%     scatter(nzz(n,:),FullData2x(n).relBcd,'.');hold on;
%     k(n,:)=polyfit(nzz(n,:),FullData2x(n).relBcd,1);
%     x(n,:)=[FullData2x(n).relBcd];
%     y(n,:)=nzz(n,:);
%     n=n+1
% end



kk=polyfit(x,y,1);
m=0:39;
%hold on;plot(m,m*kk(1)+kk(2),'r','LineWidth',1);
hold on;plot(m,m*mean(k(:,1))+mean(k(:,2)),'r','LineWidth',2);
-kk(2)/kk(1)
kk(1)
[R,P]=corrcoef(x,y)

for s=10:5:max(m),
    e(s)=std(k(:,1)*s+k(:,2));
    hold on;plot([s s],[s*mean(k(:,1))+mean(k(:,2))-e(s),s*mean(k(:,1))+mean(k(:,2))+e(s)],'r');
    hold on;plot([s-0.5,s+0.5],[s*mean(k(:,1))+mean(k(:,2))-e(s) s*mean(k(:,1))+mean(k(:,2))-e(s)],'r');
    hold on;plot([s-0.5,s+0.5],[s*mean(k(:,1))+mean(k(:,2))+e(s) s*mean(k(:,1))+mean(k(:,2))+e(s)],'r');
end
ylim([0,60]);xlim([0,60]);
set(gca,'FontSize',[14],'LineWidth',[2])
box on;












