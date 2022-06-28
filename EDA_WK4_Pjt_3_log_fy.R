library(ggplot2)

        NEI <- readRDS("summarySCC_PM25.rds")
        SCC <- readRDS("Source_Classification_Code.rds")       

        ## subset for Baltimore City, Maryland identifier

        BC <-subset(NEI, fips == "24510")
        
        ## log10 Emissions and prevent log of 0, which would give INF values
        BC$Emissions <- ifelse (BC$Emissions!=0, log10(BC$Emissions), BC$Emissions)
        

        # build basic ggplot using log1- for Emissions
        b <- ggplot(BC, aes(x = year, y = Emissions)) + geom_point( aes(color = type),alpha = 1/3, size = 2) 

        ## create a 2*2 cell plot soley by type
        ## with differing cartasioan coordinates to plot y-axi4

        b + facet_wrap(.~ type, scales = "free_y")  + geom_smooth(method = "lm", formula = y ~ x, col = "purple") 

        
        
        

        ## need title too 

        ## need x-axis as 1999, 2002, 2005, 2008 only

        + coord_cartesian(ylim = c(-6, 4))
        
        


         
 