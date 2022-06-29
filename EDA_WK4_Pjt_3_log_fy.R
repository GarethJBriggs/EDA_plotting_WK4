library(ggplot2)
                
        ##plot 3
        
        NEI <- readRDS("summarySCC_PM25.rds")
        SCC <- readRDS("Source_Classification_Code.rds")       

        ## subset for Baltimore City, Maryland identifier

        BC <-subset(NEI, fips == "24510")
        
        ## build ggplot using log10 for Emissions
        g <- ggplot(BC, aes(x = year, y = log10(Emissions))) 
        g + geom_point( aes(color = type), alpha = 0.25, size = 2) + 
                labs(x = "Year", y = "log10 Tons Emissions PM 2.5") + 
                ggtitle("PM 2.5 Emissions in Baltimore City, by Type, 1999 - 2008") + 
                facet_wrap(.~ type, scales = "free_y",) +
                geom_smooth(method = "lm", formula = y ~ x, col = "purple") +
                theme(plot.title = element_text(hjust = 0.5))

        ## copy to PNG file
        
        dev.copy(png, file = "plot3.png")
        
        ## reset devices
        
        dev.off()
        
       ## log10 Emissions and prevent log of 0, which would give INF values
        BC$Emissions <- ifelse (BC$Emissions!=0, log10(BC$Emissions), BC$Emissions)
        
      
        


         
 