library(gmodels)

setwd("~/r_analysis/2nd_chapter_phd/databases")
demo_estimates <- read.table(file = 'merged_estimates', header = F)

colnames(demo_estimates) <- c("NCUR_TR","NCUR_CH","NCUR_EN_D","NCUR_EN_M","TENDBOT1_EN_M","NBOT1_EN_M","NANC_EN","TDIV1","TDIV2","NANC_CH_EN","NBOT2_CH_EN","TBOT2_CH_EN","TENDBOT2_CH_EN","NANC_TR_CH","TDIV3","MaxEstLhood","MaxObsLhood")

sapply(demo_estimates,ci)
