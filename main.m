%% Configuration
addpath('./functions');
run('initialize.m');
% edit config manually in the workspace

%% Audio import
[audio, Fs] = audioread(config.inputFilename);
audio = prepareAnalysis(audio);  %sum to mono and normalize audio 
sound(audio, Fs);

% audio = audio(0.5*Fs:3*Fs); %if you want to crop

%% Frequency Analysis

spectrumTest(audio, Fs, config.lowestFreq, ...
    config.timeResolution, config.freqResolution,...
    config.resolutionMode, ...
    config.freqScale, config.ampScale);  

% if the result was not enough, change parameter and try again 

%% Prepare for ridge detection

[p,f,t] = spectrumAnalyse(audio, Fs, config.lowestFreq, ...
    config.timeResolution, config.freqResolution,...  
    config.resolutionMode);    
p = normalizeMatrix(p);     %  normalize
 
%% Optional treqtment
% % decimate frequency bins    
% % pのfrequencyのbinの間引き    
 
% [p,f] = decimBins(p,f,16);  

%%   Visualize  
 
spectrumVisualize(t, f, p, config.freqScale, config.ampScale);  

%% Detect the ridges  
 
[rvals, fridge] = detectRidge(p, f, config.numRidges);  

%% Visualize the ridges on the spectrum
spectrumVisualize(t, f, p, config.freqScale, config.ampScale); 
ridgeVisualize(t, fridge, rvals, config.freqScale, config.ampScale)  

%% Optional data treatment
% set values under threshold to zero.
rvals(rvals < 1e-4) = 0;

% log rescale
% logAmps = log10(amplitudes);  
% rescaledAmps = rescale(logAmps, 'InputMin', -5.5);  
% 
%% convert to csv and file export
%  interpolate and add  0 to last amplitude etc....  
 [csvAmps, csvFreqs, csvTimecode] = csvData(t, fridge, rvals, config.bpm, config.ppqr);  
 csvExport(csvAmps, csvFreqs, csvTimecode, config.soundname, config.outputFolder); 
 save(strcat('./mat/', config.soundname, '_', datestr(now, 'yyyymmdd'), '.mat'));
