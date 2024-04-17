library (ggplot2)
library (magrittr)
library(tidyverse)
library(dplyr)

setwd("~/r_analysis/2nd_chapter_phd/databases/nucleotide_diversity/")

##Do the correlation of piN/piS all D(imorphic) populations and latitude using Spearman correlation.

#summary_dn_ds <- read.table(file="summary_dn_ds.txt", header = F)

summary_dn_ds <- read.table(file="summary_pin_pis.txt", header = F)

mean_pi_non_syn <- summary_dn_ds %>%
  group_by(V1) %>%
  summarise_at(vars(V4), list(~mean(., na.rm=TRUE)))

mean_pi_syn <- summary_dn_ds %>%
  group_by(V1) %>%
  summarise_at(vars(V12), list(~mean(., na.rm=TRUE))) # change to V11 when using the "summary_dn_ds.txt" file

summary_dn_ds[, 3:11][summary_dn_ds[, 3:11] == 0] <- NA

summary_dn_ds$piN <- ifelse(summary_dn_ds$V4<=0.0005,0,summary_dn_ds$V4) #Change nucleotide diveristy values below 0.0001 as '0'
summary_dn_ds$piS <- ifelse(summary_dn_ds$V12<=0.0005,0,summary_dn_ds$V12) #Change nucleotide diveristy values below 0.0001 as '0'

summary_dn_ds[summary_dn_ds == 0] <- NA

summary_dn_ds$piN_piS <- summary_dn_ds$piN / summary_dn_ds$piS
is.na(summary_dn_ds) <- sapply(summary_dn_ds, is.infinite)

summary_dn_ds <- summary_dn_ds %>% mutate(coordinate = V1) #create a new column called 'coordinate' that is the same as 'pop'

longitude <- rep(NA, length(summary_dn_ds$coordinate))
longitude[grep("RS170_0fold_pi", summary_dn_ds$coordinate)] <- "39.55"
longitude[grep("RS180_0fold_pi", summary_dn_ds$coordinate)] <- "19.05"
longitude[grep("RSBK01_0fold_pi", summary_dn_ds$coordinate)] <- "6.9"
longitude[grep("EMC6_0fold_pi", summary_dn_ds$coordinate)] <- "-0.13"
longitude[grep("EMC3_0fold_pi", summary_dn_ds$coordinate)] <- "-2.33"
longitude[grep("EMC1_0fold_pi", summary_dn_ds$coordinate)] <- "-2.7"
longitude[grep("EM32_0fold_pi", summary_dn_ds$coordinate)] <- "-2.30"
longitude[grep("EM07_0fold_pi", summary_dn_ds$coordinate)] <- "-2.42"
longitude[grep("EM33_0fold_pi", summary_dn_ds$coordinate)] <- "-2.63"
summary_dn_ds$longitude <- longitude

summary_dn_ds$longitude <- as.numeric(summary_dn_ds$longitude)

summary_dn_ds_FILTERED <- filter(summary_dn_ds, V1 != c("EM32_0fold_pi")) %>% #remove non used populations for the analysis 
  filter(V1 != c("EM07_0fold_pi")) %>%
  filter(V1 != c("EM33_0fold_pi")) %>% 
  filter(V1 != c("EM07_0fold_pi_hetero")) %>% filter(V1 != c("EM07_0fold_pi_homo")) %>%
  filter(V1 != c("EM32_0fold_pi_hetero")) %>% filter(V1 != c("EM32_0fold_pi_homo"))

summary_dn_ds_FILTERED$longitude <- as.numeric(summary_dn_ds_FILTERED$longitude)

plot(summary_dn_ds_FILTERED$longitude,summary_dn_ds_FILTERED$piN_piS)

correlation_analyses <- cor.test(x = summary_dn_ds_FILTERED$longitude , y = summary_dn_ds_FILTERED$piN_piS, method = "spearman", exact=FALSE) # We use Sperarmn correlation 

#########################################
#Plot results

pop <- rep(NA, length(summary_dn_ds_FILTERED$V1))
pop[grep("RS170_0fold_pi", summary_dn_ds_FILTERED$V1)] <- "TR-D"
pop[grep("RS180_0fold_pi", summary_dn_ds_FILTERED$V1)] <- "SK-D"
pop[grep("RSBK01_0fold_pi", summary_dn_ds_FILTERED$V1)] <- "CH-D"
pop[grep("EMC6_0fold_pi", summary_dn_ds_FILTERED$V1)] <- "EN1-D"
pop[grep("EMC3_0fold_pi", summary_dn_ds_FILTERED$V1)] <- "EN2-D"
pop[grep("EMC1_0fold_pi", summary_dn_ds_FILTERED$V1)] <- "EN3-D"
summary_dn_ds_FILTERED['pop'] <- pop

cbind(summary_dn_ds_FILTERED,pop)

summary_dn_ds_FILTERED$pop <- factor(summary_dn_ds_FILTERED$pop, 
                               levels = c("TR-D","SK-D","CH-D","EN1-D",
                                          "EN2-D","EN3-D"))

colors_populations=c("#B06A41","#31CCAB","#e41a1c","#984ea3","#F5DA1A",
                     "#f781bf")

summary_dn_ds_FILTERED <- na.omit(summary_dn_ds_FILTERED)

