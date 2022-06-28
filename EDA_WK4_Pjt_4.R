library(scales)        

        NEI <- readRDS("summarySCC_PM25.rds")
        SCC <- readRDS("Source_Classification_Code.rds") 
        
        coal_EI <- grep("coal", SCC$EI.Sector, ignore.case = TRUE, value = FALSE) ## returns 99 values
        coal_S1<- grep("coal", SCC$SCC.Level.One, ignore.case = TRUE, value = TRUE) ## returns 0 values
        coal_S2 <- grep("coal", SCC$SCC.Level.Two, ignore.case = TRUE, value = TRUE) ## returns 0 values
        coal_S3<- grep("coal", SCC$SCC.Level.Three, ignore.case = TRUE, value = TRUE) ## returns 181 values
        coal_S4<- grep("coal", SCC$SCC.Level.Four, ignore.case = TRUE, value = TRUE) ## returns 126 values
        
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
         
        yc <- ifelse(yc!=0, log10(yc), yc)
        
        fc = NEI_SCC_mod$fips
        
        plot(x = xc, y= yc, pch = 19, cex = 2, lwd = 2, col = "red" )
        
        abline(lm(yc ~ xc), col = "red" , lwd = 2, lty = 4)
     