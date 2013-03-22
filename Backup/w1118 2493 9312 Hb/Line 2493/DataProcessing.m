clear all;clc;close all;
%%%%%%%%%%%%%%%%%%%%% Load Data %%%%%%%%%%%%%%%%%%%%%%%%
% load 2x%-100Bins;
% Data=Data([1 3 4 5 6 10 11 12 13 14 18 19 20 21 23 24 25 26]);% Post<0.25

% load 2x(day1);
% Data=Data([1 2 3 4 5 6 7 8 9 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26]);% Post<0.5
% Data=Data([1 5 7 8 9 10 11 13 15 17 18 20 21 22 23 24 25]);% Post<0.25

% load 3x;
% Data=Data([1 3 5 6 7 8 9 10	11 12 14 15	16 17 18 19	20 21 22 23	24 25 26 27	28 29 30 31	32 33]);%Post<0.5
% Data=Data([2 3 4 6 7 8 10 11 12	14 15 16 17	18 19 21 22	25 26 27 28	29]);% Post<0.25

% load 1x;
% Data=Data([1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 19 20 21 22 23 24 25 26]);% Post<0.5
% Data=Data([2 4 5 7 10 11 12 14 21 24]);% Post<0.25

% load stau;
% Data=Data([2:12,14,17,19:31]); % Posterior < 0.5 
% Data=Data([2     4     6     8    14    16    22    23]);% Post<0.25

% load nej; 
% Data=Data([1,3:27,29:33,35:40]);
%Data=Data([3 4 5 9 10 12 14 15 16 17 18 21 22 25 26 27 28 29 30 32 33 34 35 37]);% Post<0.25

%load GFP;

% load hsp;
% Data=Data([1     2     3     5     6     7     8     9    10    12    13    17    21    22    23    24    25    28    32    33    35]);% Post<0.25

% load E3;
% Data=Data([1     3     4     6     8    12    17    18    21    22    23    24    25    26    27]);

% load Dave;Data=Data([2	3	4	5	6	7	8	9	10	11	12	13	14	15	16	17	18	20	21	23	24	25	26	27	28	29	30	31	32	33	34	35	36	37	38	39	40	42]);

% load nejH; 
% Data=Data([1 3 4 5 6 7 8 9 10 11 12 13 14 15 17 18 19 20 21 23 24 25 26 27 28 29 30 31 32 33 34 35 36 37 38 39 40 41]);
% Data=Data([4     7    14    16    17    18    19    21    30    31    32    34    35    37    38]);

% load rpd3H;
% Data=Data([1     2     3     4     6     7     8     9    10    11    12    13    14    15    16    17    18    19]);
% Data=Data([2     3     5     8    12    13    14    15    16    18]);

load 2x;
Data=Data([1:27])

Factor2=80/80; % Factor2=exposure time/80ms;
load Background %-100Bins
Factor=0.6431;  % micron/pixel, apotome, 10X, plan objective
%%%%%%%% Embryo Length %%%%%%%%%%%%%%%%%%%5
EL=[Data.EL];  
[sEL,seq]=sort(EL);
aEL=EL*Factor;
disp('the sample number is');length(aEL)
disp('the mean EL is');mean(aEL)
disp('the std of EL is');std(aEL)
%%%%%%%%%%%
Bins=length(Data(1).relx);
L=floor(EL/Bins);
xx=1/Bins/2:1/Bins:1-1/Bins/2;
L2=round(900/Bins);
C=rand(length(Data),3);
%%%%%%%%%% Bcd profiles %%%%%
    %%% relative position %%%
