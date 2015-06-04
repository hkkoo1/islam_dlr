clear all; close all;
path(path, genpath('../IEKF and EKF SLAM on DLR data'));
load 'Data/truth.mat';
x0   = truth.x;          % Truth data
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
I = imread('Data\satelliteMap.jpg','JPG');    % Read the DLR satellite map.
image([-59 37],[34 -47.5],I,'alphadata',0.7);
timeSeq = 1 : step;
plot( x1(1, timeSeq), x1(2, timeSeq), '-.b', 'linewidth', 2 );
plot( x2(1, timeSeq), x2(2, timeSeq), ':r',  'linewidth', 2 );
plot( x0(1, timeSeq), x0(2, timeSeq), '-g',  'linewidth', 2 );
% print('-depsc','pathCompare.eps');

%% Features comparison
figure('name','Observations Comparison','color','w');
hold on; box on; axis equal;
xlim([-54, 25]);ylim([-32, 34]);
% set(gca,'xtick',[],'ytick',[]);
% set(gca,'Color','w','XColor','w','YColor','w')
% set(gca,'Visible','off')
I = imread('Data\gtMap.jpg','JPG');            % Read the DLR building map.
image([-48 24],[29 -30],I,'alphadata',1);
plot(z1(4:2:end), z1(5:2:end), 'b+', 'MarkerSize', 8,...
        'LineWidth', 1.5);
plot(z2(4:2:end), z2(5:2:end), 'o', 'MarkerSize', 8,...
        'MarkerEdgeColor', 'r', 'MarkerFaceColor', 'y');
plot(z2(4:2:end), z2(5:2:end), 'xr', 'MarkerSize', 8); 

%% For legned only
figure(100)
hold on;
plot(100, 100, 'o', 'MarkerSize', 30, 'LineWidth', 2,...
        'MarkerEdgeColor', 'r', 'MarkerFaceColor', 'y');
plot(100, 100, 'xr', 'MarkerSize', 30, 'LineWidth', 2); 
plot(110, 110, '+b', 'MarkerSize', 30, 'LineWidth', 2.5); 
set(gca,'Visible','off');

%% Compute absolute error in X,Y and Phi.
width=1;
errEKF=abs(x1-x0);  % EKF error.
errIEKF=abs(x2-x0); % IEKF error.
errEKF(3,:)=abs(piTopi(errEKF(3,:)));
errIEKF(3,:)=abs(piTopi(errIEKF(3,:)));
err.EKF = errEKF;
err.IEKF= errIEKF;

%% Error in x
figure('name','errorInX','color','w');
hold on;box on;
h1    = plot(timeSeq, errEKF(1, timeSeq), '-b','linewidth',width);
h2    = plot(timeSeq, errIEKF(1, timeSeq), 'r-','linewidth',width);
label = [h1, h2];
hx    = legend(label,'未加入反复测量更新','加入反复测量更新');
set(hx,'box','off','location','NorthWest','Orientation','horizontal','fontsize',12,'fontname','song');
axis([min(timeSeq) max(timeSeq) 0 12]); 
xlabel('时间(s)','fontsize',12,'fontname','Times New Roman');
ylabel('x方向绝对误差(m)','fontsize',12,'fontname','Times New Roman');
% print('-depsc','errorInX.png');

%% Error in y
figure('name','errorInY','color','w');
hold on;box on;
h1    = plot(timeSeq, errEKF(2, timeSeq), '-b','linewidth',width);
h2    = plot(timeSeq, errIEKF(2, timeSeq), 'r-','linewidth',width);
label = [h1, h2];
hy    = legend(label, '未加入反复测量更新','加入反复测量更新');
set(hy,'box','off','location','NorthWest','Orientation','horizontal','fontsize',12,'fontname','song');
xlim([min(timeSeq), max(timeSeq)]);
axis([min(timeSeq) max(timeSeq) 0 6]); 
xlabel('时间(s)','fontsize',12,'fontname','Times New Roman');
ylabel('y方向绝对误差(m)','fontsize',12,'fontname','Times New Roman');
% print('-depsc','errorInY.png');

%% Error in phi
figure('name','errorInPhi','color','w');
hold on;box on;
h1    = plot(timeSeq, errEKF(3, timeSeq), '-b','linewidth',width);
h2    = plot(timeSeq, errIEKF(3, timeSeq), 'r-','linewidth',width);
label = [h1, h2];
hphi    = legend(label, '未加入反复测量更新','加入反复测量更新');
set(hphi,'box','off','location','NorthWest','Orientation','horizontal','fontsize',12,'fontname','song');
xlim([min(timeSeq), max(timeSeq)]);
xlabel('时间(s)','fontsize',12,'fontname','Times New Roman');
ylabel('航向角\phi 绝对误差(m)','fontsize',12,'fontname','Times New Roman');
% print('-depsc','errorInPhi.png');
