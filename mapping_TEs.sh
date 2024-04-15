#!/bin/bash
#SBATCH --job-name=EM_bwa
#SBATCH --output=./logs/bwa.%j.out
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --time=500:00:00
#SBATCH --mem-per-cpu=3800
#SBATCH --nice=1000
#SBATCH --partition=main
#SBATCH -e ./logs/bwa.%j.err
#SBATCH --array=1-10%10

# Alignment of short reads + convert .sam to .bam + sort .bam

INDEX=/home/ubuntu/emiliano/pve_final-files_backup/transposable_elements/pve_haplotypeT.fasta.modified.mod.EDTA.TElib.fa
BWA=/home/ubuntu/giacomo-2/programs/bwa-0.7.17
SAMTOOLS=/home/ubuntu/emiliano/executables/samtools-1.10
FORWARD=$(ls ~/emiliano/2nd_chp/trimmed_reads/EMC6/EMC6_*R1_paired.fastq.gz | head -n $SLURM_ARRAY_TASK_ID | tail -1)
REVERSE=$(echo $FORWARD | sed 's/_R1/_R2/g')
SAMPLE=$(basename $FORWARD _R1_paired.fastq.gz)
NAME=$(echo $SAMPLE | sed -e 's/EMC6/EMC6/g')
OUTPUT=./${NAME}.bam

echo "Aligning $NAME with bwa"
$BWA/bwa mem -t 8 $INDEX $FORWARD $REVERSE | $SAMTOOLS/samtools view -@ 8 -b | $SAMTOOLS/samtools sort -@ 8 -T ${NAME} | $SAMTOOLS/samtools view -b -F 0x04 > $OUTPUT

echo "Selecting high quality mapped reads in $NAME"
$SAMTOOLS/samtools view -b -q 20 -F 0x04 -F 0X100 $OUTPUT > $NAME.mq20.bam

echo "Estimating coverage of each TE"
$SAMTOOLS/samtools coverage $NAME.mq20.bam > $NAME.mq20.cov

TEs=(LTR/Copia LTR/Gypsy LTR/unknown DNA/Helitron DNA/DTA DNA/DTC DNA/DTH DNA/DTM DNA/DTT MITE/DTA MITE/DTC MITE/DTH MITE/DTM MITE/DTT)

for i in ${TEs[@]}; do
       grep $i $NAME.mq20.cov | awk '$6 > 80' >> $NAME.cov80; done

VAR=$(wc -l $NAME.cov80 | awk '{print $1}')
FILE=/home/ubuntu/emiliano/2nd_chp/mapped_reads/EMC6/map_stats/cov_stats
IND=$(echo $NAME |sed -e 's/EMC6_//g')
COV=$(awk -F, '$1 ~ /'$IND'/' $FILE | awk '{print $4}')

seq $VAR | sed "c "$NAME"" > $NAME.sample
seq $VAR | sed "c "$COV"" > $NAME.coverage
paste $NAME.sample $NAME.cov80 $NAME.coverage >> $NAME.summary_1
awk '{print $8 / $11}' $NAME.summary_1 > $NAME.norm.cov
paste $NAME.summary_1 $NAME.norm.cov >> $NAME.summary
rm $NAME.sample $NAME.cov80 $NAME.coverage $NAME.norm.cov $NAME.summary_1

echo "Finish selecting TEs that have a depth of 100%"

for i in ${TEs[@]}; do
        echo $NAME >> $NAME.sample
        grep $i $NAME.summary | awk '{ sum += $12; n++ } END { if (n > 0) print sum / n; }' >> $NAME.summary_1; done

echo ${TEs[*]} | tr ' ' '\n' > $NAME.TEs
paste $NAME.sample $NAME.TEs $NAME.summary_1 > $NAME.summary_ind
rm $NAME.TEs $NAME.summary_1 $NAME.sample

echo "Finished making summary per individual"
