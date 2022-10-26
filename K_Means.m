clear all
close all
clc

%% Q1
%% 1
image = double(imread('mainpic.tif'));
train = imread('trainbw.tif');
test = imread('testa.tif');
% Random Band Selection
Random_Bands = [1,2,4,185,84];
image_rb = image(:,:,Random_Bands);

%% 1-1
K=4
M =zeros(size(image_rb,3),K);
while true
    % Random Centers
    for z =1:size(image_rb,3)
        M(z,:) = randi([min(min(image_rb(:,:,z))),max(max(image_rb(:,:,z)))],1,K);
    end
    
    SSE = [];
    dSSE = [];
    for i = 1:30
        
        Dist = EuclideanDistCompute(image_rb,M);
         
        C = Classifier(image_rb,Dist);
        
        M = MeanComputer(image_rb,C);
        
        SSE(i) = sum(sum(Dist.^2));
        if i>1
            dSSE(i-1) = abs(SSE(i)- SSE(i-1));
            if dSSE(i-1)<1e-10
                break
            end
        end
        
    end
    
    if i<30
        break
    end
end

figure,subplot(221)
imshow(C(:,:,1)),title('Random Center cluster 1')
subplot(222)
imshow(C(:,:,2)),title('Random Center cluster 2')
subplot(223)
imshow(C(:,:,3)),title('Random Center cluster 3')
subplot(224)
imshow(C(:,:,4)),title('Random Center cluster 4')

% Result of Clustering
final = ToRGB(C);
figure
imshow(final)
title('Random Center Clustered image')

% Confiusion Matrix
[TP,TN,FP,FN,RI,JI] = RandIndex(C,test)

% plot SSE by Iterations
figure
plot(SSE),set(gca,'xtick',[1:length(SSE)])
ylabel('SSE')
xlabel('Iteration'),grid on
title('Random Center')

%% 1-2
K = length(unique(train(:))) - 1;
M2 =zeros(size(image_rb,3),K);
% Train Centers
for i = 1:size(image_rb,3)
    b2 = image_rb(:,:,i);
    for j = 1:K
        M2(i,j) = mean(b2(train == j));
    end
end

i = 1;
while true
    Dist2 = EuclideanDistCompute(image_rb,M2);
    
    C2 = Classifier(image_rb,Dist2);
    
    M2 = MeanComputer(image_rb,C2);
    
    SSE2(i) = sum(sum(Dist2.^2));
    if i>1
        dSSE2(i-1) = abs(SSE2(i)- SSE2(i-1));
        if abs(dSSE2(i-1))<1e-10
            break
        end
    end
    i = i + 1;
    
end

figure,subplot(221)
imshow(C2(:,:,1)),title('Train Center cluster 1')
subplot(222)
imshow(C2(:,:,2)),title('Train Center cluster 2')
subplot(223)
imshow(C2(:,:,3)),title('Train Center cluster 3')
subplot(224)
imshow(C2(:,:,4)),title('Train Center cluster 4')

% Result of Clustering
final2 = ToRGB(C2);
figure
imshow(final2)
title('Train Center Clustered image')

% Confiusion Matrix
[TP2,TN2,FP2,FN2,RI2,JI2] = RandIndex(C2,test)

% plot SSE by Iterations
figure
plot(SSE2),set(gca,'xtick',[1:length(SSE2)])
ylabel('SSE')
xlabel('Iteration'),grid on
title('Train Center')


%% 1-2-3
clear SSE3
Random_Bands1 = [1,2,4,185,84];
image6 = image(:,:,Random_Bands1);

X = zeros(size(image_rb,1) * size(image6,2),size(image6,3));
for i =1:size(image6,3)
    b = image6(:,:,i);
    X(:,i) = b(:);
end
Mean_far = mean(X);
for i=1:94249
    for j=1:5
        
        pow_far(i,j)=((X(i,j) - Mean_far(1,j))^2);
        
          end
    end
dist_far=sqrt(sum(pow_far,2));
r1=[1:307]';
r2=repmat(r1,307,1);
r3=[];
for i=1:307
    r3=[r3;i*ones(307,1)];
end

T_F=[dist_far,r2,r3];
 


max_f=zeros(4,3);
for j=1:4
    for i=1:94249
        [g,h]=max(T_F(:,1));
        if i==h
            max_f(j,:,:)=T_F(i,:,:);
            T_F(i,:,:)=0;
        end
    end
end
M3=zeros(5,4);
M3(:,1)=image6(269,99,:);
M3(:,2)=image6(60,41,:);
M3(:,3)=image6(58,42,:);
M3(:,4)=image6(148,131,:);


    for i =1:20
    Dist3 = EuclideanDistCompute(image6,M3);
    
    C3= Classifier(image6,Dist3);
    
    M3 = MeanComputer(image6,C3);
    
    SSE3(i) = sum(sum(Dist3.^2));
    if i>1
        dSSE3(i-1) = abs(SSE3(i)- SSE3(i-1));
        if abs(dSSE3(i-1))<1e-10
            break
        end
    end
    i = i + 1;
    
end

figure,subplot(221)
imshow(C3(:,:,1)),title('Train far Center cluster 1')
subplot(222)
imshow(C3(:,:,2)),title('Train far Center cluster 2')
subplot(223)
imshow(C3(:,:,3)),title('Train  far Center cluster 3')
subplot(224)
imshow(C3(:,:,4)),title('Train far  Center cluster 4')

% Result of Clustering
final = ToRGB(C3);
figure
imshow(final)
title('Train far Center_Clustered image')

% Confiusion Matrix 
[TP3,TN3,FP3,FN3,RI3,JI3] = RandIndex(C3,test)

% plot SSE by Iterations
figure
plot(SSE3),set(gca,'xtick',[1:length(SSE3)])
ylabel('SSE')
xlabel('Iteration'),grid on
title('Train far Center')


