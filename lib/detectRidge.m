function [rvals, fridge] = detectRidge(p,f,numRidges,penval,numFrequencyBins)

    [fridge,~,lridge] = tfridge(p,f,penval,'NumRidges',...
        numRidges,'NumFrequencyBins',numFrequencyBins);

    rvals = p(lridge);
end
% 
% function [rvals, fridge] = detectRidge(p,f,numRidges)
% 
%     penval = 0.1;     %Penalty to frequency changes
% 
%     [fridge,~,lridge] = tfridge(p,f,penval,'NumRidges',numRidges,'NumFrequencyBins',100);
% 
%     rvals = p(lridge);
% end