%%%%%%% Load Images %%%%%%%%%%%%%
clear all;clc;close all;
BcdFiles = dir('C:\Users\che7oz\Desktop\Line 2493 9312 Bcd pooled\*_c3.jpg');
HbFiles = dir('C:\Users\che7oz\Desktop\Line 2493 9312 Bcd pooled\*_c3.jpg'); 
DapiFiles = dir('C:\Users\che7oz\Desktop\Line 2493 9312 Bcd pooled\*_c4.jpg');
for i=1:length(BcdFiles)
    I=imread(HbFiles(i).name);I=I(:,:,1);
    BcdI=imread(BcdFiles(i).name);BcdI=BcdI(:,:,1);
    DapiI=imread(DapiFiles(i).name);DapiI=DapiI(:,:,1);
%%%%%% Embryo Idnetification %%%%%%%%
    DapiILevel = graythresh(DapiI);
    bw = im2bw(DapiI,DapiILevel-.019);
%     figure,imshow(bw);
    [N,M]=bwlabel(bw,4);
    stats=regionprops(N,'all');
    embryoArea=[stats.Area];
    [embryoSize,embryoID]=max(embryoArea);
    N(find(N~=embryoID))=0;
    NN=(N~=0);
    bw2=bw.*NN;
%     figure,imshow(bw2);
    DapiI=DapiI.*uint8(NN);
%%%%% Rotate & Crop %%%%%%%%%%%%%%%
    theta=-stats(embryoID).Orientation;
    I=imrotate(I,theta);
    DapiI=imrotate(DapiI,theta);
    BcdI=imrotate(BcdI,theta);
    W=imrotate(double(bw2),theta);
%     figure,imshow(W);
    BW = edge(W,'canny');
    m0=find(sum(BW,1)>0);
    n0=find(sum(BW,2)>0);
    I1=imcrop(I,[min(m0),min(n0),max(m0)-min(m0),max(n0)-min(n0)]);
    DapiI1=imcrop(DapiI,[min(m0),min(n0),max(m0)-min(m0),max(n0)-min(n0)]);
    BcdI1=imcrop(BcdI,[min(m0),min(n0),max(m0)-min(m0),max(n0)-min(n0)]);
    theta2=180*double(max(max(BcdI1(:,1:50)))<max(max(BcdI1(:,max(m0)-min(m0)-48:max(m0)-min(m0)+1)))); % Anterior-posterior
    I1=imrotate(I1,theta2,'crop');
    DapiI1=imrotate(DapiI1,theta2,'crop');
    BcdI1=imrotate(BcdI1,theta2,'crop');
    FlipVerticalorNot=0;    % Dorsal-ventral
    if FlipVerticalorNot==1,
        I1=flipud(I1);
        DapiI1=flipud(DapiI1);
        BcdI1=flipud(BcdI1);
    end
%     figure,imshow(I1);
%     figure,imshow(DapiI1);
%     figure,imshow(BcdI1);
%     impixelregion;
%%%%%%%% Measure the intensity - relative length %%%%%%%%%%%
    BW2 = edge(DapiI1,'canny');
    I2 = uint8(BW2);
%     figure,imshow(255-I2*255);impixelregion;
    m=find(sum(I2,1)>0);
    Bins=50;
    EL(i)=max(m)-min(m)+1;
    L=floor(EL(i)/Bins);
    y=1:Bins;z=1:Bins;centroidx1=1:Bins;centroidy1=1:Bins;
    n=1:length(m);
    for j=1:length(m),
        n(j)=min(find(I2(:,m(j))>0));
    end
    n=smooth(n);n=smooth(n);n=smooth(n);
    n=n';
    EL(i)=max(m)-min(m)+1;
    L=floor(EL(i)/Bins);
    y=1:Bins;z=1:Bins;centroidx1=1:Bins;centroidy1=1:Bins;
    gama=atan(gradient(n));
    radius=10;
    centroidx=round(m-sin(gama)*radius);
    centroidy=round(n+cos(gama)*radius);
    for j=1:Bins,
        centroidx1(j)=centroidx(ceil(0.5*EL(i)-(Bins+1)/2*L+j*L));
        centroidy1(j)=centroidy(ceil(0.5*EL(i)-(Bins+1)/2*L+j*L));
        y(j)=mean2([I1(centroidy1(j),centroidx1(j)-4:centroidx1(j)+4) I1(centroidy1(j)-1,centroidx1(j)-4:centroidx1(j)+3)...
            I1(centroidy1(j)+1,centroidx1(j)-3:centroidx1(j)+4) I1(centroidy1(j)-2,centroidx1(j)-3:centroidx1(j)+3) I1(centroidy1(j)+2,centroidx1(j)-3:centroidx1(j)+3)...
            I1(centroidy1(j)-3,centroidx1(j)-2:centroidx1(j)+3) I1(centroidy1(j)+3,centroidx1(j)-3:centroidx1(j)+2) I1(centroidy1(j)-4,centroidx1(j)-2:centroidx1(j)+2)...
            I1(centroidy1(j)+4,centroidx1(j)-2:centroidx1(j)+2)]);
        z(j)=mean2([BcdI1(centroidy1(j),centroidx1(j)-4:centroidx1(j)+4) BcdI1(centroidy1(j)-1,centroidx1(j)-4:centroidx1(j)+3)...
            BcdI1(centroidy1(j)+1,centroidx1(j)-3:centroidx1(j)+4) BcdI1(centroidy1(j)-2,centroidx1(j)-3:centroidx1(j)+3) BcdI1(centroidy1(j)+2,centroidx1(j)-3:centroidx1(j)+3)...
            BcdI1(centroidy1(j)-3,centroidx1(j)-2:centroidx1(j)+3) BcdI1(centroidy1(j)+3,centroidx1(j)-3:centroidx1(j)+2) BcdI1(centroidy1(j)-4,centroidx1(j)-2:centroidx1(j)+2)...
            BcdI1(centroidy1(j)+4,centroidx1(j)-2:centroidx1(j)+2)]);
    end
