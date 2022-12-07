#!/bin/bash

datasetName=$1
datasetRoot=$2
tracks=$3
orb_vocab=../algorithms/ORB_SLAM3/Vocabulary/ORBvoc.txt

for track in $tracks
do 
echo "Launching ORB_SLAM for track $track from $datasetName dataset with Monocular sensor"
if [[ $datasetName == *"Aqualoc"* ]]; then
  configfile=../algorithms/ORB_SLAM3/Examples/Monocular/Aqualoc.yaml
  resultfile=KeyFrameTrajectory.txt
  ../algorithms/ORB_SLAM3/Examples/Monocular/mono_aqualoc $orb_vocab $configfile "$datasetRoot"/"$datasetName"/archaeo_sequence_$track\_raw_data $track

fi
if [[ $datasetName == *"MIMIR"* ]]; then
  configfile=../algorithms/ORB_SLAM3/Examples/Monocular/MIMIR.yaml
  resultfile=kf_out.txt
  echo ../algorithms/ORB_SLAM3/Examples/Monocular/mono_mimir $orb_vocab $configfile "$datasetRoot"/MIMIR/"$track"/auv0/rgb/cam0/data ../algorithms/ORB_SLAM3/Examples/Monocular/MIMIR_TimeStamps/"$track"/timestamps.txt out
  ../algorithms/ORB_SLAM3/Examples/Monocular/mono_mimir $orb_vocab $configfile "$datasetRoot"/MIMIR/"$track"/auv0/rgb/cam0/data ../algorithms/ORB_SLAM3/Examples/Monocular/MIMIR_TimeStamps/"$track"/timestamps.txt out
fi

if [[ $datasetName == *"EuRoC"* ]]; then
  configfile=../algorithms/ORB_SLAM3/Examples/Monocular/EuRoC.yaml
  resultfile=kf_out.txt
  ../algorithms/ORB_SLAM3/Examples/Monocular/mono_euroc $orb_vocab $configfile "$datasetRoot"/EuRoC/"$track" ../algorithms/ORB_SLAM3/Examples/Monocular/EuRoC_TimeStamps/"$track".txt out
fi

if [[ $datasetName == *"KITTI"* ]]; then
  if [ $track == *"00"* ]||[ $track == *"01"* ]||[ $track == *"02"* ]; then
    configfile=../algorithms/ORB_SLAM3/Examples/Monocular/KITTI00-02.yaml
  elif [[ $track == *"03"* ]]; then
    configfile=../algorithms/ORB_SLAM3/Examples/Monocular/KITTI03.yaml
  else
    configfile=../algorithms/ORB_SLAM3/Examples/Monocular/KITTI04-12.yaml
  fi
  resultfile=KeyFrameTrajectory.txt
  ../algorithms/ORB_SLAM3/Examples/Monocular/mono_kitti $orb_vocab $configfile "$datasetRoot"/KITTI/"$track"
fi

if [[ $datasetName == *"TUM"* ]]; then
  if [[ $track == *"g1"* ]]; then
    configfile=../algorithms/ORB_SLAM3/Examples/Monocular/TUM1.yaml
  elif [[ $track == *"g2"* ]]; then
    configfile=../algorithms/ORB_SLAM3/Examples/Monocular/TUM2.yaml
  elif [[ $track == *"g3"* ]]; then
    configfile=../algorithms/ORB_SLAM3/Examples/Monocular/TUM3.yaml
  fi
  resultfile=KeyFrameTrajectory.txt
  ../algorithms/ORB_SLAM3/Examples/Monocular/mono_tum $orb_vocab $configfile "$datasetRoot"/TUM/"$track" 
fi

mkdir --parents ../results/ORB_SLAM3/"$datasetName"/"$track"
mv $resultfile ../results/ORB_SLAM3/"$datasetName"/"$track"/kf_out.txt


done