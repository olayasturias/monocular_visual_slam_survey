#!/bin/bash

datasetName=$1
datasetRoot=$2

tracks='1'
for track in $tracks
do 
echo "Launching $track with Monocular sensor"
../algorithms/ORB_SLAM3/Examples/Monocular/mono_aqualoc ../algorithms/ORB_SLAM3/Vocabulary/ORBvoc.txt ../algorithms/ORB_SLAM3/Examples/Monocular/Aqualoc.yaml "$datasetRoot"/archaeo_sequence_$track\_raw_data $track
mv KeyFrameTrajectory.txt ../results/$datasetName\/kf_archaeo_sequence_$track\_raw_data.txt
done