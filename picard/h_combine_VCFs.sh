#!/bin/bash
#SBATCH --job-name=EM_gatk
#SBATCH --output=Comb_VCFs.out
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=14
#SBATCH --time=500:00:00
#SBATCH --mem-per-cpu=7800
#SBATCH --nice=1000
#SBATCH --partition=main
#SBATCH -e ./logs/Comb_VCFs.%j.err
#SBATCH -o ./logs/Comb_VCFs.%j.out

##  SET THE VARIABLES BELOW  ######################
# Please specify the full path for each variable. #

REFERENCE=/home/ubuntu/emiliano_2/pve_final-files_backup/pve_haplotypeT.fasta

###################################################

/home/ubuntu/giacomo-2/programs/gatk-4.1.2.0/gatk \
--java-options "-Xmx100g -Xms100g" \
CombineGVCFs \
-R $REFERENCE \
--variant EMC6_WG01.g.vcf.gz \
--variant EMC6_WG09.g.vcf.gz \
--variant EMC6_WG10.g.vcf.gz \
--variant EMC6_WG11.g.vcf.gz \
--variant EMC6_WG12.g.vcf.gz \
--variant EMC6_WH05.g.vcf.gz \
--variant EMC6_WH06.g.vcf.gz \
--variant EMC6_WH07.g.vcf.gz \
--variant EMC6_WH08.g.vcf.gz \
--variant EMC6_WH09.g.vcf.gz \
-O EMC6_combined.g.vcf.gz
