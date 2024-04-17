#!/bin/bash
#SBATCH --job-name=EM_index
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --time=500:00:00
#SBATCH --mem-per-cpu=3800
#SBATCH --nice=1000
#SBATCH --partition=main
#SBATCH -o ./logs/index.%j.out
#SBATCH -e ./logs/index.%j.err

##  SET THE VARIABLES BELOW  ######################
# Please specify the full path for each variable. #

INPUT=$(ls *_mdup.bam)

###################################################

for i in ${INPUT[@]}; do
~/emiliano_2/executables/samtools-1.10/samtools index $i; done

mv GW2* ./splitted_BAMs
mv *_mdup.bam ./marked_dup_BAMs
mv marked_dup_metrics* ./metrics
mv *bam ./merged_BAMs
mv *bam.bai ./merged_BAMs
