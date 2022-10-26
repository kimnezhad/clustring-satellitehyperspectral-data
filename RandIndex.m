function [TP,TN,FP,FN,RI,JI] = RandIndex(C,test)

t = [test(:),[1:length(test(:))]'];
M = find(t(:,1) ~= 0);

b1 = zeros(size(test));
b1(C(:,:,1) == 1) = 1;
b1(C(:,:,2) == 1) = 2;
b1(C(:,:,3) == 1) = 3;
b1(C(:,:,4) == 1) = 4;
TP = 0; TN = 0; FP = 0; FN = 0;
for i =1:200
    if rem(i,2) == 0
    m = M;
    else
        m = [M(1369:end);M(1:1368)];
    end
    for j = 1:1368
        p1 = t(m(1) , 1);
        n = randi([1,length(m)],1,1);
        if m(n) ~= m(1)
            p2 = t(m(n) , 1);
        end
        
        pc1 = b1(t(m(1),2));
        pc2 = b1(t(m(n),2));
        
        if (p2 == p1) & (pc1 == pc2) %same class same cluster
            TP = TP + 1;
        elseif (p2 ~= p1) & (pc1 == pc2) %different class same cluster
            FP = FP + 1;
        elseif (p2 ~= p1) & (pc1 ~= pc2) %different class different cluster
            TN = TN + 1;
        elseif (p2 == p1) & (pc1 ~= pc2) %same class different cluster
            FN = FN + 1;
        end
        
        m(n) = [];
        m(1) = [];
        
    end
end

RI = (TP + TN)/(TP + TN + FP + FN);
JI = (TP)/(TP + FP + FN);

name = {'Same Class','Different Class'};

Same_Cluster = [TP;FP];
Different_Cluster = [FN;TN];
table(Same_Cluster,Different_Cluster,'rownames',name)

end