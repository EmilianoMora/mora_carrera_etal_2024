library (ggplot2)
library (magrittr)
library(tidyverse)
library(dplyr)

setwd("~/r_analysis/2nd_chapter_phd/databases/nucleotide_diversity/")

#Do the correlation analyses with all the data.

summary_pi_4fold <- read.table(file="all_pops_4fold.txt", header = F)
colnames(summary_pi_4fold) <- c("pop","scaffold", "window","pi","wind_low","wind_high","sites", "type_pop")
summary_pi_4fold <- summary_pi_4fold %>% mutate(coordinate = pop)

longitude <- rep(NA, length(summary_pi_4fold$coordinate))
longitude[grep("RS170_4fold_pi", summary_pi_4fold$coordinate)] <- "39.55"
longitude[grep("RS180_4fold_pi", summary_pi_4fold$coordinate)] <- "19.05"
longitude[grep("RSBK01_4fold_pi", summary_pi_4fold$coordinate)] <- "6.9"
longitude[grep("EMC6_4fold_pi", summary_pi_4fold$coordinate)] <- "-0.13"
longitude[grep("EMC3_4fold_pi", summary_pi_4fold$coordinate)] <- "-2.33"
longitude[grep("EMC1_4fold_pi", summary_pi_4fold$coordinate)] <- "-2.7"
longitude[grep("EM32_4fold_pi", summary_pi_4fold$coordinate)] <- "-2.30"
longitude[grep("EM07_4fold_pi", summary_pi_4fold$coordinate)] <- "-2.42"
longitude[grep("EM33_4fold_pi", summary_pi_4fold$coordinate)] <- "-2.63"
summary_pi_4fold$longitude <- longitude

summary_pi_4fold_FILTERED <- filter(summary_pi_4fold, pop != c("EM32_4fold_pi")) %>% #remove non used populations for the analysis 
  filter(pop != c("EM07_4fold_pi")) %>%
  filter(pop != c("EM33_4fold_pi"))

summary_pi_4fold_FILTERED$longitude <- as.numeric(summary_pi_4fold_FILTERED$longitude)

plot(summary_pi_4fold_FILTERED$longitude,summary_pi_4fold_FILTERED$pi)

correlation_analyses <- cor.test(x = summary_pi_4fold_FILTERED$longitude , y = summary_pi_4fold_FILTERED$pi, method = "spearman", exact=FALSE) # We use Sperarmn correlation 

ggplot(data=summary_pi_4fold_FILTERED, aes(x=longitude, y=pi)) + 
  geom_smooth(method = "lm", se = F) +
  geom_point() +
  theme_classic() +
  xlab("Longitude (°w)") + ylab("Mean nucletodie diversity (π)") +
  theme(axis.title.x = element_text(size = 16), axis.text.x = element_text(size = 14),
        axis.title.y = element_text(size = 16), axis.text.y = element_text(size = 14),
        legend.title = element_text(size=12), legend.text = element_text(size=10)) +
  guides(color=guide_legend(title="Populations"), shape=guide_legend(title="Morph composition")) +
  scale_color_manual(values=colors_populations) + scale_shape_manual(values = c(15,16,17)) + ylim(0,0.005)

###################################
#Plot results

#MODIFY POPULATION NAMES

pop <- rep(NA, length(summary_pi_4fold$pop))
pop[grep("RS170", summary_pi_4fold$pop)] <- "TR-D"
pop[grep("RS180", summary_pi_4fold$pop)] <- "SK-D"
pop[grep("RSBK01", summary_pi_4fold$pop)] <- "CH-D"
pop[grep("EMC6", summary_pi_4fold$pop)] <- "EN1-D"
pop[grep("EMC3", summary_pi_4fold$pop)] <- "EN2-D"
pop[grep("EMC1", summary_pi_4fold$pop)] <- "EN3-D"
pop[grep("EM32", summary_pi_4fold$pop)] <- "EN5-T"
pop[grep("EM07", summary_pi_4fold$pop)] <- "EN4-T"
pop[grep("EM33", summary_pi_4fold$pop)] <- "EN6-M"
summary_pi_4fold['pop'] <- pop

summary_pi_4fold$pop <- factor(summary_pi_4fold$pop, 
                         levels = c("TR-D","SK-D","CH-D","EN1-D",
                                    "EN2-D","EN3-D","EN4-T","EN5-T","EN6-M"))

colors_populations=c("#B06A41","#31CCAB","#e41a1c","#984ea3","#F5DA1A",
                     "#f781bf","#377eb8","#33a02c","#ff7f00")

ggplot(data=summary_pi_4fold, aes(x=longitude, y=pi, color=pop, shape=type_pop)) + 
  geom_point() +
  theme_classic() +
#  geom_errorbar(aes(ymin=mean_pi-sd_pi, ymax=pi+sd_pi), width=.25,position=position_dodge(.80)) +
  xlab("Longitude (°w)") + ylab("Mean nucletodie diversity (π)") +
  theme(axis.title.x = element_text(size = 16), axis.text.x = element_text(size = 14),
        axis.title.y = element_text(size = 16), axis.text.y = element_text(size = 14),
        legend.title = element_text(size=12), legend.text = element_text(size=10)) +
  guides(color=guide_legend(title="Populations"), shape=guide_legend(title="Morph composition")) +
  scale_color_manual(values=colors_populations) + scale_shape_manual(values = c(15,16,17)) + 
  geom_abline(slope = coef(correlation_analyses)[["longitude"]], intercept = coef(correlation_analyses)[["(Intercept)"]])

