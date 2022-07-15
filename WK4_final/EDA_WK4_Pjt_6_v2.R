library(ggplot2)

                
        ## Plot 6
        
        NEI <- readRDS("summarySCC_PM25.rds")
        SCC <- readRDS("Source_Classification_Code.rds")       

        ## subset for Baltimore City, Maryland identifier & Los Angeles County
        
        bcla_df <-subset(NEI, fips == "24510" | fips == "06037")
        
        ## set fips to county name
        
        bcla_df$fips <- ifelse(bcla_df$fips == "06037", "Los Angeles", 
                               ifelse(bcla_df$fips == "24510" , "Baltimore" , NA))
        
        ## identify the rows contain vehicle emissions using grep
        mtor<- grep("vehicle", SCC$EI.Sector, ignore.case = TRUE, value = FALSE)
       
        ## create a df from SCC containing vehicles - from mtor - as source 
        ## of pollutant 
        
        mtor_SCC_df <- SCC[mtor, ]
        
        ##extract the SCC column  values from mtor_SCC_df 
        
        mtSCC <- mtor_SCC_df$SCC
                
        ## extract from bcla_df the coal combustion rows present in mtSCC
        ## producing a df containing Baltomore and Los Angeles data associated 
        ## with motor vehicles
        
        bcla_df2 <- bcla_df[bcla_df$SCC %in% mtSCC, ]
        
        ## log10 emissions in BCLA_mod df
        
        bcla_df2$Emissions <- log10(bcla_df2$Emissions)
        
        
        ## plot ggplot
       
         g <- ggplot(bcla_df2, aes(year, Emissions)) 
         g + geom_point(aes(color = fips), alpha = 1/3, size = 2) +
             facet_wrap(.~ fips, scales = "free_y") + 
             geom_smooth(method = "lm", formula = y ~ x, col = "green") +   
             labs(x = "Year", y = "log10 Tons Emissions PM 2.5") +
             ggtitle("PM 2.5 Emissions from Vehicles in Baltimore City and Los Angeles from 1999 - 2008") +
             theme(plot.title = element_text(hjust = 0.5))
        
         ## copy to PNG file
         
         dev.copy(png, file = "plot6.png")
         
         ## reset devices
         
         dev.off()
         
         
         
                  