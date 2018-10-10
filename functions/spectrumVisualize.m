function spectrumVisualize(t,f,p)
    mesh(t,f,p)
    ax = gca;
%     ax.YScale = 'log';
    ax.ZScale = 'log';
end