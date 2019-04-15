orientation1 = [179.782
9.518
173.182
16.594
179.726
14
18.749
8.795
24.558
3.663
45.9
8.41
7.735
22.009
10.647
9.947];
orientation2 = [13.5 6.1 2 28.8 24.1 22.9 29.2 32 20.3 8.5 20.2 8.5 23.9 ...
    24.3 18.4 14.3 12.8 48.3 21.4 9.9 14.6 9.4 17.4 20.9 11.3 168.7];
orientation = [orientation1' orientation2];
histogram(orientation, 18);
set(gca,...
    'FontSize', 16,...
    'Box', 'on',...
    'LineWidth', 1.5);

xlabel('$\theta$($^\circ$)', 'Interpreter', 'latex', 'FontSize', 24);
ylabel('N', 'Interpreter', 'latex', 'FontSize', 24);

probx = 0:10:180;
proby = [12 11 12 1 2 zeros(1, 12) 1 3]/42;
plot(probx, smooth(proby), 'LineWidth', 2);
set(gca,...
    'FontSize', 16,...
    'Box', 'on',...
    'XLim', [0 180],...
    'YLim', [0 0.3],...
    'LineWidth', 1.5,...
    'XScale', 'linear');
xlabel('$\theta$($^\circ$)', 'Interpreter', 'latex', 'FontSize', 24);
ylabel('$P$', 'Interpreter', 'latex', 'FontSize', 24);