        ## plot2: barchart

        NEI <- readRDS("summarySCC_PM25.rds")
        SCC <- readRDS("Source_Classification_Code.rds")       

        ## subset for Baltimore City, Maryland identifier

        (bc_df <-subset(NEI, fips == "24510"))

        ## extract gross emissions and year data  
        ## of total PM2.5 by year, to array

        bc_arr <- tapply(bc_df$Emissions, bc_df$year, sum) 

        ## create a df from sum of all Baltimore emissions array

        bc_df2 <- as.data.frame(bc_arr)

        ## process df ready for extracting values

        bc_df2$year <- rownames(bc_df2)
        rownames(bc_df2) <- NULL
        colnames(bc_df2)[1] <- "total.PM2.5"

        ## extract bcdf2$year and bcdf2$total.PM2.5 for plotting

        xb <- as.numeric(bc_df2$year)
        yb <- bc_df2$total.PM2.5
        
        ## plot barplot
        
        barplot(yb, main = "Total PM2.5 Emmisons in the Baltimore City 1999 - 2008",
                 names.arg = xb, xlab = "Year", ylab = "Tons PM2.5 Emitted", 
                 col = "red")
                
        ## copy to PNG file
        
        dev.copy(png, file = "plot2.png")
        
        ## reset devices
        
        dev.off()      
                
