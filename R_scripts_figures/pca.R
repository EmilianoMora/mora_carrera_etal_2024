library(tidyverse)
library(ggpubr)
library(dplyr)
library (magrittr)
library(dplyr)
library(shiny)
library(scatterplot3d)

setwd("~/r_analysis/2nd_chapter_phd/databases/PCA")

# Script to plot PCA based on output files of PLINK.
# Read necessary output files
pca <- read_table("all_pops.eigenvec", col_names = FALSE)
eigenval <- scan("all_pops.eigenval")

# Eliminate an column with repeated information about the individuals.
pca <- pca[,-1]

# Assign column names.
names(pca)[1] <- "ind"
names(pca)[2:ncol(pca)] <- paste0("PC", 1:(ncol(pca)-1))

# Estimates percentage of variance explained by each PC and calculates the cumulative sum of the percentage variance explained
pve <- data.frame(PC = 1:20, pve = eigenval/sum(eigenval)*100)
cumsum(pve$pve)

# Plots variance explained by PC
a <- ggplot(pve, aes(PC, pve)) + geom_bar(stat = "identity")+ ylab("Percentage variance explained") + theme_light()

# Assign populations
pop <- rep(NA, length(pca$ind))
pop[grep("RS170", pca$ind)] <- "TR-D"
pop[grep("RS180", pca$ind)] <- "SK-D"
pop[grep("RSBK01", pca$ind)] <- "CH-D"
pop[grep("EMC6", pca$ind)] <- "EN1-D"
pop[grep("EMC3", pca$ind)] <- "EN2-D"
pop[grep("EMC1", pca$ind)] <- "EN3-D"
pop[grep("EM32", pca$ind)] <- "EN4-T"
pop[grep("EM07", pca$ind)] <- "EN5-T"
pop[grep("EM33", pca$ind)] <- "EN6-M"

#Change the order of the population so that they are display in the5 order I indicate.
pop_ordered <- factor(pop, levels = c("TR-D","SK-D","CH-D","EN1-D","EN2-D","EN3-D","EN4-T","EN5-T","EN6-M"))

# Plot PCA
pca
pc1 <- pca %>% pull(PC1)
pc2 <- pca %>% pull(PC2)
pc3 <- pca %>% pull(PC3)
individuals <- pca %>% pull(ind)
reduced_pca <- cbind(pc1, pc2, pc3,individuals)
reduced_pca <- as.data.frame.matrix(reduced_pca) 

colors = c("#B06A41","#31CCAB","#e41a1c","#984ea3","#F5DA1A","#f781bf","#377eb8","#33a02c","#ff7f00")
colors <- colors[as.numeric(pop_ordered)]

plt <- with(pca, scatterplot3d(PC1, PC2, PC3, 
                                xlim=c(-0.30, 0.05), ylim=c(-0.25, 0.10), zlim=c(-0.3, 0.3),
                                ylab="", color=colors, grid=T, pch = 16, cex.symbols = 2.5, 
                                scale.y=1, angle=45, type = 'h'))
plt$points3d(x=c(0, 1), y=c(0.5, 0.5), z=c(0, 0), type="l", col="grey")
plt$points3d(x=c(0.5, 0.5), y=c(0, 1), z=c(0, 0), type="l", col="grey")
xy <- unlist(plt$xyz.convert(0.15, -0.075, -0.4)) #obtain coordinates to add "PC2" label
text(xy[1], xy[2], "PC2", srt=45, pos=2) #add PC3 to the label
legend(-6.5, 3.5, legend = levels(pop_ordered), pch = 16, pt.cex = 2, col=c("#B06A41","#31CCAB","#e41a1c","#984ea3","#F5DA1A","#f781bf","#377eb8","#33a02c","#ff7f00"),
        title='Population', cex=0.90)
