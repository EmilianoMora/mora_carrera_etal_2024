#!/bin/bash
#SBATCH --job-name=EM_PCA
#SBATCH --output logs/PCA.%j.out
#SBATCH --error logs/PCA.%j.err
#SBATCH --mail-type=FAIL,END
#SBATCH --mail-user=emiliano.mora@systbot.uzh.ch
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=16
#SBATCH --time=500:00:00
#SBATCH --mem-per-cpu=3700
#SBATCH --nice=100

PLINK=/home/ubuntu/emiliano/executables/plink_1_9
VCF=/home/ubuntu/emiliano/2nd_chp/gatk_analyses/filtering/all_pops/merged_allpops_biallelic_mac.vcf.gz

VCFTOOLS=/home/ubuntu/rebecca-2/programs/vcftools/src/cpp/
BGZIP=/home/ubuntu/giacomo-2/programs/htslib/

$PLINK/plink --vcf $VCF --allow-extra-chr --silent \
--indep-pairwise 50 10 0.1 --out all_pops --noweb

$VCFTOOLS/vcftools --gzvcf $VCF --out all_pops.pruning --positions all_pops.prune.in --stdout --recode | $BGZIP/bgzip > all_pops_prunned.vcf.gz

$PLINK/plink --vcf $VCF --double-id --allow-extra-chr \
--extract all_pops.prune.in \
--make-bed --pca --out all_pops
