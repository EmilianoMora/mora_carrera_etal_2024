setwd("~/r_analysis/2nd_chapter_phd/databases/stairway_plot")

TK_D <- read.table("RS170_random_snps_noDownstream.final.summary", header=T)
SK_D <- read.table("RS180_random_snps_noDownstream.final.summary", header=T)
CH_D <- read.table("RSBK01_random_snps_noDownstream.final.summary", header=T)
EN1_D <- read.table("EMC6_9ind_random_snps_noDownstream.final.summary", header=T)
EN2_D <- read.table("EMC3_9ind_random_snps_noDownstream.final.summary", header=T)
EN3_D <- read.table("EMC1_random_snps_noDownstream.final.summary", header=T)
EN6_M <- read.table("EM33_random_snps_noDownstream.final.summary", header=T)

#Tukish population

pdf("~/r_analysis/2nd_chapter_phd/figures/stairway_TR.plot.pdf", height = 6.25, width = 10)

plot(TK_D$year/1000,TK_D$Ne_median/1000, log=c("xy"), type="n", xlab="Time (1k years ago)", ylab="Effective Population Size (1k individuals)",xlim=c(0.1,400),ylim=c(1,40000))

lines(TK_D$year/1000,TK_D$Ne_median/1000,type="s",col="#B06A41",lwd = 2)
lines(TK_D$year/1000,TK_D$Ne_2.5./1000,type="s",col="#B06A41",lty=3)
lines(TK_D$year/1000,TK_D$Ne_97.5./1000,type="s",col="#B06A41",lty=3)

legend(30,30000,legend = c("TR-D", "95% CI"), col=c("#B06A41","black"),lty=c(1,3),lwd=c(5,1),cex=0.8)

dev.off()

#Tukish + Slovakian populations

pdf("~/r_analysis/2nd_chapter_phd/figures/stairway_TR_SK.plot.pdf",height = 6.25,width = 10)

plot(TK_D$year/1000,TK_D$Ne_median/1000, log=c("xy"), type="n", xlab="Time (1k years ago)", ylab="Effective Population Size (1k individuals)",xlim=c(0.1,400),ylim=c(1,40000))

lines(TK_D$year/1000,TK_D$Ne_median/1000,type="s",col="#B06A41",lwd = 2)
lines(TK_D$year/1000,TK_D$Ne_2.5./1000,type="s",col="#B06A41",lty=3)
lines(TK_D$year/1000,TK_D$Ne_97.5./1000,type="s",col="#B06A41",lty=3)

lines(SK_D$year/1000,SK_D$Ne_median/1000,type="s",col="#31CCAB",lwd = 2)
lines(SK_D$year/1000,SK_D$Ne_2.5./1000,type="s",col="#31CCAB",lty=3)
lines(SK_D$year/1000,SK_D$Ne_97.5./1000,type="s",col="#31CCAB",lty=3)

legend(30,30000,legend = c("TR-D", "SK-D", "95% CI"), col=c("#B06A41", "#31CCAB", "black"),lty=c(1,1,3),lwd=c(5,5,1),cex=0.8)

dev.off()

#Tukish + Slovakian + Swiss populations

pdf("~/r_analysis/2nd_chapter_phd/figures/stairway_TR_SK_CH.plot.pdf",height = 6.25,width = 10)

plot(TK_D$year/1000,TK_D$Ne_median/1000, log=c("xy"), type="n", xlab="Time (1k years ago)", ylab="Effective Population Size (1k individuals)",xlim=c(0.1,130),ylim=c(1,40000))

lines(TK_D$year/1000,TK_D$Ne_median/1000,type="s",col="#B06A41",lwd = 2)
lines(TK_D$year/1000,TK_D$Ne_2.5./1000,type="s",col="#B06A41",lty=3)
lines(TK_D$year/1000,TK_D$Ne_97.5./1000,type="s",col="#B06A41",lty=3)

lines(SK_D$year/1000,SK_D$Ne_median/1000,type="s",col="#31CCAB",lwd = 2)
lines(SK_D$year/1000,SK_D$Ne_2.5./1000,type="s",col="#31CCAB",lty=3)
lines(SK_D$year/1000,SK_D$Ne_97.5./1000,type="s",col="#31CCAB",lty=3)

