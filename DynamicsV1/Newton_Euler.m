function tau = Newton_Euler(DH,M,dq,ddq,w0,dw0,ddp0)

%% Initialization
n = size(DH,1);
z0 = [0;0;1];

R = sym('R',[3 3 n+1],'real');
R(:,:,end) = eye(3);
r = sym('r',[3 1 n],'real');

w = sym('w',[3 1 n],'real');
dw = sym('dw',[3 1 n],'real');

ddp = sym('ddp',[3 1 n],'real');
ddpc = sym('ddpc',[3 1 n],'real');

dwm = sym('dwm', [3 1 n], 'real');
zm = sym('zm', [3 1 n+1], 'real');

f = sym('f',[3 1 n+1],'real');
f(:,:,end) = [0;0;0];

u = sym('mu',[3 1 n+1],'real');
u(:,:,end) = [0;0;0];

tau = sym('tau',[1 n],'real');

dq = [dq;0];
ddq = [ddq;0];

%% Direct kinematics
for i = 1:n
    Ti = DHTransf(DH(i,:));
    Ri = Ti(1:3,1:3);
    ri = Ti(1:3,4);
    R(:,:,i) = simplify(Ri);        %Ri-1_i
    r(:,:,i) = simplify(Ri'*ri);    %ri_i-1,i
    zm(:,:,i+1) = Ri(:,3);          %zi-1_mi
end
zm(:,:,1) = z0;
zm(:,:,end) = [0;0;0];


%% Forward recursion

%i = 1
if ~isempty(symvar(DH(1,2))) %Revolute joint
    w(:,:,1) = R(:,:,1)'*(w0+dq(1)*z0);
    dw(:,:,1) = R(:,:,1)'*(dw0+ddq(1)*z0+dq(1)*Skew(w0)*z0);
    ddp(:,:,1) = R(:,:,1)'*ddp0 + Skew(dw(:,:,1))*r(:,:,1) + ...
        + Skew(w(:,:,1))*(Skew(w(:,:,1))*r(:,:,1));
    
else    %Prismatic joint
    w(:,:,1) = R(:,:,1)'*w0;
    dw(:,:,1) = R(:,:,1)'*dw0;
    ddp(:,:,1) = R(:,:,1)'*(ddp0+ddq(1)*z0) + 2*dq(1)*Skew(w(:,:,1))*R(:,:,1)'*z0 + ...
        + Skew(dw(:,:,1))*r(:,:,1) + Skew(w(:,:,1))*Skew(w(:,:,1))*r(:,:,1);
end

ddpc(:,:,1) = ddp(:,:,1) + Skew(dw(:,:,1))*M.rc{1} + Skew(w(:,:,1))*Skew(w(:,:,1))*M.rc{1};
dwm(:,:,1) = dw0 + M.kr{1}*ddq(1)*zm(:,:,1) + M.kr{1}*dq(1)*Skew(w0)*zm(:,:,1); 

%i = 2 to end
for i = 2:n
    if ~isempty(symvar(DH(i,2))) %Revolute joint
        w(:,:,i) = R(:,:,i)'*(w(:,:,i-1)+dq(i)*z0);
        dw(:,:,i) = R(:,:,i)'*(dw(:,:,i-1)+ddq(i)*z0+dq(i)*Skew(w(:,:,i-1))*z0);
        ddp(:,:,i) = R(:,:,i)'*ddp(:,:,i-1) + Skew(dw(:,:,i))*r(:,:,i) + ...
            + Skew(w(:,:,i))*Skew(w(:,:,i))*r(:,:,i);
    
    else    %Prismatic joint
        w(:,:,i) = R(:,:,i)'*w(:,:,i-1);
        dw(:,:,i) = R(:,:,i)'*dw(:,:,i-1);
        ddp(:,:,i) = R(:,:,i)'*(ddp(:,:,i-1)+ddq(i)*z0) + 2*dq(i)*Skew(w(:,:,i))*R(:,:,i)'*z0 + ...
            + Skew(dw(:,:,i))*r(:,:,i) + Skew(w(:,:,i))*Skew(w(:,:,i))*r(:,:,i);
    end

    ddpc(:,:,i) = ddp(:,:,i) + Skew(dw(:,:,i))*M.rc{i} + Skew(w(:,:,i))*Skew(w(:,:,i))*M.rc{i};
    dwm(:,:,i) = dw(:,:,i-1) + M.kr{i}*ddq(i)*zm(:,:,i) + M.kr{i}*dq(i)*Skew(w(:,:,i-1))*zm(:,:,i); 
end

%% Backwards recursion

for i=n:-1:1
    f(:,:,i) = R(:,:,i+1)*f(:,:,i+1) + M.m{i}*ddpc(:,:,i);

    u(:,:,i) = -Skew(f(:,:,i))*(r(:,:,i)+M.rc{i}) + R(:,:,i+1)*u(:,:,i+1) - Skew(M.rc{i}) * R(:,:,i+1)*f(:,:,i+1) + ...
        + M.I{i}*dw(:,:,i) + Skew(w(:,:,i))*M.I{i}*w(:,:,i) + ...
        + M.kr{i+1}*ddq(i+1)*M.Im{i+1}*zm(:,:,i+1) + M.kr{i+1}*dq(i+1)*M.Im{i+1}*Skew(w(:,:,i))*zm(:,:,i+1);
end


%% Torques

for i = 1:n
    if ~isempty(symvar(DH(i,2))) %Revolute joint
        tau(i) = u(:,:,i)'*R(:,:,i)'*z0 + M.kr{i}*M.Im{i}*dwm(:,:,i)'*zm(:,:,i);
        
    else  %Prismatic joint
        tau(i) = f(:,:,i)'*R(:,:,i)'*z0 + M.kr{i}*M.Im{i}*dwm(:,:,i)'*zm(:,:,i);
        
    end
end

%Finished
end
