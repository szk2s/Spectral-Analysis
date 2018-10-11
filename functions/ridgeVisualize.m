function ridgeVisualize(t,fridge,rvals,freqScale,ampScale)
    hold on
    plot3(t,fridge,rvals,'k','linewidth',4)
    hold off
    setAx(freqScale,ampScale);
end