function [p2,f2] = decimBins(p,f,r)
    for i = 1:size(p,2)
        for j = 1: size(p,1)/r
            p2(j,i) =  mean(p((j-1)*r+1:j*r,i));
        end
    end
    
   for k = 1:size(f,1)/r
       f2(k,1) = mean(f((k-1)*r+1:k*r,1));
   end
end