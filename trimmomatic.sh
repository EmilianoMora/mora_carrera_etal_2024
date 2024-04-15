#!/bin/bash
#SBATCH --job-name=EM_trimm
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --mem-per-cpu=3800
#SBATCH --time=96:00:00
#SBATCH -o ./logs/trimm.%j.log
#SBATCH -e ./logs/trimm.%j.err
#SBATCH --mail-type=FAIL,END
#SBATCH --nice=1000

SAMPLES=(WG09 WG10 WG11 WG12 WH05 WH06 WH07 WH08 WH09)

for i in ${SAMPLES[@]}; do
java -jar Trimmomatic-0.38/trimmomatic-0.38.jar PE $dir_reads'/P005_'$i'_R1.fastq.gz' \
$dir_reads'/P005_'$i'_R2.fastq.gz' \
$dir_trimmed'/EMC6_'$i'_R1_paired.fastq.gz' \
$dir_trimmed'/EMC6_'$i'_R1_unpaired.fastq.gz' \
$dir_trimmed'/EMC6_'$i'_R2_paired.fastq.gz' \
$dir_trimmed'/EMC6_'$i'_R2_unpaired.fastq.gz' \
ILLUMINACLIP:$PROGRAMS/Trimmomatic-0.38/adapters/TruSeq3-PE.fa:5:10:20;
done
