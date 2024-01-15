%% Generate Matlab and Simulink Code for KR6
%  Create Simulink Library file KR6_Lib.mdl
%new_system('KR6_Lib','Library');
%open_system('KR6_Lib');

%% DH table for KR6 Robot
DH_KR6 = KR6();

%% Direct Kinematics and Jacobian
[KR6_T,J]=DKin(DH_KR6);
KR6_R=KR6_T(1:3,1:3);
KR6_p=KR6_T(1:3,4);

%Generate optimized embeded Matlab function blocks for Simulink
%matlabFunctionBlock('KR6_Lib/KR6_Direct_Kinematics',KR6_R,KR6_p,J);

%% Save library in current Directory
%save_system('KR6_Lib');
%close_system('KR6_Lib');
