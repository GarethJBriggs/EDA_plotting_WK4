library(ggplot2)

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")       

## subset for Baltimore City, Maryland identifier

BC <-subset(NEI, fips == "24510")

## reset BC row names
rownames(BC) <- seq(length=nrow(BC))

## determine outliers by type

BC2 <-  subset(BC,BC$type == "NON-ROAD" & BC$Emissions > 300)

print(BC2)

BC3 <- subset(BC, BC$type == "NONPOINT" & BC$Emissions > 500)

print(BC3)

BC4 <- subset(BC, BC$type == "POINT" & BC$Emissions > 200)

print(BC4)

BC5 <- subset(BC, BC$type == "ON-ROAD" & BC$Emissions > 30)

print(BC5)

## remove outliers by row creating BC-red df

BC_red <-BC[-c(193, 295,311, 865), ]

## build basic ggplot
b <- ggplot(BC_red, aes(x = year, y = Emissions)) + geom_point( aes(color = type),alpha = 1/3, size = 2)  

## create a 2*2 cell plot soley by type
## with differing Y scale per facet plot from "free_y

b + facet_wrap(.~ type, scales = "free_y") + geom_smooth(method = "lm", formula = y ~ x, col = "purple")
                                                        
