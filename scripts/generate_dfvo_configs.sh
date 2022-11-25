datasetName=$1
datasetRoot=$2
tracks=$3
model_zoo_dir=$4


for track in $tracks
do
  if [[ $datasetName == *"EuRoC"* ]]; then
    mkdir --parents ../configs/DFVO/"$datasetName"/"$track"
    export sequence_name=$track
    export result_directory="../results/DFVO/"$datasetName"/"$sequence_name
    export dataset_directory=$datasetRoot"/"$datasetName
    ( echo "cat <<EOF >configs/DFVO/"$datasetName"/"$sequence_name".yml";
      cat ../algorithms/DF-VO/options/examples/"$datasetName"/default_configuration.yml;
      echo "EOF";
    ) >temp.yml
    . temp.yml
    rm -f temp.yml
   fi

done
