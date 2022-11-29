# Survey on monocular visual SLAM :eye_speech_bubble:
Clone this repository with submodules

```bash
git clone --recurse-submodules -j8 git@github.com:olayasturias/monocular_visual_slam_survey.git
```
If you forgot to clone the submodules, you can download them afterwards as

```bash
git submodule update --init --recursive
```
## 1. Submodule installation
For those libraries using python, we will create the correspondent virtual environments to ensure that we have the correct versions for each.
Follow the given naming for the environments, or at least be aware that the scripts refer to the names used here. If you use different names, you'll need to modify the script `scripts/run_all.sh`
### 1.1 DF-VO
Create a conda environment for DF-VO as follows:

```bash
cd algorithms/DF-VO/envs
conda env create --name dfvo --file requirement.yml
```
Note that this could take a while tea 	:tea:
For DF-VO, the models are downloaded [here](https://www.dropbox.com/sh/9by21564eb0xloh/AABHFMlWd_ja14c5wU4R1KUua?dl=0)
and saved in the directory `algorithms/DF-VO/model_zoo`
### 1.2 TrianFlow
Create a conda environment for TrianFlow as follows:
```bash
cd algorithms/TrianFlow
conda env create --name trianflow --file requirements.txt
```

For TrianFlow, the models are downloaded [here](https://drive.google.com/drive/folders/1rPXlK9bJpjU0OQH5leDCvyb0FcL5jlUk)
and saved in the directory `algorithms/TrianFlow/models`

### 1.3 ORB-SLAM3
Install the requirements indicated in the README. Once you've done that, build ORB_SLAM3 as:
```bash
cd algorithms/ORB_SLAM3
./build.sh
```

Note: for Pangolin and Eigen I recommend you to follow the instructions [in this post](https://olayasturias.github.io/ros/slam/survey/2022/03/01/slam-surveying-install.html)
### 1.4 DSO
Install the requirements indicated in the README. Once you've done that, build DSO as:
```bash
cd algorithms/dso
mkdir build
cd build
cmake ..
make -j4
```
Note: for Pangolin and Eigen I recommend you to follow the instructions [in this post](https://olayasturias.github.io/ros/slam/survey/2022/03/01/slam-surveying-install.html)