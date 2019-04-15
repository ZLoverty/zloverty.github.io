% function vd_y_experiment
clear;
load('vp_data.mat');
H = [30 50 83];
y = [];
vb = [];
vp = [];
Hrec = [];
fieldname = fieldnames(vp_data);
for i = 1: numel(fieldname)
    yt = vp_data.(fieldname{i}).y;
    ym = max(yt);
    for j = 1: numel(yt)
        if yt(j) > ym/2
            yt(j) = H(i) - yt(j);
        end
    end
    vbt = vp_data.(fieldname{i}).vb;
    vpt = vp_data.(fieldname{i}).vp;
    Hrect = ones(numel(yt), 1)*H(i);
    y = [y; yt];
    vb = [vb; vbt];
    vp = [vp; vpt];
    Hrec = [Hrec; Hrect];
end
vtable = [y vb vp Hrec];
vtable = sortrows(vtable);


fitx = vtable(:, 1);
fity = smooth(abs(vtable(:, 3)-vtable(:, 2)));
plot(fitx, fity, 'LineWidth', 3);
ft = fittype('a*x^-1', 'dependent', 'y', 'independent', 'x', 'coefficient', {'a'});
fitresult = fit(fitx(fitx>0), fity(fitx>0), ft);
hold on
hfit = line(fitx, fitresult.a*fitx.^-1, 'Color', 'r');
set(gca,...
    'FontSize', 16,...
    'Box', 'on',...
    'LineWidth', 1.5,...
    'XScale', 'log',...
    'YScale', 'log',...
    'XLim', [2 50],...
    'YLim', [2 100]);
xlabel('$y$ ($\mu$m)', 'interpreter', 'latex', 'FontSize', 24);
ylabel('$V_d$ ($\mu$m/s)','interpreter', 'latex', 'FontSize', 24);
text(6, 20, '-1', 'FontSize', 16)