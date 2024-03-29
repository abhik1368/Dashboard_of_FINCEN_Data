
#### FINCEN DATA SOURCE FROM: http://www.fincen.gov/news_room/rp/sar_by_number.html
#### UNDER QUARTERLY UPDATE (JANUARY 2015)

###Section 1 - Bank Secrecy Act Suspicious Activity Report FinCEN Form 111  for 2012-2014
###Department of Treasury Financial Crimes Enforcement Network
###8 tables of statistics


###1 - FILINGS BY MONTH

monthYear <- readRDS("data/Section1_MonthByYear.rds")

###2 - FILINGS BY STATE

stateYear <- readRDS("data/Section1_StateByYear.rds")

###3 - FILINGS BY STATE OVERALL TOTALS

stateOverall <- read.csv("data/Section1_STATEOVERALL.csv")
stateOverall$STATE <- as.character(stateOverall$STATE)

###4 - FILINGS BY SUSP TYPE OVERALL TOTALS

suspacttype <- read.csv("data/Section1_SUSPACTTYPE.csv")
suspacttype$SUSPICIOUS_ACTIVITY_TYPE <- as.character(suspacttype$SUSPICIOUS_ACTIVITY_TYPE)

###5 - FILINGS by SUSP CATEGORY & TYPE

suspcatTypebyYear <- readRDS("data/Section1_SuspCatTypeByYear.rds")
suspcatbyYear <- readRDS("data/Section1_SuspCatByYear.rds")

###6 - FILINGS by GAMING ESTABLISHMENT

gamingYear <- readRDS("data/Section1_GamingByYear.rds")

###7 - FILINGS by RELATIONSHIP


###8 - FILINGS by PAYMENT/INSTRUMENT TYPE

paymentYear <- readRDS("data/Section1_PaymentByYear.rds")
