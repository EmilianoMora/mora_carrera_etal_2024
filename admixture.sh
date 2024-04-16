#!/bin/bash
#SBATCH --job-name=EM_admixture
#SBATCH --output ./logs/admixture.%j.out
#SBATCH --error ./logs/admixture.%j.err
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --time=500:00:00
#SBATCH --mem-per-cpu=3700
#SBATCH --nice=100

ADMIXTURE=/home/ubuntu/rebecca-2/programs/admixture_linux-1.3.0
PLINK=/home/ubuntu/emiliano/executables/plink_1_9
input=/home/ubuntu/emiliano/2nd_chp/PCA
output=/home/ubuntu/emiliano/2nd_chp/admixture

# ADMIXTURE does not accept chromosome names that are not human chromosomes. We will thus just exchange the first column by 0. This works for my files too.
awk '{$1=0;print $0}' $input/all_pops.bim > $input/all_pops.bim.tmp
mv $input/all_pops.bim.tmp $input/all_pops.bim

##Finally to admixture
for i in {2..9}; do $ADMIXTURE/admixture --cv $input/all_pops.bed $i -j4 > $output/admixture_log${i}.out; done

#get cv values
awk '/CV/ {print $3,$4}' *out | cut -c 4-5,7-20 > $output/all_pops.cv.error.txt

#make new file with indiv names in one column and species names in second column
awk '{split($1,name,"_"); print $1,name[1]}' $input/all_pops.fam > all_pops.list
