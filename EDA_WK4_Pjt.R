        NEI <- readRDS("summarySCC_PM25.rds")
        
        
        ## extract gross data to df(x)
        ## of total PM2.5 by year
        
        
        x <- tapply(NEI$Emissions, NEI$year, sum) 
        x <- as.data.frame(x)
        x$year <- rownames(x)
        rownames(x) <- NULL
        colnames(x)[1] <- "total.PM2.5"

        ## process x$year and x$total.PM2.5 for plotting
        
        xp <- as.numeric(x$year)
        yp <- log10(x$total.PM2.5)
        
        ## plot data
        
        plot(xp, yp , xlab = "Year",  ylab ="log10 Tons PM2.5 Emitted",
             main = "PM2.5 Emmisons 1999 - 2008" , pch = 21, cex = 2, lwd =2,)
        
        ## fit a line
        
        abline(lm(yp ~ xp), col = "red" , lwd = 2, lty = 6)
               
        ##also 10^x for reciprocal