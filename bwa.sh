#!/bin/bash
#SBATCH --job-name=EM_bwa
#SBATCH --output=./logs/bwa.%j.out
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8
#SBATCH --time=500:00:00
#SBATCH --mem-per-cpu=3800
#SBATCH --nice=1000
#SBATCH -e ./logs/bwa.%j.err

### To run as an array move this back up #SBATCH --array=1-10%10

# Alignment of short reads + convert .sam to .bam + sort .bam

INDEX=~/emiliano_2/pve_final-files_backup/pve_haplotypeT.fasta
FORWARD=$(ls ~/emiliano_2/2nd_chp/trimmed_reads/EMC6/EMC6_*R1_paired.fastq.gz | head -n $SLURM_ARRAY_TASK_ID | tail -1)
REVERSE=$(echo $FORWARD | sed 's/_R1/_R2/g')
NAME=$(basename $FORWARD _R1_paired.fastq.gz)
OUTPUT=./${NAME}.bam
SAMTOOLS=~/emiliano_2/executables/samtools-1.10/samtools

#echo "Aligning $NAME with bwa"
#/home/ubuntu/giacomo-2/programs/bwa-0.7.17/bwa mem -t 8 $INDEX $FORWARD $REVERSE | $SAMTOOLS view -@ 8 -b | $SAMTOOLS sort -@ 8 -T ${NAME} > $OUTPUT

SAMTOOLS=~/emiliano/executables/samtools-1.10/samtools
SAMPLES=$(ls | grep .bam)

for i in ${SAMPLES[@]}; do
$SAMTOOLS view -C -T /home/ubuntu/emiliano/pve_final-files_backup/pve_haplotypeT.fasta -o $i.cram $i
rm $i; done
