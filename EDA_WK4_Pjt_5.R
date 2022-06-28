libarary(ggplot2)
        NEI <- readRDS("summarySCC_PM25.rds")
        SCC <- readRDS("Source_Classification_Code.rds")       

        ## subset for Baltimore City, Maryland identifier

        BC_df<-subset(NEI, fips == "24510")
        
        ## identify the rows contain motor vehicle emissions using grep
        
        mtor<- grep("vehicle", SCC$EI.Sector, ignore.case = TRUE, value = FALSE)
        
        ## create a df from SCC containing  motor vehicles as source of 
        ## pollutant 
        
        mtor_SCC_df <- SCC[mtor, ]
        
        ##extract the SCC values from the motor vehicle df, mtor_SCC_df 
        
        mtSCC <- mtor_SCC_df$SCC
        
        ## extract from BC_df the coal combustion rows present in mtSCC
        ## producing a df containing Baltomore and Los Angeles data associated 
        ## with motor vehicles
        
        BC_df_mod <- BC_df[BC_df$SCC %in% mtSCC, ]
        
        ## Changing emissions in BC_df_mod to log10 format
        
        BC_df_mod$Emissions <- log10(BC_df_mod$Emissions)
        
        ## Plotting Baltimore City emissions data by year in ggplot2
        
        g <- ggplot(BC_df_mod, aes(year, Emissions)) + geom_point(aes(color = "yellow"), alpha = 1/3, size = 2)
        g + geom_smooth(method = "lm", formula = y ~ x, col = "blue")
        
        ## Problem! With geom_point and color 