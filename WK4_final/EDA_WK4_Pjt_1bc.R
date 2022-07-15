        ## plot: barchart

        
        NEI <- readRDS("summarySCC_PM25.rds")
        SCC <- readRDS("Source_Classification_Code.rds")

        ## extract gross emissions and year data  
        ## of total PM2.5 by year to array

        emi_yr <- tapply(NEI$Emissions, NEI$year, sum) #

        ## create a df from sum of all USA emissions array

        emi_df <- as.data.frame(emi_yr) #


        ## process df ready for extracting values

        emi_df$year <- rownames(emi_df) #
        rownames(emi_df) <- NULL #
        colnames(emi_df)[1] <- "total.PM2.5"#

        ## process year and total.PM2.5 for plotting
        
        xp <- as.numeric(emi_df$year)
        yp <- emi_df$total.PM2.5

        ## plot barplot

        barplot(yp, main = "Total PM2.5 Emmisons in the USA 1999 - 2008", 
        names.arg = xp, xlab = "Year", ylab = "Tons PM2.5 Emitted", 
        col = "green")
        
        ## copy to PNG file
        
        dev.copy(png, file = "plot1.png")
        
        ## reset devices
        
        dev.off()
