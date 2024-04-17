#!/bin/bash
#SBATCH --job-name=EM_gatk_SV
#SBATCH --output=./logs/select_variants.%j.out
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --time=500:00:00
#SBATCH --mem-per-cpu=3800
#SBATCH --nice=1000
#SBATCH --partition=main
#SBATCH -e ./logs/select_variants.%j.err

##  SET THE VARIABLES BELOW  ######################
# Please specify the full path for each variable. #

REFERENCE=~/emiliano_2/pve_final-files_backup/pve_haplotypeT.fasta
INPUT=~/emiliano_2/2nd_chp/gatk_analyses/picard/EMC6/VCF/EMC6_combined_genotyped.vcf.gz
OUTPUT=EMC6_snp_indel_novar.vcf.gz

###################################################

/home/ubuntu/giacomo-2/programs/gatk-4.1.2.0/gatk \
--java-options "-Xmx4g -Xms4g" \
SelectVariants \
-R $REFERENCE \
-V $INPUT \
-select-type SNP \
-select-type NO_VARIATION \
-select-type INDEL \
-O $OUTPUT
#!/bin/bash
#SBATCH --job-name=EM_gatk_SV
#SBATCH --output=./logs/select_variants.%j.out
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --time=500:00:00
#SBATCH --mem-per-cpu=3800
#SBATCH --nice=1000
#SBATCH --partition=main
#SBATCH -e ./logs/select_variants.%j.err
#SBATCH --mail-type=FAIL,END
#SBATCH --mail-user=emiliano.mora@systbot.uzh.ch
#SBATCH --nodelist=med32compute004

##  SET THE VARIABLES BELOW  ######################
# Please specify the full path for each variable. #

REFERENCE=~/emiliano_2/pve_final-files_backup/pve_haplotypeT.fasta
INPUT=~/emiliano_2/2nd_chp/gatk_analyses/picard/EMC6/VCF/EMC6_combined_genotyped.vcf.gz
OUTPUT=EMC6_snp_indel_novar.vcf.gz

###################################################

/home/ubuntu/giacomo-2/programs/gatk-4.1.2.0/gatk \
--java-options "-Xmx4g -Xms4g" \
SelectVariants \
-R $REFERENCE \
-V $INPUT \
-select-type SNP \
-select-type NO_VARIATION \
-select-type INDEL \
-O $OUTPUT

###################################################

REFERENCE=~/emiliano_2/pve_final-files_backup/pve_haplotypeT.fasta
INPUT=EMC6_snp_indel_novar.vcf.gz
OUTPUT_1=EMC6_snp_indel_novar_flagged.vcf.gz
OUTPUT_2=EMC6_snp_indel_novar_flagged_filtered.vcf.gz
OUTPUT_3=EMC6_snp_indel_novar_flagged_filtered_header_fixed.vcf.gz
OUTPUT_4=EMC6_snp_indel_novar_flagged_filtered_header_fixed_biallelic_no_indel.vcf.gz
OUTPUT_5=EMC6_snp_indel_novar_flagged_filtered_header_fixed_biallelic_no_indel_ab.vcf.gz

###################################################

#/home/ubuntu/giacomo-2/programs/gatk-4.1.2.0/gatk \
#--java-options "-Xmx8g -Xms8g" \
#VariantFiltration \
#-R $REFERENCE \
#-V $INPUT \
#-filter "QD < 2.0" --filter-name "QD2" \
#-filter "FS > 60.0" --filter-name "FS60" \
#-filter "MQ < 40.0" --filter-name "MQ40" \
#-filter "MQRankSum < -12.5" --filter-name "MQRankSum-12.5" \
#-filter "ReadPosRankSum < -8.0" --filter-name "ReadPosRankSum-8" \
#-filter "(DP < 10) || (DP > 400)" --filter-name "DP10-400" \
#-filter "InbreedingCoeff < -0.99" --filter-name "InbCoeff_fixed_het" \
#-G-filter "(DP < 6) || (DP > 60)" --genotype-filter-name "Gt_DP_6-60" \
#-O $OUTPUT_1

