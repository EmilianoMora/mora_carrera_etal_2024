#!/bin/bash
#SBATCH --job-name=EM_split_BAM_readGroups
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --time=500:00:00
#SBATCH --mem-per-cpu=3800
#SBATCH --nice=1000
#SBATCH --partition=main
#SBATCH -o ./logs/split_BAM_RG.%j.out
#SBATCH -e ./logs/split_BAM_RG.%j.err

#This script will break a BAM file into several BAM files based on the read group ID. This takes around 40 minutes per sample.
BAMfiles=(/home/ubuntu/emiliano_2/2nd_chp/mapped_reads/EMC6)
SAMTOOLS=~/emiliano_2/executables/samtools-1.10/samtools

ReadGroups=$(cat ./readgroups_files/WG09_ReadGroups)
for i in ${ReadGroups[@]}; do
	{($SAMTOOLS view -H $BAMfiles/EMC6_WG09.bam); ($SAMTOOLS view -h $BAMfiles/EMC6_WG09.bam | grep $i)} | cat | $SAMTOOLS view -b - > $i'_EMC6_WG09.bam';done

ReadGroups=$(cat ./readgroups_files/WG10_ReadGroups)
for i in ${ReadGroups[@]}; do
        {($SAMTOOLS view -H $BAMfiles/EMC6_WG10.bam); ($SAMTOOLS view -h $BAMfiles/EMC6_WG10.bam | grep $i)} | cat | $SAMTOOLS view -b - > $i'_EMC6_WG10.bam';done

ReadGroups=$(cat ./readgroups_files/WG11_ReadGroups)
for i in ${ReadGroups[@]}; do
        {($SAMTOOLS view -H $BAMfiles/EMC6_WG11.bam); ($SAMTOOLS view -h $BAMfiles/EMC6_WG11.bam | grep $i)} | cat | $SAMTOOLS view -b - > $i'_EMC6_WG11.bam';done

ReadGroups=$(cat ./readgroups_files/WG12_ReadGroups)
for i in ${ReadGroups[@]}; do
        {($SAMTOOLS view -H $BAMfiles/EMC6_WG12.bam); ($SAMTOOLS view -h $BAMfiles/EMC6_WG12.bam | grep $i)} | cat | $SAMTOOLS view -b - > $i'_EMC6_WG12.bam';done

ReadGroups=$(cat ./readgroups_files/WH05_ReadGroups)
for i in ${ReadGroups[@]}; do
        {($SAMTOOLS view -H $BAMfiles/EMC6_WH05.bam); ($SAMTOOLS view -h $BAMfiles/EMC6_WH05.bam | grep $i)} | cat | $SAMTOOLS view -b - > $i'_EMC6_WH05.bam';done

ReadGroups=$(cat ./readgroups_files/WH06_ReadGroups)
for i in ${ReadGroups[@]}; do
        {($SAMTOOLS view -H $BAMfiles/EMC6_WH06.bam); ($SAMTOOLS view -h $BAMfiles/EMC6_WH06.bam | grep $i)} | cat | $SAMTOOLS view -b - > $i'_EMC6_WH06.bam';done

ReadGroups=$(cat ./readgroups_files/WH07_ReadGroups)
for i in ${ReadGroups[@]}; do
        {($SAMTOOLS view -H $BAMfiles/EMC6_WH07.bam); ($SAMTOOLS view -h $BAMfiles/EMC6_WH07.bam | grep $i)} | cat | $SAMTOOLS view -b - > $i'_EMC6_WH07.bam';done

ReadGroups=$(cat ./readgroups_files/WH08_ReadGroups)
for i in ${ReadGroups[@]}; do
        {($SAMTOOLS view -H $BAMfiles/EMC6_WH08.bam); ($SAMTOOLS view -h $BAMfiles/EMC6_WH08.bam | grep $i)} | cat | $SAMTOOLS view -b - > $i'_EMC6_WH08.bam';done

ReadGroups=$(cat ./readgroups_files/WH09_ReadGroups)
for i in ${ReadGroups[@]}; do
        {($SAMTOOLS view -H $BAMfiles/EMC6_WH09.bam); ($SAMTOOLS view -h $BAMfiles/EMC6_WH09.bam | grep $i)} | cat | $SAMTOOLS view -b - > $i'_EMC6_WH09.bam';done

ReadGroups=$(cat ./readgroups_files/WG01_ReadGroups)
for i in ${ReadGroups[@]}; do
        {($SAMTOOLS view -H $BAMfiles/EMC6_WG01.bam); ($SAMTOOLS view -h $BAMfiles/EMC6_WG01.bam | grep $i)} | cat | $SAMTOOLS view -b - > $i'_EMC6_WG01.bam';done
