        library (dplyr)
        library(ggplot2)

        ##Plot 4 - problems with log/infinity fixed here
        ##       - data is aggregated by fips/year
        ##       - data is log10
        ##       - data plot xy


        NEI <- readRDS("summarySCC_PM25.rds")
        SCC <- readRDS("Source_Classification_Code.rds") 
        
        ## extract coal values from SCC, all also contain "combustion"
        ## contins 99 sources

        coal_EI <- grep("coal", SCC$EI.Sector, ignore.case = TRUE, value = FALSE) 
        
        ## extract 99 rows containing coal combustion from SCC df
        ## gives a df of 15 cols and 99 rows 

        coal_SCC <- SCC[coal_EI, ]

        ##extract 99 SCC environmental sources from coal_SCC df
        ## to SSC_vals, giving  99 SCC values for pollutant source
        SCC_vals <- coal_SCC$SCC

        ## extract from NEI the 99 rows associated with coal combustion
        NEI_SCC_mod <- NEI[NEI$SCC %in% SCC_vals, ] 

        ## group data to allow summarizing of fips sites by coal combustion 
        ## emissions on aggrigate per county per year, as total_coal 

        NEI_SCC_mod_dp <-  NEI_SCC_mod %>%
        group_by(year, fips) %>%
        summarize(total_coal = sum(Emissions))
        
        ## log10 total_coal values for plotting

        NEI_SCC_mod_dp$total_coal <- log10(NEI_SCC_mod_dp$total_coal)
        
        ## set any -inf values in df to NA in df, to allow plotting

        NEI_SCC_mod_dp[is.na( NEI_SCC_mod_dp) | NEI_SCC_mod_dp =="-Inf"] = NA        

        g <- ggplot(NEI_SCC_mod_dp, aes(x = year, y = total_coal))
        g + geom_point(color = "red", alpha = 0.25, size = 2) +
        geom_smooth(method = "lm", formula = y ~ x, col = "purple") +
        labs(x = "Year", y = "log10 Tons Emissions PM 2.5 Summed by County") +
        ggtitle("PM 2.5 Emissions from Coal Combustion Per County Across the USA 1999 - 2008") +
                theme(plot.title = element_text(hjust = 0.5))