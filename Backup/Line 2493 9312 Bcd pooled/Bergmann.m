%% Bergmann S Coefficient calculation for Lines 2.49.3 and 9.31.2
close all; clear all; clc;
%%
load('2493 9312 Bergmann.mat'); %Pooled data
%Li = Individual egg length minus mean L over <L>
%aEL = Egg length of embryos
%xx2 = Absolute length bins
%z2 = Measured B values over absolute length (Background subtracted)
% Bthresh = Bicoid thresholds from 1:25 (approx min(max(B0)))


%% Test plots of B profiles
for i = 1:length(aEL)
% figure, plot(xx2,z2(i,:))
figure, plot(z2(i,:), xx2)
end
%% Smoothing
for i = 1:length(aEL)
z2sm(i,:) = smooth(xx2, z2(i,:))
end
%%
figure,
for i = 1:length(aEL)
plot(xx2, z2sm(i,:)); hold on;
end

figure,
for i = 1:length(aEL)
plot(xx2, z2(i,:)); hold on;
end

%% Interpolation
Bthresh = 1:1:40
intpb1 = interp1(z2sm(1, 4:53), xx2(4:53), Bthresh);
intpb2 = interp1(z2sm(2, 4:53), xx2(4:53), Bthresh);
intpb3 = interp1(z2sm(3, 4:53), xx2(4:53), Bthresh);
intpb4 = interp1(z2sm(4, 4:53), xx2(4:53), Bthresh);
intpb5 = interp1(z2sm(5, 4:53), xx2(4:53), Bthresh);
intpb6 = interp1(z2sm(6, 4:53), xx2(4:53), Bthresh);
intpb7 = interp1(z2sm(7, 4:53), xx2(4:53), Bthresh);
intpb8 = interp1(z2sm(8, 4:53), xx2(4:53), Bthresh);
intpb9 = interp1(z2sm(9, 4:53), xx2(4:53), Bthresh);
intpb10 = interp1(z2sm(10, 4:43), xx2(4:43), Bthresh);
intpb11 = interp1(z2sm(11, 4:43), xx2(4:43), Bthresh);
intpb12 = interp1(z2sm(12, 4:43), xx2(4:43), Bthresh);
intpb13 = interp1(z2sm(13, 4:43), xx2(4:43), Bthresh);
intpb14 = interp1(z2sm(14, 4:43), xx2(4:43), Bthresh);
intpb15 = interp1(z2sm(15, 4:43), xx2(4:43), Bthresh);
intpb16 = interp1(z2sm(16, 4:43), xx2(4:43), Bthresh);
intpb17 = interp1(z2sm(17, 4:43), xx2(4:43), Bthresh);
intpb18 = interp1(z2sm(18, 4:43), xx2(4:43), Bthresh);
intpb19 = interp1(z2sm(19, 4:43), xx2(4:43), Bthresh);
intpb20 = interp1(z2sm(20, 4:43), xx2(4:43), Bthresh);
intpb21 = interp1(z2sm(21, 4:43), xx2(4:43), Bthresh);

%%
% for i = 1:length(aEL)
% intpb(i,:) = interp1(z2sm(i, 4:43), xx2(4:43), Bthresh)
% end

intpb = [intpb1; intpb2; intpb3; intpb4; intpb5; intpb6; intpb7; intpb8; intpb9; intpb10; intpb11; intpb12; intpb13; intpb14; intpb15; intpb16; intpb17; intpb18; intpb19; intpb20; intpb21;]
    
%% Testbed
figure, 
plot(intpb1, Bthresh, '.'); hold on;
plot(xx2, z2sm(1,:)); hold on;

plot(intpb21, Bthresh, '.r'); hold on;
plot(xx2, z2sm(21,:),'r'); hold off;
set(gca,'YLim', [0, 70])
%%

figure, 
plot(intpb10, Bthresh, '.'); hold on;
plot(xx2, z2sm(10,:)); hold on;

plot(intpb11, Bthresh, '.r'); hold on;
plot(xx2, z2sm(11,:),'r'); hold off;
set(gca,'YLim', [0, 70])

%%
figure, 
for i = 1:21
plot(intpb(i,17), 17, '.'); hold on;
plot(xx2, z2sm(i,:)); hold on;

