#!/bin/bash
datasetRoot=$HOME/Datasets
echo "########################################################################"
echo "########################### ORB-SLAM3 ##################################"
echo "########################################################################"

echo "######################## Aqualoc  dataset ##############################"

datasetName=Aqualoc/Archaeological_site_sequences
tracks='1'
./run_orb3_mono.sh $datasetName $datasetRoot "${tracks[@]}"    

echo "############################# MIMIR ####################################"
datasetName=MIMIR
tracks='SeaFloor/track0'
./run_orb3_mono.sh $datasetName $datasetRoot "${tracks[@]}"  

echo "############################# EuRoC ####################################"
datasetName=EuRoC
tracks='MH_04_difficult'
./run_orb3_mono.sh $datasetName $datasetRoot "${tracks[@]}"  

echo "########################### TUM-RGBD ###################################"
datasetName=TUM
tracks='rgbd_dataset_freiburg1_360'
./run_orb3_mono.sh $datasetName $datasetRoot "${tracks[@]}"  