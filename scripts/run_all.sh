#!/bin/bash
datasetRoot=$HOME/Datasets

CONDA_BASE=$(conda info --base)
source "$CONDA_BASE"/etc/profile.d/conda.sh

export RUN_ORB=false
export RUN_DFVO=false
export RUN_TrianFlow=false
export RUN_DSO=true

export SubPipe_tracks='Cam0_images'
# export MIMIR_tracks='SeaFloor/track0'
# export AQUALOC_tracks='1'
# export EUROC_tracks='MH_04_difficult'
# export TUM_tracks='rgbd_dataset_freiburg1_360'

START=1
END=1 # How many times do you want to run the experiments?
for (( c=$START; c<=$END; c++ ))
do
    if [ "$RUN_ORB" = true ] ; then
        echo "########################################################################"
        echo "# Algorithm 1: ORB-SLAM3 ###############################################"
        echo "########################################################################"

        echo "######################## Aqualoc  dataset ##############################"
        datasetName=Aqualoc/Archaeological_site_sequences
        if [ -n "${AQUALOC_tracks+x}" ]; then
            ./run_orb3_mono.sh $datasetName $datasetRoot "${AQUALOC_tracks[@]}"    
        else
            echo "Skipping AQUALOC_tracks - variable not set."
        fi

        echo "############################# MIMIR ####################################"
        datasetName=MIMIR
        if [ -n "${MIMIR_tracks+x}" ]; then
            ./run_orb3_mono.sh $datasetName $datasetRoot "${MIMIR_tracks[@]}"  
        else
            echo "Skipping MIMIR_tracks - variable not set."
        fi

        echo "############################# EuRoC ####################################"
        datasetName=EuRoC
        if [ -n "${EUROC_tracks+x}" ]; then
            ./run_orb3_mono.sh $datasetName $datasetRoot "${EUROC_tracks[@]}"  
        else
            echo "Skipping EUROC_tracks - variable not set."
        fi

        echo "########################### TUM-RGBD ###################################"
        datasetName=TUM
        if [ -n "${TUM_tracks+x}" ]; then
            ./run_orb3_mono.sh $datasetName $datasetRoot "${TUM_tracks[@]}"  
        else
            echo "Skipping TUM_tracks - variable not set."
        fi
    fi

    if [ "$RUN_DFVO" = true ] ; then
        export PYTHONPATH="${PYTHONPATH}:$PWD/../algorithms/DF-VO"
        echo "####################################################################################"
        echo "# Algorithm 2: DF-VO ###############################################################"
        echo "####################################################################################"
        conda activate dfvo
        echo "#### 2.1 dataset TUM-RGBD ########################################################"
        datasetName=TUM
        if [ -n "${TUM_tracks+x}" ]; then
            ./generate_dfvo_configs.sh $datasetName $datasetRoot "${TUM_tracks[@]}" ../algorithms/DF-VO/model_zoo
            ./run_dfvo.sh $datasetName $datasetRoot "${TUM_tracks[@]}" 
        else
            echo "Skipping TUM_tracks - variable not set."
        fi

        echo "#### 2.2 dataset MIMIR ###############################################################"
        datasetName=MIMIR
        if [ -n "${MIMIR_tracks+x}" ]; then
            ./generate_dfvo_configs.sh $datasetName $datasetRoot "${MIMIR_tracks[@]}" ../algorithms/DF-VO/model_zoo
            ./run_dfvo.sh $datasetName $datasetRoot "${MIMIR_tracks[@]}" 
        else
            echo "Skipping MIMIR_tracks - variable not set."
        fi

        echo "#### 2.3 dataset EuRoC ###############################################################"
        datasetName=EuRoC
        if [ -n "${EUROC_tracks+x}" ]; then
            ./generate_dfvo_configs.sh $datasetName $datasetRoot "${EUROC_tracks[@]}" ../algorithms/DF-VO/model_zoo
            ./run_dfvo.sh $datasetName $datasetRoot "${EUROC_tracks[@]}"
        else
            echo "Skipping EUROC_tracks - variable not set."
        fi

        echo "#### 2.4 dataset Aqualoc #############################################################"
        datasetName=Aqualoc/Archaeological_site_sequences
        if [ -n "${AQUALOC_tracks+x}" ]; then
            ./generate_dfvo_configs.sh $datasetName $datasetRoot "${AQUALOC_tracks[@]}" ../algorithms/DF-VO/model_zoo
            ./run_dfvo.sh $datasetName $datasetRoot "${AQUALOC_tracks[@]}" 
        else
            echo "Skipping AQUALOC_tracks - variable not set."
        fi
    fi

    if [ "$RUN_TrianFlow" = true ] ; then
        export PYTHONPATH="${PYTHONPATH}:$PWD/../algorithms/TrianFlow"
        echo "####################################################################################"
        echo "# Algorithm 3: TrianFlow ###########################################################"
        echo "####################################################################################"
        conda activate trianflow
        echo "#### 3.1 dataset TUM-RGBD ########################################################"
        datasetName=TUM
        if [ -n "${TUM_tracks+x}" ]; then
            ./run_trianflow.sh $datasetName $datasetRoot "${TUM_tracks[@]}"
        else
            echo "Skipping TUM_tracks - variable not set."
        fi

        echo "#### 3.2 dataset MIMIR ###############################################################"
        datasetName=MIMIR
        if [ -n "${MIMIR_tracks+x}" ]; then
            ./run_trianflow.sh $datasetName $datasetRoot "${MIMIR_tracks[@]}"
        else
            echo "Skipping MIMIR_tracks - variable not set."
        fi

        echo "#### 3.3 dataset EuRoC ###############################################################"
        datasetName=EuRoC
        if [ -n "${EUROC_tracks+x}" ]; then
            ./run_trianflow.sh $datasetName $datasetRoot "${EUROC_tracks[@]}"
        else
            echo "Skipping EUROC_tracks - variable not set."
        fi

        echo "#### 3.4 dataset Aqualoc #############################################################"
        datasetName=Aqualoc/Archaeological_site_sequences
        if [ -n "${AQUALOC_tracks+x}" ]; then
            ./run_trianflow.sh $datasetName $datasetRoot "${AQUALOC_tracks[@]}"
        else
            echo "Skipping AQUALOC_tracks - variable not set."
        fi
    fi

    if [ "$RUN_DSO" = true ] ; then
        echo "#################################################//////////#######################"
        echo "# Algorithm 4: DSO #####################//////////################################"
        echo "##################################################################################"
        echo "#### 4.1 dataset TUM-RGBD ########################################################"
        datasetName=TUM
        if [ -n "${TUM_tracks+x}" ]; then
            ./run_dso.sh $datasetName $datasetRoot "${TUM_tracks[@]}"
        else
            echo "Skipping TUM_tracks - variable not set."
        fi

        echo "#### 4.2 dataset MIMIR ###############################################################"
        datasetName=MIMIR
        if [ -n "${MIMIR_tracks+x}" ]; then
            ./run_dso.sh $datasetName $datasetRoot "${MIMIR_tracks[@]}"
        else
            echo "Skipping MIMIR_tracks - variable not set."
        fi

        echo "#### 4.3 dataset EuRoC ###############################################################"
        datasetName=EuRoC
        if [ -n "${EUROC_tracks+x}" ]; then
            ./run_dso.sh $datasetName $datasetRoot "${EUROC_tracks[@]}"
        else
            echo "Skipping EUROC_tracks - variable not set."
        fi

        echo "#### 4.4 dataset Aqualoc #############################################################"
        datasetName=Aqualoc/Archaeological_site_sequences
        if [ -n "${AQUALOC_tracks+x}" ]; then
            ./run_dso.sh $datasetName $datasetRoot "${AQUALOC_tracks[@]}"
        else
            echo "Skipping AQUALOC_tracks - variable not set."
        fi

        echo "#### 4.5 dataset SubPipe #############################################################"
        datasetName=SubPipe
        if [ -n "${SubPipe_tracks+x}" ]; then
            ./run_dso.sh $datasetName $datasetRoot "${SubPipe_tracks[@]}"
        else
            echo "Skipping SubPipe_tracks - variable not set."
        fi
    fi
done