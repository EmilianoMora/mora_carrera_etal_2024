library(stringr)
library(dplyr)
library(ggplot2)
library(ggpubr)
library(gridExtra)

setwd("~/r_analysis/2nd_chapter_phd/databases/tranposable_elements/")

te <- read.table("TEs_merged_80", header = F)

out <- str_split_fixed(te$V1, "_", 2)
df <- cbind(te, out)
colnames(df) <- c("sample", "TEs", "depth", "pop", "ind")

df<-df[!(df$TEs=="MITE/DTT" | df$TEs=="MITE/DTM" | df$TEs=="MITE/DTH" | df$TEs=="MITE/DTC" | df$TEs=="MITE/DTA" | 
           df$TEs=="LTR/unknown"),]

pop_2 <- rep(NA, length(df$pop))
pop_2[grep("EM33", df$pop)] <- "EN6-M"
pop_2[grep("EMC6", df$pop)] <- "EN1-D"
pop_2[grep("EMC3", df$pop)] <- "EN2-D"
pop_2[grep("EMC1", df$pop)] <- "EN3-D"
pop_2[grep("EM32", df$pop)] <- "EN4-T"
pop_2[grep("EM07", df$pop)] <- "EN5-T"
pop_2[grep("RS170", df$pop)] <- "TR-D"
pop_2[grep("RS180", df$pop)] <- "SK-D"
pop_2[grep("RSBK01", df$pop)] <- "CH-D"

df <- cbind(df, pop_2)

#Change the order of the population so that they are display in the order I indicate.

pop_ordered <- factor(pop_2, levels = c("EN6-M", "EN5-T", "EN4-T", "EN3-D","EN2-D","EN1-D","CH-D","SK-D","TR-D"))
colors_populations=c("#ff7f00","#33a02c","#377eb8","#f781bf","#F5DA1A",
                     "#984ea3","#e41a1c","#31CCAB","#B06A41")

  ggplot(df, aes(x=TEs, y=depth, fill=pop_ordered)) +
    geom_boxplot() +
    theme_classic() +
    scale_fill_manual(values = colors_populations) +
    xlab("Transposable Elements Superfamilies ") + ylab("Normalized TEs sequence coverage") +
    theme(axis.title.x = element_text(size = 16), axis.text.x = element_text(size = 14),
          axis.title.y = element_text(size = 16), axis.text.y = element_text(size = 14),
          legend.title = element_text(size=12), legend.text = element_text(size=10)) +
    guides(fill=guide_legend(title="Populations"))

  ################################
#Split plots per TE superfamily FOR SUPPLEMENTARY
  
  te <- read.table("TEs_merged_80", header = F)
  
  out <- str_split_fixed(te$V1, "_", 2)
  df <- cbind(te, out)
  colnames(df) <- c("sample", "TEs", "depth", "pop", "ind")
  
  pop_2 <- rep(NA, length(df$pop))
  pop_2[grep("EM33", df$pop)] <- "EN6-M"
  pop_2[grep("EMC6", df$pop)] <- "EN1-D"
  pop_2[grep("EMC3", df$pop)] <- "EN2-D"
  pop_2[grep("EMC1", df$pop)] <- "EN3-D"
  pop_2[grep("EM32", df$pop)] <- "EN4-T"
  pop_2[grep("EM07", df$pop)] <- "EN5-T"
  pop_2[grep("RS170", df$pop)] <- "TR-D"
  pop_2[grep("RS180", df$pop)] <- "SK-D"
  pop_2[grep("RSBK01", df$pop)] <- "CH-D"
  
  df <- cbind(df, pop_2)
  
  df<-df[!(df$TEs=="MITE/DTT" | df$TEs=="MITE/DTM" | df$TEs=="MITE/DTH" | df$TEs=="MITE/DTC" | df$TEs=="MITE/DTA" | 
             df$TEs=="LTR/unknown"),]
  
  df_A<-df[!(df$TEs=="DNA/DTC" | df$TEs=="DNA/DTH" | df$TEs=="DNA/DTT" | df$TEs=="DNA/Helitron" | df$TEs=="LTR/Copia" | df$TEs=="LTR/Gypsy"),]
 
  pop_ordered <- factor(df_A$pop_2, levels = c("EN6-M", "EN5-T", "EN4-T", "EN3-D","EN2-D","EN1-D","CH-D","SK-D","TR-D"))
  colors_populations=c("#ff7f00","#33a02c","#377eb8","#f781bf","#F5DA1A",
                       "#984ea3","#e41a1c","#31CCAB","#B06A41")
  
