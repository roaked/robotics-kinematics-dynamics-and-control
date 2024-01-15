%% Oval
load('oval.mat')
figure
plot(p_d.Data(150:1100,1),p_d.Data(150:1100,3))

xlim([-0.9 0.5])
ylim([0.2 1.6])
xlabel('X [m]')
ylabel('Z [m]')
title('Trajectory of the end effector')
set ( gca, 'xdir', 'reverse' )

%% IST
load('IST.mat')

figure
plot(p_d.Data(:,1),p_d.Data(:,3))
xlim([-0.6 1])
ylim([0 1.6])
xlabel('X [m]')
ylabel('Z [m]')
title('Trajectory of the end effector')
set ( gca, 'xdir', 'reverse' )