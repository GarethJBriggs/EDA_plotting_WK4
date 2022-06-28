NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

## extract gross data to df(x)
## of total PM2.5 by year


x <- tapply(NEI$Emissions, NEI$year, sum) 
x <- as.data.frame(x)
x$year <- rownames(x)
rownames(x) <- NULL
colnames(x)[1] <- "total.PM2.5"

## process x$year and x$total.PM2.5 for plotting

year <- as.numeric(x$year)
PM2.5 <- x$total.PM2.5