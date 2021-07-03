#!/bin/bash

for ARGUMENT in "$@"

do

    KEY=$(echo $ARGUMENT | cut -f1 -d=)
    VALUE=$(echo $ARGUMENT | cut -f2 -d=)

    case "$KEY" in
            GPU)          GPU=${VALUE} ;;
            SEED)         SEED=${VALUE} ;;
            DATASET)      DATASET=${VALUE} ;;
            *)
    esac

    echo "$KEY = $VALUE"

done

echo $GPU
echo $SEED
echo $DATASET
echo $N_SHOT
echo $N_QUERY


for s in ${SEED}; do
        OMP_NUM_THREADS=4 MKL_NUM_THREADS=4 CUDA_VISIBLE_DEVICES=${GPU} python start_training.py --arch resnet12 --batch-size 512 --seed ${s} --expm-id resnet12-nca-replacement-${DATASET}-batch512-seed${s} --dataset ${DATASET} --replacement-sampling --proto-train-iter 75;
done
