function v = vf_blake
% vd_y_single_point_force
% vd_y_collective
% vd_y_single_force_dipole
% v_theory
% compare_experiment
% concentration_dependence
% gen_average_flow_field_data(n);
% plot_average_data
end

function plot_average_data
% Plot average vd_y using data in av_data.mat file. 
load('av_data.mat');
x = av_data.x3av;
y = av_data.vav;
err = std(av_data.vraw, 0, 1);
hold on
errorbar(x, y/22, err/22, 'LineStyle', 'none', 'Color', 'k');
plot(x, y/22, 'LineWidth', 2, 'Color', 'k');
hold off
set(gca,'XLim', [0 50],...
    'Box', 'on', 'FontSize', 16);
xlabel('$y$ ($\mu$m)', 'interpreter', 'latex', 'FontSize', 24);
ylabel('$V_d/v$','interpreter', 'latex', 'FontSize', 24);
end

function [x3av, vav] = gen_average_flow_field_data(n)
% Generate average velocity field data over n runs. Output av_data.mat that
% contains the average data (x3av, vav) and raw data (x3raw, vraw).
LD = 2e6;
[x3, v] = vd_y_collective_arg(LD);
x3sum = zeros(size(x3));
vsum = zeros(size(x3));
x3raw = zeros(n, size(x3, 2));
vraw = zeros(n, size(x3, 2));
for i = 1: n
    [x3, v] = vd_y_collective_arg(LD);
    x3sum = x3sum + x3;
    vsum = vsum + v;
    x3raw(i, :) = x3;
    vraw(i, :) = v;
end
x3av = x3sum/n;
vav = vsum/n;
av_data = struct();
av_data.x3av = x3av;
av_data.vav = vav;
av_data.x3raw = x3raw;
av_data.vraw = vraw;
save('av_data.mat', 'av_data');
end

function concentration_dependence
% Concentration dependence of vd_h curve
LD = [0.5 1 2 4 8]*1e6;
h = logspace(1.39, 2.1);
hold on
for i = 1: numel(LD)
    [x3, v] = vd_y_collective_arg(LD(i));
    for j = 1: numel(h)
        av(j) = trapz(x3(x3<h(j)), v(x3<h(j)))/h(j)*2;
    end
    plot(h, av/22, 'LineWidth', 3);
end
hold off
set(gca, 'XScale', 'log', 'YScale', 'log',...
    'Box', 'on', 'FontSize', 16);
hold on
plot(h(h>50&h<80), 50*h(h>50&h<80).^-1, 'LineStyle', '--', 'Color', 'k');
hold off
text(63, 0.9, '-1', 'FontSize', 16);
xlabel('$h$ ($\mu$m)', 'interpreter', 'latex', 'FontSize', 24);
ylabel('$\left<V_d\right>/v$','interpreter', 'latex', 'FontSize', 24);
end

function [x3, v] = vd_y_collective_arg(LD)
% Generate velocity disturbance induced by a whole boundary layer of
% bacteria aligning in the same direction. 
% x3 is the distance from boundary to point of interest.
% v is the disturbance velocity in flow direction.
% Take args and disable plots
% LD = 2e6;
xrange = 1e-3;
[xx, actual_LD] = gen_dipole_dist(LD, xrange);
theta = 20/180*pi;
F = [cos(theta) 0 sin(theta)]*0.43e-12;
x3 = linspace(0,128,100)*1e-6;
mu = 1e-3;
d = 2.2e-6;
v = zeros(size(x3));
for j = 1: numel(x3)
    x = [0, 0, x3(j)];
    for i = 1: numel(xx)
        y = [xx(i) 0 1*1e-6];
        v(j) = v(j) + vf_blake_force_dipole(x, y, d, F, mu);
    end
end
x3 = x3*1e6;
v = v*1e6;
end

function compare_experiment
% Compare the vd_y dependence of experiment and theory.
% Theory
[x3, v] = vd_y_collective;
% Experimental data
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
figure(3);
he = plot(fitx, fity, 'LineWidth', 3);
ft = fittype('a*x^-1', 'dependent', 'y', 'independent', 'x', 'coefficient', {'a'});
fitresult = fit(fitx(fitx>0), fity(fitx>0), ft);
hold on
hfit = line(fitx, fitresult.a*fitx.^-1, 'Color', 'k', 'LineStyle', '--');
set(gca,...
    'FontSize', 16,...
    'Box', 'on',...
    'LineWidth', 1.5,...
    'XScale', 'log',...
    'YScale', 'log');
%     'XLim', [2 50],...
%     'YLim', [2 100]);
xlabel('$y$ ($\mu$m)', 'interpreter', 'latex', 'FontSize', 24);
ylabel('$V_d$ ($\mu$m/s)','interpreter', 'latex', 'FontSize', 24);
text(6, 20, '-1', 'FontSize', 16);

