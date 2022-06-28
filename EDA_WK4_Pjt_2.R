        ## plot2

        NEI <- readRDS("summarySCC_PM25.rds")
        SCC <- readRDS("Source_Classification_Code.rds")       
        
        ## subset for Baltimore City, Maryland identifier
        
        (BC <-subset(NEI, fips == "24510"))
        
        ## extract gross emissions and year data  
        ## of total PM2.5 by year, to array
        
        BCs <- tapply(BC$Emissions, BC$year, sum) 
        
        
        ## create a df from sum of all USA emissions array
        BC_df <- as.data.frame(BCs)
        
        
        ## process df ready for extracting values
        
        BC_df$year <- rownames(BC_df)
        rownames(BC_df) <- NULL
        colnames(BC_df)[1] <- "total.PM2.5"

        ## extract BCdf$year and BCdf$total.PM2.5 for plotting

        xBC <- as.numeric(BC_df$year)
        yBC <- log10(BC_df$total.PM2.5)
        
        ## plot data
        
        plot(xBC, yBC , xlab = "Year",  ylab ="log10 Tons PM 2.5 Emitted",
        main = "PM 2.5 Emmisons 1999 - 2008, Baltimore City, Maryland" 
        , pch = 19, cex = 1.5, lwd =2,)

        ## fit a line

        abline(lm(yBC ~ xBC), col = "green" , lwd = 2, lty = 4)
        
        ## copy to PNG file
        
        dev.copy(png, file = "plot2.png")
        
        ## reset devices
        
        dev.off()