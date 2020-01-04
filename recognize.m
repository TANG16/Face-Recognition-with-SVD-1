function recognize(strnumber)

%Global Variable from traindata.m
global n;
global imagesize;
global epsDisFace;
global epsDisTrain;
global U;
global rank;
global coorvec;
global immean;

%Read Test From File
epsDisFace=10000;
epsDisTrain=10000;
timage=imread(['test/' strnumber '.jpg']);
timage=imresize(timage, [imagesize imagesize]);
if size(timage,3)==3 %Check If Is RGB
    timage=rgb2gray(timage);
end
timage=double(timage);

%Normalize The Image like DataBase Images
timage=timage(:)-immean; 
tcoorvec=U(:,1:rank)'*timage;

%Calculate The Distance From FaceSpace
tepsDisFace=norm(timage-(U(:,1:rank)*tcoorvec));
%If Is In FaceSpace
if tepsDisFace<epsDisFace
    
    %Calculate The Distance of tcoorvec To each column of coorvec
    distances=zeros(n,1);
    for i=1:n
        distances(i,1)=norm(coorvec(:,i)-tcoorvec);
    end
    %Take The Minimum
    [minDis index]=min(distances(:,1));
    
    %If Is In DataBase
    if minDis<epsDisTrain
        disp(sprintf('The Face Is Number %d Person',index));
    %If Is Not In DataBase
    else
        disp('The Face Isnot In DataBase!')
    end
else
    %If Is Not A Face
    disp('Test Image Is Estimated As Nonface!');
end

end