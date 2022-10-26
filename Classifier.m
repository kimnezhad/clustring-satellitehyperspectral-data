function C = Classifier(image_rb,Dist)
C = zeros(size(image_rb,1),size(image_rb,2),size(Dist,2));


[~,n] = min(Dist');
n = n';

n = reshape(n,size(image_rb,1),size(image_rb,2));

for i = 1:size(Dist,2)
    C(:,:,i) = n == i;
end

end