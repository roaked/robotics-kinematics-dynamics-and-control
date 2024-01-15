load('IST.mat')
%load('oval.mat')

%% Centralized controller gains

Kr = 100;
wn_cent = 15*ones(7,1);
%wn_cent = [20 20 20 20 30 20 50];
qsi_cent = 1;

Kd_Cent = zeros(7,7);
Kp_Cent = zeros(7,7);

for i=1:7
    Kd_Cent(i,i) = 2*qsi_cent*wn_cent(i);
    Kp_Cent(i,i) = wn_cent(i)^2;
end

%% Decentralized controller gains
Bmax =[89.24 5.319 4.876 2.516 2.111 2.101 2.1];

wn_decent = [20 30 40 40 60 60 60];
qsi_decent = sqrt(2)/2 * ones(7,1);

Kd_Decent = zeros(7,7);
Kp_Decent = zeros(7,7);

for i=1:7
    Kd_Decent(i,i) = 2*qsi_decent(i)*wn_decent(i)*Bmax(i);
    Kp_Decent(i,i) = wn_decent(i)^2*Bmax(i);
end
