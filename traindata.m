close all;
clear all; %clear Workspace
clc; %clear command Window
 
%defining Global variable to use in recognize function
global n;
global imagesize;
global U;
global rank;
global coorvec;
global immean;
global epsDisFace;
global epsDisTrain;

%enteries
n=10;
imagesize=120;


%Train The DataBase
C=zeros(imagesize^2,n);
for i=1:n
    img=imread(sprintf('train/%d.jpg', i));
    img=imresize(img,[imagesize imagesize]); %Shrink The Size Of Image
    if size(img,3)==3 %If The Image Is RGB
    img=rgb2gray(img);
    end
    img=double(img);
    C(:,i)=img(:);
end
immean=mean(C,2); %Normalize The Matrix to Remove Simillarity 
A=C-immean*ones(1,n);
[U,S,V]=svd(A);
rank=nnz(S);
coorvec=U(:,1:rank)'*A; %Change The Base To Normal
disp('Training The DataBase Is Done Successfully!');
