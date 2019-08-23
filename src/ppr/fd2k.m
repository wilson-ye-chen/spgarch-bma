function d2k = fd2k(in1,in2)
%FD2K
%    D2K = FD2K(IN1,IN2)

%    This function was generated by the Symbolic Math Toolbox version 7.1.
%    27-Oct-2017 12:40:40

a1 = in1(:,1);
a2 = in1(:,2);
a3 = in1(:,3);
b1 = in2(:,1);
b2 = in2(:,2);
b3 = in2(:,3);
t2 = a1.*2.0-b1.*2.0;
t3 = a1-b1;
t4 = a2-b2;
t5 = a3-b3;
t6 = t3.^2;
t7 = t4.^2;
t8 = t5.^2;
t9 = t6+t7+t8+1.0;
t10 = a2.*2.0-b2.*2.0;
t11 = 1.0./t9.^(5.0./2.0);
t12 = 1.0./t9.^(3.0./2.0);
t13 = a3.*2.0-b3.*2.0;
d2k = [t12-t2.^2.*t11.*(3.0./4.0),t12-t10.^2.*t11.*(3.0./4.0),t12-t11.*t13.^2.*(3.0./4.0)];