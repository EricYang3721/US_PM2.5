## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
#SCC <- readRDS("Source_Classification_Code.rds")
total_PM_year <- tapply(NEI$Emissions, NEI$year, sum) # Get the sum of the pollution for each year
# Plot figure and save as a png file.
plot(names(total_PM_year),total_PM_year, xlab='year', ylab = 'total emission (ton)', main='Total PM2.5 emission in US')
dev.copy(png, 'plot1.png')
dev.off()