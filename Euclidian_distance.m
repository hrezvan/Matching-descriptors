function [index_list,out_distance] = Euclidian_distance(a,b)
for i=1:length(a)
    aa = a(i,1:9);
    for j=1:length(b)
        bb = b(j,1:9);
        for k=1:9
            d(k) = (aa(k)-bb(k))^2;
        end
        distance(j) = sqrt(sum(d));
    end
    min_dist = min(distance(distance>0));
    for index=1:length(distance)
        if distance(index) == min_dist
%             index_list(i) = index;
            break
        end
    end
    out_distance(i) = min_dist;
    index_list(i) = index;
end

end