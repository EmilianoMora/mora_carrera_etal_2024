#!/bin/bash
#SBATCH --job-name=EM_DFE
#SBATCH --error ./logs/DFE.%j.err
#SBATCH --out ./logs/DFE.%j.out
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --time=900:00:00
#SBATCH --mem-per-cpu=3800
#SBATCH --nice=1000
#SBATCH --partition=main

DFE=/home/ubuntu/emiliano/executables/dfe-alpha-release-2.16
FILE=/home/ubuntu/emiliano/2nd_chp/DFE
POPS=(EM33 EMC1 EMC3 EMC6 RS170 RS180 RSBK01 EM07_HETERO EM07_HOMO EM32_HETERO EM32_HOMO)

export DFE_STUFF=/home/ubuntu/emiliano/executables/dfe-alpha-release-2.16
export LD_LIBRARY_PATH="/usr/lib/x86_64-linux-gnu:$PATH"
export LD_LIBRARY_PATH="/home/ubuntu/emiliano/2nd_chp/DFE:/usr/lib:$PATH"

for i in ${POPS[@]}; do
$DFE/est_dfe -c $FILE/config_files/'dfe_config_'$i'_neu'
$DFE/est_dfe -c $FILE/config_files/'dfe_config_'$i'_sel'
$DFE/prop_muts_in_s_ranges -c $FILE/outputs/''$i'_sel'/est_dfe.out -o $FILE/outputs/dfe_bins/'output_'$i'';done

for i in ${POPS[@]}; do
$DFE/est_dfe -c $FILE/config_files/'dfe_config_'$i'_neu'
$DFE/est_dfe -c $FILE/config_files/'dfe_config_'$i'_sel'
$DFE/prop_muts_in_s_ranges -c $FILE/outputs/''$i'_sel'/est_dfe.out -o $FILE/outputs/dfe_bins/'output_'$i'';done
