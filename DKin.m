function [T,J] = DKin( Robot )
%DKin Homogeneous Transformation Matrix for Robot Direct Kinematics and
%   T=[R p; 0 1]

n=size(Robot,1);      %get number of robot joints
q=symvar(Robot);      %get names of robot coordinates

%Initial z
z =[0; 0; 1];
%p =[0; 0; 0];

syms Jp Jo J
syms pex pey pez
pe=[pex; pey; pez];

Jp(1:3,1:n) = 0;
Jo(1:3,1:n) = 0;

%Direct kinematics for first link
T=DHTransf(Robot(1,:));

%Prismatic joint
Jp(:,1) = z;
%Jo(:,1) is 0, already defined

for i=2:n
    z = T(1:3,3);
    p = T(1:3,4);
    
    %Joi = zi-1 for Revolute Joints
    Jo(1:3,i) = z;
    
    %Jp = zi-1 x (pe-p(i-1)) for Revolute Joints
    Jp(1:3,i) = cross(z,(pe-p)); 
    
    %Direct kinematics for remaining links
    T=T*DHTransf(Robot(i,:));
end

%End effector position
p = T(1:3,4);

J = [Jp;Jo];

%Replace values of the end effector position
J = subs(J,{pex,pey,pez},{p(1),p(2),p(3)});

%Simplify
T=simplify(T);
J=simplify(J);

end