library(reshape)
library(ggplot2)

setwd("~/r_analysis/2nd_chapter_phd/databases")

four_bot_models <-read.csv("distribution_AIC_fastsimcoal.csv", header = T)
four_bot_models <- four_bot_models[-1,]
df <- subset(four_bot_models,select = -c(Model.2,Model.3,Model.4,Model.5,
                                  Model.6,Model.2_3,Model.3_3,Model.4_3,Model.5_3,Model.6_3,
                                  Model.2_4,Model.3_4,Model.4_4,Model.5_4,Model.6_4))
colnames(df) <- c("Model 1","Model 2","Model 3","Model 4","Model 5","Model 6")

melt_data <- melt(df)
boxplot(data=melt_data, value~variable, xaxt="n")

ggplot(melt_data, aes(factor(variable), value)) + geom_boxplot() +
  theme_classic() + 
  ylab("AIC") +
  theme(axis.title.x = element_blank(), axis.text.x = element_text(size = 12),
        axis.title.y = element_text(size = 14), axis.text.y = element_text(size = 12),
        plot.title = element_text(hjust = 0.5)) +
  labs(title = "Distribution of AIC values among tested demographic models")
