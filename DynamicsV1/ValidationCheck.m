function [G1,PHI1,B1] = ValidationCheck()
%Validation check
syms q1 q2 q3 dq1 dq2 dq3 real
syms a2 real
syms g positive
syms lc1 lc2 lc3 m1 m2 m3 real
syms I1x I1y I1z I1xy I1xz I1yz real
syms I2x I2y I2z I2xy I2xz I2yz real
syms I3x I3y I3z I3xy I3xz I3yz real

syms G1 PHI1 B1 real
G1(1) = 0;
G1(2) = m3*g*(a2*cos(q2)+(q3-lc3)*sin(q2)) + m2*g*(a2-lc2)*cos(q2);
G1(3) = -m3*g*cos(q2);

PHI1(1) = -(I2z-I2x+I3z-I3x+m2*(a2-lc2)^2 + m3*a2^2 - m3*(q3-lc3)^2)*sin(2*q2)*dq1*dq2 ...
    + 2*(m3*a2*(q3-lc3)-I2xz-I3xz)*cos(2*q2)*dq1*dq2 ...
    + ((I2xy+I3xy)*cos(q2)+(I2yz+I3yz)*sin(q2))*dq2^2 ...
    + m3*((q3-lc3)*(1-cos(2*q2))+a2*sin(2*q2))*dq1*dq3;

PHI1(2) = (I2xz+I3xz-m3*a2*q3+m3*a2*lc3)*dq1^2*cos(2*q2) + 2*m3*dq2*dq3*(q3-lc3)...
    + 1/2*(I2z-I2x+I3z-I3x+m2*(a2-lc2)^2 + m3*a2^2 - m3*(q3-lc3)^2)*dq1^2*sin(2*q2);

PHI1(3) = -1/2 * m3*(a2*sin(2*q2)+2*(q3-lc3)*sin(q2)^2)*dq1^2 - m3*(q3-lc3)*dq2^2;

B1(1,1) = (I2z-I2x+I3z-I3x+m2*(a2-lc2)^2 + m3*a2^2 - m3*(q3-lc3)^2)*cos(q2)^2 ...
    + (m3*a2*(q3-lc3)-I2xz-I3xz)*sin(2*q2)+I1y+I2x+I3x+m3*(q3-lc3)^2;

B1(1,2) = (I2xy+I3xy)*sin(q2) - (I2yz+I3yz)*cos(q2);
B1(2,1) = B1(1,2);
B1(1,3) = 0;
B1(3,1) = 0;
B1(2,2) = I2y+I3y+m3*(q3-lc3)^2+(a2-lc2)*(m3*a2+m2*(a2-lc2))+m3*a2*lc2;
B1(2,3) = -m3*a2;
B1(3,2) = B1(2,3);
B1(3,3) = m3;

% G1 = simplify(G1);
% PHI1 = simplify(PHI1);
% B1 = simplify(B1);
end