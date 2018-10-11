function spectrumTest(audiodata, Fs, lowestFreq, timeResolution, freqScale, ampScale)
    pspectrum(audiodata,Fs,'spectrogram',...
    'TimeResolution', timeResolution,...
    'Leakage',1,'OverlapPercent',85,'MinThreshold',-60,...
    'FrequencyLimits',[lowestFreq, Fs/4],'Reassign',true);
    setAx(freqScale,ampScale);
end