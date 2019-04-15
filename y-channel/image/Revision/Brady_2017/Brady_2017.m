function Brady_2017
spheres
% ellipsoids
% EDif_SR
end

function visc = visc_Brady(h, SR)
vfrac = 0.01;
A = 1+2.5*vfrac;
B = -3*vfrac/16;
U0 = 20;
a = 2.2;


tau_R = 2;
if h < U0*tau_R
    Pe = SR*h/U0;
    Pe_R = a/h;
else
    Pe = SR*tau_R;
    Pe_R = a/(U0*tau_R);
end
visc = A + B*(1/Pe_R)^2*(1-(Pe/4)^2)/(1+(Pe/4)^2)^2;
end

function visc = visc_Brady_ellipse(h, SR)
vfrac = 0.01;
B = 0.88;
U0 = 20;
alpha = -15;
a = 10; % length scale of E. coli force dipole
Pe_R = a/h;
K = 1.5;
aspect_ratio = 1.7/0.5;
visc = 1 + 2.5*vfrac - (-0.2*B*alpha*Pe_R + (1+B)/4) * 3*vfrac/(4*Pe_R^2) ...
    * K * aspect_ratio;
end

function dif = FEDif_1(SR)
% viscosity difference between h=50 and h=25 for certain shear rate
h50 = visc_Brady(50, SR);
h25 = visc_Brady(25, SR);
dif = abs(h50 / h25);
end

function EDif_SR
SR = 0:0.1:20;
for i = 1: numel(SR)
    dif(i) = FEDif_1(SR(i));
end
plot(SR, dif, 'LineWidth', 3);
set(gca,...
    'XScale', 'linear',...
    'box', 'on',...
    'LineWidth', 1.5,...
    'FontSize', 16,...
    'XLim', [1.2 20]);
xlabel('$\dot\gamma$ (s$^{-1}$)', 'Interpreter', 'latex', 'FontSize', 24);
% ylabel('$\Delta\eta_{max}$', 'Interpreter', 'latex', 'FontSize', 24);
ylabel('$\eta_{max}/\eta_{min}$', 'Interpreter', 'latex', 'FontSize', 24);
end

function spheres
% This function plots the viscosity \eta as a function of confinement length
% scale h, predicted by Takatori & Brady, PRL, 2017. (spheres)
h = linspace(1, 128);
SR = 2.1;
co = varycolor(numel(SR));
hold on;
for j = 1: numel(SR)
    for i = 1: numel(h)
        x(i) = visc_Brady(h(i), SR(j));
    end
    plot(h, x, 'Color', co(j, :), 'DisplayName', num2str(SR(j)),...
        'LineWidth', 3);
end
hold off;
hl = legend;
set(gca,...
    'box', 'on',...
    'LineWidth', 1.5,...
    'FontSize', 16,...
    'XLim', [25 128],...
    'YLim', [.94 1.06]);
set(hl,...
    'FontSize', 14,...
    'NumColumns', 2,...
    'Location', 'Northwest');
xlabel('$h$ ($\mu$m)', 'Interpreter', 'latex', 'FontSize', 24);
ylabel('$\eta/\eta_0$', 'Interpreter', 'latex', 'FontSize', 24);
% gtext('$\frac{\eta}{\eta_0}=1+\frac{5}{2}\phi-\frac{3\phi}{16}(\frac{1}{Pe_R})^2(\frac{1-(Pe/4)^2}{[1+(Pe/4)^2]^2})$',...
%     'Interpreter', 'latex', 'FontSize', 13);
end

function ellipsoids
% This function plots the viscosity \eta as a function of confinement length
% scale h, predicted by Takatori & Brady, PRL, 2017. (ellipsoids)
h = linspace(1, 128);
SR = 1:1;
co = varycolor(numel(SR));
hold on;
for j = 1: numel(SR)
    for i = 1: numel(h)
        x(i) = visc_Brady_ellipse(h(i), SR(j));
    end
    plot(h, x, 'Color', co(j, :), 'DisplayName', num2str(SR(j)),...
        'LineWidth', 3);
end
hold off;
hl = legend;
set(gca,...
    'box', 'on',...
    'LineWidth', 1.5,...
    'FontSize', 16,...
    'XLim', [25 50]);
set(hl,...
    'FontSize', 14,...
    'NumColumns', 2,...
    'Location', 'Northwest');
xlabel('$h$ ($\mu$m)', 'Interpreter', 'latex', 'FontSize', 24);
ylabel('$\eta/\eta_0$', 'Interpreter', 'latex', 'FontSize', 24);
% gtext('$\frac{\eta}{\eta_0}=1+\frac{5}{2}\phi-\frac{3\phi}{16}(\frac{1}{Pe_R})^2(\frac{1-(Pe/4)^2}{[1+(Pe/4)^2]^2})$',...
%     'Interpreter', 'latex', 'FontSize', 13);
end