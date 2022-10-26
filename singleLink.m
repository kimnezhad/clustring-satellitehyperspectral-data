function chc = singleLink(X)
ch = [1:length(X)]';
hc = [1:length(X)]';
chc = [1:length(X)]';
 
for i = 1:max(hc)
    idx1 = hc == i;
    if sum(idx1) == 0
        continue
    end
    id1 = ch(idx1);
    sl = [];
    for j = 1:max(hc)
        if j == i
            continue
        end
        idx2 = hc == j;
        if sum(idx2) == 0
            continue
        end
        id2 = ch(idx2);
        d = zeros(sum(idx1),sum(idx2),3);
        x1 = [X(idx1,:),id1];
        x2 = [X(idx2,:),id2];
        [d(:,:,3),d(:,:,2)] = meshgrid(id2,id1);
        
        for k2=1:sum(idx2)
            d(:,k2,1) = sqrt((x1(:,1) - x2(k2,1)).^2 +(x1(:,2) - x2(k2,2)).^2 +(x1(:,3) - x2(k2,3)).^2 +(x1(:,4) - x2(k2,4)).^2 +(x1(:,5) - x2(k2,5)).^2);
        end
        [r,c]=find(d(:,:,1) == min(min(d(:,:,1))));
        sl(end+1,:) = [i,j,d(r,c,1)];
        
    end
    [~,nn]=min(sl(:,3));
    ii = sl(nn,1); jj = sl(nn,2);
    chc((hc == ii | hc == jj)) = min(ii,jj);
    hc((hc == ii | hc == jj)) = [];
 
end
 
end
