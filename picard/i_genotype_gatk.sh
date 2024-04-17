#!/bin/bash
#SBATCH --job-name=EM_gatk
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=14
#SBATCH --time=500:00:00
#SBATCH --mem-per-cpu=7800
#SBATCH --nice=1000
#SBATCH --partition=main
#SBATCH -o ./logs/Genotype.%j.out
#SBATCH -e ./logs/Genotype.%j.err

##  SET THE VARIABLES BELOW  ######################
# Please specify the full path for each variable. #

REFERENCE=/home/ubuntu/emiliano_2/pve_final-files_backup/pve_haplotypeT.fasta
INPUT=EMC6_combined.g.vcf.gz
OUTPUT=EMC6_combined_genotyped.vcf.gz

###################################################

/home/ubuntu/giacomo-2/programs/gatk-4.1.2.0/gatk \
--java-options "-Xmx100g -Xms100g" \
GenotypeGVCFs \
-R $REFERENCE \
-V $INPUT \
--include-non-variant-sites true \
-O $OUTPUT

mv *vcf.gz ./marked_dup_BAMs/VCF
mv *tbi ./VCF
