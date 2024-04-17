library ("RColorBrewer")
setwd("~/r_analysis/2nd_chapter_phd/databases/ADMIXTURE")
opt=character(0)

#set the name of your files here. Everything before the .Q
opt$prefix="all_pops"
opt$outPrefix=opt$prefix

# Assign the first argument to prefix
prefix=opt$prefix

# Get individual names in the correct order
labels<-read.table("all_pops.list.txt")

# Name the columns
names(labels)<-c("ind","pop")

# Change individuals and populations ID.
labels$pop <- gsub("RS170", "TR-D", labels$pop)
labels$pop <- gsub("RSBK01", "CH-D", labels$pop)
labels$pop <- gsub("RS180", "SK-D", labels$pop)
labels$pop <- gsub("EMC6", "EN-D1", labels$pop)
labels$pop <- gsub("EMC3", "EN-D2", labels$pop)
labels$pop <- gsub("EMC1", "EN-D3", labels$pop)
labels$pop <- gsub("EM32", "EN-T1", labels$pop)
labels$pop <- gsub("EM07", "EN-T2", labels$pop)
labels$pop <- gsub("EM33", "EN-M1", labels$pop)

# Set the display order of the population in the Admixture plot
opt$populations <-"EN-M1,EN-T2,EN-T1,EN-D3,EN-D2,EN-D1,CH-D,SK-D,TR-D"

# Add a column with population indices to order the barplots
# Use the order of populations provided as the fourth argument (list separated by commas)
labels$n<-factor(labels$pop,levels=unlist(strsplit(opt$populations,",")))
levels(labels$n)<-c(1:length(levels(labels$n)))
labels$n<-as.integer(as.character(labels$n))

# read in the different admixture output files
minK=4
maxK=6
tbl<-lapply(minK:maxK, function(x) read.table(paste0(prefix,".",x,".Q")))


# Prepare spaces to separate the populations/species
rep<-as.vector(table(labels$n))
spaces<-0
for(i in 1:length(rep)){spaces=c(spaces,rep(0,rep[i]-1),0.5)}
spaces<-spaces[-length(spaces)]

# Plot the number of k's
par(mfrow=c(maxK-1,1),mar=c(0,1,0,0),oma=c(2,1,9,1),mgp=c(0,0.2,0),xaxs="i",cex.lab=1.3)
bp<-barplot(t(as.matrix(tbl[[1]][order(labels$n),])), col=colorRampPalette(brewer.pal(11, "Spectral"))(minK),xaxt="n", border=NA,ylab=paste("K=",minK),yaxt="n",space=spaces)
axis(3,at=bp,labels=labels$ind[order(labels$n)],las=2,tick=T,cex=0.5,tck=0.04)
lapply(2:(length(tbl)), function(x) barplot(t(as.matrix(tbl[[x]][order(labels$n),])), col=colorRampPalette(brewer.pal(11, "Spectral"))(x+minK-1),xaxt="n", border=NA,ylab=paste0("K=",x+minK-1),yaxt="n",space=spaces))
axis(1,at=c(which(spaces==0.5),bp[length(bp)])-diff(c(1,which(spaces==0.5),bp[length(bp)]))/2,
     labels=unlist(strsplit(opt$populations,",")))
