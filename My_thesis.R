# install the necessaries libraries
install.packages("devtools")
devtools::install_github("nipfpmf/eventstudies", ref="master")

library(tools)
install_github("EventStudyTools/api-wrapper.r")
install.packages("EventStudy")

# install  EventStudy API
apiUrl <- "http://api.eventstudytools.com"
apiKey <- "573e58c665fcc08cc6e5a660beaad0cb"

# install EventStudy library
library(EventStudy)

# Setup API Connection
estSetup <- EventStudyAPI$new(apiUrl)
estSetup$authentication(apiKey)

# Type of Analysis
estType <- "arc"

# import CSV files for the analysis
dataFiles <- c("request_file" = "01_RequestFile.csv", 
               "firm_data"    = "02_firmData.csv", 
               "market_data"  = "03_marketData.csv")

# the first 20 entries of RequestFile
library(readr)
RequestFile <- readr::read_delim("01_RequestFile.csv", col_names = F, delim = ";")
names(RequestFile) <- c("Event ID", "Firm ID", "Market ID", "Event Date", "Grouping Variable", "Start Event Window", "End Event Window", "End of Estimation Window", "Estimation Window Length")
knitr::kable(head(RequestFile), pad=0)

# the first 20 entries of firm data
library(readr)
FirmDatas <- readr::read_delim("02_FirmData.csv", col_names = F, delim = ";")
names(FirmDatas) <- c("Firm ID", "Date", "Closing Price")
knitr::kable(head(FirmDatas))

# the first 20 entries of market data
library(readr)
MarketData <- readr::read_delim("03_MarketData.csv", col_names = F, delim = ";")
names(MarketData) <- c("Market ID", "Date", "Closing Price")
knitr::kable(head(MarketData))

# Path of result files
resultPath <- "results"

# Perform standard Event Study methodology
estRes <- estSetup$performDefaultEventStudy(estType   = estType,
                                            dataFiles = dataFiles, 
                                            destDir   = resultPath)
