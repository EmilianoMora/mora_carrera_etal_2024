#!/bin/bash
#SBATCH --job-name=EM_MarkDup
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --time=500:00:00
#SBATCH --mem-per-cpu=3800
#SBATCH --nice=1000
#SBATCH --partition=main
#SBATCH -o ./logs/MarkDup.%j.out
#SBATCH -e ./logs/MarkDup.%j.err

#Creates a BAM file where the PCR duplicates are indicated. Takes approximately ~30 minutes.

BAM_files=$(ls | grep -oE 'EMC6_\w\w\w\w' | sort -u)

for i in ${BAM_files[@]}; do

java -jar /home/ubuntu/giacomo-2/programs/picard.jar MarkDuplicates \
      I=''$i'.bam' \
      O=''$i'_mdup.bam' \
      M='marked_dup_metrics'$i''.txt; done
