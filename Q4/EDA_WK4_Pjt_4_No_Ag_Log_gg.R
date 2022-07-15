        library(ggplot2)

        ##Plot 4 - problems with log/infinity are rectified here
        ##       - data is not aggregated by fips/year
        ##       - data is log10
        
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
        NEI_SCC_mod <- NEI[NEI$SCC %in% SCC_vals, ] 


        ## set to log10 Emissions column

        NEI_SCC_mod$Emissions <- log10(NEI_SCC_mod$Emissions)
        
        ## remove -Inf, convert to NA

        NEI_SCC_mod[is.na( NEI_SCC_mod) | NEI_SCC_mod =="-Inf"] = NA        


        ## extract variables

        xc = NEI_SCC_mod$year

        yc = NEI_SCC_mod$Emissions
        
        g <- ggplot(NEI_SCC_mod, aes(x = year, y = Emissions))
        g + geom_point(color = "red", alpha = 0.25, size = 2) +
                geom_smooth(method = "lm", formula = y ~ x, col = "purple")