function descriptor = descriptor(type,img,p,q,dim)
for i=1:length(p)
   if p(i)<=dim || q(i)<=dim || q(i)>=size(img,2)-dim || p(i)>=size(img,1)-dim
       p(i) = 0;
       q(i) = 0;
   end
end
p(p==0) = [];
q(q==0) = [];
No_corners = length(p);
step = floor(dim/2);
if strcmpi(type,'DN')
    for i=1:No_corners
            window = img(p(i)-step:p(i)+step,q(i)-step:q(i)+step);
            descriptor(i,:) = reshape(window',1,dim^2);
    end

elseif strcmpi(type,'Gradient')
    for i=1:No_corners
        window = img(p(i)-1:p(i)+1,q(i)-1:q(i)+1);
        descriptor(i,:) = reshape(window',1,dim^2);
    end
    
elseif strcmpi(type,'Moment')
    for i=1:No_corners
       window =  img(p(i)-1:p(i)+1,q(i)-1:q(i)+1);
       c = [0 0 0 0 1 1 1 2 2];c = reshape(c,3,3);c = c';
       z = [0 1 2 3 0 1 2 0 1];z = reshape(z,3,3);z = z';
       for j=1:3
%            for u=1:3
                for k=1:3
                    m(j,k) = sum(sum(j^c(k)*k^z(k)*window));
                end
%            end
       end
       descriptor(i,:) =  reshape(m,1,9);
    end
end

end