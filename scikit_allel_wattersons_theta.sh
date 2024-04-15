#!/bin/bash
#SBATCH --job-name=EM_theta
#SBATCH --output logs/theta.%j.out
#SBATCH --error logs/theta.%j.err
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --time=500:00:00
#SBATCH --mem-per-cpu=3800
#SBATCH --nice=0

pops=(EMC3 EMC6)
chr=(pve_haplotypeT_001 pve_haplotypeT_002 pve_haplotypeT_003 pve_haplotypeT_004 pve_haplotypeT_005 pve_haplotypeT_006 pve_haplotypeT_007 pve_haplotypeT_008 pve_haplotypeT_009 pve_haplotypeT_010 pve_haplotypeT_0
11)
for j in ${pops[@]}; do
for i in ${chr[@]}; do
source /home/ubuntu/etienne/progs/miniconda3/bin/activate emiliano3.6
python << END
import allel
import sys
import numpy as np
import pandas as pd
vcf_file = allel.read_vcf("/home/ubuntu/emiliano/2nd_chp/gatk_analyses/annotate_VCF/with_NewAnnotate/$j/4fold_$j.vcf.gz", fields='*', region='$i')
genotypes = vcf_file['calldata/GT']
gt_array = allel.GenotypeArray(genotypes)
allele_counts = gt_array.count_alleles(max_allele=1)
pos=vcf_file['variants/POS']
pos_allele_counts = np.column_stack((pos, allele_counts)) #Concatenates 'pos' and 'allele_counts' into a single matrix with three columns.
pos_allele_counts_df = pd.DataFrame({'C1':pos_allele_counts[:,0], 'C2':pos_allele_counts[:,1], 'C3':pos_allele_counts[:,2]}) # Converts 'pos_allele_counts' into a pandas dataframe.
pos_pve_haplotypeT_001=48641430
pos_pve_haplotypeT_002=40447909
pos_pve_haplotypeT_003=36637001
pos_pve_haplotypeT_004=35909858
pos_pve_haplotypeT_005=34632233
pos_pve_haplotypeT_006=34034358
pos_pve_haplotypeT_007=33978870
pos_pve_haplotypeT_008=33941020
pos_pve_haplotypeT_009=33717025
pos_pve_haplotypeT_010=33391577
pos_pve_haplotypeT_011=31809631
pos_2 = np.arange(1,np.max(pos_$i)+1, 1)
pos_2_df = pd.DataFrame({'C1':pos_2}) # Converts 'pos_2' into a pandas dataframe.
merged_df = pd.merge(pos_allele_counts_df, pos_2_df, on = "C1", how = "outer") # Merge two dataframes based on the values of the values of C1 (position).
sorted_df = merged_df.sort_values(by='C1', ascending = True) # Sort the dataframe based on the values of C1.
na_to_zero_df = sorted_df.fillna(0) # Change all NaN's to zeros. All NaN's are sites that are not included in the original VCF (e.g., that were filtered out by low quality, INDELs or 0-fold sites).
integers_df = na_to_zero_df.astype(int) # By default all values in a pandas dataframe have decimals that cause a problem when converting into numpy arrays, so we set all values to integers.
df_to_nparray = integers_df.to_numpy() # Convert pandas data frame to numpy array that can be used as input for scikit-allel.
final_allele_counts = np.delete(df_to_nparray, 0, 1) # Deletes the first column of 'df_to_nparray'.
acc_sites = final_allele_counts.any(axis=1) # Creates a Boolean array of the lenght of 'final_allele_counts' where all sites with zero on the first column (i.e., no calls) are coded as False.
pos_3 = np.arange(1,len(pos_2)+1, 1)
theta, windows, n_bases, counts = allel.windowed_watterson_theta(pos_3, final_allele_counts, size = 50000, is_accessible = acc_sites, start = 1, stop = pos_$i)
pd.set_option('display.float_format', '{:.20f}'.format)
theta_df = pd.DataFrame({'C1':theta})
pd.set_option('display.float_format', '{:.8f}'.format)
theta_df_round = theta_df.round(8)
windows_df = pd.DataFrame({'C1':windows[:,0], 'C2':windows[:,1]})
n_bases_df = pd.DataFrame({'C1':n_bases})
counts_df = pd.DataFrame({'C1':counts})
path = '/home/ubuntu/emiliano/2nd_chp/scikit/watterson/windows'
sys_stdout = open(path, 'w')
sys_stdout.write(windows_df.to_string())
sys_stdout.close()
path = '/home/ubuntu/emiliano/2nd_chp/scikit/watterson/n_bases'
sys_stdout = open(path, 'w')
sys_stdout.write(n_bases_df.to_string())
sys_stdout.close()
path = '/home/ubuntu/emiliano/2nd_chp/scikit/watterson/counts'
sys_stdout = open(path, 'w')
sys_stdout.write(counts_df.to_string())
sys_stdout.close()
path = '/home/ubuntu/emiliano/2nd_chp/scikit/watterson/ave_theta'
sys_stdout = open(path, 'w')
sys_stdout.write(theta_df_round.to_string())
sys_stdout.close()
END

