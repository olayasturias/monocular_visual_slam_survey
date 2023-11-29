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

export PYTHONPATH="${PYTHONPATH}:$PWD/../algorithms/TrianFlow"

for track in $tracks
do
    result_directory="../results/TrianFlow/"$datasetName"/"$track
    mkdir --parents $result_directory
    #if file exists, rename with index
    if [ -f $result_directory/$track/result.txt ]; then
        i=1
        while [ -f $result_directory/$track/result"_$i".txt ]; do
            let i++
        done
        resultfile=result"_$i".txt
    else
        resultfile=result.txt
    fi

    if [[ $datasetName == *"Aqualoc"* ]]; then
        track=archaeo_sequence_$track\_raw_data/raw_data/images_sequence_$track 
    fi

    python ../algorithms/TrianFlow/infer_vo.py  --config_file ../configs/TrianFlow/"$datasetName".yaml \
                        --gpu 0 \
                        --traj_save_dir_txt $result_directory/$track/$resultfile \
                        --sequences_root_dir "$datasetRoot"/"$datasetName" \
                        --sequence $track \
                        --pretrained_model ../algorithms/TrianFlow/models/tum.pth 
                
done   
