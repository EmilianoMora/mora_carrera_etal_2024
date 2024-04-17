library(tidyverse)
library(ggplot2)
library(reshape2)
library(ggpubr)

setwd("~/r_analysis/2nd_chapter_phd/databases/DFE")

DFE <- read.table('all_pops', header = F)
colnames(DFE) <- c("pop_original", "0-1", "1-10","10-100","100-inf")

# Assign population names
pop <- rep(NA, length(DFE$pop_original))
pop[grep("RS170", DFE$pop_original)] <- "TR-D"
pop[grep("RS180", DFE$pop_original)] <- "SK-D"
pop[grep("RSBK01", DFE$pop_original)] <- "CH-D"
pop[grep("EMC6", DFE$pop_original)] <- "EN1-D"
pop[grep("EMC3", DFE$pop_original)] <- "EN2-D"
pop[grep("EMC1", DFE$pop_original)] <- "EN3-D"
pop[grep("EM32_HETERO", DFE$pop_original)] <- "EN5-T-HE"
pop[grep("EM32_HOMO", DFE$pop_original)] <- "EN5-T-HO"
pop[grep("EM07_HETERO", DFE$pop_original)] <- "EN4-T-HE"
pop[grep("EM07_HOMO", DFE$pop_original)] <- "EN4-T-HO"
pop[grep("EM33", DFE$pop_original)] <- "EN6-M"
DFE['pop_original'] <- pop

stacked_DFE <- melt(DFE,id.vars = 1)
colnames(stacked_DFE) <- c("pop_original","bin","prop_ns")

average_stacked_DFE <- stacked_DFE %>% group_by(pop_original, bin) %>% summarise_at(vars("prop_ns"), funs(mean,sd))

data_clone <- average_stacked_DFE
#Accomodate populations west to east (i.e, EN6-M to TR-D)
data_clone$pop_original <- factor(data_clone$pop_original, 
                                  levels = c("TR-D","SK-D","CH-D","EN1-D",
                                             "EN2-D","EN3-D","EN4-T-HE","EN4-T-HO","EN5-T-HE","EN5-T-HO","EN6-M"))
colors_populations=c("#B06A41","#31CCAB","#e41a1c","#984ea3","#F5DA1A",
                     "#f781bf","#377eb8","#86CDDB","#33a02c","#A1DB81","#ff7f00")

#Accomodate populations west to east (i.e, EN6-M to TR-D)
#data_clone$pop_original <- factor(data_clone$pop_original, 
#                                  levels = c("EN6-M","EN5-T-HE","EN5-T-HO",
#                                             "EN4-T-HE","EN3-T-HO","EN3-D",
#                                             "EN2-D","EN1-D","CH-D","SK-D","TR-D"))
#col=c("#ff7f00","#A1DB81","#33a02c","#86CDDB","#377eb8","#f781bf",
#      "#F5DA1A","#984ea3","#e41a1c","#31CCAB","#B06A41")

ggplot(data_clone, aes(x=bin, y=mean, fill=pop_original)) +
  theme_classic() +
  geom_bar(position=position_dodge(), stat="identity", width = 0.80, size=0.85,colour="black") +
  geom_errorbar(aes(ymin=mean-sd, ymax=mean+sd), width=.25,position=position_dodge(.80)) +
  xlab("Strenght of Purifying Selection (Nes)") + ylab("Proportion of NS sites") +
  theme(axis.title.x = element_text(size = 16), axis.text.x = element_text(size = 14),
        axis.title.y = element_text(size = 16), axis.text.y = element_text(size = 14),
        legend.title = element_text(size=12), legend.text = element_text(size=10),
        aspect.ratio = 1/2) +
  scale_fill_manual(values=colors_populations) + guides(fill=guide_legend(title="Populations"))