paste ave_theta windows counts | tail -n+2 | awk '{print $2,$4,$5,$7}' | sed 's/$/\t'$i'/' | awk '{print $0,NR}' | awk -v OFS='\t' '{print $5,$6,$1,$2,$3,$4}' > $i
rm ave_theta counts n_bases windows; done
cat ${chr[@]} >> ''$j'_4fold_theta'
rm ${chr[@]}; done


for j in ${pops[@]}; do
for i in ${chr[@]}; do
source /home/ubuntu/etienne/progs/miniconda3/bin/activate emiliano3.6
python << END
import allel
import sys
import numpy as np
import pandas as pd
vcf_file = allel.read_vcf("/home/ubuntu/emiliano/2nd_chp/gatk_analyses/annotate_VCF/with_NewAnnotate/$j/0fold_$j.vcf.gz", fields='*', region='$i') # 0-fold estimates
genotypes = vcf_file['calldata/GT']
gt_array = allel.GenotypeArray(genotypes)
allele_counts = gt_array.count_alleles(max_allele=1)
pos=vcf_file['variants/POS']
pos_allele_counts = np.column_stack((pos, allele_counts)) #Concatenates 'pos' and 'allele_counts' into a single matrix with three columns.
pos_allele_counts_df = pd.DataFrame({'C1':pos_allele_counts[:,0], 'C2':pos_allele_counts[:,1], 'C3':pos_allele_counts[:,2]}) # Converts 'pos_allele_counts' into a pandas dataframe.
pos_pve_haplotypeT_001 =48641430
pos_pve_haplotypeT_002 =40447909
pos_pve_haplotypeT_003 =36637001
pos_pve_haplotypeT_004 =35909858
pos_pve_haplotypeT_005 =34632233
pos_pve_haplotypeT_006 =34034358
pos_pve_haplotypeT_007 =33978870
pos_pve_haplotypeT_008 =33941020
pos_pve_haplotypeT_009 =33717025
pos_pve_haplotypeT_010 =33391577
pos_pve_haplotypeT_011 =31809631
pos_2 = np.arange(1,np.max(pos_$i)+1, 1)
pos_2_df = pd.DataFrame({'C1':pos_2}) # Converts 'pos_2' into a pandas dataframe.
merged_df = pd.merge(pos_allele_counts_df, pos_2_df, on = "C1", how = "outer") # Merge two dataframes based on the values of the values of C1 (position).
sorted_df = merged_df.sort_values(by='C1', ascending = True) # Sort the dataframe based on the values of C1.
na_to_zero_df = sorted_df.fillna(0) # Change all NaN's to zeros. All NaN's are sites that are not included in the original VCF (e.g., that were filtered out by low quality, INDELs or 0-fold sites).
integers_df = na_to_zero_df.astype(int) # By default all values in a pandas dataframe have decimals that cause a problem when converting into numpy arrays, so we set all values to integers.
df_to_nparray = integers_df.to_numpy() # Convert pandas data frame to numpy array that can be used as input for scikit-allel.
final_allele_counts = np.delete(df_to_nparray, 0, 1) # Deletes the first column of 'df_to_nparray'.
acc_sites = final_allele_counts.any(axis=1) # Creates a Boolean array of the lenght of 'final_allele_counts' where all sites with zero on the first column (i.e., no calls) are coded as False.
pos_3 = np.arange(1,len(pos_2)+1, 1)
theta, windows, n_bases, counts = allel.windowed_watterson_theta(pos_3, final_allele_counts, size = 50000, is_accessible = acc_sites, start = 1, stop = pos_$i)
pd.set_option('display.float_format', '{:.20f}'.format)
theta_df = pd.DataFrame({'C1':theta})
pd.set_option('display.float_format', '{:.8f}'.format)
theta_df_round = theta_df.round(8)
windows_df = pd.DataFrame({'C1':windows[:,0], 'C2':windows[:,1]})
n_bases_df = pd.DataFrame({'C1':n_bases})
counts_df = pd.DataFrame({'C1':counts})
path = '/home/ubuntu/emiliano/2nd_chp/scikit/watterson/windows'
sys_stdout = open(path, 'w')
sys_stdout.write(windows_df.to_string())
sys_stdout.close()
path = '/home/ubuntu/emiliano/2nd_chp/scikit/watterson/n_bases'
sys_stdout = open(path, 'w')
sys_stdout.write(n_bases_df.to_string())
sys_stdout.close()
path = '/home/ubuntu/emiliano/2nd_chp/scikit/watterson/counts'
sys_stdout = open(path, 'w')
sys_stdout.write(counts_df.to_string())
sys_stdout.close()
path = '/home/ubuntu/emiliano/2nd_chp/scikit/watterson/ave_theta'
sys_stdout = open(path, 'w')
sys_stdout.write(theta_df_round.to_string())
sys_stdout.close()
END

paste ave_theta windows counts | tail -n+2 | awk '{print $2,$4,$5,$7}' | sed 's/$/\t'$i'/' | awk '{print $0,NR}' | awk -v OFS='\t' '{print $5,$6,$1,$2,$3,$4}' > $i
rm ave_theta counts n_bases windows; done
cat ${chr[@]} >> ''$j'_0fold_theta'
rm  ${chr[@]}; done
