library(sqldf)
library(plyr)

#### FINCEN DATA SOURCE FROM: http://www.fincen.gov/news_room/rp/sar_by_number.html
#### UNDER QUARTERLY UPDATE (JANUARY 2015)

###Section 1 - Bank Secrecy Act Suspicious Activity Report FinCEN Form 111  for 2012-2014
###Department of Treasury Financial Crimes Enforcement Network
###8 tables of statistics


###1 - FILINGS BY MONTH

month <- read.csv("data/Section1_MONTH.csv")
month$MONTH <- as.character(month$MONTH)
names(month)[2] <- "y2012"
names(month)[3] <- "y2013"
names(month)[4] <- "y2014"

## AGGREGATES BY MONTH BY YEAR
monthY <- month 

month2012 <- sqldf("select distinct MONTH, sum(y2012) as 'NUMBER_OF_FILINGS' from monthY group by MONTH")
month2012$YEAR <- 2012
month2013 <- sqldf("select distinct MONTH, sum(y2013) as 'NUMBER_OF_FILINGS' from monthY group by MONTH")
month2013$YEAR <- 2013
month2014 <- sqldf("select distinct MONTH, sum(y2014) as 'NUMBER_OF_FILINGS' from monthY group by MONTH")
month2014$YEAR <- 2014

monthYears <- list(
  a = data.frame(month2012),
  b = data.frame(month2013),
  c = data.frame(month2014)
)

monthALL <- join_all(monthYears, by = NULL, type = "full", match = "all")

monthbyYear <- sqldf("select * from monthALL order by MONTH, YEAR") 
monthYear <- as.data.frame(monthbyYear)
monthYear$YEAR <- as.integer(monthYear$YEAR)

###2 - FILINGS BY STATE

state <- read.csv("data/Section1_STATE.csv")
state$STATE <- as.character(state$STATE)
names(state)[2] <- "y2012"
names(state)[3] <- "y2013"
names(state)[4] <- "y2014"

## AGGREGATES BY STATE BY YEAR
stateY <- state 

state2012 <- sqldf("select distinct STATE, sum(y2012) as 'NUMBER_OF_FILINGS' from stateY group by STATE")
state2012$YEAR <- 2012
state2013 <- sqldf("select distinct STATE, sum(y2013) as 'NUMBER_OF_FILINGS' from stateY group by STATE")
state2013$YEAR <- 2013
state2014 <- sqldf("select distinct STATE, sum(y2014) as 'NUMBER_OF_FILINGS' from stateY group by STATE")
state2014$YEAR <- 2014

stateYears <- list(
  a = data.frame(state2012),
  b = data.frame(state2013),
  c = data.frame(state2014)
)

stateALL <- join_all(stateYears, by = NULL, type = "full", match = "all")

statebyYear <- sqldf("select * from stateALL order by STATE, YEAR") 
stateYear <- as.data.frame(statebyYear)
stateYear$YEAR <- as.integer(stateYear$YEAR)

###3 - FILINGS BY STATE OVERALL TOTALS

stateOverall <- read.csv("data/Section1_STATEOVERALL.csv")
stateOverall$STATE <- as.character(stateOverall$STATE)

###4 - FILINGS BY SUSP TYPE OVERALL TOTALS

suspacttype <- read.csv("data/Section1_SUSPACTTYPE.csv")
suspacttype$SUSPICIOUS_ACTIVITY_TYPE <- as.character(suspacttype$SUSPICIOUS_ACTIVITY_TYPE)

###5 - FILINGS by SUSP CATEGORY

suspactcategory <- read.csv("data/Section1_SUSPACTCATEGORY.csv")
suspactcategory$SUSPICIOUS_ACTIVITY_CATEGORY <- as.character(suspactcategory$SUSPICIOUS_ACTIVITY_CATEGORY)
suspactcategory$SUSPICIOUS_ACTIVITY_TYPE <- as.character(suspactcategory$SUSPICIOUS_ACTIVITY_TYPE)
names(suspactcategory)[3] <- "y2012"
names(suspactcategory)[4] <- "y2013"
names(suspactcategory)[5] <- "y2014"

## AGGREGATES BY SUSPICIOUS ACTIVITY CATEGORY TYPE BY YEAR
suspCatType <- suspactcategory

