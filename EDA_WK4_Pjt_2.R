        NEI <- readRDS("summarySCC_PM25.rds")
        SCC <- readRDS("Source_Classification_Code.rds")       
        
        ## subset for Baltimore City, Maryland identifier
        
        (BC <-subset(NEI, fips == "24510"))

        BCs <- tapply(BC$Emissions, BC$year, sum) 
        BCdf <- as.data.frame(BCs)
        BCdf$year <- rownames(BCdf)
        rownames(BCdf) <- NULL
        colnames(BCdf)[1] <- "total.PM2.5"

        ## extract BCdf$year and BCdf$total.PM2.5 for plotting

        xBC <- as.numeric(BCdf$year)
        yBC <- log10(BCdf$total.PM2.5)
        
        ## plot data
        
        plot(xBC, yBC , xlab = "Year",  ylab ="log10 Tons PM2.5 Emitted",
        main = "PM2.5 Emmisons 1999 - 2008, Baltimore City, Maryland" 
        , pch = 19, cex = 1.5, lwd =2,)

        ## fit a line

        abline(lm(yBC ~ xBC), col = "33" , lwd = 2, lty = 4)
        