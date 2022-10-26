function M = MeanComputer(image_rb,C)
c = zeros(size(image_rb,1),size(image_rb,2));
for i =1:size(image_rb,3)
    b = image_rb(:,:,i);
    for j = 1:size(C,3)
        c(C(:,:,j) == 1) = b(C(:,:,j) == 1);
        M(i,j) = mean(mean(c));
    end
end

end