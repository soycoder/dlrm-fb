# DLRM

1. Setting Environment variable

        $ W_DIR=<working dir path>
 
2. Cloning project

        $ cd $W_DIR
        $ git clone https://github.com/soycoder/dlrm-fb.git dlrm/

3. 
        # CPU only
        $ wget http://167.71.205.129/apisith/dlrm-ct8.3-cpu.sif




4. Download dataset
    []()

5. Edit Job Script
    - Slurm (TARA Cluster @ThaiSC)
        - Preprocessing 
            
                #!/bin/bash
                #SBATCH -p compute
                #SBATCH --account=proj5008
                #SBATCH --job-name=preporc-dlrm
                #SBATCH -N 1
                #SBATCH --ntasks-per-node=40
                #SBATCH --time=10:00:00

                module purge
                module load Singularity
                module load OpenMPI/4.1.1-GCC-10.3.0

                WORK_DIR=/tarafs/scratch/proj5008-roopai/DLRM-cpu
                IMG=dlrm-ct8.3-cpu.sif

                # mpirun -n ${SLURM_NTASKS} \
                ${WORK_DIR}/$IMG \
                python ${WORK_DIR}/dlrm/dlrm_s_pytorch.py \
                    --data-generation=dataset \
                    --data-set=kaggle \
                    --raw-data-file=${WORK_DIR}/data/criteo-kaggle/train.txt \
                    --mini-batch-size=128 \
                    --memory-map \
                    --test-mini-batch-size=16384 \
                    --test-num-workers=4 

                



    - PBS
