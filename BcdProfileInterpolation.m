%%  Bicoid Profile Interpolation
close all; clear all; clc
%%
load('BcdProfiles.mat'); %Loads dataset
%aEL = Egg length of embryos
%xx2 = absolute x
%xx = relative x
%z = Bcd Intensity Data for relative egg length
%z2 = Bcd Intensity Data for absolute egg length

%% Test plots of B profiles
% for i = 1:length(aEL)
% % figure, plot(xx2,z2(i,:))
% figure, plot(z2(i,:), xx2)
% end
%% Smoothing
for i = 1:10
    L2493z2sm(i,:) = smooth(xx2, L2493z2(i,:))
end

for i = 1:10
    L2493zsm(i,:) = smooth(xx, L2493z(i,:))
end

for i = 1:11
    L9312z2sm(i,:) = smooth(xx2(1:46), L9312z2(i,:))
end

for i = 1:11
    L9312zsm(i,:) = smooth(xx, L9312z(i,:))
end
%% Interpolation
Bthresh = 1:1:50
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
%% Concatenate Profiles
intpb = [intpb1; intpb2; intpb3; intpb4; intpb5; intpb6; intpb7; intpb8; intpb9; intpb10; intpb11; intpb12; intpb13; intpb14; intpb15; intpb16; intpb17; intpb18; intpb19; intpb20; intpb21;]
 