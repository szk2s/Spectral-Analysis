function ridgeVisualize(t,fridge,rvals)
    hold on
    plot3(t,fridge,rvals,'k','linewidth',4)
    hold off
    ax = gca;
%     ax.YScale = 'log';
    ax.ZScale = 'log';
end