#Plot with different stripes in the trimorphic populations
#ggplot(data_clone, aes(x=bin, y=mean, fill=pop_original)) +
#  theme_classic() +
#  geom_bar(position=position_dodge(), stat="identity", width = 0.80, size=0.85,colour="black") +
#  geom_errorbar(aes(ymin=mean-sd, ymax=mean+sd), width=.25,position=position_dodge(.80)) +
#  xlab("Strenght of Purifying Selection (Nes)") + ylab("Proportion of NS sites") +
#  theme(axis.title.x = element_text(size = 16), axis.text.x = element_text(size = 14),
#        axis.title.y = element_text(size = 16), axis.text.y = element_text(size = 14),
#        legend.title = element_text(size=12), legend.text = element_text(size=10),
#        aspect.ratio = 1/2) +
#  scale_fill_manual(values=colors_populations) +
#  geom_bar_pattern(position = "dodge", 
#                   pattern=c("none","none","none","none", #CH-D
#                             "none","none","none","none", #EN1-D
#                             "none","none","none","none", #EN2-D
#                             "none","none","none","none", #EN3-D
#                             "none","none","none","none", #EN4-T-HE
#                             "stripe","stripe","stripe","stripe", #EN4-T-HO
#                             "none","none","none","none", #EN5-T-HE
#                             "stripe","stripe","stripe","stripe", #EN5-T-HO
#                             "none","none","none","none", #EN6-M
#                             "none","none","none","none", #SK-D
#                             "none","none","none","none"), #TR-D
#pattern_density=0.1, pattern_spacing=0.05, pattern_fill='black', stat = "identity")
#+ stat_compare_means(comparisons = comp)

#comp <- list(c(data_clone$bin, data_clone$pop_original))

######################################################################################################
##Do the correlation of piN/piS all D(imorphic) populations and latitude using Spearman correlation.

setwd("~/r_analysis/2nd_chapter_phd/databases/DFE")

DFE <- read.table('all_pops', header = F)
colnames(DFE) <- c("pop_original", "A", "B","C","D")

DFE <- DFE %>% mutate(coordinate = pop_original) #create a new column called 'coordinate' that is the same as 'pop_original'

longitude <- rep(NA, length(DFE$coordinate))
longitude[grep("RS170", DFE$coordinate)] <- "39.55"
longitude[grep("RS180", DFE$coordinate)] <- "19.05"
longitude[grep("RSBK01", DFE$coordinate)] <- "6.9"
longitude[grep("EMC6", DFE$coordinate)] <- "-0.13"
longitude[grep("EMC3", DFE$coordinate)] <- "-2.33"
longitude[grep("EMC1", DFE$coordinate)] <- "-2.7"
longitude[grep("EM32", DFE$coordinate)] <- "-2.30"
longitude[grep("EM07", DFE$coordinate)] <- "-2.42"
longitude[grep("EM33", DFE$coordinate)] <- "-2.63"
DFE$longitude <- longitude

DFE$longitude <- as.numeric(DFE$longitude)

DFE_FILTERED <- filter(DFE, pop_original != c("EM32_HETERO")) %>% #remove non used populations for the analysis 
  filter(pop_original != c("EM07_HETERO")) %>%   filter(pop_original != c("EM07_HOMO")) %>%
  filter(pop_original != c("EM33")) %>%   filter(pop_original != c("EM32_HOMO"))

correlation_analyses_0_1 <- cor.test(x = DFE_FILTERED$longitude , y = DFE_FILTERED$A, method = "spearman", exact=FALSE) # We use Sperarmn correlation 
correlation_analyses_1_10 <- cor.test(x = DFE_FILTERED$longitude , y = DFE_FILTERED$B, method = "spearman", exact=FALSE) # We use Sperarmn correlation 
correlation_analyses_10_100 <- cor.test(x = DFE_FILTERED$longitude , y = DFE_FILTERED$C, method = "spearman", exact=FALSE) # We use Sperarmn correlation 
correlation_analyses_100_inf <- cor.test(x = DFE_FILTERED$longitude , y = DFE_FILTERED$D, method = "spearman", exact=FALSE) # We use Sperarmn correlation 

