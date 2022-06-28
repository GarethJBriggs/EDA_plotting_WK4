library(ggplot2)
        NEI <- readRDS("summarySCC_PM25.rds")
        SCC <- readRDS("Source_Classification_Code.rds")       

        ## subset for Baltimore City, Maryland identifier & Los Angeles County
        
        BCLA_df <-subset(NEI, fips == "24510" | fips == "06037")
        
        ## identify the rows contain vehicle emissions using grep
        mtor<- grep("vehicle", SCC$EI.Sector, ignore.case = TRUE, value = FALSE)
       
        ## create a df from SCC containing vehicles - from mtor - as source 
        ## of pollutant 
        
        mtor_SCC_df <- SCC[mtor, ]
        
        ##extract the SCC column  values from mtor_SCC_df 
        
        mtSCC <- mtor_SCC_df$SCC
                
        ## extract from BCLA_df the coal combustion rows present in mtSCC
        ## producing a df containing Baltomore and Los Angeles data associated 
        ## with motor vehicles
        
        BCLA_df_mod <- BCLA_df[BCLA_df$SCC %in% mtSCC, ]
        
        ## log10 emissions in BCLA_mod df
        
        BCLA_df_mod$Emissions <- log10(BCLA_df_mod$Emissions)
        
        ## plot ggplot, fact wrap and color for BC and LA fips, with regressions lines
       
         g <- ggplot(BCLA_df_mod, aes(year, Emissions)) + geom_point(aes(color = fips), alpha = 1/3, size = 2)
         g + facet_wrap(.~ fips, scales = "free_y") + geom_smooth(method = "lm", formula = y ~ x, col = "green")     
        
        
        
                