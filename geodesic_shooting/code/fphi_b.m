function func_phi_b = fphi_b(vt, phit)
for x_dir = 1:100
    for y_dir = 1:100
        %transpose(Dvt_each) * vt_each
        phit_each = phit(:,x_dir,y_dir);
        phit_x= phit_each(1,1);
        phit_y= phit_each(2,1);
        Dvt_each = [Dx(phit_x) Dy(phit_x); Dx(phit_y) Dy(phit_y)];
        vt_each = vt(:,x_dir,y_dir);
        func_phi_b(:,x_dir,y_dir) = - Dvt_each * vt_each;
    end
end