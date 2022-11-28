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
    ( echo "cat <<EOF >../configs/DFVO/"$datasetName"/"$sequence_name".yml";
      cat ../algorithms/DF-VO/options/examples/"$datasetName"/default_configuration.yml;
      echo "EOF";
    ) >temp.yml
    . temp.yml
    rm -f temp.yml
  fi
  if [[ $datasetName == *"MIMIR"* ]]; then
    export seqname="$(dirname $track)" 
    export trackname="$(basename $track)" 
    mkdir --parents ../configs/DFVO/"$datasetName"/"$seqname"
    mkdir --parents "../results/DFVO/"$datasetName"/"$seqname
    export result_directory="../results/DFVO/"$datasetName"/"$track
    export dataset_directory=$datasetRoot"/"$datasetName
    export sequence_name="$track"
    ( echo "cat <<EOF >../configs/DFVO/"$datasetName"/"$seqname"/"$trackname".yml";
      cat ../algorithms/DF-VO/options/examples/"$datasetName"/default_configuration.yml;
      echo "EOF";
    ) >temp.yml
    . temp.yml
    rm -f temp.yml
  fi
  if [[ $datasetName == *"TUM"* ]]; then
    if [[ $track == *"g1"* ]]; then
      export tum_room=tum-1
    elif [[ $track == *"g2"* ]]; then
      export tum_room=tum-2
    elif [[ $track == *"g3"* ]]; then
      export tum_room=tum-3
    fi
    export seqname="$(dirname $track)" 
    export trackname="$(basename $track)" 
    mkdir --parents ../configs/DFVO/"$datasetName"/"$seqname"
    mkdir --parents "../results/DFVO/"$datasetName"/"$seqname
    export result_directory="../results/DFVO/"$datasetName"/"$track
    export dataset_directory=$datasetRoot"/"$datasetName
    export sequence_name="$track"
    ( echo "cat <<EOF >../configs/DFVO/"$datasetName"/"$seqname"/"$trackname".yml";
      cat ../algorithms/DF-VO/options/examples/"$datasetName"/default_configuration.yml;
      echo "EOF";
    ) >temp.yml
    . temp.yml
    rm -f temp.yml
  fi
done
