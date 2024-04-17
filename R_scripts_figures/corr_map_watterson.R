library (ggplot2)
library (magrittr)
library(tidyverse)
library(dplyr)

setwd("~/r_analysis/2nd_chapter_phd/databases")

#Do the correlation analyses with all the data.

summary_theta_hetero_4fold <- read.table(file="summary_watterson_4fold.txt", header = F)
colnames(summary_theta_hetero_4fold) <- c("pop","scaffold", "window","watterson","wind_low","wind_high","sites")
summary_theta_hetero_4fold <- summary_theta_hetero_4fold %>% mutate(coordinate = pop)

longitude <- rep(NA, length(summary_theta_hetero_4fold$coordinate))
longitude[grep("RS170_4fold_theta", summary_theta_hetero_4fold$coordinate)] <- "39.55"
longitude[grep("RS180_4fold_theta", summary_theta_hetero_4fold$coordinate)] <- "19.05"
longitude[grep("RSBK01_4fold_theta", summary_theta_hetero_4fold$coordinate)] <- "6.9"
longitude[grep("EMC6_4fold_theta", summary_theta_hetero_4fold$coordinate)] <- "-0.13"
longitude[grep("EMC3_4fold_theta", summary_theta_hetero_4fold$coordinate)] <- "-2.33"
longitude[grep("EMC1_4fold_theta", summary_theta_hetero_4fold$coordinate)] <- "-2.7"
longitude[grep("EM32_4fold_theta", summary_theta_hetero_4fold$coordinate)] <- "-2.30"
longitude[grep("EM07_4fold_theta", summary_theta_hetero_4fold$coordinate)] <- "-2.42"
longitude[grep("EM33_4fold_theta", summary_theta_hetero_4fold$coordinate)] <- "-2.63"
summary_theta_hetero_4fold$longitude <- longitude

summary_theta_hetero_4fold_FILTERED <- filter(summary_theta_hetero_4fold, pop != c("EM32_4fold_theta_hetero")) %>% #remove non used populations for the analysis 
  filter(pop != c("EM07_4fold_theta_hetero")) %>%
  filter(pop != c("EM33_4fold_theta_hetero")) %>%
  filter(pop != c("EM07_4fold_theta_homo")) %>%
  filter(pop != c("EM33_4fold_theta_homo")) %>%
  filter(pop != c("EM32_4fold_theta_homo"))

summary_theta_hetero_4fold_FILTERED$longitude <- as.numeric(summary_theta_hetero_4fold_FILTERED$longitude)

plot(summary_theta_hetero_4fold_FILTERED$longitude,summary_theta_hetero_4fold_FILTERED$watterson)

correlation_analyses <- cor.test(x = summary_theta_hetero_4fold_FILTERED$longitude , y = summary_theta_hetero_4fold_FILTERED$watterson, method = "spearman", exact=FALSE) # We use Sperarmn correlation 
