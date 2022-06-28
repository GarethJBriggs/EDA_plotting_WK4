
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
        
        fips <- split(BCLA_df_mod, BCLA_df_mod$fips)
        
        df_fip_LA <- as.data.frame(fips$`06037`)
        df_fip_BC <- as.data.frame(fips$`24510`)
        
        xLA = df_fip_LA$year
        yLA = df_fip_LA$Emissions
        
        xBC = df_fip_BC$year
        yLA = df_fip_BC$Emissions
        
        par(mfrow = C(1,2))
        
        with(BCLA_df_mod, {
                plot(xb, yb[fips =="24510" ])
                plot(xb, yb[fips == "06037"])
                                           })
        
        
        
                