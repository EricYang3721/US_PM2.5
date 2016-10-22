library(dplyr)
SCC <- readRDS("Source_Classification_Code.rds")
NEI <- readRDS("summarySCC_PM25.rds")
index <- grep('mobile', tolower(SCC$EI.Sector))
index <- grep('vehicle', tolower(SCC$EI.Sector[index]))
sub_SCC <- SCC[index,]
vehicle_SCC <- sub_SCC$SCC
vehicle_NEI <- subset(NEI, SCC %in% as.character(vehicle_SCC))
baltimore_vehicle_NEI <- subset(vehicle_NEI,fips == '24510')
baltimore_vehicle_PM_year <- tapply(baltimore_vehicle_NEI$Emissions, baltimore_vehicle_NEI$year, sum)
plot(names(baltimore_vehicle_PM_year),baltimore_vehicle_PM_year, xlab='year', ylab = 'total emission (ton)', main='Total motor vehicle PM2.5 emission in Baltimore, MD')
dev.copy(png, 'plot5.png')
dev.off()