A <-  ggplot(df_A, aes(x=TEs, y=depth, fill=pop_ordered)) +
    geom_boxplot() +
    theme_classic() +
    scale_fill_manual(values = colors_populations) +
    xlab("Transposable Elements Superfamilies ") + ylab("Normalized TEs sequence coverage") +
    theme(axis.title.x = element_blank(),
          axis.title.y = element_blank(),
          legend.position = "none")
  
  df_B<-df[!(df$TEs=="DNA/DTA" | df$TEs=="DNA/DTM" | df$TEs=="DNA/DTH" | df$TEs=="DNA/Helitron" | df$TEs=="LTR/Copia" | df$TEs=="LTR/Gypsy"),]
  
  pop_ordered <- factor(df_B$pop_2, levels = c("EN6-M", "EN5-T", "EN4-T", "EN3-D","EN2-D","EN1-D","CH-D","SK-D","TR-D"))
  colors_populations=c("#ff7f00","#33a02c","#377eb8","#f781bf","#F5DA1A",
                       "#984ea3","#e41a1c","#31CCAB","#B06A41")
  
B <-  ggplot(df_B, aes(x=TEs, y=depth, fill=pop_ordered)) +
    geom_boxplot() +
    theme_classic() +
    scale_fill_manual(values = colors_populations) +
    theme(axis.title.x = element_blank(),
          axis.title.y = element_blank(),
          legend.position = "none")
  
  df_C<-df[!(df$TEs=="DNA/DTA" | df$TEs=="DNA/DTC" | df$TEs=="DNA/DTT" | df$TEs=="DNA/DTM" | df$TEs=="LTR/Copia" | df$TEs=="LTR/Gypsy"),]
  
  pop_ordered <- factor(df_C$pop_2, levels = c("EN6-M", "EN5-T", "EN4-T", "EN3-D","EN2-D","EN1-D","CH-D","SK-D","TR-D"))
  colors_populations=c("#ff7f00","#33a02c","#377eb8","#f781bf","#F5DA1A",
                       "#984ea3","#e41a1c","#31CCAB","#B06A41")
  
C <-  ggplot(df_C, aes(x=TEs, y=depth, fill=pop_ordered)) +
    geom_boxplot() +
    theme_classic() +
    scale_fill_manual(values = colors_populations) +
  theme(axis.title.x = element_blank(),
        axis.title.y = element_blank(),
        legend.position = "none")
  
  df_D<-df[!(df$TEs=="DNA/DTA" | df$TEs=="DNA/DTC" | df$TEs=="DNA/DTH" | df$TEs=="DNA/DTM" | df$TEs=="DNA/Helitron" | df$TEs=="DNA/DTT"),]
  
  pop_ordered <- factor(df_D$pop_2, levels = c("EN6-M", "EN5-T", "EN4-T", "EN3-D","EN2-D","EN1-D","CH-D","SK-D","TR-D"))
  colors_populations=c("#ff7f00","#33a02c","#377eb8","#f781bf","#F5DA1A",
                       "#984ea3","#e41a1c","#31CCAB","#B06A41")
  