%plot theory
hold on 
ht = plot(x3(x3<40&x3>2), v(x3<40&x3>2), 'LineWidth', 3, 'Color', 'r');
hold off
hl = legend(gca, [he hfit ht], 'Experiment', 'Fitting curve', 'Theory');
hl.Location = 'southwest';
end

function v_theory
% Predict the velocity profile resulting from boundary layer effect
% Use vd_y_collective function to generate vd_y data.
% !Velocity data is not final because of the random distribution of force
% dipole, need to average many runs. 
v0 = 22;
h = 30;
SR = 30;
ytheory = yy/30-0.5;
[x3, vd] = vd_y_collective;
x3 = x3(x3<=h);
vd = vd(x3<=h);
vd2 = fliplr(vd);
v = -SR/h*x3.^2 + SR*x3;
x3t = x3/h-0.5;
figure(3);
hold on
hv = plot(x3t, v/v0, 'LineStyle', '--',...
    'LineWidth', 1.5,...
    'Color', defaultColor(3),...
    'DisplayName', 'Parabola');
hvd = plot(x3t, (vd+vd2)/v0,'LineStyle', '--',...
    'LineWidth', 1.5,...
    'Color', defaultColor(2),...
    'DisplayName', 'Disturbance');
hsup = plot(x3t, (v + vd + vd2)/v0,...
    'LineWidth', 3,...
    'Color', 'r',...
    'DisplayName', 'Superposition');
hold off
set(gca,...
    'FontSize', 16,...
    'Box', 'on',...
    'LineWidth', 1.5,...
    'XLim', [-0.5 0.5],...
    'YLim', [0 13],...
    'XMinorTick', 'on');
ax = gca;
ax.XAxis.TickValues = [-0.5 -0.25 0 0.25 0.5];
ax.XAxis.MinorTickValues = [-0.375 -0.125 0.125 0.375];
hl = legend(gca,...
    [hv hvd hsup], 'Poiseuille',  'Disturbance', 'Superposition');
hl.Location = 'best';
hl.NumColumns = 1;
set(hl, 'FontSize', 20);
xlabel('$y/h$', 'Interpreter', 'latex', 'FontSize', 24);
ylabel('$V/v$', 'Interpreter', 'latex', 'FontSize', 24);
end

function [x3, v] = vd_y_collective
% Generate velocity disturbance induced by a whole boundary layer of
% bacteria aligning in the same direction. 
% x3 is the distance from boundary to point of interest.
% v is the disturbance velocity in flow direction.
LD = 2e6;
xrange = 1e-3;
[xx, actual_LD] = gen_dipole_dist(LD, xrange);
theta = 20/180*pi;
F = [cos(theta) 0 sin(theta)]*0.43e-12;
x3 = linspace(0,128,100)*1e-6;
mu = 1e-3;
d = 2.2e-6;
v = zeros(size(x3));
for j = 1: numel(x3)
    x = [0, 0, x3(j)];
    for i = 1: numel(xx)
        y = [xx(i) 0 1e-6];
        v(j) = v(j) + vf_blake_force_dipole(x, y, d, F, mu);
    end
end
x3 = x3*1e6;
v = v*1e6;
plot(x3, v/22, 'LineWidth', 3);
set(gca, 'XScale', 'log', 'YScale', 'log',...
    'Box', 'on', 'FontSize', 16);
hold on
plot(x3(x3>8&x3<30), 15*(x3(x3>8&x3<30)).^-1, 'LineStyle', '--', 'Color', 'k');
hold off
text(18.5, 1, '-1', 'FontSize', 16);
xlabel('$y$ ($\mu$m)', 'interpreter', 'latex', 'FontSize', 24);
ylabel('$V_d/v$','interpreter', 'latex', 'FontSize', 24);
figure(2);
h = logspace(1.39, 2.1);
for i = 1: numel(h)
    av(i) = trapz(x3(x3<h(i)), v(x3<h(i)))/h(i)*2;
end
plot(h, av/22, 'LineWidth', 3);
set(gca, 'XScale', 'log', 'YScale', 'log',...
    'Box', 'on', 'FontSize', 16);
hold on
plot(h(h>50&h<80), h(h>50&h<80).^-1, 'LineStyle', '--', 'Color', 'k');
hold off
text(63, 0.9, '-1', 'FontSize', 16);
xlabel('$h$ ($\mu$m)', 'interpreter', 'latex', 'FontSize', 24);
ylabel('$\left<V_d\right>/v$','interpreter', 'latex', 'FontSize', 24);
end

