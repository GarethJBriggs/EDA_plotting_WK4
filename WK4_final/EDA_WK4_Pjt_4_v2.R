        library (dplyr)
        library(ggplot2)

        ##Plot 4 - problems with log/infinity fixed here
        ##       - data is aggregated by fips/year
        ##       - data is log10
        ##       - data plot xy


        NEI <- readRDS("summarySCC_PM25.rds")
        SCC <- readRDS("Source_Classification_Code.rds") 
        
        ## extract coal values from SCC, all also contain "combustion"
        ## totaling 99 environmantal sources

        coal_ei <- grep("coal", SCC$EI.Sector, ignore.case = TRUE, value = FALSE) 
        
        ## extract 99 rows containing coal combustion from SCC df
        ## gives a df of 15 cols and 99 rows 

        coal_scc <- SCC[coal_ei, ]

        ##extract 99 SCC environmental sources from coal_scc df
        ## to SSC_vals, giving  99 SCC values for pollutant source
        scc_vals <- coal_scc$SCC

        ## extract from NEI the 99 rows associated with coal combustion
        nei_scc_df <- NEI[NEI$SCC %in% scc_vals, ] 

        ## group data to allow summarizing of fips sites by coal combustion 
        ## emissions on aggrigate per county per year, as total_coal 

        nei_scc_df <-  nei_scc_df %>%
        group_by(year, fips) %>%
        summarize(total_coal = sum(Emissions))
        
        ## log10 total_coal values for plotting

        nei_scc_df$total_coal <- log10(nei_scc_df$total_coal)
        
        ## set any -inf values in df to NA to allow plotting

        nei_scc_df[is.na( nei_scc_df) | nei_scc_df =="-Inf"] = NA  
        
        ## ggplot
        
        ## plot aesthetics

        g <- ggplot(nei_scc_df, aes(x = year, y = total_coal))
        
                ## plot points
        
                g + geom_point(color = "red", alpha = 0.25, size = 2) +
                        
                ## add regression line        
                        
                        
                geom_smooth(method = "lm", formula = y ~ x, col = "purple") +
                        
                ## label axies        
                        
                        
                labs(x = "Year", y = "log10 Tons Emissions PM 2.5 Summed by County") +
                        
                ## add title
                        
                        
                ggtitle("PM 2.5 Emissions from Coal Combustion Per County Across the USA 1999 - 2008") +
                        
                ## centre tittle        
                        
                theme(plot.title = element_text(hjust = 0.5))
                
                
        ## copy to PNG file
                
        dev.copy(png, file = "plot4.png")
                
        ## reset devices
                
        dev.off()