D <-  ggplot(df_D, aes(x=TEs, y=depth, fill=pop_ordered)) +
    geom_boxplot() +
    theme_classic() +
    scale_fill_manual(values = colors_populations) +
  xlab("Transposable Elements Superfamilies ") + ylab("Normalized TEs sequence coverage") +
  theme(axis.title.x = element_text(size = 16), axis.text.x = element_text(size = 14),
        axis.title.y = element_blank(),
        legend.position = "none") 

ggarrange(A, B, C, D , 
          labels = c("A", "B", "C", "D"),
          ncol = 1, nrow = 4)
  
#Statistical analyses

pop_type <- rep(NA, length(df$pop))
pop_type[grep("EN6-M", df$pop_2)] <- "M"
pop_type[grep("EN1-D", df$pop_2)] <- "D"
pop_type[grep("EN2-D", df$pop_2)] <- "D"
pop_type[grep("EN3-D", df$pop_2)] <- "D"
pop_type[grep("EN4-T", df$pop_2)] <- "T"
pop_type[grep("EN5-T", df$pop_2)] <- "T"
pop_type[grep("TR-D", df$pop_2)] <- "D"
pop_type[grep("SK-D", df$pop_2)] <- "D"
pop_type[grep("CH-D", df$pop_2)] <- "D"

df <- cbind(df, pop_type)

descdist(df$depth, discrete = F)

y1 <- glm(depth~TEs, data = df)
summary(y1)
y2 <- glm(depth~pop, data = df)
summary(y2)
y3 <- glm(depth~TEs*pop_2, data = df)
summary(y3)
y4 <- glm(depth~TEs*pop_type, data = df)
summary(y4)

anova(y1,y2,y3,y4)

#######################################################

df<-df[!(df$TEs=="MITE/DTT" | df$TEs=="MITE/DTM" | df$TEs=="MITE/DTH" | df$TEs=="MITE/DTC" | df$TEs=="MITE/DTA" | 
          df$TEs=="LTR/unknown"),]

#Statistical analyses by elminating EN4-T, EN5-T, and EN6-M.
df_no_homostyles <- filter(df, pop_2 != c("EN4-T")) %>% #remove non used populations for the analysis 
  filter(pop_2 != c("EN5-T")) %>%
  filter(pop_2 != c("EN6-M"))

#Specify TR-D as the intercept of the model 
df_no_homostyles <- within(df_no_homostyles, pop_2 <- relevel(pop_2, ref="TR-D"))
df_no_homostyles <- within(df_no_homostyles, TEs <- relevel(TEs, ref="DNA/DTT"))
y3b <- glm(depth~pop_2*TEs, data = df_no_homostyles)
summary(y3b)

############################################################
#Statistical analyses by elminating Continental populations

df<-df[!(df$TEs=="MITE/DTT" | df$TEs=="MITE/DTM" | df$TEs=="MITE/DTH" | df$TEs=="MITE/DTC" | df$TEs=="MITE/DTA" | 
          df$TEs=="LTR/unknown"),]

df_no_ContEur <- filter(df, pop_2 != c("CH-D")) %>% #remove non used populations for the analysis 
  filter(pop_2 != c("TR-D")) %>%
  filter(pop_2 != c("SK-D"))

#Specify EN1-D as the intercept of the model 
df_no_ContEur <- within(df_no_ContEur, pop_2 <- relevel(pop_2, ref="EN1-D"))
df_no_ContEur <- within(df_no_ContEur, TEs <- relevel(TEs, ref="DNA/DTT"))
y3b <- glm(depth~pop_2*TEs, data = df_no_ContEur)
summary(y3b)


#MIXED POPULATIONS

te <- read.table("TEs_mixed_merged_2", header = F)
  out <- str_split_fixed(te$V1, "_", 2)
df <- cbind(te, out)
colnames(df) <- c("sample", "TEs", "cov", "pop", "pop_2", "ind")


ggplot(df, aes(x=TEs, y=cov, fill=pop)) +
  geom_boxplot(alpha=0.3) +
  scale_fill_brewer(palette="Dark2")

x <- aov(cov~pop*TEs, data = df)
