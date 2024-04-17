#!/bin/bash
#SBATCH --job-name=EM_BCFtools
#SBATCH --error ./logs/BCFtools_merge.%j.err
#SBATCH --out ./logs/BCFtools_merge.%j.out
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --time=900:00:00
#SBATCH --mem-per-cpu=3800
#SBATCH --nice=100
#SBATCH --partition=main

##  SET THE VARIABLES BELOW  ######################
# Please specify the full path for each variable. #

PROGRAMS=/home/ubuntu/my_data/Narcis/executables/bcftools-1.8
REF=home/giacomo-3/pve-final/haploT/pve_haplotypeT.fasta
DIR=/home/ubuntu/emiliano/2nd_chp/gatk_analyses/filtering/
VCFTOOLS=/home/ubuntu/my_data/Narcis/executables/vcftools/src/cpp
BGZIP=/home/ubuntu/giacomo-2/programs/htslib/
TABIX=/home/ubuntu/my_data/Narcis/executables/htslib/

#$PROGRAMS/bcftools merge $DIR/EM07/EM07_snp_indel_novar_flagged_filtered_header_fixed_biallelic_no_indel_ab.vcf.gz \
#$DIR/EM32/EM32_snp_indel_novar_flagged_filtered_header_fixed_biallelic_no_indel_ab.vcf.gz \
#$DIR/EM33/EM33_snp_indel_novar_flagged_filtered_header_fixed_biallelic_no_indel_ab.vcf.gz \
#$DIR/EMC1/EMC1_snp_indel_novar_flagged_filtered_header_fixed_biallelic_no_indel_ab.vcf.gz \
#$DIR/EMC3/EMC3_snp_indel_novar_flagged_filtered_header_fixed_biallelic_no_indel_ab.vcf.gz \
#$DIR/EMC6/EMC6_snp_indel_novar_flagged_filtered_header_fixed_biallelic_no_indel_ab.vcf.gz \
#$DIR/RS170/RS170_snp_indel_novar_flagged_filtered_header_fixed_biallelic_no_indel_ab.vcf.gz \
#$DIR/RS180/RS180_snp_indel_novar_flagged_filtered_header_fixed_biallelic_no_indel_ab.vcf.gz \
#$DIR/RSBK01/RSBK01_snp_indel_novar_flagged_filtered_header_fixed_biallelic_no_indel_ab.vcf.gz --force-samples -Oz -o $DIR/all_pops/merged_allpops.vcf.gz

#$TABIX/tabix -p vcf $DIR/all_pops/merged_allpops.vcf.gz

#echo "Finished merging VCF files from all the populations and indexing the new VCF"

#correct maf filter depending on the number of individuals. THe total number fo sample is 87 (174 chromosomes). This the MAF filter should be 0.012
#correct maf filter depending on the number of individuals. THe total number fo sample is 107 (214 chromosomes). This the MAF filter should be 0.01

#$VCFTOOLS/vcftools --gzvcf merged_allpops.vcf.gz --remove-indels --mac 2 --max-missing 0.8 --max-alleles 2 \
#--remove-indv EM07_WB10 --remove-indv EM32_WA08 --remove-indv EM32_WC08 --remove-indv EM32_WE07 --remove-indv EMC3_WC04 --remove-indv EMC6_WG01 \
#--recode --recode-INFO-all --stdout | $BGZIP/bgzip -c > merged_allpops_biallelic_mac.vcf.gz

#$TABIX/tabix -p vcf $DIR/all_pops/merged_allpops_biallelic_mac.vcf.gz

echo "Finished filtering and indexing the merged VCF file"

$VCFTOOLS/vcftools --gzvcf merged_allpops.vcf.gz --remove-indels --max-missing 0.8 --max-alleles 2 \
--remove-indv EM07_WB10 --remove-indv EM32_WA08 --remove-indv EM32_WC08 --remove-indv EM32_WE07 --remove-indv EMC3_WC04 --remove-indv EMC6_WG01 \
--recode --recode-INFO-all --stdout | $BGZIP/bgzip -c > merged_allpops_biallelic.vcf.gz

$TABIX/tabix -p vcf $DIR/all_pops/merged_allpops_biallelic.vcf.gz