ggplot(data=summary_dn_ds_FILTERED, aes(x=as.numeric(longitude), y=as.numeric(piN_piS), color=pop)) + 
  geom_boxplot(width=2) +
  geom_smooth(method = "lm", color = 'grey', se =F) +
  theme_classic() +
  xlab("Longitude (°E)") + ylab("Strength of purifying selection (π N / π S)") +
  theme(axis.title.x = element_text(size = 16), axis.text.x = element_text(size = 14),
        axis.title.y = element_text(size = 16), axis.text.y = element_text(size = 14),
        legend.title = element_text(size=12), legend.text = element_text(size=10)) + 
  ylim(0,8) + guides(col=guide_legend("Populations")) +
  scale_color_manual(values=colors_populations)

summary_dn_ds_FILTERED %>% 
  group_by(V1) %>%
  summarise_at(vars(piN_piS), list(~mean(., na.rm=TRUE)))

summary_dn_ds_FILTERED %>% 
  group_by(V1) %>%
  summarise_at(vars(piN_piS), list(~median(., na.rm=TRUE)))

########################################################################################
#Do the analysis of piN/piS between the M(onomorphic) and the T(rimoprhic) populations.

setwd("~/r_analysis/2nd_chapter_phd/databases/nucleotide_diversity/")

summary_dn_ds <- read.table(file="summary_pin_pis.txt", header = F)

summary_dn_ds$piN <- ifelse(summary_dn_ds$V4<=0.0005,0,summary_dn_ds$V4) # Turn everything that is below 0.0009 into a zero. Low values of piN drags piN/piS upwards.
summary_dn_ds$piS <- ifelse(summary_dn_ds$V12<=0.0005,0,summary_dn_ds$V12) # Turn everything that is below 0.0009 into a zero. Low values of piS drags piN/piS downwards.

#summary_dn_ds[summary_dn_ds == 0] <- NA  #Replace a zero with NA's in all columns

summary_dn_ds$piN_piS <- summary_dn_ds$piN / summary_dn_ds$piS #Calculate piN/piS

summary_dn_ds["piN_piS"][summary_dn_ds["piN_piS"] == 0] <- NA #Eliminates all cases where piN/piS is zero. This eliminates the bias against EM33.

is.na(summary_dn_ds) <- sapply(summary_dn_ds, is.infinite) # When piS is zero, R thinks that piN/piS is inf (inifite) so we turn all 'inf' into NA.

summary_dn_ds %>% ggplot( aes(x=V1, y=piN_piS)) +
  geom_boxplot() +
  theme(
    legend.position="none",
    plot.title = element_text(size=11))+
  ggtitle("Basic boxplot") +
  xlab("") + ylim(0,2)

ggplot(summary_dn_ds, aes(x = piN_piS)) +
  geom_histogram(aes(color = V1), fill = "white",
                 position = "identity", bins = 30) + xlim(0,2) + facet_grid(V1 ~ .)

#summary_dn_ds$piN_piS <- ifelse(summary_dn_ds$piN_piS>=1,NA,summary_dn_ds$piN_piS)

summary_dn_ds %>% 
  group_by(V1) %>%
  summarise_at(vars(piN_piS), funs(mean(., na.rm=TRUE)))

summary_dn_ds %>% 
  group_by(V1) %>%
  summarise_at(vars(piN_piS), funs(median(., na.rm=TRUE)))

summary_dn_ds_FILTERED <- filter(summary_dn_ds, V1 != c("RS170_0fold_pi")) %>% #remove non used populations for the analysis 
  filter(V1 != c("RSBK01_0fold_pi")) %>% filter(V1 != c("RS180_0fold_pi")) %>% filter(V1 != c("EM07_0fold_pi")) %>%
  filter(V1 != c("EM32_0fold_pi"))

pop_type <- rep(NA, length(summary_dn_ds_FILTERED$pop2))
pop_type[grep("EMC1_0fold_pi", summary_dn_ds_FILTERED$V1)] <- "D"
pop_type[grep("EMC3_0fold_pi", summary_dn_ds_FILTERED$V1)] <- "D"
pop_type[grep("EMC6_0fold_pi", summary_dn_ds_FILTERED$V1)] <- "D"
pop_type[grep("EM33_0fold_pi", summary_dn_ds_FILTERED$V1)] <- "M"
summary_dn_ds_FILTERED$pop_type <- pop_type

kruskal.test(piN_piS ~ V1, summary_dn_ds_FILTERED)
kruskal.test(piN_piS ~ pop_type, summary_dn_ds_FILTERED)
kruskal.test(piN_piS ~ V16, summary_dn_ds_FILTERED)

pairwise.wilcox.test(summary_dn_ds_FILTERED$piN_piS, summary_dn_ds_FILTERED$V1, p.adjust.method = "bonf")
pairwise.wilcox.test(summary_dn_ds_FILTERED$piN_piS, summary_dn_ds_FILTERED$pop_type, p.adjust.method = "bonf")
pairwise.wilcox.test(summary_dn_ds_FILTERED$piN_piS, summary_dn_ds_FILTERED$V16, p.adjust.method = "bonf")

summary_dn_ds_FILTERED %>% 
  group_by(V1) %>%
  summarise_at(vars(piN_piS), funs(mean(., na.rm=TRUE)))

summary_dn_ds_FILTERED %>% 
  group_by(V1) %>%
  summarise_at(vars(piN_piS), funs(median(., na.rm=TRUE)))
