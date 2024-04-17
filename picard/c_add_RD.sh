#!/bin/bash
#SBATCH --job-name=EM_AddReadGroups
#SBATCH --output=add_RG.out
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --time=500:00:00
#SBATCH --mem-per-cpu=3800
#SBATCH --nice=1000
#SBATCH --partition=main
#SBATCH -o ./logs/add_RG.%j.out
#SBATCH -e ./logs/add_RG.%j.err
#SBATCH --mail-type=FAIL,END
#SBATCH --mail-user=emiliano.mora@systbot.uzh.ch
#SBATCH --exclude=compute001,computeGPU001,computeGPU002

#This script will add the read group information into a BAM.This takes approximately 25 min

ReadGroups=$(cat ./readgroups_files/WG09_ReadGroups)

for i in ${ReadGroups[@]}; do
	java -jar /home/ubuntu/giacomo-2/programs/picard.jar AddOrReplaceReadGroups \
	I=''$i'_EMC6_WG09.bam' \
	O=''$i'_EMC6_WG09_RG.bam' \
	RGID=$i \
	RGLB=WG09 \
	RGPL=ILLUMINA \
	RGPU=WG09 \
	RGSM=WG09; done

ReadGroups=$(cat ./readgroups_files/WG10_ReadGroups)

for i in ${ReadGroups[@]}; do
        java -jar /home/ubuntu/giacomo-2/programs/picard.jar AddOrReplaceReadGroups \
        I=''$i'_EMC6_WG10.bam' \
        O=''$i'_EMC6_WG10_RG.bam' \
        RGID=$i \
        RGLB=WG10 \
        RGPL=ILLUMINA \
        RGPU=WG10 \
        RGSM=WG10; done

ReadGroups=$(cat ./readgroups_files/WG11_ReadGroups)

for i in ${ReadGroups[@]}; do
        java -jar /home/ubuntu/giacomo-2/programs/picard.jar AddOrReplaceReadGroups \
        I=''$i'_EMC6_WG11.bam' \
        O=''$i'_EMC6_WG11_RG.bam' \
        RGID=$i \
        RGLB=WG11 \
        RGPL=ILLUMINA \
        RGPU=WG11 \
        RGSM=WG11; done

ReadGroups=$(cat ./readgroups_files/WG12_ReadGroups)

for i in ${ReadGroups[@]}; do
        java -jar /home/ubuntu/giacomo-2/programs/picard.jar AddOrReplaceReadGroups \
        I=''$i'_EMC6_WG12.bam' \
        O=''$i'_EMC6_WG12_RG.bam' \
        RGID=$i \
        RGLB=WG12 \
        RGPL=ILLUMINA \
        RGPU=WG12 \
        RGSM=WG12; done

ReadGroups=$(cat ./readgroups_files/WH05_ReadGroups)

for i in ${ReadGroups[@]}; do
        java -jar /home/ubuntu/giacomo-2/programs/picard.jar AddOrReplaceReadGroups \
        I=''$i'_EMC6_WH05.bam' \
        O=''$i'_EMC6_WH05_RG.bam' \
        RGID=$i \
        RGLB=WH05 \
        RGPL=ILLUMINA \
        RGPU=WH05 \
        RGSM=WH05; done

ReadGroups=$(cat ./readgroups_files/WH06_ReadGroups)

for i in ${ReadGroups[@]}; do
        java -jar /home/ubuntu/giacomo-2/programs/picard.jar AddOrReplaceReadGroups \
        I=''$i'_EMC6_WH06.bam' \
        O=''$i'_EMC6_WH06_RG.bam' \
        RGID=$i \
        RGLB=WH06 \
        RGPL=ILLUMINA \
        RGPU=WH06 \
        RGSM=WH06; done

ReadGroups=$(cat ./readgroups_files/WH07_ReadGroups)

for i in ${ReadGroups[@]}; do
        java -jar /home/ubuntu/giacomo-2/programs/picard.jar AddOrReplaceReadGroups \
        I=''$i'_EMC6_WH07.bam' \
        O=''$i'_EMC6_WH07_RG.bam' \
        RGID=$i \
        RGLB=WH07 \
        RGPL=ILLUMINA \
        RGPU=WH07 \
        RGSM=WH07; done

ReadGroups=$(cat ./readgroups_files/WH08_ReadGroups)

for i in ${ReadGroups[@]}; do
        java -jar /home/ubuntu/giacomo-2/programs/picard.jar AddOrReplaceReadGroups \
        I=''$i'_EMC6_WH08.bam' \
        O=''$i'_EMC6_WH08_RG.bam' \
        RGID=$i \
        RGLB=WH08 \
        RGPL=ILLUMINA \
        RGPU=WH08 \
        RGSM=WH08; done

ReadGroups=$(cat ./readgroups_files/WH09_ReadGroups)

for i in ${ReadGroups[@]}; do
        java -jar /home/ubuntu/giacomo-2/programs/picard.jar AddOrReplaceReadGroups \
        I=''$i'_EMC6_WH09.bam' \
        O=''$i'_EMC6_WH09_RG.bam' \
        RGID=$i \
        RGLB=WH09 \
        RGPL=ILLUMINA \
        RGPU=WH09 \
        RGSM=WH09; done

ReadGroups=$(cat ./readgroups_files/WG01_ReadGroups)

for i in ${ReadGroups[@]}; do
        java -jar /home/ubuntu/giacomo-2/programs/picard.jar AddOrReplaceReadGroups \
        I=''$i'_EMC6_WG01.bam' \
        O=''$i'_EMC6_WG01_RG.bam' \
        RGID=$i \
        RGLB=WG01 \
        RGPL=ILLUMINA \
        RGPU=WG01 \
        RGSM=WG01; done
