function [xx, actual_LD] = gen_dipole_dist(LD, xrange)
% Linear density
Prob = 0.1;
Lattice_interval = Prob/LD;% Lattice interval
xx = -xrange/2:Lattice_interval:xrange/2;
for i = 1: numel(xx)
    if rand < Prob
        dipole_exist(i) = 1;
    else
        dipole_exist(i) = 0;
    end
end
xx = xx(dipole_exist==1);
actual_LD = numel(xx)/xrange;
end