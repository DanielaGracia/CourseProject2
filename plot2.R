## 2. Have total emissions from PM2.5 decreased in the Baltimore City, Maryland 
## (fips == "24510") from 1999 to 2008? Use the base plotting system to make a 
## plot answering this question.

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
NEI2 <- filter(NEI,fips == "24510")
NEI3 <- group_by(NEI2, Year.Group=NEI2$year)
summary <- summarise(NEI3,Total.Emissions=sum(Emissions))

png(filename = "plot2.png")
par(mar=c(6,6,4,6))
barplot(height=summary$Total.Emissions, 
        names=summary$Year.Group, 
        main = "Total PM2.5 Emissions in Baltimore City, Maryland (1999-2008)",
        ylab="Total Emissions (tons)",
        col=c("#a3c1ad", "#a0d6b4","#5f9ea0","#317873"),
        xlab = "Year")

dev.off()

