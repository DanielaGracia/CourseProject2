## 5. How have emissions from motor vehicle sources changed from 1999–2008 in 
## Baltimore City?

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
library(ggplot2)

# 2. Create plot

cond1 <- grepl("vehicle", SCC$SCC.Level.Two, ignore.case = TRUE)

SCC2 <- filter(SCC,cond1)
NEI2 <- subset(NEI, NEI$SCC %in% SCC2$SCC)
NEI2 <- filter(NEI2,fips == "24510")
NEI2 <- group_by(NEI2, Year.Group=NEI2$year)
summary0 <- summarise(NEI2,Total.Emissions=sum(Emissions))
summary1 <- summarise(NEI2,Total.Emissions=median(Emissions))

png(filename = "plot5.png")

par(mar=c(6,6,4,6))
barplot(height=summary0$Total.Emissions, 
                names=summary0$Year.Group, 
                main = "Total PM2.5 Emissions in Baltimore City from Motor Vehicle Sources",
                ylab="Total Emissions (tons)",
                col=c("#55e8ec","#b4ffee", "#7bdda4", "#44b48f"),
                xlab = "Year")
        
dev.off()


         