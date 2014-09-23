setwd("C:/Users/enrique.balp/Desktop/TV_campaign_linio/TV_analysis")

country <- "col"
end <- "20140828"

end <- as.POSIXlt(paste(end,"235900"), format="%Y%m%d %H%M%S")
if(country == 'mex') start <- as.POSIXlt("20140827", format="%Y%m%d")
if(country == 'col') start <- as.POSIXlt("20140825", format="%Y%m%d")

# First make sure traffic data are available  ---  ./datagenerator.R
source("./data_generator.R")

# Loads and Preprocess spot data  ---  ./[country]/loadspots_[country].R  
source(paste('./',country,'/loadspots_',country,'.R',sep="")) 

# Primary analysis: loads traffic data, calculates baselines and spot lifts -- ./primary_analysis.R
source("./primary_analysis.R")






