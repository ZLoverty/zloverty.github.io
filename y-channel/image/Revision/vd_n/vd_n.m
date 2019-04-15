clear;
load('vdy_data_cutoff.mat');
LD = vdy_data.LD;
U0 = 22;
c = vdy_data.parameter.c;
yy = vdy_data.y;
yy = yy*1e6;
vd = vdy_data.vd;
vd = vd*1e6;
vda = zeros(numel(LD), 1);
hold on
for i = 1: numel(LD)
    y = yy(:, i);
    v = vd(:, i);
%     indv = ~isnan(v);
%     y = y(indv);
%     v = v(indv);
    h = 30;
    ind = y(:, 1)<h;
    vda(i) = 2 * trapz(y(ind), v(ind))/h;
end
plot(LD'*1e-6, vda/U0, 'LineWidth', 1.5, 'Marker', 'o');
set(gca,...
    'FontSize', 16,...
    'Box', 'on',...
    'LineWidth', 1.5,...
    'XLim', [-1 9],...
    'YLim', [-10/22 160/22]);
%     'XScale', 'log',...
%     'YScale', 'log');

xlabel('$n$ ($\mu$m$^{-1}$)', 'interpreter', 'latex', 'FontSize', 24);
ylabel('$\left<V_d\right>/v$','interpreter', 'latex', 'FontSize', 24);