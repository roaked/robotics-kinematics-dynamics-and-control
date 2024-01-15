function A = DHTransf( p )
%DHTransf Returns the symbolic D-H joint transformation matrix
% p = [d v a alpha offset]

% Check if it is a rotational or translational joint and add offset
% symbolically.
q=symvar(p);        %get symbolic variable from p
if isequal(p(2),q)  %if it is a rotational joint
    p(2)=p(2)+p(5);  %add offset to v
else
    p(1)=p(1)+p(5);  %add offset to d
end

% Build D-H matrix
A=[cos(p(2)) -sin(p(2))*cos(p(4))  sin(p(2))*sin(p(4)) p(3)*cos(p(2));
   sin(p(2))  cos(p(2))*cos(p(4)) -cos(p(2))*sin(p(4)) p(3)*sin(p(2));
   0          sin(p(4))            cos(p(4))                 p(1)    ;
   0             0                    0                        1     ];

end

