#!/bin/bash
datasetRoot=$HOME/Datasets

CONDA_BASE=$(conda info --base)
source "$CONDA_BASE"/etc/profile.d/conda.sh

export RUN_ORB=true
export RUN_DFVO=true
export RUN_TrianFlow=true
export RUN_DSO=true

export MIMIR_tracks='SeaFloor/track0'
export AQUALOC_tracks='1'
export EUROC_tracks='MH_04_difficult'
export TUM_tracks='rgbd_dataset_freiburg1_360'

START=1
END=10
for (( c=$START; c<=$END; c++ ))
do
    if [ "$RUN_ORB" = true ] ; then
        echo "########################################################################"
        echo "# Algorithm 1: ORB-SLAM3 ###############################################"
        echo "########################################################################"

        echo "######################## Aqualoc  dataset ##############################"
        datasetName=Aqualoc/Archaeological_site_sequences
        ./run_orb3_mono.sh $datasetName $datasetRoot "${AQUALOC_tracks[@]}"    

        echo "############################# MIMIR ####################################"
        datasetName=MIMIR
        ./run_orb3_mono.sh $datasetName $datasetRoot "${MIMIR_tracks[@]}"  

        echo "############################# EuRoC ####################################"
        datasetName=EuRoC
        ./run_orb3_mono.sh $datasetName $datasetRoot "${EUROC_tracks[@]}"  

        echo "########################### TUM-RGBD ###################################"
        datasetName=TUM
        ./run_orb3_mono.sh $datasetName $datasetRoot "${TUM_tracks[@]}"  
    fi

    if [ "$RUN_DFVO" = true ] ; then
        echo "####################################################################################"
        echo "# Algorithm 2: DF-VO ###############################################################"
        echo "####################################################################################"
        conda activate dfvo
        echo "#### 2.1 dataset TUM-RGBD ########################################################"
        datasetName=TUM
        ./generate_dfvo_configs.sh $datasetName $datasetRoot "${TUM_tracks[@]}" ../algorithms/DF-VO/model_zoo
        ./run_dfvo.sh $datasetName $datasetRoot "${TUM_tracks[@]}" 

        echo "#### 2.2 dataset MIMIR ###############################################################"
        datasetName=MIMIR
        ./generate_dfvo_configs.sh $datasetName $datasetRoot "${MIMIR_tracks[@]}" ../algorithms/DF-VO/model_zoo
        export PYTHONPATH="${PYTHONPATH}:$PWD/../algorithms/DF-VO"
        ./run_dfvo.sh $datasetName $datasetRoot "${MIMIR_tracks[@]}" 

        echo "#### 2.3 dataset EuRoC ###############################################################"
        datasetName=EuRoC
        ./generate_dfvo_configs.sh $datasetName $datasetRoot "${EUROC_tracks[@]}" ../algorithms/DF-VO/model_zoo
        export PYTHONPATH="${PYTHONPATH}:$PWD/../algorithms/DF-VO"
        ./run_dfvo.sh $datasetName $datasetRoot "${EUROC_tracks[@]}"

        echo "#### 2.4 dataset Aqualoc #############################################################"
        datasetName=Aqualoc/Archaeological_site_sequences
        export PYTHONPATH="${PYTHONPATH}:$PWD/../algorithms/DF-VO"
        ./generate_dfvo_configs.sh $datasetName $datasetRoot "${AQUALOC_tracks[@]}" ../algorithms/DF-VO/model_zoo
        ./run_dfvo.sh $datasetName $datasetRoot "${AQUALOC_tracks[@]}" 
    fi

    if [ "$RUN_TrianFlow" = true ] ; then
        echo "####################################################################################"
        echo "# Algorithm 3: TrianFlow ###########################################################"
        echo "####################################################################################"
        conda activate trianflow
        echo "#### 3.1 dataset TUM-RGBD ########################################################"
        datasetName=TUM
        ./run_trianflow.sh $datasetName $datasetRoot "${TUM_tracks[@]}"

        echo "#### 3.2 dataset MIMIR ###############################################################"
        datasetName=MIMIR
        export PYTHONPATH="${PYTHONPATH}:$PWD/../algorithms/TrianFlow"
        ./run_trianflow.sh $datasetName $datasetRoot "${MIMIR_tracks[@]}"

        echo "#### 3.3 dataset EuRoC ###############################################################"
        datasetName=EuRoC
        export PYTHONPATH="${PYTHONPATH}:$PWD/../algorithms/TrianFlow"
        ./run_trianflow.sh $datasetName $datasetRoot "${EUROC_tracks[@]}"

        echo "#### 3.4 dataset Aqualoc #############################################################"
        datasetName=Aqualoc/Archaeological_site_sequences
        export PYTHONPATH="${PYTHONPATH}:$PWD/../algorithms/TrianFlow"
        ./run_trianflow.sh $datasetName $datasetRoot "${AQUALOC_tracks[@]}"
    fi

    if [ "$RUN_DSO" = true ] ; then
        echo "#################################################//////////#######################"
        echo "# Algorithm 4: DSO #####################//////////################################"
        echo "##################################################################################"
        echo "#### 4.1 dataset TUM-RGBD ########################################################"
        datasetName=TUM
        ./run_dso.sh $datasetName $datasetRoot "${TUM_tracks[@]}"
        echo "#### 4.2 dataset MIMIR ###############################################################"
        datasetName=MIMIR
        ./run_dso.sh $datasetName $datasetRoot "${MIMIR_tracks[@]}"
        echo "#### 4.3 dataset EuRoC ###############################################################"
        datasetName=EuRoC
        ./run_dso.sh $datasetName $datasetRoot "${EUROC_tracks[@]}"
        echo "#### 4.4 dataset Aqualoc #############################################################"
        datasetName=Aqualoc/Archaeological_site_sequences
        ./run_dso.sh $datasetName $datasetRoot "${AQUALOC_tracks[@]}"
    fi
done