%%%%%%%% Measure the intensity - absolute length %%%%%%%%%%%
    L2=round(900/Bins);
    Bins2=floor(EL(i)/L2);
    y2=1:Bins2;z2=1:Bins2;centroidx2=1:Bins2;centroidy2=1:Bins2;
    for j=1:Bins2,
        centroidx2(j)=centroidx(j*L2-ceil(L2/2)+1);
        centroidy2(j)=centroidy(j*L2-ceil(L2/2)+1);
        y2(j)=mean2([I1(centroidy2(j),centroidx2(j)-4:centroidx2(j)+4) I1(centroidy2(j)-1,centroidx2(j)-4:centroidx2(j)+3)...
            I1(centroidy2(j)+1,centroidx2(j)-3:centroidx2(j)+4) I1(centroidy2(j)-2,centroidx2(j)-3:centroidx2(j)+3) I1(centroidy2(j)+2,centroidx2(j)-3:centroidx2(j)+3)...
            I1(centroidy2(j)-3,centroidx2(j)-2:centroidx2(j)+3) I1(centroidy2(j)+3,centroidx2(j)-3:centroidx2(j)+2) I1(centroidy2(j)-4,centroidx2(j)-2:centroidx2(j)+2)...
            I1(centroidy2(j)+4,centroidx2(j)-2:centroidx2(j)+2)]);
        z2(j)=mean2([BcdI1(centroidy2(j),centroidx2(j)-4:centroidx2(j)+4) BcdI1(centroidy2(j)-1,centroidx2(j)-4:centroidx2(j)+3)...
            BcdI1(centroidy2(j)+1,centroidx2(j)-3:centroidx2(j)+4) BcdI1(centroidy2(j)-2,centroidx2(j)-3:centroidx2(j)+3) BcdI1(centroidy2(j)+2,centroidx2(j)-3:centroidx2(j)+3)...
            BcdI1(centroidy2(j)-3,centroidx2(j)-2:centroidx2(j)+3) BcdI1(centroidy2(j)+3,centroidx2(j)-3:centroidx2(j)+2) BcdI1(centroidy2(j)-4,centroidx2(j)-2:centroidx2(j)+2)...
            BcdI1(centroidy2(j)+4,centroidx2(j)-2:centroidx2(j)+2)]);
    end
    figure,imshow(DapiI1);hold on; title(DapiFiles(i).name);
%     figure,imshow(BcdI1);hold on;
    scatter(m,n,'r','.');hold on;
    scatter(centroidx1,centroidy1,'b','.');hold on;
    scatter(centroidx2,centroidy2,'b','.');hold on;
    scatter(centroidx,centroidy,'b','.');   
%%%%%%%% Record the data %%%%%%%%%%%
    Data(i).EL=EL(i);
    Data(i).relx=centroidx1-min(m)+1;
    Data(i).rely=centroidy1-min(n)+1;
    Data(i).relHb=double(y);
    Data(i).relBcd=double(z);
    Data(i).absx=centroidx2-min(m)+1;
    Data(i).absy=centroidy2-min(n)+1;
    Data(i).absHb=double(y2);
    Data(i).absBcd=double(z2);
    Data(i).name=BcdFiles(i).name;
    disp(['Processing ' num2str(i)]);
end
 if FlipVerticalorNot==0,
      save('2x','Data');
 else save('2x-ventral','Data');
 end
% 