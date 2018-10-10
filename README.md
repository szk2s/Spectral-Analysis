# Usage  
    
First, please add "lib" folder to Matlab path.  

### sum to mono and normalize audio  
```
audioData = prepareAnalysis(audioData);  
```
###  Time frequency analysis  
```
[p,f,t] = spectrumAnalyse(audioData,Fs);  
```
### decimate frequency bins    
pのfrequencyのbinの間引き    
```
[p,f] = decimBins(p,f,16);  
```  
### normalize  
```
p=normalizeMatrix(p);  
```  
###  Visualize  
```
spectrumVisualize(t,f,p);  
```  
###  detect the ridges  
```
numRidges = 15;
[rvals, fridge] = detectRidge(p,f,numRidges);  
```  
###  visualize the ridges on the spectrum
```
spectrumVisualize(t,f,p); 
ridgeVisualize(t,fridge,rvals)  
```  
  
<!-- ###  rescale  
素材によってはMIDIコンバートするときはやった方がいいものも  
```
logAmps = log10(amplitudes);  
rescaledAmps = rescale(logAmps, 'InputMin', -5.5);  
```   -->
### interpolate and add  0 to last amplitude etc....  
```
bpm = 120;
ppqr = 96;
[csvAmps, csvFreqs, csvTimecode] = csvData(t,fridge,rvals,bpm,ppqr);  
```  
    
