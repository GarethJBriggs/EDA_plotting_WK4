##Plot 4 - problems with log/infinity are rectified here
##       - data is not aggregated by fips/year
##       - data is log10
##       - data plot bp

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


        ## set to log10 Emissions column

        NEI_SCC_mod$Emissions <- log10(NEI_SCC_mod$Emissions)

        ## remove -Inf, convert to NA

        NEI_SCC_mod[is.na( NEI_SCC_mod) | NEI_SCC_mod =="-Inf"] = NA        

        
        ## extract variables
        
        xc = NEI_SCC_mod$year

        yc = NEI_SCC_mod$Emissions
        
        ## plot
       
        boxplot(yc ~ xc)

        ## copy to PNG file

        dev.copy(png, file = "plot4.png")

        ## reset devices

        dev.off()
        
        ##  summeries of non aggrigated data
        
        ##summary(sp$`1999`)
        ##Min. 1st Qu.  Median    Mean 3rd Qu.    Max.    NA's 
        ##-2.6990 -1.4089 -0.6364 -0.3165  0.4701  4.1546      30 
        ##> summary(sp$`2002`)
        ##Min. 1st Qu.  Median    Mean 3rd Qu.    Max.    NA's 
        ##-5.5963 -1.0969 -0.0862 -0.0800  0.9157  4.0103    2425 
        ##> summary(sp$`2005`)
        ##Min. 1st Qu.  Median    Mean 3rd Qu.    Max.    NA's 
        ##-5.5963 -1.0969 -0.0809 -0.0711  0.9315  4.0594    2412 
        ##> 
        ##> summary(sp$`2008`)
        ## Min. 1st Qu.  Median    Mean 3rd Qu.    Max.    NA's 
        ##-8.1249 -0.8074  0.4126  0.2564  1.4213  3.8586    1744 
        
        

        