lines(CH_D$year/1000,CH_D$Ne_median/1000,type="s",col="#e41a1c",lwd = 2)
lines(CH_D$year/1000,CH_D$Ne_2.5./1000,type="s",col="#e41a1c",lty=3)
lines(CH_D$year/1000,CH_D$Ne_97.5./1000,type="s",col="#e41a1c",lty=3)

legend(30,30000,legend = c("TR-D", "SK-D", "CH-D", "95% CI"), col=c("#B06A41", "#31CCAB", "#e41a1c", "black"),lty=c(1,1,1,3),lwd=c(5,5,5,1),cex=0.8)

dev.off()

#Tukish + Slovakian + Swiss + English (only EN1)

pdf("~/r_analysis/2nd_chapter_phd/figures/stairway_TR_SK_CH_EN1.plot.pdf",height = 6.25,width = 10)

plot(TK_D$year/1000,TK_D$Ne_median/1000, log=c("xy"), type="n", xlab="Time (1k years ago)", ylab="Effective Population Size (1k individuals)",xlim=c(0.1,130),ylim=c(1,40000))

lines(TK_D$year/1000,TK_D$Ne_median/1000,type="s",col="#B06A41",lwd = 2)
lines(TK_D$year/1000,TK_D$Ne_2.5./1000,type="s",col="#B06A41",lty=3)
lines(TK_D$year/1000,TK_D$Ne_97.5./1000,type="s",col="#B06A41",lty=3)

lines(SK_D$year/1000,SK_D$Ne_median/1000,type="s",col="#31CCAB",lwd = 2)
lines(SK_D$year/1000,SK_D$Ne_2.5./1000,type="s",col="#31CCAB",lty=3)
lines(SK_D$year/1000,SK_D$Ne_97.5./1000,type="s",col="#31CCAB",lty=3)

lines(CH_D$year/1000,CH_D$Ne_median/1000,type="s",col="#e41a1c",lwd = 2)
lines(CH_D$year/1000,CH_D$Ne_2.5./1000,type="s",col="#e41a1c",lty=3)
lines(CH_D$year/1000,CH_D$Ne_97.5./1000,type="s",col="#e41a1c",lty=3)

lines(EN1_D$year/1000,EN1_D$Ne_median/1000,type="s",col="#984ea3",lwd = 2)
lines(EN1_D$year/1000,EN1_D$Ne_2.5./1000,type="s",col="#984ea3",lty=3)
lines(EN1_D$year/1000,EN1_D$Ne_97.5./1000,type="s",col="#984ea3",lty=3)

legend(30,30000,legend = c("TR-D","SK-D","CH-D","EN1-D", "95% CI"), col=c("#B06A41","#31CCAB","#e41a1c","#984ea3","black"),lty=c(1,1,1,1,3),lwd=c(5,5,5,5,1),cex=0.8)

dev.off()

#Tukish + Slovakian + Swiss + English populations (ALL except mixed pops)

pdf("~/r_analysis/2nd_chapter_phd/figures/stairway_TR_SK_CH_EN1_EN2_EN3_EN6.plot.pdf",height = 6.25,width = 10)

plot(TK_D$year/1000,TK_D$Ne_median/1000, log=c("xy"), type="n", xlab="Time (1k years ago)", ylab="Effective Population Size (1k individuals)",xlim=c(0.1,400),ylim=c(1,40000))

lines(TK_D$year/1000,TK_D$Ne_median/1000,type="s",col="#B06A41",lwd = 2)
lines(TK_D$year/1000,TK_D$Ne_2.5./1000,type="s",col="#B06A41",lty=3)
lines(TK_D$year/1000,TK_D$Ne_97.5./1000,type="s",col="#B06A41",lty=3)

lines(SK_D$year/1000,SK_D$Ne_median/1000,type="s",col="#31CCAB",lwd = 2)
lines(SK_D$year/1000,SK_D$Ne_2.5./1000,type="s",col="#31CCAB",lty=3)
lines(SK_D$year/1000,SK_D$Ne_97.5./1000,type="s",col="#31CCAB",lty=3)

lines(CH_D$year/1000,CH_D$Ne_median/1000,type="s",col="#e41a1c",lwd = 2)
lines(CH_D$year/1000,CH_D$Ne_2.5./1000,type="s",col="#e41a1c",lty=3)
lines(CH_D$year/1000,CH_D$Ne_97.5./1000,type="s",col="#e41a1c",lty=3)

