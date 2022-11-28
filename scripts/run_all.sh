#!/bin/bash
datasetRoot=$HOME/Datasets

CONDA_BASE=$(conda info --base)
source "$CONDA_BASE"/etc/profile.d/conda.sh

echo "####################################################################################"
echo "# Algorithm 3: TrianFlow ###########################################################"
echo "####################################################################################"
conda activate trianflow
echo "#### 1.1 dataset TUM-RGBD ########################################################"
datasetName=TUM
tracks='rgbd_dataset_freiburg1_360'
./generate_dfvo_configs.sh $datasetName $datasetRoot "${tracks[@]}" ../algorithms/DF-VO/model_zoo
export PYTHONPATH="${PYTHONPATH}:$PWD/../algorithms/TrianFlow"
./run_trianflow.sh $datasetName $datasetRoot "${tracks[@]}"
echo "#### 1.2 dataset MIMIR ###############################################################"
datasetName=MIMIR
tracks='SeaFloor/track0'
export PYTHONPATH="${PYTHONPATH}:$PWD/../algorithms/TrianFlow"
./run_trianflow.sh $datasetName $datasetRoot "${tracks[@]}"
echo "#### 1.3 dataset EuRoC ###############################################################"
datasetName=EuRoC
tracks='MH_04_difficult'
export PYTHONPATH="${PYTHONPATH}:$PWD/../algorithms/TrianFlow"
./run_trianflow.sh $datasetName $datasetRoot "${tracks[@]}"
echo "#### 1.4 dataset Aqualoc #############################################################"
datasetName=Aqualoc/Archaeological_site_sequences
tracks='1'
export PYTHONPATH="${PYTHONPATH}:$PWD/../algorithms/TrianFlow"
./run_trianflow.sh $datasetName $datasetRoot "${tracks[@]}"


# echo "####################################################################################"
# echo "# Algorithm 2: DF-VO ###############################################################"
# echo "####################################################################################"
# conda activate dfvo
# echo "#### 1.1 dataset TUM-RGBD ########################################################"
# datasetName=TUM
# tracks='rgbd_dataset_freiburg1_360'
# ./generate_dfvo_configs.sh $datasetName $datasetRoot "${tracks[@]}" ../algorithms/DF-VO/model_zoo
# export PYTHONPATH="${PYTHONPATH}:$PWD/../algorithms/DF-VO"
# ./run_dfvo.sh $datasetName $datasetRoot "${tracks[@]}" 

# echo "#### 1.2 dataset MIMIR ###############################################################"
# datasetName=MIMIR
# tracks='SeaFloor/track0'
# ./generate_dfvo_configs.sh $datasetName $datasetRoot "${tracks[@]}" ../algorithms/DF-VO/model_zoo
# export PYTHONPATH="${PYTHONPATH}:$PWD/../algorithms/DF-VO"
# ./run_dfvo.sh $datasetName $datasetRoot "${tracks[@]}" 

# echo "#### 1.3 dataset EuRoC ###############################################################"
# datasetName=EuRoC
# tracks='MH_04_difficult'
# ./generate_dfvo_configs.sh $datasetName $datasetRoot "${tracks[@]}" ../algorithms/DF-VO/model_zoo
# export PYTHONPATH="${PYTHONPATH}:$PWD/../algorithms/DF-VO"
# ./run_dfvo.sh $datasetName $datasetRoot "${tracks[@]}"

# echo "#### 1.4 dataset Aqualoc #############################################################"
# datasetName=Aqualoc/Archaeological_site_sequences
# tracks='1'
# export PYTHONPATH="${PYTHONPATH}:$PWD/../algorithms/DF-VO"
# ./generate_dfvo_configs.sh $datasetName $datasetRoot "${tracks[@]}" ../algorithms/DF-VO/model_zoo
# ./run_dfvo.sh $datasetName $datasetRoot "${tracks[@]}" 


# echo "########################################################################"
# echo "# Algorithm 1: ORB-SLAM3 ###############################################"
# echo "########################################################################"

# echo "######################## Aqualoc  dataset ##############################"

# datasetName=Aqualoc/Archaeological_site_sequences
# tracks='1'
# ./run_orb3_mono.sh $datasetName $datasetRoot "${tracks[@]}"    

# echo "############################# MIMIR ####################################"
# datasetName=MIMIR
# tracks='SeaFloor/track0'
# ./run_orb3_mono.sh $datasetName $datasetRoot "${tracks[@]}"  

# echo "############################# EuRoC ####################################"
# datasetName=EuRoC
# tracks='MH_04_difficult'
# ./run_orb3_mono.sh $datasetName $datasetRoot "${tracks[@]}"  

# echo "########################### TUM-RGBD ###################################"
# datasetName=TUM
# tracks='rgbd_dataset_freiburg1_360'
# ./run_orb3_mono.sh $datasetName $datasetRoot "${tracks[@]}"  