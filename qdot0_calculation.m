% Initialization:
syms q1 q2 q3 q4 q5 q6 q7 real;
q = [q1;q2;q3;q4;q5;q6;q7];
n = length(q);

% Maximum and minimum joint angles:
qMinMax = [-1 1;
           -170 170;
           -270 90;
           -170 170;
           -185 185;
           -120 120;
           0 360];

qMinMax = deg2rad(qMinMax);

% Symbolic expression for w(q):
w = sym(0);
for i=1:n
    w = w + ((q(i)-mean(qMinMax(i,:)))/(qMinMax(i,2)-qMinMax(i,1)))^2;
end
w = w*(-1/(2*n));

% Symbolic expression for qdot0:
qdot0 = sym(zeros(n,1));
for i=1:n
    qdot0(i)=diff(w,q(i));
end
