libarary(ggplot2)

        ## Problem: With geom_point and color not showing, bae on legend and axes                 

        NEI <- readRDS("summarySCC_PM25.rds")
        SCC <- readRDS("Source_Classification_Code.rds")       

        ## subset for Baltimore City, Maryland identifier

        bc_df<-subset(NEI, fips == "24510")
        
        ## identify the rows contain motor vehicle emissions using grep
        
        mtor <- grep("vehicle", SCC$EI.Sector, ignore.case = TRUE, value = FALSE)
        
        ## subset SCC df by motor vehicle emissions to get df containing
        ## data that refers soley to vehicle emissions 
        
        mtor_df <- SCC[mtor, ]
        
        ## extract the SCC source value column from  vehicle the emissions df 
        
        mtscc <- mtor_df$SCC

        ## modify Baltimore df by subsetting df by sources of vehicle emission
        
        
        bc_df <- bc_df[bc_df$SCC %in% mtscc, ]
        
        
        ## Changing emissions in bc_df to log10 format
        
        bc_df$Emissions <- log10(bc_df$Emissions)
        
        ## Plotting Baltimore City emissions data by year in ggplot2
        
        
        ## set aesthetics
        g <- ggplot(bc_df, aes(year, Emissions)) 
        
        
        ## add points
        
        g + geom_point(color = "purple", alpha = 1/3, size = 2) +
            
            ## label axis    
            
            labs(x = "Year", y = "log10 Tons Emissions PM 2.5") +
            
            ## label title
            
            ggtitle("PM 2.5 Emissions from Vehicles in Baltimore City from 1999 - 2008") +
        
            
            ## add line
                
            geom_smooth(method = "lm", formula = y ~ x, col = "blue") +
        
            ## centre title
                
            theme(plot.title = element_text(hjust = 0.5))
        
        
        
        ## copy to PNG file
        
        dev.copy(png, file = "plot5.png")
        
        ## reset devices
        
        dev.off()
        