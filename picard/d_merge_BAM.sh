#!/bin/bash
#SBATCH --job-name=EM_mergeBAM
#SBATCH --output=merge_BAM.out
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --time=500:00:00
#SBATCH --mem-per-cpu=3800
#SBATCH --nice=1000
#SBATCH --partition=main
#SBATCH -o ./logs/merge_BAM.%j.out
#SBATCH -e ./logs/merge_BAM.%j.err

#This script will merge several BAM files into a single one. This takes approximately 20 minutes per sample.

#files=$(ls | grep -e 'RG' | sed 's/^/I=/')

#java -jar /home/ubuntu/giacomo-2/programs/picard.jar MergeSamFiles $files O=merged.bam

#samtools stats merged.bam | grep "is sorted:" to determine if the file is sorted or not
#One can also use samtools index merged.bam. If BAM is not sorted the index command will output an error.

files=$(ls | grep EMC6_WG09_RG.bam | sed 's/^/I=/')

for i in {files[@]}; do
java -jar /home/ubuntu/giacomo-2/programs/picard.jar MergeSamFiles $files  O='EMC6_WG09'.bam;done

files=$(ls | grep EMC6_WG10_RG.bam | sed 's/^/I=/')

for i in {files[@]}; do
java -jar /home/ubuntu/giacomo-2/programs/picard.jar MergeSamFiles $files  O='EMC6_WG10'.bam;done

files=$(ls | grep EMC6_WG11_RG.bam | sed 's/^/I=/')

for i in {files[@]}; do
java -jar /home/ubuntu/giacomo-2/programs/picard.jar MergeSamFiles $files  O='EMC6_WG11'.bam;done

files=$(ls | grep EMC6_WG12_RG.bam | sed 's/^/I=/')

for i in {files[@]}; do
java -jar /home/ubuntu/giacomo-2/programs/picard.jar MergeSamFiles $files  O='EMC6_WG12'.bam;done

files=$(ls | grep EMC6_WH05_RG.bam | sed 's/^/I=/')

for i in {files[@]}; do
java -jar /home/ubuntu/giacomo-2/programs/picard.jar MergeSamFiles $files  O='EMC6_WH05'.bam;done

files=$(ls | grep EMC6_WH06_RG.bam | sed 's/^/I=/')

for i in {files[@]}; do
java -jar /home/ubuntu/giacomo-2/programs/picard.jar MergeSamFiles $files  O='EMC6_WH06'.bam;done

files=$(ls | grep EMC6_WH07_RG.bam | sed 's/^/I=/')

for i in {files[@]}; do
java -jar /home/ubuntu/giacomo-2/programs/picard.jar MergeSamFiles $files  O='EMC6_WH07'.bam;done

files=$(ls | grep EMC6_WH08_RG.bam | sed 's/^/I=/')

for i in {files[@]}; do
java -jar /home/ubuntu/giacomo-2/programs/picard.jar MergeSamFiles $files  O='EMC6_WH08'.bam;done

files=$(ls | grep EMC6_WH09_RG.bam | sed 's/^/I=/')

for i in {files[@]}; do
java -jar /home/ubuntu/giacomo-2/programs/picard.jar MergeSamFiles $files  O='EMC6_WH09'.bam;done

files=$(ls | grep EMC6_WG01_RG.bam | sed 's/^/I=/')

for i in {files[@]}; do
java -jar /home/ubuntu/giacomo-2/programs/picard.jar MergeSamFiles $files  O='EMC6_WG01'.bam;done
