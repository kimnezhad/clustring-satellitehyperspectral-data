clear,clc,close all

%% Q3
% Read Images
image = double(imread('mainpic.tif'));

train = imread('trainbw.tif');
% train2 = imread('trainnew.tif');
test = imread('testa.tif');

% Random Band Selection
Random_Bands = [1,2,4,185,84];

image_rb = image(:,:,Random_Bands);

%% 3-1

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
    % for i =1:100
    Distm2 = manhatandist(image_rb,M2);;
    
    C2 = Classifier(image_rb,Distm2);
    
    M2 = MeanComputer(image_rb,C2);
    
    SSE2(i) = sum(sum(Distm2.^2));
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

% Confiusion Matrix and accuracy
[TP2,TN2,FP2,FN2,RI2,JI2] = RandIndex(C2,test)

% plot SSE by Iterations
figure
plot(SSE2),set(gca,'xtick',[1:length(SSE2)])
ylabel('SSE')
xlabel('Iteration'),grid on
title('Train Center')

%
