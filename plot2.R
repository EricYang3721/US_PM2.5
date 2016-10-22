NEI <- readRDS("summarySCC_PM25.rds")
baltimore <- subset(NEI, fips == '24510')
total_baltimore_year <- tapply(baltimore$Emissions, baltimore$year, sum) 
plot(names(total_baltimore_year), total_baltimore_year, xlab='year', ylab='total emission in baltimore (ton)', main='Total PM2.5 emission in baltimore ')
dev.copy(png, 'plot2.png')
dev.off()