library(dplyr)
#read files
SCC <- readRDS("Source_Classification_Code.rds")
NEI <- readRDS("summarySCC_PM25.rds")
# subset data with 'mobile' and 'vehicle' 
index <- grep('mobile', tolower(SCC$EI.Sector))
index <- grep('vehicle', tolower(SCC$EI.Sector[index]))
sub_SCC <- SCC[index,]
vehicle_SCC <- sub_SCC$SCC
vehicle_NEI <- subset(NEI, SCC %in% as.character(vehicle_SCC))
# subset observations in baltimore in the motor-vehicle subset, and sum the pm2.5 pollution
baltimore_vehicle_NEI <- subset(vehicle_NEI,fips == '24510')
baltimore_vehicle_PM_year <- tapply(baltimore_vehicle_NEI$Emissions, baltimore_vehicle_NEI$year, sum)
# plot figure and save as a file
plot(names(baltimore_vehicle_PM_year),baltimore_vehicle_PM_year, xlab='year', ylab = 'total emission (ton)', main='Total motor vehicle PM2.5 emission in Baltimore, MD')
dev.copy(png, 'plot5.png')
dev.off()
