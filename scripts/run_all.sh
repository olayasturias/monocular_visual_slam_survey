#!/bin/bash
datasetRoot=$HOME/Datasets

echo "########################################################################"
echo "############################# DF-VO ###################################"
echo "########################################################################"

echo "############################# MIMIR ####################################"
# datasetName=MIMIR
# tracks='SeaFloor/track0'
# ./generate_dfvo_configs.sh $datasetName $datasetRoot "${tracks[@]}" ../algorithms/DF-VO/model_zoo
# export PYTHONPATH="${PYTHONPATH}:$PWD/../algorithms/DF-VO"
# ./run_dfvo.sh $datasetName $datasetRoot "${tracks[@]}" 

echo "############################# EuRoC ####################################"
# datasetName=EuRoC
# tracks='MH_04_difficult'
# ./generate_dfvo_configs.sh $datasetName $datasetRoot "${tracks[@]}" ../algorithms/DF-VO/model_zoo
# export PYTHONPATH="${PYTHONPATH}:$PWD/../algorithms/DF-VO"
# ./run_dfvo.sh $datasetName $datasetRoot "${tracks[@]}"

echo "######################## Aqualoc  dataset ##############################"
# datasetName=Aqualoc/Archaeological_site_sequences
# tracks='1'
# ./generate_dfvo_configs.sh $datasetName $datasetRoot "${tracks[@]}" 
# ./run_dfvo.sh $datasetName $datasetRoot "${tracks[@]}" 

# datasetName=Aqualoc/Archaeological_site_sequences
# tracks='1'
# ./run_orb3_mono.sh $datasetName $datasetRoot "${tracks[@]}"   

# echo "########################################################################"
# echo "########################### ORB-SLAM3 ##################################"
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