close all; clear all; clc;
% load Data.mat
BcdFiles = dir('C:\Users\che7oz\Desktop\Line 2 49 3 2010\*_c3.jpg');
DapiFiles = dir('C:\Users\che7oz\Desktop\Line 2 49 3 2010\*_c4.jpg');
%% Load Images
for i = 1:length(BcdFiles)
BcdI = imread(BcdFiles(i).name);
BcdI = BcdI(:,:,1);
DapiI = imread(DapiFiles(i).name);
DapiI = DapiI(:,:,1);
%%
DapiILevel = graythresh(DapiI);
bw = im2bw(DapiI, DapiILevel+1.5*(DapiILevel));
figure,
imshow(bw)


end