##############
#plot correlation with latitude

pop <- rep(NA, length(DFE_FILTERED$pop_original))
pop[grep("RS170", DFE_FILTERED$pop_original)] <- "TR-D"
pop[grep("RS180", DFE_FILTERED$pop_original)] <- "SK-D"
pop[grep("RSBK01", DFE_FILTERED$pop_original)] <- "CH-D"
pop[grep("EMC6", DFE_FILTERED$pop_original)] <- "EN1-D"
pop[grep("EMC3", DFE_FILTERED$pop_original)] <- "EN2-D"
pop[grep("EMC1", DFE_FILTERED$pop_original)] <- "EN3-D"
DFE_FILTERED['pop'] <- pop

cbind(DFE_FILTERED,pop)

DFE_FILTERED$pop <- factor(DFE_FILTERED$pop, levels = c("TR-D","SK-D","CH-D","EN1-D","EN2-D","EN3-D"))

colors_populations=c("#B06A41","#31CCAB","#e41a1c","#984ea3","#F5DA1A","#f781bf")

plot_0_1 <- ggplot(data=DFE_FILTERED, aes(x=as.numeric(longitude), y=as.numeric(A), color=pop)) + 
  geom_point() +
  theme_classic() +
  xlab("Longitude (°w)") + ylab("DFE bin 0-1") +
  theme(axis.title.x = element_text(size = 16), axis.text.x = element_text(size = 14),
        axis.title.y = element_text(size = 16), axis.text.y = element_text(size = 14),
        legend.title = element_text(size=12), legend.text = element_text(size=10)) + 
  ylim(0,0.5) + geom_smooth(method = "lm", se = F)

plot_1_10 <- ggplot(data=DFE_FILTERED, aes(x=as.numeric(longitude), y=as.numeric(B), color=pop)) + 
  geom_point() +
  theme_classic() +
  xlab("Longitude (°w)") + ylab("DFE bin 1-10") +
  theme(axis.title.x = element_text(size = 16), axis.text.x = element_text(size = 14),
        axis.title.y = element_text(size = 16), axis.text.y = element_text(size = 14),
        legend.title = element_text(size=12), legend.text = element_text(size=10)) + 
  ylim(0,0.5) + geom_smooth(method = "lm", se = F)

plot_10_100 <- ggplot(data=DFE_FILTERED, aes(x=as.numeric(longitude), y=as.numeric(C), color=pop)) + 
  geom_point() +
  theme_classic() +
  xlab("Longitude (°w)") + ylab("DFE bin 10-100") +
  theme(axis.title.x = element_text(size = 16), axis.text.x = element_text(size = 14),
        axis.title.y = element_text(size = 16), axis.text.y = element_text(size = 14),
        legend.title = element_text(size=12), legend.text = element_text(size=10)) + 
  ylim(0,0.5) + geom_smooth(method = "lm", se = F)

plot_100_inf <- ggplot(data=DFE_FILTERED, aes(x=as.numeric(longitude), y=as.numeric(D), color=pop)) + 
  geom_point() +
  theme_classic() +
  xlab("Longitude (°w)") + ylab("DFE bin 100-Inf") +
  theme(axis.title.x = element_text(size = 16), axis.text.x = element_text(size = 14),
        axis.title.y = element_text(size = 16), axis.text.y = element_text(size = 14),
        legend.title = element_text(size=12), legend.text = element_text(size=10)) + 
  ylim(0,0.5) + geom_smooth(method = "lm", se = F)

ggarrange(plot_0_1, plot_1_10, plot_10_100, plot_100_inf, 
          labels = c("A", "B", "C", "D"),
          ncol = 2, nrow = 2)

