%sum to mono and normalize audio

function result = prepareAnalysis(audioData)    
    monoAudio = mean(audioData,2);
    ratio = 1/max(abs(monoAudio));
    result = monoAudio * ratio;
end