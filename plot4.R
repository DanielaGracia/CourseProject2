## 4. Across the United States, how have emissions from coal combustion-related 
## sources changed from 1999–2008?

# 1. Download and read data

setwd("/Users/daniela/Desktop/Data Science Coursera/4-Exploratory_Data_Analysis/Assignment2/CourseProject2")
fileurl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
if(!file.exists("NEIdata.zip")){ 
        download.file(fileurl,destfile = "NEIdata.zip")
        unzip("NEIdata.zip")
}

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
NEI <- transform(NEI, year=factor(year))

library(dplyr)

# 2. Create plot

cond1 <- grepl("Fuel Comb.*Coal", SCC$EI.Sector)
cond2 <- grepl("Comb.*Coal", SCC$Short.Name)
cond3 <- grepl("Coal-fired", SCC$Short.Name)
cond4 <- grepl("In-Process Fuel Use.*Coal", SCC$Short.Name)

SCC2 <- filter(SCC,cond1|cond2|cond3|cond4)
NEI2 <- subset(NEI, NEI$SCC %in% SCC2$SCC)
NEI3 <- group_by(NEI2, Year.Group=NEI2$year)
summary0 <- summarise(NEI3,Total.Emissions=sum(Emissions))
summary2 <-summarise(NEI3,Max.Emissions=max(Emissions))
summary3 <-summarise(NEI3,Mean.Emissions=mean(Emissions))
summary4 <-summarise(NEI3,Median.Emissions=median(Emissions))

png(filename = "plot4.png")
par(mfrow=c(2,2), oma = c(2,3,2,2))

with(NEI3, {
        
        barplot(height=summary0$Total.Emissions, 
                names=summary0$Year.Group, 
                ylab="Total Emissions (tons)",
                main = "Total emissions",
                cex.main = 1,
                col=c("#55e8ec","#b4ffee", "#7bdda4", "#44b48f") )
        barplot(height=summary2$Max.Emissions, 
                names=summary2$Year.Group, 
                ylab="Max Emissions (tons)",
                cex.main = 1,
                main = "Max emissions",
                col=c("#55e8ec","#b4ffee", "#7bdda4", "#44b48f"))
        barplot(height=summary3$Mean.Emissions, 
                names=summary3$Year.Group, 
                ylab="Mean Emissions (tons)",
                cex.main = 1,
                main = "Mean emissions",
                col=c("#55e8ec","#b4ffee", "#7bdda4", "#44b48f"))
        barplot(height=summary4$Median.Emissions, 
                names=summary4$Year.Group, 
                ylab="MedianEmissions (tons)",
                cex.main = 1,
                main = "Median emissions",
                col=c("#55e8ec","#b4ffee", "#7bdda4", "#44b48f"))
        mtext("Emissions from Coal Combustion-Related Sources in the USA (1999 - 2008)", outer=TRUE)
        
        })
     
dev.off()