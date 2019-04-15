% Plot vd-y the boundary layer effect
% Should use with data file vdy_data.mat in the same folder
% The data file should contain the information of parameters used for the
% calculation
clear;
load('vdy_data_cutoff.mat');
LD = vdy_data.LD;
y = vdy_data.y;
vd = vdy_data.vd;
if numel(LD) == size(y, 2)
    disp('Okay data');
else
    disp('Error data');
end

L = 30e-6;
U = 30e-6;
hold on
for i = 3: numel(LD)
    hName = ['h' num2str(i)];
    eval([hName '= line(y(:, i)*1e6, vd(:, i)/U)']);
    set(eval(hName),... 
        'LineWidth', 1.5,...
        'Color', defaultColor(i),...
        'DisplayName', num2str(LD(i)*1e-6));
end
hold off
set(gca,...
    'FontSize', 16,...
    'Box', 'on',...
    'LineWidth', 1.5,...
    'XLim', [0 80],...
    'YLim', [-2 40]);
%     'XScale', 'log',...
%     'YScale', 'log');

xlabel('$y$ ($\mu$m)', 'interpreter', 'latex', 'FontSize', 24);
ylabel('$\left<V_d\right>/v$','interpreter', 'latex', 'FontSize', 24);
fitx = y(:, 6)*1e6;
fity = vd(:, 6)/U;
ft = fittype('a*x^-2', 'dependent', 'y', 'independent', 'x', 'coefficient', {'a'});
fitresult = fit(fitx, fity, ft)
hold on
% line(fitx(fitx>3 & fitx<10), 300*fitx(fitx>3 & fitx<10).^-2, 'Color', 'k', 'LineStyle', '--');
hl = legend(gca,...
    [h3, h4, h5, h6], '1', '2', '4', '8');
hl.Location = 'northeast';
hl.NumColumns = 2;