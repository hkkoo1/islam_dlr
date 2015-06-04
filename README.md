# islam_dlr
The codes of the paper The Mobile Robot Visual Navigation with Iterative Measurement Update

**The bibtex of this paper is:**</br>
@article{许亚芳2015基于迭代观测更新的移动机器人视觉导航,</br>
  title={基于迭代观测更新的移动机器人视觉导航},</br>
  author={许亚芳 and 孙作雷 and 曾连荪 and 张波},</br>
  journal={信息与控制},</br>
  year={2015}</br>
}

# About the project
```
Run the script "run.m", and you can see the demo of EKF-SLAM or IEKF-SLAM on the DLR data set by setting the switches. 
Also, you can change the configuration and other switches in "run.m" to get different results. 
```
**Note:**

Before run the script "run.m", you should set the path by hand. In the Matlab menu, just click Home->Set path->Add folder, and select the path of the file "IEKF and EKF SLAM on DLR data". 

**The following files mean :**
## Data
DLR data set and the experimental data. 
* **truth.mat :** ground truth in DLR data set.
* **relMotion.mat :** odometry in DLR data set.
* **landmark.mat :** observations in DLR data set.
* **EKFobs4.mat :** experimental data of EKF-SLAM.
* **IEKF2obs4.mat :** experimental data of IEKF-SLAM.

## Filter
It contains the filter codes for SLAM execution.
* **predictEKF.m :** predict step of EKF and IEKF SLAM. 
* **updateEKF.m :** update step of EKF-SLAM.
* **updateIEKF.m** and **iterate.m :** update step of IEKF-SLAM.
* **augmentState.m :** augment step, that is add new features to the map.

## Utilities
Models and tools for SLAM demo. 
* **compound.m :** complete the estimating uncertain spatial relationships in robotics.
* **corresponding.m :** classify features with known corresponding.
* **piTopi.m :** make sure the angle is in [-pi, pi].
* **obsModel.m :** observation model.
* **vis.m :** for animation.

**The demo shows on [youku](http://dwz.cn/iekfslam)**