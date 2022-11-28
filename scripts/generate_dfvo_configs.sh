datasetName=$1
datasetRoot=$2
tracks=$3
model_zoo_dir=$4


for track in $tracks
do
  export sequence_name=$track
  export result_directory="../results/DFVO/"$datasetName"/"$sequence_name
  export dataset_directory=$datasetRoot"/"$datasetName
  mkdir --parents ../configs/DFVO/"$datasetName"
  mkdir --parents ../results/DFVO/"$datasetName"/"$sequence_name"


  if [[ $datasetName == *"MIMIR"* ]]; then

    export sequence_name="$(dirname $track)" 
    export track="$(basename $track)" 

    mkdir --parents ../configs/DFVO/"$datasetName"/"$sequence_name"
    mkdir --parents "../results/DFVO/"$datasetName"/"$sequence_name
        
    ( echo "cat <<EOF >../configs/DFVO/"$datasetName"/"$sequence_name"/"$track".yml";
      cat ../algorithms/DF-VO/options/examples/"$datasetName"/default_configuration.yml;
      echo "EOF";
    ) >temp.yml
    . temp.yml
    rm -f temp.yml
  else
    if [[ $datasetName == *"TUM"* ]]; then
      if [[ $track == *"g1"* ]]; then
        export tum_room=tum-1
      elif [[ $track == *"g2"* ]]; then
        export tum_room=tum-2
      elif [[ $track == *"g3"* ]]; then
        export tum_room=tum-3
      fi
    fi
    ( echo "cat <<EOF >../configs/DFVO/"$datasetName"/"$sequence_name".yml";
      cat ../algorithms/DF-VO/options/examples/"$datasetName"/default_configuration.yml;
      echo "EOF";
    ) >temp.yml
    . temp.yml
    rm -f temp.yml
  fi

done