#####################################



mean_pi <- summary_pi_4fold %>%
  group_by(pop) %>%
  summarise_at(vars(pi), funs(mean(., na.rm=TRUE)))

mean_pi_df <- as.data.frame(mean_pi)

sd_pi <- summary_pi_4fold %>%
  group_by(pop) %>%
  summarise_at(vars(pi), funs(sd(., na.rm=TRUE)))

sd_pi_df <- as.data.frame(sd_pi)
mean_sd_pi <- cbind(mean_pi,sd_pi_df)
colnames(mean_sd_pi) <- c("pop","mean_pi","pop2","sd_pi")

#ADD longitude COORDINATES

longitude <- rep(NA, length(mean_sd_pi$pop2))
longitude[grep("RS170_4fold_pi", mean_sd_pi$pop2)] <- "39.55"
longitude[grep("RS180_4fold_pi", mean_sd_pi$pop2)] <- "19.05"
longitude[grep("RSBK01_4fold_pi", mean_sd_pi$pop2)] <- "6.9"
longitude[grep("EMC6_4fold_pi", mean_sd_pi$pop2)] <- "-0.13"
longitude[grep("EMC3_4fold_pi", mean_sd_pi$pop2)] <- "-2.33"
longitude[grep("EMC1_4fold_pi", mean_sd_pi$pop2)] <- "-2.7"
longitude[grep("EM32_4fold_pi", mean_sd_pi$pop2)] <- "-2.30"
longitude[grep("EM07_4fold_pi", mean_sd_pi$pop2)] <- "-2.42"
longitude[grep("EM33_4fold_pi", mean_sd_pi$pop2)] <- "-2.63"
mean_sd_pi$longitude <- longitude

#MODIFY POPULATION NAMES

pop <- rep(NA, length(mean_sd_pi$pop))
pop[grep("RS170", mean_sd_pi$pop)] <- "TR-D"
pop[grep("RS180", mean_sd_pi$pop)] <- "SK-D"
pop[grep("RSBK01", mean_sd_pi$pop)] <- "CH-D"
pop[grep("EMC6", mean_sd_pi$pop)] <- "EN1-D"
pop[grep("EMC3", mean_sd_pi$pop)] <- "EN2-D"
pop[grep("EMC1", mean_sd_pi$pop)] <- "EN3-D"
pop[grep("EM32", mean_sd_pi$pop)] <- "EN5-T"
pop[grep("EM07", mean_sd_pi$pop)] <- "EN4-T"
pop[grep("EM33", mean_sd_pi$pop)] <- "EN6-M"
mean_sd_pi['pop'] <- pop

#ADD longitude COORDINATES

pop_type <- rep(NA, length(mean_sd_pi$pop2))
pop_type[grep("TR-D", mean_sd_pi$pop)] <- "D"
pop_type[grep("SK-D", mean_sd_pi$pop)] <- "D"
pop_type[grep("CH-D", mean_sd_pi$pop)] <- "D"
pop_type[grep("EN1-D", mean_sd_pi$pop)] <- "D"
pop_type[grep("EN2-D", mean_sd_pi$pop)] <- "D"
pop_type[grep("EN3-D", mean_sd_pi$pop)] <- "D"
pop_type[grep("EN4-T", mean_sd_pi$pop)] <- "T"
pop_type[grep("EN5-T", mean_sd_pi$pop)] <- "T"
pop_type[grep("EN6-M", mean_sd_pi$pop)] <- "M"
mean_sd_pi$pop_type <- pop_type

mean_sd_pi$longitude <- as.numeric(mean_sd_pi$longitude)

mean_sd_pi_FILTERED <- filter(mean_sd_pi, pop_type != c("T")) %>% filter(pop_type != c("M")) #remove populations T(rimorphic) and M(onomorphic).

correlation_analyses <- lm(mean_pi~longitude, mean_sd_pi_FILTERED)

summary (correlation_analyses)


# PLOT RESULTS

mean_sd_pi$pop <- factor(mean_sd_pi$pop, 
                                  levels = c("TR-D","SK-D","CH-D","EN1-D",
                                             "EN2-D","EN3-D","EN4-T","EN5-T","EN6-M"))

colors_populations=c("#B06A41","#31CCAB","#e41a1c","#984ea3","#F5DA1A",
                     "#f781bf","#377eb8","#33a02c","#ff7f00")

ggplot(data=mean_sd_pi, aes(x=longitude, y=mean_pi, color=pop, shape=pop_type)) + 
  geom_point() +
  theme_classic() +
  geom_errorbar(aes(ymin=mean_pi-sd_pi, ymax=mean_pi+sd_pi), width=.25,position=position_dodge(.80)) +
  xlab("Longitude (°w)") + ylab("Mean nucletodie diversity (π)") +
  theme(axis.title.x = element_text(size = 16), axis.text.x = element_text(size = 14),
        axis.title.y = element_text(size = 16), axis.text.y = element_text(size = 14),
        legend.title = element_text(size=12), legend.text = element_text(size=10)) +
  guides(color=guide_legend(title="Populations"), shape=guide_legend(title="Morph composition")) +
  scale_color_manual(values=colors_populations) + scale_shape_manual(values = c(15,16,17)) + 
  geom_abline(slope = coef(correlation_analyses)[["longitude"]], intercept = coef(correlation_analyses)[["(Intercept)"]])