suspCatT2012 <- sqldf("select distinct SUSPICIOUS_ACTIVITY_CATEGORY, SUSPICIOUS_ACTIVITY_TYPE, sum(y2012) as 'NUMBER_OF_FILINGS' from suspCatType group by SUSPICIOUS_ACTIVITY_CATEGORY, SUSPICIOUS_ACTIVITY_TYPE order by SUSPICIOUS_ACTIVITY_CATEGORY, SUSPICIOUS_ACTIVITY_TYPE")
suspCatT2012$YEAR <- 2012
suspCatT2013 <- sqldf("select distinct SUSPICIOUS_ACTIVITY_CATEGORY, SUSPICIOUS_ACTIVITY_TYPE, sum(y2013) as 'NUMBER_OF_FILINGS' from suspCatType group by SUSPICIOUS_ACTIVITY_CATEGORY, SUSPICIOUS_ACTIVITY_TYPE order by SUSPICIOUS_ACTIVITY_CATEGORY, SUSPICIOUS_ACTIVITY_TYPE")
suspCatT2013$YEAR <- 2013
suspCatT2014 <- sqldf("select distinct SUSPICIOUS_ACTIVITY_CATEGORY, SUSPICIOUS_ACTIVITY_TYPE, sum(y2014) as 'NUMBER_OF_FILINGS' from suspCatType group by SUSPICIOUS_ACTIVITY_CATEGORY, SUSPICIOUS_ACTIVITY_TYPE order by SUSPICIOUS_ACTIVITY_CATEGORY, SUSPICIOUS_ACTIVITY_TYPE")
suspCatT2014$YEAR <- 2014

suspcatTYears <- list(
  a = data.frame(suspCatT2012),
  b = data.frame(suspCatT2013),
  c = data.frame(suspCatT2014)
)

suspcatTALL <- join_all(suspcatTYears, by = NULL, type = "full", match = "all")

suspcatTypebyYear <- sqldf("select * from suspcatTALL order by YEAR, SUSPICIOUS_ACTIVITY_CATEGORY, SUSPICIOUS_ACTIVITY_TYPE") 
suspcatTypebyYear <- as.data.frame(suspcatTypebyYear)
suspcatTypebyYear$YEAR <- as.integer(suspcatTypebyYear$YEAR)

## AGGREGATES BY SUSPICIOUS ACTIVITY CATEGORY BY YEAR
suspCat <- suspactcategory
suspCat$SUSPICIOUS_ACTIVITY_TYPE <- NULL

suspCat2012 <- sqldf("select distinct SUSPICIOUS_ACTIVITY_CATEGORY, sum(y2012) as 'NUMBER_OF_FILINGS' from suspCat group by SUSPICIOUS_ACTIVITY_CATEGORY order by SUSPICIOUS_ACTIVITY_CATEGORY")
suspCat2012$YEAR <- 2012
suspCat2013 <- sqldf("select distinct SUSPICIOUS_ACTIVITY_CATEGORY, sum(y2013) as 'NUMBER_OF_FILINGS' from suspCat group by SUSPICIOUS_ACTIVITY_CATEGORY order by SUSPICIOUS_ACTIVITY_CATEGORY")
suspCat2013$YEAR <- 2013
suspCat2014 <- sqldf("select distinct SUSPICIOUS_ACTIVITY_CATEGORY, sum(y2014) as 'NUMBER_OF_FILINGS' from suspCat group by SUSPICIOUS_ACTIVITY_CATEGORY order by SUSPICIOUS_ACTIVITY_CATEGORY")
suspCat2014$YEAR <- 2014

suspcatYears <- list(
  a = data.frame(suspCat2012),
  b = data.frame(suspCat2013),
  c = data.frame(suspCat2014)
)

suspcatALL <- join_all(suspcatYears, by = NULL, type = "full", match = "all")

suspcatbyYear <- sqldf("select * from suspcatALL order by SUSPICIOUS_ACTIVITY_CATEGORY, YEAR") 
suspcatbyYear <- as.data.frame(suspcatbyYear)
suspcatbyYear$YEAR <- as.integer(suspcatbyYear$YEAR)

###6 - FILINGS by GAMING ESTABLISHMENT

gamingEst <- read.csv("data/Section1_GAMINGEST.csv")
gamingEst$TYPE_OF_GAMING_ESTABLISHMENT<- as.character(gamingEst$TYPE_OF_GAMING_ESTABLISHMENT)
names(gamingEst)[2] <- "y2012"
names(gamingEst)[3] <- "y2013"
names(gamingEst)[4] <- "y2014"

