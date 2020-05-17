function func_phi_a = fphi_a(vt, phit)
phit_x = phit(1, :, :);
phit_x = dementionReduction(phit_x);
phit_y = phit(2, :, :);
phit_y = dementionReduction(phit_y);
% vtx, phit_x, phit_y 100*100
funcphi_a_x = interp2(dementionReduction(vt(1, :, :)), phit_x, phit_y, 'spline');
% vty, phit_x, phit_y 100*100
funcphi_a_y = interp2(dementionReduction(vt(2, :, :)), phit_x, phit_y, 'spline');
func_phi_a(1, :, :) = funcphi_a_x;
func_phi_a(2, :, :) = funcphi_a_y;
