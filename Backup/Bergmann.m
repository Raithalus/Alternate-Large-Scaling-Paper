%% Bergmann S Coefficient calculation for Lines 2.49.3 and 9.31.2
close all; clear all; clc;
%%
load('2493 9312 Bergmann.mat'); %Pooled data
%Li = Individual egg length minus mean L over <L>
%aEL = Egg length of embryos
%xx2 = Absolute length bins
%z2 = Measured B values over absolute length (Background subtracted)
%Bthresh = Bicoid thresholds from 1:25 (approx min(max(B0)))


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
intpb1 = interp1(z2sm(1, 4:44), xx2(4:44), Bthresh);
intpb2 = interp1(z2sm(2, 4:44), xx2(4:44), Bthresh);
intpb3 = interp1(z2sm(3, 4:44), xx2(4:44), Bthresh);
intpb4 = interp1(z2sm(4, 4:44), xx2(4:44), Bthresh);
intpb5 = interp1(z2sm(5, 4:44), xx2(4:44), Bthresh);
intpb6 = interp1(z2sm(6, 4:44), xx2(4:44), Bthresh);
intpb7 = interp1(z2sm(7, 4:44), xx2(4:44), Bthresh);
intpb8 = interp1(z2sm(8, 4:44), xx2(4:44), Bthresh);
intpb9 = interp1(z2sm(9, 4:44), xx2(4:44), Bthresh);
intpb10 = interp1(z2sm(10, 4:44), xx2(4:44), Bthresh);
intpb11 = interp1(z2sm(11, 4:44), xx2(4:44), Bthresh);
intpb12 = interp1(z2sm(12, 4:44), xx2(4:44), Bthresh);
intpb13 = interp1(z2sm(13, 4:44), xx2(4:44), Bthresh);
intpb14 = interp1(z2sm(14, 4:44), xx2(4:44), Bthresh);
intpb15 = interp1(z2sm(15, 4:44), xx2(4:44), Bthresh);
intpb16 = interp1(z2sm(16, 4:44), xx2(4:44), Bthresh);
intpb17 = interp1(z2sm(17, 4:44), xx2(4:44), Bthresh);
intpb18 = interp1(z2sm(18, 4:44), xx2(4:44), Bthresh);
intpb19 = interp1(z2sm(19, 4:44), xx2(4:44), Bthresh);
intpb20 = interp1(z2sm(20, 4:44), xx2(4:44), Bthresh);
intpb21 = interp1(z2sm(21, 4:44), xx2(4:44), Bthresh);



%%
intpb11 = interp1(z2sm(11, 4:50), xx2(4:50), Bthresh)
%%
for i = 1:length(aEL)
intpb(i,:) = interp1(z2sm(i, 4:50), xx2(4:50), Bthresh)
end

%% Testbed
figure, 
plot(intpb1, Bthresh, '.'); hold on;
plot(xx2, z2sm(1,:)); hold on;
set(gca,'YLim', [0, 70])
%% Testbed multi



figure,
plot(intpb, Bthresh, 'o'); hold on;
for i = 11:length(aEL)
plot(xx2, z2sm(i,:)); hold on
end



