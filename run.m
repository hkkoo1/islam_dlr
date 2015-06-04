% dbstop if error;
% clear all; close all;
path(path, genpath('../IEKF and EKF SLAM on DLR data'));
load 'Data/truth.mat';
%% Switches
visualize= 1; % If zero, there is no demo.
openIEKF = 0; % If zero, open EKF-SLAM. Otherwise, open IEKF-SLAM.
              % and the value of openIEKF is the iterative number.
loadData = 1; % If zero, carry out the process of SLAM.
              % Otherwise, use the stored data of SLAM.
%%
step     = 3297;
if loadData == 1                  
    if openIEKF == 0
        load 'Data/EKFobs4.mat'    % Run directly with EKF-SLAM data.
    else
        load 'Data/IEKF2obs4.mat'  % Run directly with IEKF-SLAM data.
    end
else                               % Run EKF-SLAM or IEKF-SLAM and generate data.
%%
    %% Parametres configuration
    load 'Data/relMotion.mat';  % Robot odometry data in DLR
    load 'Data/landmark.mat';   % Observations in DLR.
    pos      = truth.x(:,1);    % Robot initial pose.
%   pos(3)   = pos(3)+0.065 ;   % Modify the pose.
    cov      = truth.P(:,:,1);  % Initial covariance.
    sum =0;
    %% Assign memory and Initialise.
    data.path      = zeros(3, step+1); % Assign memory for estimated path.
    data.path(:,1) = pos;
    data.pos(1).x  = pos;              % State include robot and landmarks.
%   data.pos(1).P = diag(cov);         % Covariance
    idList   = zeros(1,23001);         % Assign memory for corresponding list.
    %% Main Loop
    disp('Wait for a moment...');
    tic;
    for i = 1:step
         %% Predict simulation
         [pos, cov] = predictEKF(pos, cov, relMotion(i).x, relMotion(i).P);
         %% Observe 
         sum = sum +1;
         if sum==4
             sum = 0;
         [zf, idf, Rf, zn, Rn, idList] = correspond(pos, landmark(i).z,...
                                  landmark(i).R, landmark(i).ID, idList);
         %% Update 
             if openIEKF == 0
                 [pos, cov] = updateEKF(pos, cov, zf, Rf, idf);
             else
                 [pos, cov] = updateIEKF(pos, cov, zf, Rf, idf, openIEKF);
             end
             [pos, cov] = augmentState(pos, cov, zn, Rn);
         end
         %% Store data.
         data.path(:,i+1) = pos(1:3); % Convenient for animation.
         data.pos(i+1).x  = pos;
    end
    toc;
end
%% Animation.
vis(data, truth, step, visualize, openIEKF);


        
        