#!/bin/bash
#SBATCH --job-name=EM_gatk
#SBATCH --output=HapCall.out
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --time=500:00:00
#SBATCH --mem-per-cpu=3800
#SBATCH --nice=1000
#SBATCH --partition=main
#SBATCH -e HapCall.%j.err
#SBATCH --mail-type=FAIL,END
#SBATCH --array=1-19%5

##  SET THE VARIABLES BELOW  ######################
# Please specify the full path for each variable. #

REFERENCE=~/giacomo-3/pve-final/haploT/pve_haplotypeT.fasta
INPUT=$( ls *_mdup.bam | head -n $SLURM_ARRAY_TASK_ID | tail -1)
NAME=$(basename $INPUT _mdup.bam)

###################################################

/home/ubuntu/giacomo-2/programs/gatk-4.1.2.0/gatk \
--java-options "-Xmx4g" \
HaplotypeCaller \
-R $REFERENCE \
-I $INPUT \
-O ${NAME}.raw.vcf \
--standard-min-confidence-threshold-for-calling 30 \
--min-base-quality-score 20 \
-ERC GVCF

/home/ubuntu/giacomo-2/programs/gatk-4.1.2.0/gatk \
--java-options "-Xmx100g -Xms100g" \
CombineGVCFs \
-R $REFERENCE \
--variant EM32_WA06.raw.vcf \
--variant EM32_WA07.raw.vcf \
--variant EM32_WA08.raw.vcf \
--variant EM32_WB06.raw.vcf \
--variant EM32_WB07.raw.vcf \
--variant EM32_WB08.raw.vcf \
--variant EM32_WC06.raw.vcf \
--variant EM32_WC07.raw.vcf \
--variant EM32_WC08.raw.vcf \
--variant EM32_WD06.raw.vcf \
--variant EM32_WD07.raw.vcf \
--variant EM32_WE06.raw.vcf \
--variant EM32_WE07.raw.vcf \
--variant EM32_WF06.raw.vcf \
--variant EM32_WF07.raw.vcf \
--variant EM32_WG06.raw.vcf \
--variant EM32_WG07.raw.vcf \
--variant EM32_WH05.raw.vcf \
--variant EM32_WH07.raw.vcf \
--variant EM32_WH06.raw.vcf \
-O combined_EM32.raw.vcf

##  SET THE VARIABLES BELOW  ######################
# Please specify the full path for each variable. #

REFERENCE=~/giacomo-3/pve-final/haploT/pve_haplotypeT.fasta
INPUT=combined_EM32.raw.vcf
OUTPUT=combined_EM32_genotyped.vcf

###################################################

/home/ubuntu/giacomo-2/programs/gatk-4.1.2.0/gatk \
--java-options "-Xmx100g -Xms100g" \
GenotypeGVCFs \
-R $REFERENCE \
-V $INPUT \
--include-non-variant-sites true \
-O $OUTPUT


