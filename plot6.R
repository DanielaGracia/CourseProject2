## 5. Compare emissions from motor vehicle sources in Baltimore City with 
## emissions from motor vehicle sources in Los Angeles County, California 
## (fips == "06037"). 
## Which city has seen greater changes over time in motor vehicle emissions?

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
NEILa <- filter(NEI2,fips == "06037")
NEIBa <- filter(NEI2,fips == "24510")
NEI2 <- rbind(NEILa,NEIBa)
NEI2 <- transform(NEI2, fips=factor(fips))
levels(NEI2$fips) <- c("Los Angeles County", "Baltimore City")

png(filename = "plot6.png")

g <- ggplot(NEI2, aes(x=year,y=Emissions)) +
        facet_grid(.~fips) +
        geom_bar(stat="identity", aes(fill=year) ) +
        theme_bw() +
        labs(x = "Year", y = "Total Emissions (tons)", title="Total PM2.5 Emissions from motor vehicle sources in Baltimore City, \n Maryland and Los Angeles County, California (1999 - 2008)")
g

dev.off()


