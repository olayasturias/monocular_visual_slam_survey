#!/bin/bash

# Check if all three arguments are provided
if [ "$#" -ne 3 ]; then
    echo "Usage: $0 <DatasetName> <DatasetRoot> <Tracks>"
    echo "Example: $0 TUM $HOME/Datasets rgbd_dataset_freiburg1_xyz"
    exit 1
fi

datasetName="$1"
datasetRoot="$2"
tracks="$3"

export PYTHONPATH="${PYTHONPATH}:$PWD/../algorithms/DF-VO"

for track in $tracks
do
    mkdir --parents ../results/DFVO/"$datasetName"/"$track"
    python ../algorithms/DF-VO/apis/run.py -d ../configs/DFVO/$datasetName/"$track".yml \
    --no_confirm
done