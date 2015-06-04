%% Path & feature comparison between EKF-SLAM and IEKF-SLAM
clear all; close all;
load 'Data/truth.mat';
x0   = truth.x; % truth data
load 'Data/EKFobs4.mat'; % EKF-SLAM on DLR Data
step = 3298;
x1 = data.path;
z1 = data.pos(step).x;
pos1=data.pos;
load 'Data/IEKF2obs4.mat';% IEKF-SLAM on DLR Data
x2 = data.path;
z2 = data.pos(step).x;
pos2=data.pos;

%% Path comparison
figure('name','Path Comparison','color','w');
hold on; box on; axis equal;
xlim([-50, 20]);ylim([-30, 30]);
xlabel('x(m)'); ylabel('y(m)');
%
I = imread('Data\satelliteMap.jpg','JPG'); % Read the DLR satellite map.
% image([-59 37],[34 -47.5],I,'alphadata',0.7);
timeSeq = 1 : step;
plot( x1(1, timeSeq), x1(2, timeSeq), '-.b', 'linewidth', 2 );
plot( x2(1, timeSeq), x2(2, timeSeq), '-r',  'linewidth', 2 );
% plot( x0(1, timeSeq), x0(2, timeSeq), '-g',  'linewidth', 2 );
% print('-depsc','pathCompare.eps');

%% Features comparison
% figure('name','Observations Comparison','color','w');
% hold on; box on; axis equal;
% xlim([-54, 25]);ylim([-32, 34]);
% set(gca,'xtick',[],'ytick',[]);
% set(gca,'Color','w','XColor','w','YColor','w')
% set(gca,'Visible','off')
% I = imread('Data\gtMap.jpg','JPG'); % read the DLR building map.
% image([-48 24],[29 -30],I,'alphadata',1);
plot(z1(4:2:end), z1(5:2:end), 'b+', 'MarkerSize', 8,...
        'LineWidth', 1.5);
plot(z2(4:2:end), z2(5:2:end), 'o', 'MarkerSize', 8,...
        'MarkerEdgeColor', 'r', 'MarkerFaceColor', 'y');
plot(z2(4:2:end), z2(5:2:end), 'xr', 'MarkerSize', 8); 