plot_0_1 <- plot(DFE_FILTERED$longitude,DFE_FILTERED$A)
plot_1_10 <- plot(DFE_FILTERED$longitude,DFE_FILTERED$B)
plot_10_100 <- plot(DFE_FILTERED$longitude,DFE_FILTERED$C)
plot_100_inf <- plot(DFE_FILTERED$longitude,DFE_FILTERED$D)

ggplot(data=summary_dn_ds_FILTERED, aes(x=longitude, y=piN_piS)) + 
  geom_smooth(method = "lm", se = F) +
  geom_point() +
  theme_classic() +
  xlab("Longitude (°w)") + ylab("Mean nucletodie diversity (π)") +
  theme(axis.title.x = element_text(size = 16), axis.text.x = element_text(size = 14),
        axis.title.y = element_text(size = 16), axis.text.y = element_text(size = 14),
        legend.title = element_text(size=12), legend.text = element_text(size=10)) + 
  scale_shape_manual(values = c(15,16,17)) + ylim(0,2)

summary_dn_ds_FILTERED %>% 
  group_by(V1) %>%
  summarise_at(vars(piN_piS), funs(mean(., na.rm=TRUE)))

summary_dn_ds_FILTERED %>% 
  group_by(V1) %>%
  summarise_at(vars(piN_piS), funs(median(., na.rm=TRUE)))

########################################################################################
#Do the analysis of piN/piS between the M(onomorphic) and the T(rimoprhic) populations.

setwd("~/r_analysis/2nd_chapter_phd/databases/DFE")

DFE <- read.table('all_pops', header = F)
colnames(DFE) <- c("pop_original", "A", "B","C","D")

DFE_FILTERED <- filter(DFE, pop_original != c("RS170")) %>% #remove non used populations for the analysis 
  filter(pop_original != c("RS180")) %>%
  filter(pop_original != c("RSBK01"))

pop_type <- rep(NA, length(DFE_FILTERED$pop_original))
pop_type[grep("EMC1", DFE_FILTERED$pop_original)] <- "D"
pop_type[grep("EMC3", DFE_FILTERED$pop_original)] <- "D"
pop_type[grep("EMC6", DFE_FILTERED$pop_original)] <- "D"
pop_type[grep("EM33", DFE_FILTERED$pop_original)] <- "M"
pop_type[grep("EM07_HETERO", DFE_FILTERED$pop_original)] <- "T"
pop_type[grep("EM07_HOMO", DFE_FILTERED$pop_original)] <- "T"
pop_type[grep("EM32_HETERO", DFE_FILTERED$pop_original)] <- "T"
pop_type[grep("EM32_HOMO", DFE_FILTERED$pop_original)] <- "T"
DFE_FILTERED$pop_type <- pop_type

cbind(DFE_FILTERED,pop)

colnames(DFE_FILTERED) <- c("pop", "A", "B","C","D","pop_type")

kruskal.test(A ~ pop, DFE_FILTERED)
kruskal.test(B ~ pop, DFE_FILTERED)
kruskal.test(C ~ pop, DFE_FILTERED)
kruskal.test(D ~ pop, DFE_FILTERED)

kruskal.test(A ~ pop_type, DFE_FILTERED)

pairwise.wilcox.test(DFE_FILTERED$A, DFE_FILTERED$pop, p.adjust.method = "bonf")
pairwise.wilcox.test(DFE_FILTERED$B, DFE_FILTERED$pop, p.adjust.method = "bonf")
pairwise.wilcox.test(DFE_FILTERED$C, DFE_FILTERED$pop, p.adjust.method = "bonf")
pairwise.wilcox.test(DFE_FILTERED$D, DFE_FILTERED$pop, p.adjust.method = "bonf")

DFE_FILTERED %>% 
  group_by(pop) %>%
  summarise_at(vars(A), funs(mean(., na.rm=TRUE)))

DFE_FILTERED %>% 
  group_by(pop) %>%
  summarise_at(vars(A), funs(median(., na.rm=TRUE)))
