library(ggplot2)
                
        ##plot 3
        
        NEI <- readRDS("summarySCC_PM25.rds")
        SCC <- readRDS("Source_Classification_Code.rds")       

        ## subset for Baltimore City, Maryland identifier

        BC <-subset(NEI, fips == "24510")
        

        ## build basic ggplot using log1- for Emissions
        g <- ggplot(BC, aes(x = year, y = log10(Emissions)))  
        g + geom_point( aes(color = type), alpha = 0.25, size = 2)
        g <- g + facet_wrap(.~ type, scales = "free_y") + geom_smooth(method = "lm", formula = y ~ x, col = "purple") 
        g + labs(x = "Year", y = "log10 Tons Emissions PM 2.5")+ ggtitle("PM 2.5 Emissions in Baltimore City, by Type, 1999 - 2008")
        

         
       
        
       
        
        ## copy to PNG file
        
        dev.copy(png, file = "plot2.png")
        
        ## reset devices
        
        dev.off()
        
        

         g + xlab("Year") + ylab("log10 Tons Emissions PM 2.5") 

      
        + coord_cartesian(ylim = c(-6, 4))
        
        


         ## log10 Emissions and prevent log of 0, which would give INF values
        BC$Emissions <- ifelse (BC$Emissions!=0, log10(BC$Emissions), BC$Emissions)
        
 