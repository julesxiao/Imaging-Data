%**************Question 1(b)********************
%step size
[t,y] = differentStep(0.1);
disp("approximation solution at t = 1 is " + y(11));
disp("approximation solution at t = 2 is " + y(21));
disp("approximation solution at t = 3 is " + y(31));
disp("approximation solution at t = 4 is " + y(41));
disp("approximation solution at t = 5 is " + y(51));
disp("Error of the Euler method at t = 1 is " + abs(y_exact(1) -y(11)));
disp("Error of the Euler method at t = 2 is " + abs(y_exact(2) -y(21)));
disp("Error of the Euler method at t = 3 is " + abs(y_exact(3) -y(31)));
disp("Error of the Euler method at t = 4 is " + abs(y_exact(4) -y(41)));
disp("Error of the Euler method at t = 5 is " + abs(y_exact(5) -y(51)));
%**************Question 1(c)**********************
% plot the closed-form solution
[t1,y1] = differentStep(0.1);
[t2,y2] = differentStep(0.05);
%get the solution at t = {1,2,3,4,5}
sol_h2 = [y2(21),y2(41),y2(61),y2(81),y2(101)];
[t3,y3] = differentStep(0.01);
sol_h3 = [y3(101),y3(201),y3(301),y3(401),y3(501)];
[t4,y4] = differentStep(0.005);
sol_h4 = [y4(201),y4(401),y4(601),y4(801),y4(1001)];
[t5,y5] = differentStep(0.001);
sol_h5 = [y5(1001),y5(2001),y5(3001),y5(4001),y5(5001)];
%% plot the exact solution
t0 = 0:0.01:5;
y0 = 1 + 0.5 * exp(-4 * t0) - 0.5 * exp(-2*t0);
%% plot the approximation solution
hold on;
plot(t0,y0)
plot(t1,y1)
plot(t2,y2)
plot(t3,y3)
plot(t4,y4)
plot(t5,y5)
legend('exact solution','h = 0.1', 'h = 0.05', 'h = 0.01', 'h = 0.005', 'h = 0.001');
hold off;