lines(EN1_D$year/1000,EN1_D$Ne_median/1000,type="s",col="#984ea3",lwd = 2)
lines(EN1_D$year/1000,EN1_D$Ne_2.5./1000,type="s",col="#984ea3",lty=3)
lines(EN1_D$year/1000,EN1_D$Ne_97.5./1000,type="s",col="#984ea3",lty=3)

lines(EN2_D$year/1000,EN2_D$Ne_median/1000,type="s",col="#F5DA1A",lwd = 2)
lines(EN2_D$year/1000,EN2_D$Ne_2.5./1000,type="s",col="#F5DA1A",lty=3)
lines(EN2_D$year/1000,EN2_D$Ne_97.5./1000,type="s",col="#F5DA1A",lty=3)

lines(EN3_D$year/1000,EN3_D$Ne_median/1000,type="s",col="#f781bf",lwd = 2)
lines(EN3_D$year/1000,EN3_D$Ne_2.5./1000,type="s",col="#f781bf",lty=3)
lines(EN3_D$year/1000,EN3_D$Ne_97.5./1000,type="s",col="#f781bf",lty=3)

lines(EN6_M$year/1000,EN6_M$Ne_median/1000,type="s",col="#ff7f00",lwd = 2)
lines(EN6_M$year/1000,EN6_M$Ne_2.5./1000,type="s",col="#ff7f00",lty=3)
lines(EN6_M$year/1000,EN6_M$Ne_97.5./1000,type="s",col="#ff7f00",lty=3)

legend(30,30000,legend = c("TR-D","SK-D","CH-D","EN1-D","EN2-D","EN3-D","EN6-M", "95% CI"), col=c("#B06A41","#31CCAB","#e41a1c","#984ea3","#F5DA1A","#f781bf","#ff7f00","black"),lty=c(1,1,1,1,1,1,1,3),lwd=c(5,5,5,5,5,5,5,1),cex=0.8)

dev.off()

#One heterostylous population and the monomoprhic population.

  pdf("~/r_analysis/2nd_chapter_phd/figures/stairway_EN1_EN6.plot.pdf",height = 6.25,width = 10)
  
  plot(TK_D$year/1000,TK_D$Ne_median/1000, log=c("xy"), type="n", xlab="Time (1k years ago)", ylab="Effective Population Size (1k individuals)",xlim=c(0.1,130),ylim=c(1,40000))
  
  lines(EN1_D$year/1000,EN1_D$Ne_median/1000,type="s",col="#984ea3",lwd = 2)
  lines(EN1_D$year/1000,EN1_D$Ne_2.5./1000,type="s",col="#984ea3",lty=3)
  lines(EN1_D$year/1000,EN1_D$Ne_97.5./1000,type="s",col="#984ea3",lty=3)
  
  lines(EN6_M$year/1000,EN6_M$Ne_median/1000,type="s",col="#ff7f00",lwd = 2)
  lines(EN6_M$year/1000,EN6_M$Ne_2.5./1000,type="s",col="#ff7f00",lty=3)
  lines(EN6_M$year/1000,EN6_M$Ne_97.5./1000,type="s",col="#ff7f00",lty=3)
  
  legend(30,30000,legend = c("EN1-D","EN6-M", "95% CI"), col=c("#984ea3","#ff7f00","black"),lty=c(1,1,3),lwd=c(5,5,1),cex=0.8)
  
  dev.off()

#################################################################################
#Mixed populations

setwd("~/r_analysis/2nd_chapter_phd/databases/stairway_plot/")

EN4_HE <- read.table("EM32_HETERO_random_snps_noDownstream.final.summary", header=T)
EN4_HO <- read.table("EM32_HOMO_random_snps_noDownstream.final.summary", header=T)

#EN04 (EM32)

pdf("~/r_analysis/2nd_chapter_phd/figures/stairway_EN4.pdf",height = 6.25,width = 10)

plot(EN4_HE$year/1000,EN4_HE$Ne_median/1000, log=c("xy"), type="n", xlab="Time (1k years ago)", ylab="Effective Population Size (1k individuals)",xlim=c(0.1,400),ylim=c(1,40000))

lines(EN4_HE$year/1000,EN4_HE$Ne_median/1000,type="s",col="#377eb8",lwd = 2)
lines(EN4_HE$year/1000,EN4_HE$Ne_2.5./1000,type="s",col="#377eb8",lty=3)
lines(EN4_HE$year/1000,EN4_HE$Ne_97.5./1000,type="s",col="#377eb8",lty=3)