##################################################

#/home/ubuntu/giacomo-2/programs/gatk-4.1.2.0/gatk \
#--java-options "-Xmx8g -Xms8g" \
#SelectVariants \
#-R $REFERENCE \
#-V $OUTPUT_1 \
#-select-type SNP \
#-select-type NO_VARIATION \
#-select-type INDEL \
#--exclude-filtered \
#--set-filtered-gt-to-nocall true \
#-O $OUTPUT_2

##################################################

PROGRAMS=/home/ubuntu/my_data/Narcis/executables/bcftools-1.8
REF=~/emiliano_2/pve_final-files_backup/pve_haplotypeT.fasta
DIR=/home/ubuntu/emiliano_2/2nd_chp/gatk_analyses/filtering/

#$PROGRAMS/bcftools view -h $DIR/EMC6/$OUTPUT_2 > $DIR/EMC6/header_EMC6.txt # Extracts header from VCF file and sends it to txt file
#sed 's/^##FORMAT=<ID=AD,Number=R/##FORMAT=<ID=AD,Number=./' $DIR/EMC6/header_EMC6.txt > $DIR/EMC6/header_EMC6_fixed.txt # Substitutes Number=R to Number=. otherwise bcftools does not run and creates a new txt f
$
#sed -E 's/(W\w[0-12]*[0-9])/EMC6_\1/g' $DIR/EMC6/header_EMC6_fixed.txt > $DIR/EMC6/header_EMC6_fixed_2.txt # Adds the population ID to each individual in the header and creates a new txt file
#$PROGRAMS/bcftools reheader -h $DIR/EMC6/header_EMC6_fixed_2.txt -o $DIR/EMC6/$OUTPUT_3 $DIR/EMC6/$OUTPUT_2 # Add the new head$
#$TABIX/tabix -p vcf $DIR/EMC6/$OUTPUT_3

#rm $DIR/EMC6/header_EMC6.txt $DIR/EMC6/header_EMC6_fixed.txt $DIR/EMC6/header_EMC6_fixed_2.txt

#eliminating the previous file for storage purposes

#rm $OUTPUT_2
#rm $OUTPUT_2.tbi

##################################################

VCFTOOLS=/home/ubuntu/my_data/Narcis/executables/vcftools/src/cpp/
vcf_files=/home/ubuntu/emiliano/2nd_chp/gatk_analyses/filtering
BGZIP=/home/ubuntu/my_data/Narcis/executables/htslib/
TABIX=/home/ubuntu/my_data/Narcis/executables/htslib/

#Eliminating EMC6_WG01 and chr04
$VCFTOOLS/vcftools --gzvcf $vcf_files/EMC6/$OUTPUT_3 --max-alleles 2 --max-missing 0.8 --remove-indv EMC6_WG01 --chr pve_haplotypeT_001 --chr pve_haplotypeT_002 --chr pve_haplotypeT_003 --chr pve_haplotypeT_005 
--chr pve_haplotypeT_006 --chr pve_haplotypeT_007 --chr pve_haplotypeT_008 --chr pve_haplotypeT_009 --chr pve_haplotypeT_010 --chr pve_haplotypeT_011 --remove-indels --recode --recode-INFO-all --stdout | $BGZIP/
bgzip -c > $vcf_files/EMC6/$OUTPUT_4
$TABIX/tabix -p vcf $vcf_files/EMC6/$OUTPUT_4

##################################################

BCFTOOLS=/home/ubuntu/my_data/Narcis/executables/bcftools-1.8

$BCFTOOLS/bcftools filter -e 'GT="het" & (FORMAT/AD[*:1])/((FORMAT/AD[*:0]) + (FORMAT/AD[*:1]))  <= 0.30 | GT="het" & (FORMAT/AD[*:1])/((FORMAT/AD[*:0]) + (FORMAT/AD[*:1])) >= 0.70' \
$vcf_files/EMC6/$OUTPUT_4 -Oz -o $OUTPUT_5
$TABIX/tabix -p vcf $vcf_files/EMC6/$OUTPUT_5
