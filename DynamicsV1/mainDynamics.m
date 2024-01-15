% clear all
% clc

%[DH_tab,M] = KR6_e;
[DH_tab,M] = KR6;
%[DH_tab, M] = validation_DH();

n = size(DH_tab,1);

dq = sym('dq',[n 1],'real');
ddq = sym('ddq',[n 1],'real');

w0 = [0 0 0]';
dw0 = [0 0 0]';
syms g positive;

%ddp0 = [0 0 g]';   %Validation example
ddp0 = [0 -g 0]';   %KR6

%Only links, motor parameters set to 0
Ml = M;
Ml.kr(:) = {0};
Ml.Im(:) = {0};

%Only motors, link parameters set to 0
Mm = M;
Mm.m(:) = {0};
Mm.rc(:) = {[0;0;0]};
Mm.I(:) = {zeros(3,3)};

%tau = NewtonEuler(DH_tab, M, dq, ddq, w0, dw0, ddp0);
display(datetime('now'));
%% Gravity:
G = Newton_Euler(DH_tab, M, zeros(n,1),zeros(n,1),[0;0;0],[0;0;0],ddp0);
G = simplify(G);

%% Mass Matrix:
% tau = Newton_Euler(DH_tab, M, zeros(n,1), ddq, [0;0;0], dw0, [0;0;0]);
% B = simplify(jacobian(tau(:,1:end),ddq));

tau_l = Newton_Euler(DH_tab, Ml, zeros(n,1), ddq, [0;0;0], dw0, [0;0;0]);
B = simplify(jacobian(tau_l(:,1:end),ddq));

tau_m = Newton_Euler(DH_tab, Mm, zeros(n,1), ddq, [0;0;0], dw0, [0;0;0]);
Bm = simplify(jacobian(tau_m(:,1:end),ddq));

%% Centrifugal / Coriolis:
% phi_1 = Newton_Euler(DH_tab, M, dq, zeros(n,1), w0, [0;0;0], [0;0;0]);
% phi = simplify(phi_1);

phi_l = Newton_Euler(DH_tab, Ml, dq, zeros(n,1), w0, [0;0;0], [0;0;0]);
phi = simplify(phi_l);

phi_m = Newton_Euler(DH_tab, Mm, dq, zeros(n,1), w0, [0;0;0], [0;0;0]);
phim = simplify(phi_m);
%% Simulink block:
display(datetime('now'));

% new_system('KR6_Lib_dyn');
% open_system('KR6_Lib_dyn')
% matlabFunctionBlock('KR6_Lib_dyn/Dynamics',B,Bm,phi,phim,G)
% save_system('KR6_Lib_dyn');
% close_system('KR6_Lib_dyn');
% display(datetime('now'));

% new_system('KR6_e_Lib_dyn');
% open_system('KR6_e_Lib_dyn')
% matlabFunctionBlock('KR6_e_Lib_dyn/Dynamics',B,Bm,phi,phim,G)
% save_system('KR6_e_Lib_dyn');
% close_system('KR6_e_Lib_dyn');
% display(datetime('now'));