end


%% Testbed multi 
%Plot to show interpolated points fall on the smoothened curve
figure,
plot(intpb1, Bthresh, 'o'); hold on;
plot(intpb2, Bthresh, 'o'); hold on;
plot(intpb3, Bthresh, 'o'); hold on;
plot(intpb4, Bthresh, 'o'); hold on;
plot(intpb5, Bthresh, 'o'); hold on;
plot(intpb6, Bthresh, 'o'); hold on;
plot(intpb7, Bthresh, 'o'); hold on;
plot(intpb8, Bthresh, 'o'); hold on;
plot(intpb9, Bthresh, 'o'); hold on;
plot(intpb10, Bthresh, 'o'); hold on;
plot(intpb11, Bthresh, 'o'); hold on;
plot(intpb12, Bthresh, 'o'); hold on;
plot(intpb13, Bthresh, 'o'); hold on;
plot(intpb14, Bthresh, 'o'); hold on;
plot(intpb15, Bthresh, 'o'); hold on;
plot(intpb16, Bthresh, 'o'); hold on;
plot(intpb17, Bthresh, 'o'); hold on;
plot(intpb18, Bthresh, 'o'); hold on;
plot(intpb19, Bthresh, 'o'); hold on;
plot(intpb20, Bthresh, 'o'); hold on;
plot(intpb21, Bthresh, 'o'); hold on;
%%
for i = 1:length(aEL)
plot(xx2, z2sm(i,:)); hold on
end
%% bracketx calculation

for i = 1:25
    bracketx(:,i) = nanmean(intpb(:,i));
end

%%
for i = 1:25
intpb1xi(i) = (intpb1(i)-bracketx(i))/bracketx(i)
intpb2xi(i) = (intpb2(i)-bracketx(i))/bracketx(i)
intpb3xi(i) = (intpb3(i)-bracketx(i))/bracketx(i)
intpb4xi(i) = (intpb4(i)-bracketx(i))/bracketx(i)
intpb5xi(i) = (intpb5(i)-bracketx(i))/bracketx(i)
intpb6xi(i) = (intpb6(i)-bracketx(i))/bracketx(i)
intpb7xi(i) = (intpb7(i)-bracketx(i))/bracketx(i)
intpb8xi(i) = (intpb8(i)-bracketx(i))/bracketx(i)
intpb9xi(i) = (intpb9(i)-bracketx(i))/bracketx(i)
intpb10xi(i) = (intpb10(i)-bracketx(i))/bracketx(i)
intpb11xi(i) = (intpb11(i)-bracketx(i))/bracketx(i)
intpb12xi(i) = (intpb12(i)-bracketx(i))/bracketx(i)
intpb13xi(i) = (intpb13(i)-bracketx(i))/bracketx(i)
intpb14xi(i) = (intpb14(i)-bracketx(i))/bracketx(i)
intpb15xi(i) = (intpb15(i)-bracketx(i))/bracketx(i)
intpb16xi(i) = (intpb16(i)-bracketx(i))/bracketx(i)
intpb17xi(i) = (intpb17(i)-bracketx(i))/bracketx(i)
intpb18xi(i) = (intpb18(i)-bracketx(i))/bracketx(i)
intpb19xi(i) = (intpb19(i)-bracketx(i))/bracketx(i)
intpb20xi(i) = (intpb20(i)-bracketx(i))/bracketx(i)
intpb21xi(i) = (intpb21(i)-bracketx(i))/bracketx(i)
end
%%
intpbxi = [intpb1xi; 
           intpb2xi; 
           intpb3xi; 
           intpb4xi; 
           intpb5xi; 
           intpb6xi; 
           intpb7xi; 
           intpb8xi; 
           intpb9xi; 
           intpb10xi; 
           intpb11xi; 
           intpb12xi; 
           intpb13xi; 
           intpb14xi;
           intpb15xi; 
           intpb16xi; 
           intpb17xi; 
           intpb18xi; 
           intpb19xi; 
           intpb20xi; 
           intpb21xi;]
%%
for i = 1:25
    figure,
    for j = 1:21
    scatter(Li(j,1),intpbxi(j,i)); hold on;
    end
    
end









