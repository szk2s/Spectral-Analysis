function csvExport(csvAmps, csvFreqs, csvTimecode, soundname, outputFolder)
    csvwrite(strcat(outputFolder, '/', soundname, '_amps.csv'), csvAmps);
    csvwrite(strcat(outputFolder, '/', soundname, '_freqs.csv'), csvFreqs);
    csvwrite(strcat(outputFolder, '/', soundname, '_timecode.csv'), csvTimecode);
end

