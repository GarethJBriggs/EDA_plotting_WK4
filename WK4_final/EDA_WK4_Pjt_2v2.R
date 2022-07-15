        ## plot2

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
        yb <- log10(bc_df2$total.PM2.5)
        
        ## plot data
        
        plot(xb, yb , xlab = "Year",  ylab ="log10 Tons PM 2.5 Emitted",
        main = "PM 2.5 Emmisons 1999 - 2008, Baltimore City, Maryland" 
        , pch = 19, cex = 1, lwd =2,)

        ## fit a line

        abline(lm(yb ~ xb), col = "green" , lwd = 2, lty = 4)
        
        ## copy to PNG file
        
        dev.copy(png, file = "plot2.png")
        
        ## reset devices
        
        dev.off()