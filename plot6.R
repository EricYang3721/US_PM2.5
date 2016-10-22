library(dplyr)
library(tidyr)
library(ggplot2)
#read files
SCC <- readRDS("Source_Classification_Code.rds")
NEI <- readRDS("summarySCC_PM25.rds")
# subset NEI for the SCC with 'mobile' and 'vehicle' in US
index <- grep('mobile', tolower(SCC$EI.Sector))
index <- grep('vehicle', tolower(SCC$EI.Sector[index]))
sub_SCC <- SCC[index,]
vehicle_SCC <- sub_SCC$SCC
vehicle_NEI <- subset(NEI, SCC %in% as.character(vehicle_SCC))
# subset observations in baltimore from the moto-vehicle subset
baltimore_vehicle_NEI <- subset(vehicle_NEI,fips == '24510')
baltimore_vehicle_PM_year <- tapply(baltimore_vehicle_NEI$Emissions, baltimore_vehicle_NEI$year, sum)
# subset observations in log angeles from the moto-vehicle subset
LA_vehicle_NEI <- subset(vehicle_NEI, fips =='06037')
LA_vehicle_PM_year <- tapply(LA_vehicle_NEI$Emission, LA_vehicle_NEI$year, sum)
# combine the baltimore and los angeles data in one dataframe, and spread the dataframe
dframe <- data.frame(baltimore_vehicle_PM_year,LA_vehicle_PM_year)
colnames(dframe) <- c('Baltimore', 'Los Angeles')
dframe$year <- rownames(dframe)
dframe <- dframe %>% gather(City, Emission, -year)
# plot figure and save as a png file
q<-with(dframe, qplot(year, Emission, col=City))
q+ggtitle('Total motor vehicle PM2.5 emission')+ylab('Emission (ton)')
dev.copy(png, 'plot6.png')
dev.off()
