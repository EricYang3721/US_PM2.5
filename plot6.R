library(dplyr)
library(tidyr)
library(ggplot2)
SCC <- readRDS("Source_Classification_Code.rds")
NEI <- readRDS("summarySCC_PM25.rds")
index <- grep('mobile', tolower(SCC$EI.Sector))
index <- grep('vehicle', tolower(SCC$EI.Sector[index]))
sub_SCC <- SCC[index,]
vehicle_SCC <- sub_SCC$SCC
vehicle_NEI <- subset(NEI, SCC %in% as.character(vehicle_SCC))

baltimore_vehicle_NEI <- subset(vehicle_NEI,fips == '24510')
baltimore_vehicle_PM_year <- tapply(baltimore_vehicle_NEI$Emissions, baltimore_vehicle_NEI$year, sum)

LA_vehicle_NEI <- subset(vehicle_NEI, fips =='06037')
LA_vehicle_PM_year <- tapply(LA_vehicle_NEI$Emission, LA_vehicle_NEI$year, sum)
dframe <- data.frame(baltimore_vehicle_PM_year,LA_vehicle_PM_year)
colnames(dframe) <- c('Baltimore', 'Los Angeles')
dframe$year <- rownames(dframe)
dframe <- dframe %>% gather(City, Emission, -year)
q<-with(dframe, qplot(year, Emission, col=City))
q+ggtitle('Total motor vehicle PM2.5 emission')+ylab('Emission (ton)')
dev.copy(png, 'plot6.png')
dev.off()
