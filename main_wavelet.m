%% Configuration
addpath('./lib');
run('initialize.m');
% edit 'config' manually in the workspace

%% Audio import
[audio, Fs] = audioread(config.inputFilename);
audio = prepareAnalysis(audio);  %sum to mono and normalize audio 

audio = audio(0.5*Fs:1.5*Fs); %if you want to crop input file.

sound(audio, Fs);
%% Wavelet Transform

[cfs,f] = cwt(audio',Fs,'WaveletParameters',[14,200]);
p = abs(cfs);
p = normalizeMatrix(p); p = p.*0.999;%  normalize
sampleIdxes = 0:1:size(audio,1)-1;
t = sampleIdxes / Fs;
%% Fourier Transform (you can skip)

[p2,f2,t2] = spectrumAnalyse(audio, Fs, config.lowestFreq, ...
    config.timeResolution, config.freqResolution,...  
    config.resolutionMode);    
p2 = normalizeMatrix(p2); p2 = p2.*0.999;     %  normalize
 
%% plot (you can skip)
figure(1)
surf(t, f, log10(p), 'EdgeColor', 'none');
axis xy; 
axis tight; 
colormap(jet); view(0,90);
xlabel('Time');
ylabel('Frequency');
colorbar;
set(gca,'YScale','log');
title 'Wavelet Transform';

figure(2)
surf(t2, f2, log10(p2), 'EdgeColor', 'none');
axis xy; 
axis tight; 
colormap(jet); view(0,90);
xlabel('Time');
ylabel('Frequency');
colorbar;
set(gca,'YScale','log');
title 'Fourier Transform';


%% plot3D (you can skip)
figure(1)
surf(t, f, p, 'EdgeColor', 'none');
axis tight; 
xlabel('Time');
ylabel('Frequency');
set(gca,'YScale','log');
title 'Wavelet Transform';

figure(2)
surf(t2, f2, p2, 'EdgeColor', 'none');
axis tight; 
xlabel('Time');
ylabel('Frequency');
set(gca,'YScale','log');
title 'Fourier Transform';

%% Convert to json to text
bpm = config.bpm;
ppqr = config.ppqr;

p =normalizeMatrix(p);
step = 60/bpm/ppqr; %1/tick (=60/bpm/ppqr)のステップ
ticks = min(t):step:max(t); 
jsonAmps = interp1(t, p',ticks)';
jsonAmps = horzcat(jsonAmps, zeros(size(jsonAmps,1),1));
jsonTimecode = horzcat(ticks,ticks(1,end)*2-ticks(1,end-1));

data.freqs = f;
data.amps = jsonAmps;
data.times = jsonTimecode;
data.soundname = config.soundname;
jsonStr = jsonencode(data);

fid = fopen(strcat('./export/', config.soundname, '_', datestr(now, 'yyyymmdd'),'.json'), 'w');
if fid == -1, error('Cannot create JSON file'); end
fwrite(fid, jsonStr, 'char');
fclose(fid);

%% Convert to csv and file export
%  interpolate and add  0 to last amplitude etc....  
 [csvAmps, csvFreqs, csvTimecode] = csvData(t, f, p, config.bpm, config.ppqr);  
 csvExport(csvAmps, csvFreqs, csvTimecode, config.soundname, config.outputFolder); 
 save(strcat('./mat/', config.soundname, '_', datestr(now, 'yyyymmdd'), '.mat'));
 
 
 save(strcat('./mat/', config.soundname, '_', datestr(now, 'yyyymmdd'), '.mat'));