## AGGREGATES BY MONTH BY YEAR
gamingY <- gamingEst

gaming2012 <- sqldf("select distinct TYPE_OF_GAMING_ESTABLISHMENT, sum(y2012) as 'NUMBER_OF_FILINGS' from gamingY group by TYPE_OF_GAMING_ESTABLISHMENT")
gaming2012$YEAR <- 2012
gaming2013 <- sqldf("select distinct TYPE_OF_GAMING_ESTABLISHMENT, sum(y2013) as 'NUMBER_OF_FILINGS' from gamingY group by TYPE_OF_GAMING_ESTABLISHMENT")
gaming2013$YEAR <- 2013
gaming2014 <- sqldf("select distinct TYPE_OF_GAMING_ESTABLISHMENT, sum(y2014) as 'NUMBER_OF_FILINGS' from gamingY group by TYPE_OF_GAMING_ESTABLISHMENT")
gaming2014$YEAR <- 2014

gamingYears <- list(
  a = data.frame(gaming2012),
  b = data.frame(gaming2013),
  c = data.frame(gaming2014)
)

gamingALL <- join_all(gamingYears, by = NULL, type = "full", match = "all")

gamingbyYear <- sqldf("select * from gamingALL order by TYPE_OF_GAMING_ESTABLISHMENT, YEAR") 
gamingYear <- as.data.frame(gamingbyYear)
gamingYear$YEAR <- as.integer(gamingYear$YEAR)

###7 - FILINGS by RELATIONSHIP

filingRelation <- read.csv("data/Section1_FILINGRELATIONSHIP.csv")
filingRelation$RELATIONSHIP <- as.character(filingRelation$RELATIONSHIP)
names(filingRelation)[2] <- "y2012"
names(filingRelation)[3] <- "y2013"
names(filingRelation)[4] <- "y2014"

###8 - FILINGS by PAYMENT/INSTRUMENT TYPE
paymentType <- read.csv("data/Section1_PAYMENTTYPE.csv")
paymentType$PAYMENT_INSTRUMENT_TYPE <- as.character(paymentType$PAYMENT_INSTRUMENT_TYPE)
names(paymentType)[2] <- "y2012"
names(paymentType)[3] <- "y2013"
names(paymentType)[4] <- "y2014"

## AGGREGATES BY MONTH BY YEAR
paymentY <- paymentType

payment2012 <- sqldf("select distinct PAYMENT_INSTRUMENT_TYPE, sum(y2012) as 'NUMBER_OF_FILINGS' from paymentY group by PAYMENT_INSTRUMENT_TYPE")
payment2012$YEAR <- 2012
payment2013 <- sqldf("select distinct PAYMENT_INSTRUMENT_TYPE, sum(y2013) as 'NUMBER_OF_FILINGS' from paymentY group by PAYMENT_INSTRUMENT_TYPE")
payment2013$YEAR <- 2013
payment2014 <- sqldf("select distinct PAYMENT_INSTRUMENT_TYPE, sum(y2014) as 'NUMBER_OF_FILINGS' from paymentY group by PAYMENT_INSTRUMENT_TYPE")
payment2014$YEAR <- 2014

paymentYears <- list(
  a = data.frame(payment2012),
  b = data.frame(payment2013),
  c = data.frame(payment2014)
)

paymentALL <- join_all(paymentYears, by = NULL, type = "full", match = "all")

paymentbyYear <- sqldf("select * from paymentALL order by PAYMENT_INSTRUMENT_TYPE, YEAR") 
paymentYear <- as.data.frame(paymentbyYear)
paymentYear$YEAR <- as.integer(paymentYear$YEAR)


#######################

saveRDS(monthYear, file = "data/Section1_MonthByYear.rds")

saveRDS(stateYear, file = "data/Section1_StateByYear.rds")

saveRDS(suspcatTypebyYear, file = "data/Section1_SuspCatTypeByYear.rds")

saveRDS(suspcatbyYear, file = "data/Section1_SuspCatByYear.rds")

saveRDS(gamingYear, file = "data/Section1_GamingByYear.rds")

saveRDS(paymentYear, file = "data/Section1_PaymentByYear.rds")
