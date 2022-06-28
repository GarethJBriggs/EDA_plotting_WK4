        ##Plot 1        

        NEI <- readRDS("summarySCC_PM25.rds")
        SCC <- readRDS("Source_Classification_Code.rds")
        
        ## extract gross emissions and year data  
        ## of total PM2.5 by year to array
           
        
        Emi_Yr <- tapply(NEI$Emissions, NEI$year, sum) #
        
        ## create a df from sum of all USA emissions array
        
        Emi_Yr_df <- as.data.frame(Emi_Yr) #
        
        
        ## process df ready for extracting values
        
        Emi_Yr_df$year <- rownames(Emi_Yr_df) #
        rownames(Emi_Yr_df) <- NULL #
        colnames(Emi_Yr_df)[1] <- "total.PM2.5"#

        ## process year and total.PM2.5 for plotting
        
        xp <- as.numeric(Emi_Yr_df$year)
        yp <- log10(Emi_Yr_df$total.PM2.5)
        
        ## plot data
        
        plot(xp, yp , xlab = "Year",  ylab ="log10 Tons PM2.5 Emitted",
             main = "Total PM2.5 Emmisons in the USA 1999 - 2008" , pch = 21, cex = 2, lwd =2,)
        
        ## fit a line
        
        abline(lm(yp ~ xp), col = "red" , lwd = 2, lty = 6)
               
        ## copy to PNG file
        
        dev.copy(png, file = "plot1.png")
        
        ## reset devices
        dev.off()