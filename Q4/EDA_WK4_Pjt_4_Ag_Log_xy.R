        library (dplyr)

        ##Plot 4 - problems with log/infinity fixed here
        ##       - data is aggregated by fips/year
        ##       - data is log10
        ##       - data plot xy
        

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

         ## group data to allow summarizing of fips sites by coal combustion observations

         NEI_SCC_mod_dp <-  NEI_SCC_mod %>%
         group_by(year, fips) %>%
         summarize(total_coal = sum(Emissions))
        
         NEI_SCC_mod_dp$total_coal <- log10(NEI_SCC_mod_dp$total_coal)
        
        
        ## code fine to this point 
        
        NEI_SCC_mod_dp[is.na( NEI_SCC_mod_dp) | NEI_SCC_mod_dp =="-Inf"] = NA        
        
        
        xc = NEI_SCC_mod_dp$year

        yc = NEI_SCC_mod_dp$total_coal
        
        
        ## plot
        
        plot(x = xc, y = yc, pch = 19, cex = 2, lwd = 2, col = "red" )
        
        abline(lm(yc ~ xc), col = "red" , lwd = 2, lty = 4)






