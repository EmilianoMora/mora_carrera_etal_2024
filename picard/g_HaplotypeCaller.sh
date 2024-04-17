#!/bin/bash
#SBATCH --job-name=EM_gatk_HapCall
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --time=500:00:00
#SBATCH --mem-per-cpu=3800
#SBATCH --nice=1000
#SBATCH --partition=main
#SBATCH -o ./logs/HapCall.%j.out
#SBATCH -e ./logs/HapCall.%j.err
#SBATCH --array=1-10%10

##  SET THE VARIABLES BELOW  ######################
# Please specify the full path for each variable. #

REFERENCE=/home/ubuntu/emiliano_2/pve_final-files_backup/pve_haplotypeT.fasta
INPUT=$(ls /home/ubuntu/emiliano_2/2nd_chp/gatk_analyses/picard/EMC6/marked_dup_BAMs/*_mdup.bam | head -n $SLURM_ARRAY_TASK_ID | tail -1)
NAME=$(basename $INPUT _mdup.bam)

###################################################

/home/ubuntu/giacomo-2/programs/gatk-4.1.2.0/gatk \
--java-options "-Xmx4g" \
HaplotypeCaller \
-R $REFERENCE \
-I $INPUT \
-O ${NAME}.g.vcf.gz \
--standard-min-confidence-threshold-for-calling 30 \
--min-base-quality-score 20 \
-ERC GVCF
