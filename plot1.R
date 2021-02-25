## 1. Have total emissions from PM2.5 decreased in the United States from 1999 
## to 2008? Using the base plotting system, make a plot showing the total PM2.5 
## emission from all sources for each of the years 1999, 2002, 2005, and 2008.

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
NEI2 <- group_by(NEI, Year.Group=NEI$year)
summary <- summarise(NEI2,Total.Emissions=sum(Emissions))
cols <- c("blue", "yellow", "green", "black")

png(filename = "plot1.png")
par(mar=c(6,6,4,2))
barplot(height=summary$Total.Emissions, 
        names=summary$Year.Group, 
        main = "Total PM2.5 Emissions (1999-2008)",
        ylab="Total Emissions (tons)",
        col=c("#a3c1ad", "#a0d6b4","#5f9ea0","#317873"),
        xlab = "Year")

dev.off()

