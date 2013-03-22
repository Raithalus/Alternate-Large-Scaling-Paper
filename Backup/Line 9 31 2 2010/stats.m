%% Load
close all; clear all; clc;
load stats.mat
%% Merged Plot Absolute X

figure,
% plot(xx22, L2meanz2); hold on;
% plot(xx29, L9meanz2); hold off;
errorbar(xx22, L2meanz2, L2e2, 'b'); hold on;
errorbar(xx29, L9meanz2, L9e2, 'r'); hold off;
legend('Line 2.49.3', 'Line 9.31.2')
xlabel('x (\mum)')
ylabel('\itB')
xlim([0,700])
ylim([-2 55])



%% Merged Plot Relative X

figure, 
% plot(xx, L2meanz); hold on;
% plot(xx, L9meanz); hold on;
errorbar(xx, L2meanz, L2e, 'b'); hold on;
errorbar(xx, L9meanz, L9e, 'r'); hold off;
legend('Line 2.49.3', 'Line 9.31.2')
xlabel('x/L')
ylabel('\itB')


%% Background subtraction - xAbs

L2meanz2b = mean(L2meanz2((length(L2meanz2)-5):length(L2meanz2)));
L9meanz2b = mean(L9meanz2((length(L9meanz2)-5):length(L9meanz2)));

L2meanz3 = L2meanz2 - L2meanz2b
L9meanz3 = L9meanz2 - L9meanz2b

%%
figure,
errorbar(xx22, L2meanz3, L2e2, 'b'); hold on;
errorbar(xx29, L9meanz3, L9e2, 'r'); hold off;
legend('Line 2.49.3', 'Line 9.31.2')
xlabel('x (\mum)')
ylabel('\itB')
xlim([0 700])
ylim([-2 55])


%% Background subtraction - xRel

L2meanzb = mean(L2meanz((length(L2meanz)-5):length(L2meanz)));
L9meanzb = mean(L9meanz((length(L9meanz)-5):length(L9meanz)));

L2meanz4 = L2meanz - L2meanzb
L9meanz4 = L9meanz - L9meanzb
%%
figure,
errorbar(xx, L2meanz4, L2e, 'b'); hold on;
errorbar(xx, L9meanz4, L9e, 'r'); hold off;
legend('Line 2.49.3', 'Line 9.31.2')
xlabel('x/L')
ylabel('\itB')
ylim([-2 55])
%%
Bmax2 = max(L2meanz3)
Bmax9 = max(L9meanz3)







