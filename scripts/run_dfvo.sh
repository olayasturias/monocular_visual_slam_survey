#!/bin/bash

datasetName=$1
datasetRoot=$2
tracks=$3

for track in $tracks
do
    mkdir --parents ../results/DFVO/"$datasetName"/"$track"
    python ../algorithms/DF-VO/apis/run.py -d configs/DFVO/$datasetName/"$track".yml
done