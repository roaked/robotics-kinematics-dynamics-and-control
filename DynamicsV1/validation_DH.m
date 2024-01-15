function [DH,M] = validation_DH()
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

syms q1 q2 q3 real
syms a2 real


      %d    v     a    alfa  offset    
DH = [ 0   q1     0    pi/2    0;      %link 1
       0   q2    a2    pi/2    0;      %link 2
      q3    0     0       0    0];     %link 3
  
syms lc1 lc2 lc3 m1 m2 m3 real
syms I1x I1y I1z I1xy I1xz I1yz real
syms I2x I2y I2z I2xy I2xz I2yz real
syms I3x I3y I3z I3xy I3xz I3yz real


M.rc{1} = [0;-lc1;0];     %r1_1c1
M.rc{2} = [-lc2;0;0];     %r2_2c2
M.rc{3} = [0;0;-lc3];     %r3_3c3

% M2(1).rc = [0;-lc1;0];     %r1_1c1
% M2(2).rc = [-lc2;0;0];     %r2_2c2
% M2(3).rc = [0;0;-lc3];     %r3_3c3

M.m{1} = m1;
M.m{2} = m2;
M.m{3} = m3;

% M.I{1} = [0 0 0;0 I1y 0; 0 0 0];
% M.I{2} = [0 0 0;0 I2y 0; 0 0 0];

M.I{1} = [I1x I1xy I1xz; I1xy I1y I1yz; I1xz I1yz I1z];
M.I{2} = [I2x I2xy I2xz; I2xy I2y I2yz; I2xz I2yz I2z];
M.I{3} = [I3x I3xy I3xz; I3xy I3y I3yz; I3xz I3yz I3z];

M.kr{1} = 0;
M.kr{2} = 0;
M.kr{3} = 0;
M.kr{4} = 0;

M.Im{1} = 0;
M.Im{2} = 0;
M.Im{3} = 0;
M.Im{4} = 0;

end

