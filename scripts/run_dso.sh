#!/bin/bash  
datasetName=$1
datasetRoot=$2
tracks=$3

for track in $tracks
do
    result_directory="../results/DSO/"$datasetName"/"$track
    mkdir --parents $result_directory
    echo "$result_directory"/result.txt

    if [[ $datasetName == *"Aqualoc"* ]]; then
        imgpath=$datasetName\/archaeo_sequence_$track\_raw_data/raw_data/images_sequence_$track 
    fi
    if [[ $datasetName == *"TUM"* ]]; then
        imgpath=$datasetName\/$track/rgb
    fi
    if [[ $datasetName == *"MIMIR"* ]]; then
        imgpath=$datasetName\/$track/auv0/rgb/cam0/data
    fi
    if [[ $datasetName == *"EuRoC"* ]]; then
        imgpath=$datasetName\/$track/mav0/cam0/data
    fi
    ../algorithms/DSO/build/bin/dso_dataset \
        calib=../configs/dso/"$datasetName".txt \
        files=$datasetRoot/$imgpath \
        preset=2 \
        mode=1 \
        nolog=1 \
        start=0

    #if file exists, rename with index
    if [ -f "$result_directory"/result.txt ]; then
    i=1
    while [ -f "$result_directory"/result"_$i".txt ]; do
        let i++
    done
    mv result.txt "$result_directory"/result"_$i".txt
    else
    mv result.txt "$result_directory"/result.txt
    fi
done 