library (ggplot2)
library (magrittr)
library(tidyverse)
library(dplyr)

setwd("~/r_analysis/2nd_chapter_phd/databases/nucleotide_diversity/")

#summary_pi_4fold <- read.table(file="all_pops_4fold.txt", header = F) #The "all_pops_4fold.txt" has all the populations, but the trimorphic population (EM07 and EM32) are not divided.

#Make summary statistics

summary_pi_4fold <- read.table(file="summary_pi_4fold.txt", header = F)

summary_pi_4fold %>%
  group_by(V1) %>%
  summarise_at(vars(V4), funs(mean(., na.rm=TRUE)))

summary_pi_4fold %>% ggplot( aes(x=V1, y=V4)) +
  geom_boxplot() +
  theme(
    legend.position="none",
    plot.title = element_text(size=11))+
  ggtitle("Basic boxplot") +
  xlab("") + ylim(0,0.1)

#Tests for differences in nucleotide diversity between EN6-M and all English dimorphic populations (EN1,EN2, EN3, EN4 and EN5)

summary_pi_4fold_FILTERED <- filter(summary_pi_4fold, V1 != c("RS170_4fold_pi")) %>% #remove non used populations for the analysis 
  filter(V1 != c("RSBK01_4fold_pi")) %>% filter(V1 != c("RS180_4fold_pi")) %>% 
  filter(V1 != c("EM32_4fold_pi"))  %>% filter(V1 != c("EM07_4fold_pi"))

pop_type <- rep(NA, length(summary_pi_4fold_FILTERED$pop2))
pop_type[grep("EMC1_4fold_pi", summary_pi_4fold_FILTERED$V1)] <- "D"
pop_type[grep("EMC3_4fold_pi", summary_pi_4fold_FILTERED$V1)] <- "D"
pop_type[grep("EMC6_4fold_pi", summary_pi_4fold_FILTERED$V1)] <- "D"

pop_type[grep("EM33_4fold_pi", summary_pi_4fold_FILTERED$V1)] <- "M"
summary_pi_4fold_FILTERED$pop_type <- pop_type

kruskal.test(V4 ~ V1, summary_pi_4fold_FILTERED)
kruskal.test(V4 ~ pop_type, summary_pi_4fold_FILTERED)

pairwise.wilcox.test(summary_pi_4fold_FILTERED$V4, summary_pi_4fold_FILTERED$V1, p.adjust.method = "bonf")


#Tests for differences in nucleotide diversity between EN6-M and all English dimorphic populations (EN1,EN2, and EN3)

summary_pi_4fold_FILTERED <- filter(summary_pi_4fold, V1 != c("EM07_4fold_pi_hetero")) %>% #remove non used populations for the analysis 
  filter(V1 != c("EM07_4fold_pi_homo")) %>%
  filter(V1 != c("EM32_4fold_pi_hetero")) %>%
  filter(V1 != c("EM32_4fold_pi_homo")) %>%
  filter(V1 != c("RSBK01_4fold_pi")) %>%
  filter(V1 != c("RS180_4fold_pi")) %>%
  filter(V1 != c("RS170_4fold_pi"))

pop_type <- rep(NA, length(summary_pi_4fold_FILTERED$pop2))
pop_type[grep("EMC1_4fold_pi", summary_pi_4fold_FILTERED$V1)] <- "D"
pop_type[grep("EMC3_4fold_pi", summary_pi_4fold_FILTERED$V1)] <- "D"
pop_type[grep("EMC6_4fold_pi", summary_pi_4fold_FILTERED$V1)] <- "D"
pop_type[grep("EM33_4fold_pi", summary_pi_4fold_FILTERED$V1)] <- "M"
summary_pi_4fold_FILTERED$pop_type <- pop_type

kruskal.test(V4 ~ V1, summary_pi_4fold_FILTERED)
kruskal.test(V4 ~ pop_type, summary_pi_4fold_FILTERED)

pairwise.wilcox.test(summary_pi_4fold_FILTERED$V4, summary_pi_4fold_FILTERED$V1, p.adjust.method = "bonf")

###########The same as above but with Watterson's theta
#Tests for differences in nucleotide diversity between EN6-M and all English dimorphic populations (EN1,EN2, EN3, EN4 and EN5)

summary_wat_4fold <- read.table(file="summary_watterson_4fold.txt", header = F)

