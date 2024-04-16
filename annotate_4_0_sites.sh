#!/bin/bash
#SBATCH --job-name=EM_annot
#SBATCH --output=./logs/annot.%j.out
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --time=500:00:00
#SBATCH --mem-per-cpu=3800
#SBATCH --nice=0
#SBATCH --partition=main
#SBATCH --error=./logs/annot.%j.err

#get reduce VCF files based in the 4-fold and 0-fold sites

#Annotation file was done following the python command in
ref=pve_haplotypeT.fasta
ann=pve_haplotypeT.edited.final.gff
python3 NewAnnotateRef.py $ref $ann
awk '$6 ~ /4/' info_gff.74708.out | awk '{print $1, $2}' | sed 's/\s/\t/g' > 4fold_sites.txt
awk '$6 ~ /3/' info_gff.74708.out | awk '{print $1, $2}' | sed 's/\s/\t/g' > 0fold_sites.txt
awk '$6 ~ /1/' info_gff.74708.out | awk '{print $1, $2}' | sed 's/\s/\t/g' > intron_sites.txt
awk '$6 ~ /0/' info_gff.74708.out | awk '{print $1, $2}' | sed 's/\s/\t/g' > intergenic_sites.txt

ANNOTATED_FILE=/home/ubuntu/emiliano/pve_final-files_backup/NewAnnotation
VCF=EMC6_snp_indel_novar_flagged_filtered_header_fixed_biallelic_no_indel_ab.vcf.gz
DIR=/home/ubuntu/emiliano/2nd_chp/gatk_analyses/annotate_VCF/with_NewAnnotate/EMC6
BGZIP=/home/ubuntu/my_data/Narcis/executables/htslib/bgzip
TABIX=/home/ubuntu/my_data/Narcis/executables/htslib/tabix
VCFTOOLS=/home/ubuntu/my_data/Narcis/executables/vcftools/src/cpp/vcftools

$VCFTOOLS --gzvcf $VCF --positions $ANNOTATED_FILE/0fold_sites.txt --recode --recode-INFO-all --stdout | $BGZIP -c > 0fold_EMC6.vcf.gz
$VCFTOOLS --gzvcf $VCF --positions $ANNOTATED_FILE/4fold_sites.txt --recode --recode-INFO-all --stdout | $BGZIP -c > 4fold_EMC6.vcf.gz

$TABIX -p vcf $DIR/0fold_EMC6.vcf.gz
$TABIX -p vcf $DIR/4fold_EMC6.vcf.gz