function vd_y_single_point_force
% Generate single point force velocity field (near boundary) in flow direction.
x3 = linspace(0, 10)*1e-6;
y = [0 0 1]*1e-6;
theta = 20/180*pi;
F = [cos(theta) 0 sin(theta)]*0.43e-12;
mu = 1e-3;
for i = 1: numel(x3)
    x = [0 0 x3(i)];
    v(i) = vf_blake_point_force(x, y, F, mu);
end
plot(x3*1e6, v*1e6, 'LineWidth', 3);
set(gca,...
    'FontSize', 16,...
    'Box', 'on',...
    'LineWidth', 1.5);
xlabel('$y$ ($\mu$m)', 'interpreter', 'latex', 'FontSize', 24);
ylabel('$V_d$ ($\mu$m/s)','interpreter', 'latex', 'FontSize', 24);
end

function vd_y_single_force_dipole
% Generate single force dipole (near boundary) velocity field in flow direction.
x3 = linspace(0, 10)*1e-6;
y = [0 0 1]*1e-6;
theta = 20/180*pi;
F = [cos(theta) 0 sin(theta)]*0.43e-12;
d = 2.2e-6;
mu = 1e-3;
for i = 1: numel(x3)
    x = [0 0 x3(i)];
    [v(i), v1(i), v2(i)] = vf_blake_force_dipole(x, y, d, F, mu);
end
hold on
hsup = plot(x3*1e6, v*1e6, 'LineWidth', 3);
hf = plot(x3*1e6, v1*1e6, 'LineWidth', 1);
hb = plot(x3*1e6, v2*1e6, 'LineWidth', 1);
hpower = plot(x3(x3>3e-6&x3<6e-6)*1e6, 150*(x3(x3>3e-6&x3<6e-6)*1e6).^-2.8,...
    'LineWidth', 1, 'LineStyle', '--', 'Color', 'k');
hold off
text(4.2, 4, '-2.8', 'FontSize', 16);
set(gca, 'XScale', 'log', 'YScale', 'log', 'XLim', [1 10],...
    'FontSize', 16,...
    'Box', 'on',...
    'LineWidth', 1.5);
xlabel('$y$ ($\mu$m)', 'interpreter', 'latex', 'FontSize', 24);
ylabel('$V_d$ ($\mu$m/s)','interpreter', 'latex', 'FontSize', 24);
hl = legend(gca, [hsup hf hb], 'Superposition', 'Forward', 'Backward');
hl.Location = 'southeast';
end

function [v, v1, v2] = vf_blake_force_dipole(x, y, d, F, mu)
% Calculate force dipole flow field (in x1 direction), using Blake 1971
% point force formula.
orientation = F/norm(F);
y1 = y + d/2*orientation;
y2 = y - d/2*orientation;
v1 = vf_blake_point_force(x, y1, F, mu);
v2 = vf_blake_point_force(x, y2, -F, mu);
v = v1 + v2;
end

function v = vf_blake_point_force(x, y, F, mu)
% Calculate point force flow field (in x1 direction), using Blake 1971 formula.
% x: position vector of point of interest % x = [1 0 2];
% y: position vector of point force center % y = [0 0 1];
% F: force vector % F = [1 0 1];
% mu: viscosity of fluid % mu = 1;
% The flow field (in this program the #1 component at x induced by a point
% force at y will be calculated. Image system is considered. Position
% vector of point force image is calculated as
%   yi = y .* [1 1 -1];
% for given y. 
% No-slip boundary is set at x3 = 0, so that the distance between boundary
% and force center, h, is y(3).
%   h = y(3);
h = y(3);
rv = x - y;
r = norm(rv);
yi = y .* [1 1 -1];
Rv = x - yi;
R = norm(Rv);

term1 = F(1)/(8*pi*mu)*( (1/r-1/R) + rv(1)*rv(1)/r^3 - Rv(1)*Rv(1)/R^3 + ...
    2*h*( (h-Rv(3))*R^3 - 3*R*Rv(1)*(h*Rv(1)-Rv(1)*Rv(3)) )/( R^6 ) );
term2 = F(2)/(8*pi*mu)*( rv(1)*rv(2)/r^3 - Rv(1)*Rv(2)/R^3 - ...
    6*h*( (h*Rv(1)-Rv(1)*Rv(3))*Rv(2) )/( R^5 ) );
term3 = F(3)/(8*pi*mu)*( rv(1)*rv(3)/r^3 - Rv(1)*Rv(3)/R^3 - ...
    2*h*(  -Rv(1)*R^3 - 3*R*Rv(3)*(h*Rv(1) - Rv(1)*Rv(3)) )/( R^6 ) );

v = term1 + term2 + term3;
end