#Make summary statistics

summary_wat_4fold %>%
  group_by(V1) %>%
  summarise_at(vars(V4), funs(mean(., na.rm=TRUE)))

summary_wat_4fold_FILTERED <- filter(summary_wat_4fold, V1 != c("RS170_4fold_theta")) %>% #remove non used populations for the analysis 
  filter(V1 != c("RSBK01_4fold_theta")) %>%
  filter(V1 != c("RS180_4fold_theta"))

pop_type <- rep(NA, length(summary_wat_4fold_FILTERED$pop2))
pop_type[grep("EMC1_4fold_theta", summary_wat_4fold_FILTERED$V1)] <- "D"
pop_type[grep("EMC3_4fold_theta", summary_wat_4fold_FILTERED$V1)] <- "D"
pop_type[grep("EMC6_4fold_theta", summary_wat_4fold_FILTERED$V1)] <- "D"
pop_type[grep("EM33_4fold_theta", summary_wat_4fold_FILTERED$V1)] <- "M"
summary_wat_4fold_FILTERED$pop_type <- pop_type

kruskal.test(V4 ~ V1, summary_wat_4fold_FILTERED)
kruskal.test(V4 ~ pop_type, summary_wat_4fold_FILTERED)

pairwise.wilcox.test(summary_wat_4fold_FILTERED$V4, summary_wat_4fold_FILTERED$V1, p.adjust.method = "bonf")

############The same as above but with Watterson's theta
#Tests for differences in nucleotide diversity between EN6-M and all English dimorphic populations (EN1,EN2, EN3, EN4 and EN5)

summary_wat_4fold <- read.table(file="summary_watterson_4fold.txt", header = F)

summary_wat_4fold_FILTERED <- filter(summary_wat_4fold, V1 != c("EM07_4fold_theta_hetero")) %>% #remove non used populations for the analysis 
  filter(V1 != c("EM07_4fold_theta_homo")) %>%
  filter(V1 != c("EM32_4fold_theta_hetero")) %>%
  filter(V1 != c("EM32_4fold_theta_homo")) %>%
  filter(V1 != c("RSBK01_4fold_theta")) %>%
  filter(V1 != c("RS180_4fold_theta")) %>%
  filter(V1 != c("RS170_4fold_theta"))

pop_type <- rep(NA, length(summary_wat_4fold_FILTERED$pop2))
pop_type[grep("EMC1_4fold_theta", summary_wat_4fold_FILTERED$V1)] <- "D"
pop_type[grep("EMC3_4fold_theta", summary_wat_4fold_FILTERED$V1)] <- "D"
pop_type[grep("EMC6_4fold_theta", summary_wat_4fold_FILTERED$V1)] <- "D"
pop_type[grep("EM33_4fold_theta", summary_wat_4fold_FILTERED$V1)] <- "M"
summary_wat_4fold_FILTERED$pop_type <- pop_type

kruskal.test(V4 ~ V1, summary_wat_4fold_FILTERED)
kruskal.test(V4 ~ pop_type, summary_wat_4fold_FILTERED)

pairwise.wilcox.test(summary_wat_4fold_FILTERED$V4, summary_wat_4fold_FILTERED$V1, p.adjust.method = "bonf")

##################################################
#plot 0fold sites

summary_dn_ds %>% ggplot( aes(x=V1, y=V4)) +
  geom_boxplot() +
  theme(
    legend.position="none",
    plot.title = element_text(size=11))+
  ggtitle("Basic boxplot") +
  xlab("")

summary_dn_ds %>% 
  group_by(V1) %>%
  summarise_at(vars(V4), funs(mean(., na.rm=TRUE)))

summary_dn_ds %>% 
  group_by(V1) %>%
  summarise_at(vars(V4), funs(median(., na.rm=TRUE)))

#plot 4fold sites

summary_dn_ds %>% ggplot( aes(x=V1, y=V11)) +
  geom_boxplot() +
  theme(
    legend.position="none",
    plot.title = element_text(size=11))+
  ggtitle("Basic boxplot") +
  xlab("")


summary_dn_ds %>% 
  group_by(V1) %>%
  summarise_at(vars(V11), funs(mean(., na.rm=TRUE)))

summary_dn_ds %>% 
  group_by(V1) %>%
  summarise_at(vars(V11), funs(median(., na.rm=TRUE)))
