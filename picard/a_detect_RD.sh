#!/bin/bash
#SBATCH --job-name=EM_detect_RD
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --time=500:00:00
#SBATCH --mem-per-cpu=3800
#SBATCH --nice=1000
#SBATCH --partition=main
#SBATCH -o ./logs/det_readGroups.%j.out
#SBATCH -e ./logs/det_readGroups.%j.err

#This script will create a file with the different read groups present in a BAM file (one read group file per BAM file). A read group will be conformed by the information of the flow cell ID and the sequencing lane within the flow cell
#in the followng format 'flow cell ID:lane ID' (e.g. GW200217000:3). It takes approximately 6 minutes per sample.
#Transform BAM to SAM|Eliminate the header|prints the sequencing read information| separates the read information into columns by adding a 'tab space' instead of  a ':'|prints the colums with flow cell ID and lane ID |
#looks for unique combinations of flow cell ID and lane ID columns |adds a ":" instead of the space and redirects into a file


SAM_FILES=/home/ubuntu/emiliano_2/2nd_chp/mapped_reads/EMC6/EMC6_
SAMPLES=$(ls /home/ubuntu/emiliano_2/2nd_chp/mapped_reads/EMC6 | grep -oE 'W\w\w\w' | sort -u)
SAMTOOLS=~/emiliano_2/executables/samtools-1.10/samtools

for i in ${SAMPLES[@]}; do
	 $SAMTOOLS view -h $SAM_FILES''$i'.bam' | sed '/@SQ/d;/@HD/d;/@PG/d' | awk '{print $1}' | sed 's/:/\t/g' | awk '{print $3,$4'} | sort -u | sed 's/\s/:/g' > ./readgroups_files/''$i'_ReadGroups'; done
