function func_b = f_b(vt)
%% calculate transpose(Dvt) * vt + div(vt* transpose(vt)
X = vt(1, :, :);
Y = vt(2, :, :);
X = dementionReduction(X);
Y = dementionReduction(Y);
%for each pixel
for x_dir = 1:100
    for y_dir = 1: 100
        %transpose(Dvt_each) * vt_each
        vt_each = vt(:,x_dir,y_dir);
        vx= vt_each(1,1);
        vy= vt_each(2,1);
        Dvt_each = [Dx(vx) Dy(vx); Dx(vy) Dy(vy)];
        left_each(:,x_dir,y_dir) = transpose(Dvt_each) * vt_each; 
        %div(vt* transpose(vt);
        x = X(x_dir,y_dir);
        y = Y(x_dir,y_dir);
        right(:,x_dir,y_dir) = [Dx(x*x)+ Dy(x*y); Dx(y*x)+ Dy(y*y)];
    end
end
%transpose(Dvt) * vt + div(vt* transpose(vt);
Result_equa = left_each + right;
%% do smoothing
Result_equa_x = Result_equa(1, :, :);
Result_equa_y = Result_equa(2, :, :);
Result_equa_x = dementionReduction(Result_equa_x);
Result_equa_y = dementionReduction(Result_equa_y);
func_b(1, :, :) = -smooth(Result_equa_x,16);
func_b(2, :, :) = -smooth(Result_equa_y,16);