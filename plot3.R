## 3. Of the four types of sources indicated by the type (point, nonpoint, 
## onroad, nonroad) variable, which of these four sources have seen decreases in 
## emissions from 1999–2008 for Baltimore City? Which have seen increases in 
## emissions from 1999–2008? Use the ggplot2 plotting system to make a plot 
## answer this question.

# 1. Download and read data

setwd("/Users/daniela/Desktop/Data Science Coursera/4-Exploratory_Data_Analysis/Assignment2/CourseProject2")
fileurl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
if(!file.exists("NEIdata.zip")){ 
        download.file(fileurl,destfile = "NEIdata.zip")
        unzip("NEIdata.zip")
}

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

library(dplyr)
library(ggplot2)

# 2. Create plot
NEI2 <- filter(NEI,fips == "24510")
NEI2 <- transform(NEI2, year=factor(year))
NEI2 <- transform(NEI2, type=factor(type))

png(filename = "plot3.png")

p <- ggplot(NEI2, aes(x=year, y=Emissions)) +
        facet_grid(.~type) +
        geom_bar(stat="identity", fill="#ffe9e1" ) +
        theme_bw() +
        labs(x = "Year", y = "Total Emissions (tons)", title="Total PM2.5 Emissions in Baltimore City, Maryland for different sources")
p
dev.off()

