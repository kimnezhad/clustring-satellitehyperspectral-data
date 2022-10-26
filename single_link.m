clear all
close all
clc
image = double(imread('mainpic.tif'));

train = imread('trainbw.tif');
% train2 = imread('trainnew.tif');
test = imread('testbw.tif');
%
% train(train2 == 1) = 1;
% train(train2 == 2) = 2;
% train(train2 == 3) = 3;
% train(train2 == 4) = 4;

% Random Band Selection
Random_Bands = [12,185,86,84,85];
% Random_Bands = [1,2,3,4,5];
% Random_Bands = randi([0,210],1,5);
image5 = image(:,:,Random_Bands);

X = zeros(size(image5,1) * size(image5,2),size(image5,3));
for i =1:size(image5,3)
    b = image5(:,:,i);
    X(:,i) = b(:);
end
for i=1:5000
    for j=1:5000
            dist_e=(X(i,1)-X(j,1))^2 +(X(i,2)-X(j,2))^2+(X(i,3)-X(j,3))^2+(X(i,4)-X(j,4))^2+(X(i,5)-X(j,5))^2;
             mini_dist = sqrt(dist_e);
                    ty(i,j)=mini_dist;
    end
end

   while 1

        [l,z]=min_dist(ty);
        [ty,z] = mini_swap(ty,l,z);

          if(l>z) te=l;
                l=z;
                z=te;
          end
        [d,e]=size(ty);  
        for b=2:d
            for f=1:b
              ty(b,f) = ty(f,b);
            end
        end
        disp('After Reducing Dimension:');
        [ty]= delete(ty,z);
%         disp(ty);
        [d,e]=size(ty);
        disp(' Dsl = ');
%         disp(ty);
        if d==2 && e==2
          break;
        end
   end
   
function [ty,z] = mini_swap(ty,l,z)
 [o,p] = size(ty);
    for j=1:o
      if(ty(l,j)> ty(z,j))  
          ty(l,j)=ty(z,j);
      end
    end
 end

function [l,z] = min_dist(ty)
[m,n]=size(ty);
l=0;
z=0;
mino=999999999999999;
     for i=1:m
        for j=1:m
          if  ty(i,j)<mino && ty(i,j)>0
                        mino=ty(i,j);
                        l=i;
                        z=j;
              
           end
        end
    end
disp('Minimum value between cluster: ');
  disp(l);
  disp(z);
end

