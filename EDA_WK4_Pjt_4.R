library(scales)        

        ##Plot 4 - problems with log/infinity

        NEI <- readRDS("summarySCC_PM25.rds")
        SCC <- readRDS("Source_Classification_Code.rds") 
        
        coal_EI <- grep("coal", SCC$EI.Sector, ignore.case = TRUE, value = FALSE) ## returns 99 values
        
        ## extract 99 rows containing coal combustion from SCC df
        ## gives a df of 15 cols and 99 rows 
        
        coal_SCC <- SCC[coal_EI, ]
        
        ##extract 99 SCC environmental sources from coal_SCC df
        ## to SSC_vals, the 99 SCC characters for pollutant source
        SCC_vals <- coal_SCC$SCC
        
        ## extract from NEI the coal combustion rows
        NEI_SCC_mod <- NEI[NEI$SCC %in% SCC_vals, ] ##rm.na's'
        
        xc = NEI_SCC_mod$year
        
        yc = NEI_SCC_mod$Emissions
        
        table(is.infinite(yc))
         
        plot(x = xc, y= yc, pch = 19, cex = 2, lwd = 2, col = "red" )
        
        abline(lm(yc ~ xc), col = "red" , lwd = 2, lty = 4)
        
        ## copy to PNG file
        
        dev.copy(png, file = "plot4.png")
        
        ## reset devices
        
        dev.off()
     
        