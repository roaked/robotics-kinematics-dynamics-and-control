function [DH_tab, M] = KR6_big()
%   Returns D-H table of parameters for Robotic Arm
%   Robot=[d v a alpha offset;
%          d v a alpha offset;
%          . . .   .   offset;
%          d v a alpha offset];
%   Use symbolic variables for each joint coordinate of the robot: in the d
%   column for a prismatic joint and in the v column for a rotational
%   joint. Name the variables from q1 to qn. In the last column, insert the
%   coordinate offset for the manipulator Home position.
% 

syms q1 q2 q3 q4 q5 q6 q7 real

%meters
a2 =25*10^-3;
a3 = 315*10^-3;
a4 =35*10^-3;
d5 =-365*10^-3;
d7 = -80*10^-3;

          %d     v     a     alfa  offset      
DH_tab = [ q1     0     0    -pi/2    0;      %link 1
           0    q2    a2     pi/2    0;      %link 2
           0    q3    a3        0    0;      %link 3
           0    q4    a4     pi/2    0;      %link 4
          d5    q5     0    -pi/2    0;      %link 5
           0    q6     0     pi/2    0;      %link 6
          d7    q7     0       pi    0];     %link 7
          

% Masses of links 1 to 7 [kg]
M.m{1} = 54.153;
M.m{2} = 10.526;
M.m{3} = 12.299;
M.m{4} = 4.810;
M.m{5} = 4.582;
M.m{6} = 0.747;
M.m{7} = 0.023;
   

% Centers of mass of link 1 to 7 [m]    
M.rc{1} = [ 0.0004; -0.0005;  0.4416];
M.rc{2} = [-0.0170;  0.0674;  0.0020];
M.rc{3} = [-0.1840; -0.0053; -0.0058];
M.rc{4} = [-0.0246;  0.0000; -0.0161];
M.rc{5} = [ 0.0001; -0.1341;  0.0036];
M.rc{6} = [ 0.0000;  0.0019; -0.0168];
M.rc{7} = [ 0.0000;  0.0000; -0.0075];


% Inertia tensors for links 1 to 7 [kg.m^2]
M.I{1} = [ 1.2211 -0.0033 -0.1784;
            -0.0033  1.3092  0.0012;
            -0.1784  0.0012  1.0273];
        
M.I{2} = [ 0.1277  0.0089       0;
           0.0089  0.0943  0.0009;
                0  0.0009  0.0840];

M.I{3} = [ 0.0639  0.0015  0.0028;
             0.0015  0.2515       0;
             0.0028       0  0.2255];

M.I{4} = [ 0.0164       0  0.0023;
                  0  0.0186       0;
             0.0023       0  0.0136];

M.I{5} = [ 0.0287       0       0;
                  0  0.0096 -0.0003;
                  0 -0.0003  0.0259];

% M.I{6} = [ 0.00098       0       0;
%                   0  0.00092  -0.00003;
%                   0  -0.00003  0.00054];

M.I{6} = [ 0.0010         0       0;
                  0  0.0009       0;
                  0       0  0.0005];


% % % M.I{6} = [ 0.00098       0       0;
% % %                   0  0.00092  0.00003;
% % %                   0  0.00003  0.00054];

M.I{7} = [   3E-6       0       0;
                  0    3E-6      0;
                  0       0   5E-6];


% Define rotors z axis inertias [kg.m^2]:
M.Im{1} = 0.00021;
M.Im{2} = 0.00021;
M.Im{3} = 0.00021;
M.Im{4} = 0.00021;
M.Im{5} = 0.00021;
M.Im{6} = 0.00021;
M.Im{7} = 0.00021;
M.Im{8} = 0;

% M.Im{1} = 0;
% M.Im{2} = 0;
% M.Im{3} = 0;
% M.Im{4} = 0;
% M.Im{5} = 0;
% M.Im{6} = 0;
% M.Im{7} = 0;
% M.Im{8} = 0;

% Define gear reduction rations:
M.kr{1} = 100;
M.kr{2} = 100;
M.kr{3} = 100;
M.kr{4} = 100;
M.kr{5} = 100;
M.kr{6} = 100;
M.kr{7} = 100;
M.kr{8} = 0;

% M.kr{1} = 0;
% M.kr{2} = 0;
% M.kr{3} = 0;
% M.kr{4} = 0;
% M.kr{5} = 0;
% M.kr{6} = 0;
% M.kr{7} = 0;
% M.kr{8} = 0;

end

