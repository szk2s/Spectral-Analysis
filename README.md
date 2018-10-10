# Note  
    
First, please add lib folder to Matlab path.  

### sum to mono and normalize audio  
audioData = prepareAnalysis(audioData);  
  
###  Time Frequency Analysis  
  
[p,f,t] = spectrumAnalyse(audioData,Fs);  
  
### pのfrequencyのbinの間引き  
[p,f] = decimBins(p,f,16);  
  
### pのnormalize  
p=normalizeMatrix(p);  
  
###  Visualize  
spectrumVisualize(t,f,p);  
  
###  detect the ridges  
[rvals, fridge] = detectRidge(p,f,numRidges);  
  
###  visualize the ridges  
ridgeVisualize(t,fridge,rvals)  
  
  
###  rescale 素材によってはMIDIコンバートするときはやった方がいいものも  
logAmps = log10(amplitudes);  
rescaledAmps = rescale(logAmps, 'InputMin', -5.5);  
  
### interpolate and add  0 to last amplitude etc....  
[csvAmps, csvFreqs, csvTimecode] = csvData(t,fridge,rvals,bpm,ppqr);  
  
    