lines(EN4_HO$year/1000,EN4_HO$Ne_median/1000,type="s",col="grey",lwd = 2)
lines(EN4_HO$year/1000,EN4_HO$Ne_2.5./1000,type="s",col="grey",lty=3)
lines(EN4_HO$year/1000,EN4_HO$Ne_97.5./1000,type="s",col="grey",lty=3)

legend(30,30000,legend = c("EN4-T(HE)", "EN4-T(H0)", "95% CI"), col=c("#377eb8", "grey", "black"),lty=c(1,1,3),lwd=c(5,5,1),cex=0.8)

dev.off()

##################################

setwd("~/r_analysis/2nd_chapter_phd/databases/stairway_plot/")

EN5_HE <- read.table("EM07_HETERO_random_snps_noDownstream.final.summary", header=T)
EN5_HO <- read.table("EM07_HOMO_random_snps_noDownstream.final.summary", header=T)

#EN04 (EM32)

pdf("~/r_analysis/2nd_chapter_phd/figures/stairway_EN5.pdf",height = 6.25,width = 10)

plot(EN5_HE$year/1000,EN5_HE$Ne_median/1000, log=c("xy"), type="n", xlab="Time (1k years ago)", ylab="Effective Population Size (1k individuals)",xlim=c(0.1,400),ylim=c(1,40000))

lines(EN5_HE$year/1000,EN5_HE$Ne_median/1000,type="s",col="#33a02c",lwd = 2)
lines(EN5_HE$year/1000,EN5_HE$Ne_2.5./1000,type="s",col="#33a02c",lty=3)
lines(EN5_HE$year/1000,EN5_HE$Ne_97.5./1000,type="s",col="#33a02c",lty=3)

lines(EN5_HO$year/1000,EN5_HO$Ne_median/1000,type="s",col="grey",lwd = 2)
lines(EN5_HO$year/1000,EN5_HO$Ne_2.5./1000,type="s",col="grey",lty=3)
lines(EN5_HO$year/1000,EN5_HO$Ne_97.5./1000,type="s",col="grey",lty=3)

legend(30,30000,legend = c("EN5-T(HE)", "EN5-T(H0)", "95% CI"), col=c("#33a02c", "grey", "black"),lty=c(1,1,3),lwd=c(5,5,1),cex=0.8)

dev.off()

####################################

EN1 <- read.table("EMC1.final.summary", header=T)
EN2_HE <- read.table("EM32_HETERO.final.summary", header=T)
EN3_HE <- read.table("EM07_HETERO.final.summary", header=T)

pdf("stairway_en1_en2_en3.plot.pdf",height = 6.25,width = 10)

plot(EN2_HE$year/1000,EN2_HE$Ne_median/1000, log=c("xy"), type="n", xlab="Time (1k years ago)", ylab="Effective Population Size (1k individuals)",xlim=c(0.1,70),ylim=c(1,40000))

lines(EN1$year/1000,EN1$Ne_median/1000,type="s",col="#47A843",lwd = 2)
lines(EN1$year/1000,EN1$Ne_2.5./1000,type="s",col="#47A843",lty=3)
lines(EN1$year/1000,EN1$Ne_97.5./1000,type="s",col="#47A843",lty=3)

lines(EN2_HE$year/1000,EN2_HE$Ne_median/1000,type="s",col="#377eb8",lwd = 2)
lines(EN2_HE$year/1000,EN2_HE$Ne_2.5./1000,type="s",col="#377eb8",lty=3)
lines(EN2_HE$year/1000,EN2_HE$Ne_97.5./1000,type="s",col="#377eb8",lty=3)

lines(EN3_HE$year/1000,EN3_HE$Ne_median/1000,type="s",col="#F5DA1A",lwd = 2)
lines(EN3_HE$year/1000,EN3_HE$Ne_2.5./1000,type="s",col="#F5DA1A",lty=3)
lines(EN3_HE$year/1000,EN3_HE$Ne_97.5./1000,type="s",col="#F5DA1A",lty=3)

legend(30,30000,legend = c("EN-D","EN-T1","EN-T2","95% CI"), col=c("#47A843","#377eb8","#F5DA1A","black"),lty=c(1,1,1,3),lwd=c(5,5,5,1),cex=0.8)

dev.off()
