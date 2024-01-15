function Robot = KR6()
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
Robot = [ q1    0     0    -pi/2    0;      %link 1
          0    q2    a2     pi/2    0;      %link 2
          0    q3    a3        0    0;      %link 3
          0    q4    a4     pi/2    0;      %link 4
         d5    q5     0    -pi/2    0;      %link 5
          0    q6     0     pi/2    0;      %link 6
         d7    q7     0       pi    0];     %link 7
end

