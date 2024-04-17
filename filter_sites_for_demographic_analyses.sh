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

BCFTOOLS=/home/ubuntu/my_data/Narcis/executables/bcftools-1.8
DIR=/home/ubuntu/emiliano/2nd_chp/gatk_analyses/filtering/
VCFTOOLS=/home/ubuntu/my_data/Narcis/executables/vcftools/src/cpp
BGZIP=/home/ubuntu/giacomo-2/programs/htslib/
TABIX=/home/ubuntu/my_data/Narcis/executables/htslib/
BEDTOOLS=/home/ubuntu/exe_primrose/bedtools2/bin

$BCFTOOLS/bcftools query -l $DIR/EMC6/EMC6_snp_indel_novar_flagged_filtered_header_fixed_biallelic_no_indel_ab.vcf.gz | grep "EMC6" | awk '{split($0,a,"_"); print $1,a[1]}' > pop_file

TRANSCRIPTS=/home/ubuntu/emiliano/pve_final-files_backup/gff/pve_haplotypeT_transcript.final.gff
KB_DOWNSTREAM=/home/ubuntu/emiliano/pve_final-files_backup/gff/pve_haplotypeT_transcript_2kb_downstream.final.gff
REPEATS=/home/ubuntu/emiliano/pve_final-files_backup/gff_TEs/modified_gff/pve_haplotypeT.fasta.modified.mod.EDTA.TEanno.modifiedEMC.gff3
CENTROMERES=centromeres.txt
VCF=$DIR/EMC6/EMC6_snp_indel_novar_flagged_filtered_header_fixed_biallelic_no_indel_ab.vcf.gz
VNAME=$(basename $VCF .vcf.gz)

$BEDTOOLS/intersectBed -v -a $VCF -b $REPEATS -header | $BGZIP/bgzip > ${VNAME}_norepeats.vcf.gz
$TABIX/tabix -p vcf ${VNAME}_norepeats.vcf.gz

$BEDTOOLS/intersectBed -v -a ${VNAME}_norepeats.vcf.gz -b $CENTROMERES -header | $BGZIP/bgzip > ${VNAME}_norepeats_nocentromeres.vcf.gz
$TABIX/tabix -p vcf ${VNAME}_norepeats_nocentromeres.vcf.gz

$BEDTOOLS/intersectBed -v -a ${VNAME}_norepeats_nocentromeres.vcf.gz -b $TRANSCRIPTS -header | $BGZIP/bgzip > ${VNAME}_norepeats_nocentromeres_notranscripts.vcf.gz
$TABIX/tabix -p vcf ${VNAME}_norepeats_nocentromeres_notranscripts.vcf.gz

$VCFTOOLS/vcftools --gzvcf ${VNAME}_norepeats_nocentromeres_notranscripts.vcf.gz --max-missing 1 --not-chr pve_haplotypeT_004 --recode --recode-INFO-all --stdout | $BGZIP/bgzip > ${VNAME}_norepeats_nocentromeres
_notranscripts_missing.vcf.gz
$TABIX/tabix -p vcf ${VNAME}_norepeats_nocentromeres_notranscripts_missing.vcf.gz

$BCFTOOLS/bcftools view --header-only ${VNAME}_norepeats_nocentromeres_notranscripts_missing.vcf.gz > ${VNAME}_norepeats_nocentromeres_notranscripts_missing_SUBSAMPLE.vcf
$BCFTOOLS/bcftools view --no-header ${VNAME}_norepeats_nocentromeres_notranscripts_missing.vcf.gz | awk '{printf("%f\t%s\n",rand(),$0);}' | sort -t $'\t' -k1,1g | cut -f2- | \
 head -n 1000000 | awk '$1 ~ /^#/ {print $0;next} {print $0 | "sort -k1,1 -k2,2n"}' >> ${VNAME}_norepeats_nocentromeres_notranscripts_missing_SUBSAMPLE.vcf

$BGZIP/bgzip -c ${VNAME}_norepeats_nocentromeres_notranscripts_missing_SUBSAMPLE.vcf > ${VNAME}_norepeats_nocentromeres_notranscripts_missing_SUBSAMPLE.vcf.gz
$TABIX/tabix -p vcf ${VNAME}_norepeats_nocentromeres_notranscripts_missing_SUBSAMPLE.vcf.gz

rm ${VNAME}_norepeats_nocentromeres_notranscripts_missing_SUBSAMPLE.vcf

$BEDTOOLS/intersectBed -v -a ${VNAME}_norepeats_nocentromeres_notranscripts.vcf.gz -b $KB_DOWNSTREAM -header | $BGZIP/bgzip > ${VNAME}_norepeats_nocentromeres_notranscripts_nodownstream.vcf.gz
$TABIX/tabix -p vcf ${VNAME}_norepeats_nocentromeres_notranscripts_nodownstream.vcf.gz

$VCFTOOLS/vcftools --gzvcf ${VNAME}_norepeats_nocentromeres_notranscripts_nodownstream.vcf.gz --max-missing 1 --recode --recode-INFO-all --stdout | $BGZIP/bgzip > ${VNAME}_norepeats_nocentromeres_notranscripts_n
odownstream_missing.vcf.gz
$TABIX/tabix -p vcf ${VNAME}_norepeats_nocentromeres_notranscripts_nodownstream_missing.vcf.gz

$BCFTOOLS/bcftools view --header-only ${VNAME}_norepeats_nocentromeres_notranscripts_nodownstream_missing.vcf.gz > ${VNAME}_norepeats_nocentromeres_notranscripts_nodownstream_missing_SUBSAMPLE.vcf
$BCFTOOLS/bcftools view --no-header ${VNAME}_norepeats_nocentromeres_notranscripts_nodownstream_missing.vcf.gz | awk '{printf("%f\t%s\n",rand(),$0);}' | sort -t $'\t' -k1,1g | cut -f2- | \
 head -n 1000000 | awk '$1 ~ /^#/ {print $0;next} {print $0 | "sort -k1,1 -k2,2n"}' >> ${VNAME}_norepeats_nocentromeres_notranscripts_nodownstream_missing_SUBSAMPLE.vcf

$BGZIP/bgzip -c ${VNAME}_norepeats_nocentromeres_notranscripts_nodownstream_missing_SUBSAMPLE.vcf > ${VNAME}_norepeats_nocentromeres_notranscripts_nodownstream_missing_SUBSAMPLE.vcf.gz
$TABIX/tabix -p vcf ${VNAME}_norepeats_nocentromeres_notranscripts_nodownstream_missing_SUBSAMPLE.vcf.gz

rm ${VNAME}_norepeats_nocentromeres_notranscripts_nodownstream_missing_SUBSAMPLE.vcf
