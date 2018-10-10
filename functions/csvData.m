function [csvAmps, csvFreqs, csvTimecode] = csvData(t,fridge,rvals,bpm,ppqr)
    rvals=normalizeMatrix(rvals);
    step = 60/bpm/ppqr; %1/tick (=60/bpm/ppqr)のステップ
    ticks = min(t):step:max(t); 
    csvAmps = interp1( t,rvals,ticks)';
    csvAmps = horzcat(csvAmps, zeros(size(csvAmps,1),1));
    csvFreqs = interp1(t,fridge,ticks)';
    csvFreqs = horzcat(csvFreqs, csvFreqs(:,end));
    csvTimecode = horzcat(ticks,ticks(1,end)*2-ticks(1,end-1));
end