figure;
for i=1:length(Data), title('W118 0-4h 125ms 1:50 Bcdsc')
    Data(i).relBcd=Data(i).relBcd/Factor2;
    Data(i).absBcd=Data(i).absBcd/Factor2;
    x=Data(i).relx/Data(i).EL;
    z(i,:)=Data(i).relBcd;
    [Bmax1(i),Pmax1(i)]=max(z(i,:));
    lB(i,:)=log((z(i,1:40)-mean(Background.meanrel))/(Bmax1(i)-mean(Background.meanrel)));
    lBk=polyfit(xx(6:25),lB(i,6:25),1);
    lambda(i)=-1/lBk(1);
    lambdaf(i,:)=-(z(i,:)'-mean(Background.meanrel))./gradient(smooth(z(i,:)))/Bins;
    scatter(x,z(i,:),[],C(i,:),'.')
    hold on;
end
meanz=mean(z);
for i=1:Bins,
    e(i)=std(z(:,i));
end
errorbar(xx,Background.meanrel,Background.stdrel,'k');
errorbar(xx,meanz,e,'k');
xlim([0,1])
xlabel('x/L');
ylabel('Intensity');
set(gca,'FontSize',[14],'LineWidth',[2])
box on;
    %%%% absolute position %%%%%%%%%
figure;
for i=1:length(Data),
    Bins2(i)=length(Data(i).absx);
    x2=Data(i).absx*Factor;
    z2=Data(i).absBcd;
    scatter(x2,z2,[],C(i,:),'.'),hold on;
    [Bmax2(i),Pmax2(i)]=max(z2);
    lB2(i,:)=log((z2(1:40)-mean(Background.meanrel))/(Bmax2(i)-mean(Background.meanrel)));
    lBk2=polyfit(x2(6:25),lB2(i,6:25),1);
    lambda2(i)=-1/lBk2(1);
    lambdaf2(i,:)=-(z2(1:40)'-mean(Background.meanrel))./gradient(smooth(z2(1:40)))*L2*Factor;
    x2=[];z2=[];
end
minBins=min(Bins2);
for j=1:max(Bins2),
    data(j).z2=[];
    data(j).y2=[];
end
for i=1:length(Data),
    for j=1:Bins2(i),
        data(j).z2=[data(j).z2,Data(i).absBcd(j)];
    end
end
for j=1:length(data),
    meanz2(j)=mean(data(j).z2);
    e2(j)=std(data(j).z2);
end
xx2=ceil(L2/2):L2:ceil(L2/2)+(length(data)-1)*L2;
xx2=xx2*Factor;
errorbar(xx2,meanz2,e2,'k');
xlim([0,max(aEL)]);
% ylim([0,30]);
title('W118 0-4h 125ms 1:50 Bcdsc')
xlabel('x');
ylabel('Intensity');
set(gca,'FontSize',[14],'LineWidth',[2])
box on;
%%%%%%%%%%% Hb boundary %%%%%%%%%%%%%%%%%5555
    %%%%%%%% Hb - x/L %%%%%%%55
boundary=zeros(length(Data),24);
figure, 
for i=1:length(Data), 
    x=Data(i).relx;
    y=Data(i).relHb;
    x=x/EL(i);
    y2=sort(y);                           %4
    thresholdmax=mean(y2(length(y2)-4:length(y2)));
    thresholdmin=mean(y2(1:10));
    yy=(y-thresholdmin)/(thresholdmax-thresholdmin);
    scatter(x,yy,[],C(i,:),'.');hold on
    PosteriorHb(i)=max(yy(find(x>0.65)));
    AnteriorHb(i)=max(yy(find(x<0.32)));
    
    HbRatio(i) = AnteriorHb(i)/PosteriorHb(i);
    
    yMinusHalf=yy(:)-0.5;
    yShift1=[0; yMinusHalf];yShift2=[yMinusHalf;0];
    yShiftMinus=yShift1.*yShift2;
    foundHalf=find(yShiftMinus<0);
    for q=1:length(foundHalf)
        if yy(foundHalf(q)-1)>yy(foundHalf(q))
            boundary(i,q)=interp1(yy(foundHalf(q)-1:foundHalf(q)),x(foundHalf(q)-1:foundHalf(q)),0.5);
        end
    end
    yyy(i,:)=yy;
    sl(i,:)=gradient(yy);
    ssl(i,:)=gradient(smooth(yy));
end
xlim([0,1]);ylim([-0.05,1.15]);
thresholdhigh=0.65;
for i=1:size(boundary,1)
    sortBoundary=sort(boundary(i,:));
    j=24;
    while sortBoundary(j)>thresholdhigh
        j=j-1;
    end
    boundaryArray(i)=sortBoundary(j);
end
disp('the mean RelativeHbBoundary is');mean(boundaryArray)
disp('the std of RelativeHbBoundary is');std(boundaryArray)
disp('PosteriorHb lower than 0.25');find(PosteriorHb<0.25)
% figure;
meany=mean(yyy);
for i=1:size(yyy,2),
    he(i)=std(yyy(:,i));
end
errorbar(xx,meany,he,'k');
title('');
ylabel('Relative Intensity');
xlabel('x/L')
set(gca,'FontSize',[14],'LineWidth',[2],'XTick',0:0.1:1)
box on;
    %%%%%%% Hb - x %%%%%%%%%
figure;
Boundary=zeros(length(Data),24);
for i=1:length(Data),
    x=Data(i).absx*Factor;
    y=Data(i).absHb;    
    y2=sort(y);                           %4
    thresholdmax=mean(y2(length(y2)-4:length(y2)));
    thresholdmin=mean(y2(1:10));
    yy=(y-thresholdmin)/(thresholdmax-thresholdmin);
    scatter(x,yy,[],C(i,:),'.');hold on;
    YMinusHalf=yy(:)-0.5;
    YShift1=[0; YMinusHalf];YShift2=[YMinusHalf;0];
    YShiftMinus=YShift1.*YShift2;
    FoundHalf=find(YShiftMinus<0);
    for q=1:length(FoundHalf)
        if yy(FoundHalf(q)-1)>yy(FoundHalf(q))
            Boundary(i,q)=interp1(yy(FoundHalf(q)-1:FoundHalf(q)),x(FoundHalf(q)-1:FoundHalf(q)),0.5);
        end
    end
    for j=1:length(yy),
        data(j).y2=[data(j).y2,yy(j)];
    end
end
xlim([0,max(aEL)]);ylim([-0.05,1.15]);
for i=1:size(Boundary,1)
    SortBoundary=sort(Boundary(i,:)); % sort boundary for each curve
    j=24;
    while SortBoundary(j)>thresholdhigh*mean(aEL)
        j=j-1;
    end
    BoundaryArray(i)=SortBoundary(j);
end
disp('the mean AbsoluteHbBoundary is');mean(BoundaryArray)
disp('the std of AbsoluteHbBoundary is');std(BoundaryArray)

for j=1:length(data),
    meany2(j)=mean(data(j).y2);
    he2(j)=std(data(j).y2);
end
errorbar(xx2,meany2,he2,'k');
title('802-2-2/cyo; E1s/E1s 0-4h n=9');
ylabel('Relative Intensity');
xlabel('x')
set(gca,'FontSize',[14],'LineWidth',[2])
box on;

% %%%%%%% Bthreshold & Bmax %%%%%
% 
Bcdthreshold=z(:,round(mean(boundaryArray)*Bins));
Bcdthreshold2=data(round(mean(BoundaryArray)/Factor/L2)).z2;
disp('the Bx is');mean(Bcdthreshold)-mean(Background.meanrel)
disp('the std of Bcdthreshold is');std(Bcdthreshold)

for i=1:length(Data),
    Bt(i)=z(i,round(boundaryArray(i)*Bins));
    z2=[];z2=data(round(BoundaryArray(i)/(L2*Factor))).z2;
    Bt2(i)=z2(i);
end

disp('the iBcdthreshold2 is');mean(Bt2)-mean(Background.meanrel)
disp('the std of iBcdthreshold2 is');std(Bt2)
% 
% 
% % %%%%%%%%%% input/output %%%%%%%%%%%%%%
figure;
for i=1:length(Data),
    scatter(log((z(i,:)-mean(Background.meanrel))/(mean(Bt)-mean(Background.meanrel))),yyy(i,:),'.');hold on;
end
xlim([-3,3]);ylim([-0.05,1.15])
set(gca,'FontSize',[14],'LineWidth',[2])
box on;

Hill=5;
for i=1:length(Data),
    h(i)=nlinfit((z(i,15:25)-mean(Background.meanrel))/(mean(Bt)-mean(Background.meanrel)),yyy(i,15:25),'cooperate',Hill);
   for j=15:25,
       zz2(i,j-14)=data(j).z2(i);
       yy2(i,j-14)=data(j).y2(i);
   end
    h2(i)=nlinfit((zz2(i,:)-mean(Background.meanrel))/(mean(Bt2)-mean(Background.meanrel)),yy2(i,:),'cooperate',Hill);
end
mean(h)
std(h)
disp('the Hill is');mean(h2)
disp('the std of Hill');std(h2)

h2=ones(length(Data),1);
%%%%%%%%%%%%  Large embryos vs. small embryos - Hb boundary %%%%%%%%%
LongRelxH=boundaryArray(seq(ceil(length(EL)/2)+1:length(EL)));
ShortRelxH=boundaryArray(seq(1:floor(length(EL)/2)));
LongAbsxH=BoundaryArray(seq(ceil(length(EL)/2)+1:length(EL)));
ShortAbsxH=BoundaryArray(seq(1:floor(length(EL)/2)));
Ht=(mean(LongRelxH)-mean(ShortRelxH))/std(boundaryArray)/((1/length(LongRelxH)+1/length(ShortRelxH))^0.5)
Ht2=(mean(LongAbsxH)-mean(ShortAbsxH))/std(BoundaryArray)/((1/length(LongAbsxH)+1/length(ShortAbsxH))^0.5)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
mean(Bmax2)-mean(Background.meanrel)
std(Bmax2)

mean(lambda2)
std(lambda2)
[R(:,:,1),P(:,:,1)]=corrcoef(BoundaryArray,aEL);
[R(:,:,2),P(:,:,2)]=corrcoef(boundaryArray,aEL);
[R(:,:,3),P(:,:,3)]=corrcoef(Bmax2,aEL);
% [R(:,:,4),P(:,:,4)]=corrcoef(lambda2,aEL);
[R(:,:,5),P(:,:,5)]=corrcoef(h2,aEL);
[R(:,:,6),P(:,:,6)]=corrcoef(Bt2,aEL);
[R(:,:,7),P(:,:,7)]=corrcoef(h2,Bt2);
% [R(:,:,8),P(:,:,8)]=corrcoef(lambda2,Bt2);
[R(:,:,9),P(:,:,9)]=corrcoef(Bmax2,Bt2);
[R(:,:,10),P(:,:,10)]=corrcoef(BoundaryArray,Bt2);
[R(:,:,11),P(:,:,11)]=corrcoef(boundaryArray,Bt2);
% [R(:,:,12),P(:,:,12)]=corrcoef(lambda2,h2);
% [R(:,:,13),P(:,:,13)]=corrcoef(lambda2,Bmax2);
% [R(:,:,14),P(:,:,14)]=corrcoef(BoundaryArray,lambda2);
% [R(:,:,15),P(:,:,15)]=corrcoef(boundaryArray,lambda2);
[R(:,:,16),P(:,:,16)]=corrcoef(boundaryArray,Bcdthreshold);
[R(:,:,17),P(:,:,17)]=corrcoef(BoundaryArray,Bcdthreshold2);
for i=1:17,
    r(i)=R(1,2,i);
    p(i)=P(1,2,i);
end
[r;p]'
%close all

% %%%%%%%%%%%%%%%%

figure;
zP=z(find(boundaryArray>median(boundaryArray)),:);
plot(xx,mean(zP),'r');hold on;
zA=z(find(boundaryArray<median(boundaryArray)),:);
plot(xx,mean(zA),'b');
set(gca,'FontSize',[14],'LineWidth',[2])


yP=yyy(find(boundaryArray>median(boundaryArray)),:);
yA=yyy(find(boundaryArray<median(boundaryArray)),:);
figure;
plot(xx,mean(yP),'r');hold on;
plot(xx,mean(yA),'b');
ylim([-0.05,1.15]);
set(gca,'FontSize',[14],'LineWidth',[2])


%%%%%%%%%%%%  LS grouping %%%%%%%%%%%%%%%%
figure;
zL=z(find(aEL>median(aEL)),:);
plot(xx,mean(zL),'r');hold on;
zS=z(find(aEL<median(aEL)),:);
plot(xx,mean(zS),'b');
title('802-2-2/cyo; E1s/E1s 0-4h 700ms n=9')
xlabel('x/L')
ylabel('Intensity')
legend('Large', 'Small')
set(gca,'FontSize',[14],'LineWidth',[2],'XTick',0:0.1:1)

figure;
yL=yyy(find(aEL>median(aEL)),:);
plot(xx,mean(yL),'r');hold on;
yS=yyy(find(aEL<median(aEL)),:);
plot(xx,mean(yS),'b');
xlim([0,1]);ylim([-0.05,1.15]);
title('802-2-2/cyo; E1s/E1s 0-4h 700ms n=9')
xlabel('x/L')
ylabel('Relative Intensity')
legend('Large', 'Small')
set(gca,'FontSize',[14],'LineWidth',[2],'XTick',0:0.1:1)
for j=1:floor(min(EL)/L2),
    data2(j).zL=data(j).z2(find(aEL>median(aEL)));
    mzL2(j)=mean(data2(j).zL);
    data2(j).zS=data(j).z2(find(aEL<median(aEL)));
    mzS2(j)=mean(data2(j).zS);
    data2(j).yL=data(j).y2(find(aEL>median(aEL)));
    myL2(j)=mean(data2(j).yL);
    data2(j).yS=data(j).y2(find(aEL<median(aEL)));
    myS2(j)=mean(data2(j).yS);
end


figure;
plot(xx2(1:j),mzL2,'r');hold on;
plot(xx2(1:j),mzS2,'b');
xlim([0,max(aEL)]);
title('802-2-2/cyo; E1s/E1s 0-4h 700ms n=9')
xlabel('x')
ylabel('Intensity')
legend('Large', 'Small')
set(gca,'FontSize',[14],'LineWidth',[2])

%%%%%%%%% Spearman' rank %%%%%%%%%%%%%%%%
% [sortBt2,idx]=sort(Bt2);
% [sortLambda2,idx2]=sort(lambda2(idx));
% [idx22,idx3]=sort(idx2);
% d=idx3-(1:1:length(idx3));
% rs=1-sum(d.^2)*6/length(d)/(length(d)^2-1)
% ts=rs/(((1-rs^2)/(length(d)-2))^0.5);
% ps=2*(1-tcdf(abs(ts),length(d)-2))

% for j=1:Bins,
%     [sortBt2,idx]=sort(z(:,j));
%     [sortLambda2,idx2]=sort(aEL(idx));
%     [idx22,idx3]=sort(idx2);
%     d=idx3-(1:1:length(idx3));
%     rs(j)=1-sum(d.^2)*6/length(d)/(length(d)^2-1);
%     ts(j)=rs(j)/(((1-rs(j)^2)/(length(d)-2))^0.5);
%     ps(j)=2*(1-tcdf(abs(ts(j)),length(d)-2));
% end
% plot(xx,rs,'b');hold on;
% for j=1:Bins,
%     [sortBt2,idx]=sort(data(j).z2);
%     [sortLambda2,idx2]=sort(aEL(idx));
%     [idx22,idx3]=sort(idx2);
%     d=idx3-(1:1:length(idx3));
%     rs2(j)=1-sum(d.^2)*6/length(d)/(length(d)^2-1);
%     ts2(j)=rs2(j)/(((1-rs2(j)^2)/(length(d)-2))^0.5);
%     ps2(j)=2*(1-tcdf(abs(ts2(j)),length(d)-2));
% end
% plot(xx,rs2,'r');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%
for j=1:length(xx),
ccM=corrcoef(yyy(:,1),yyy(:,j));
cc(j)=ccM(2);
ccM2=corrcoef(z(:,1),z(:,j));
cc2(j)=ccM2(2);
end
figure,plot(xx,cc2,'r','LineWidth',[2]);hold on,plot(xx(1:25),cc(1:25),'b','LineWidth',[2])
set(gca,'FontSize',[14],'LineWidth',[2],'YLim',[0,1])
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%% total Bcd and Hb %%%%%%%%%%%%%
Bb=Background.meanrel;
% Bh=Background.meanrelHb;
% for i=1:length(Data),
%     x2=Data(i).absx*Factor;
%     z2=Data(i).absBcd;
%     y2=Data(i).absHb;
%     for j=1:length(Data(i).absHb),
%         z2(j)=z2(j)-Bb(ceil(x2(j)/aEL(i)/0.02));
%         %y2(j)=y2(j)-Bh(ceil(x2(j)/aEL(i)/0.02));
%     end
%     sb(i)=sum(z2);
%     sh(i)=sum(y2);
% end
% [R,P]=corrcoef(aEL,sb)
% figure,scatter(aEL,sb)
% bl=polyfit(aEL,sb,1);
% hold on;plot(520:600,[520:600]*bl(1)+bl(2),'LineWidth',[2])
% box on;set(gca,'FontSize',[14],'LineWidth',[2])
% [R,P]=corrcoef(aEL,sh)
% figure,scatter(aEL,sh)
% box on;set(gca,'FontSize',[14],'LineWidth',[2])
% [R,P]=corrcoef(sb,sh)
% figure,scatter(sb,sh)
% box on;set(gca,'FontSize',[14],'LineWidth',[2])
% [R,P]=corrcoef(BoundaryArray,sb)
% [R,P]=corrcoef(BoundaryArray,sh)
% [R,P]=corrcoef(BoundaryArray,aEL)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% [R,P]=corrcoef(PosteriorHb,aEL)
% [R,P]=corrcoef(PosteriorHb,BoundaryArray)
% [R,P]=corrcoef(PosteriorHb,boundaryArray)
% [R,P]=corrcoef(PosteriorHb,Bt2)
% [R,P]=corrcoef(PosteriorHb,Bmax2)
% figure,scatter(PosteriorHb,boundaryArray)
% figure,scatter(PosteriorHb,Bt2)
% figure,scatter(PosteriorHb,Bmax2)

%close all
%M=[PosteriorHb./AnteriorHb;aEL;sb;Bt2;Bmax2;lambda2;]'

%% 802-2-2/cyo; E1s/E1s and E1/Tm6B Bcd profile Overlay
figure;
for i=1:length(Data),
    Data(i).relBcd=Data(i).relBcd/Factor2;
    Data(i).absBcd=Data(i).absBcd/Factor2;
    x=Data(i).relx/Data(i).EL;
    z(i,:)=Data(i).relBcd;
    [Bmax1(i),Pmax1(i)]=max(z(i,:));
    lB(i,:)=log((z(i,1:40)-mean(Background.meanrel))/(Bmax1(i)-mean(Background.meanrel)));
    lBk=polyfit(xx(6:25),lB(i,6:25),1);
    lambda(i)=-1/lBk(1);
    lambdaf(i,:)=-(z(i,:)'-mean(Background.meanrel))./gradient(smooth(z(i,:)))/Bins;
%     scatter(x,z(i,:),[],C(i,:),'.')
    hold on;
end
meanz=mean(z);
for i=1:Bins,
    e(i)=std(z(:,i));
end
errorbar(xx,Background.meanrel,Background.stdrel,'k');
% errorbar(xx, meanz1x, e1x,'r') %1 copy Bcd; E1/Tm6B Manually inserted via Excel
errorbar(xx,meanz,e,'b'); % 802-2-2/cyo; E1/E1
xlim([0,1])
xlabel('x/L')
ylabel('Intensity')
title('802 and 1x Bcd Profile Overlay')
legend('802-2-2/cyo; E1/E1', 'E1/Tm6B')
set(gca,'FontSize',[14],'LineWidth',[2])
box on;
%%
figure;
meany=mean(yyy);
for i=1:size(yyy,2),
    he(i)=std(yyy(:,i));
end
errorbar(xx,meany,he,'k');
set(gca,'FontSize',[14],'LineWidth',[2],'XTick',0:0.2:1)
box on;
%% Posterior Hb Ranking
% Plots Average Bcd Profiles based on separating the population by
% Posterior Hunchback Level

figure;
zLhb=z(find(PosteriorHb>median(PosteriorHb)),:);
plot(xx,mean(zLhb),'r');hold on;
zShb=z(find(PosteriorHb<median(PosteriorHb)),:);
plot(xx,mean(zShb),'b');
title('802-2-2/cyo; E1s/E1s 0-4h Posterior Hb Rank')
xlabel('x/L')
ylabel('Intensity')
legend('Posterior Hb Large', 'Posterior Hb Small')
set(gca,'FontSize',[14],'LineWidth',[2],'XTick',0:0.1:1)
%% Absolute Hunchback
figure;
for i=1:length(Data), 
    AbsHb(i,:)=Data(i).relHb;
% x=Data(i).relx/Data(i).EL;
% errorHb = ???
% errorbar(xx, errorHb, meanHb);
scatter(x,AbsHb(i,:),[],C(i,:),'.'), 
ylim([0,55])
HbBack(i,:) = AbsHb(i, [30:35])
hold on
end
HbBack=HbBack'
MeanHbBack=mean(HbBack)
HbBack=HbBack'
MeanHbBack=MeanHbBack'
SubAbsHb = AbsHb((1:length(Data)),:)-MeanHbBack(i)

figure;
for i=1:length(Data), 
% x=Data(i).relx/Data(i).EL;
% errorHb = ???
% errorbar(xx, errorHb, meanHb);
scatter(x,SubAbsHb(i,:),[],C(i,:),'.'), 
ylim([0,55])
HbBack(i,:) = AbsHb(i, [30:35]),
hold on
end


