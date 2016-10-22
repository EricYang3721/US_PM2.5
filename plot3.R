library(dplyr)
library(tidyr)
library(ggplot2)
NEI <- readRDS("summarySCC_PM25.rds")
baltimore <- subset(NEI, fips == '24510')
years <- unique(baltimore$year)
sources <- unique(baltimore$type)
dframe <- data.frame(NULL)

for (year_ind in years) {
  sub <- subset(baltimore, year == year_ind)
  df_tmp <- tapply(sub$Emission, sub$type, sum)
  dframe <- bind_rows(dframe, as.data.frame(t(df_tmp)))
}
rownames(dframe) <- years
dframe$year <- years
d1 <- dframe %>% gather(type, emission, -year)
g <- ggplot(data=d1, aes(year, emission, color=type))
g + geom_point()+ggtitle('PM2.5 from different types')+ylab('PM2.5 emission (ton)')
dev.copy(png, 'plot3.png')
dev.off()
