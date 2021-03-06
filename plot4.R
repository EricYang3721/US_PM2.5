library(dplyr)
# load files
SCC <- readRDS("Source_Classification_Code.rds")
NEI <- readRDS("summarySCC_PM25.rds")
# subset the observations with 'comb' and 'coal' in the EI.Sector column
index <- grep('comb', tolower(SCC$EI.Sector))
index <- grep('coal', tolower(SCC$EI.Sector[index]))
sub_SCC <- SCC[index,]
comb_coal_SCC <- sub_SCC$SCC
comb_coal_NEI <- subset(NEI, SCC %in% as.character(comb_coal_SCC))
# sum the pm2.5 from coal combustion respect to years
US_comb_coal_PM_year <- tapply(comb_coal_NEI$Emissions, comb_coal_NEI$year, sum)
plot(names(US_comb_coal_PM_year),US_comb_coal_PM_year, xlab='year', ylab = 'total emission (ton)', main='Total coal combustion-related PM2.5 emission in US')
dev.copy(png, 'plot4.png')
dev.off()