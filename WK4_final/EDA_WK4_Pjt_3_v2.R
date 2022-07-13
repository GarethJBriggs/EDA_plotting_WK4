library(ggplot2)
                
        ##plot 3
        
        NEI <- readRDS("summarySCC_PM25.rds")
        SCC <- readRDS("Source_Classification_Code.rds")       

        ## subset for Baltimore City, Maryland identifier

        bc_df <-subset(NEI, fips == "24510")
        
        ## build ggplot using log10 for Emissions
        ## plot aesthetics 
       
         g <- ggplot(bc_df, aes(x = year, y = log10(Emissions)))
        
         ## plot points
        
         g + geom_point( aes(color = type), alpha = 0.25, size = 2) + 
                
                ## label axles
                
                labs(x = "Year", y = "log10 Tons Emissions PM 2.5") + 
                
                ## label title
                
                ggtitle("PM 2.5 Emissions in Baltimore City by Emission Source Type 1999 - 2008") +
                
                ## set facets
                
                facet_wrap(.~ type, scales = "free_y",) +
                
                ## add line
                
                geom_smooth(method = "lm", formula = y ~ x, col = "purple") +
                
                ## centre title
                
                theme(plot.title = element_text(hjust = 0.5))
        
                
        ## copy to PNG file
        
        dev.copy(png, file = "plot3.png")
        
        ## reset devices
        
        dev.off()
        
       
        
      
        


         
 