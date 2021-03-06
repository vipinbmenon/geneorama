#' @name   round_weeks
#' @title  Round dates to weeks
#' @author Gene Leynes
#' 
#' @param x Vector of dates
#'
#' @description
#' 		Converts a vector of dates to weeks using data.table's IDate.
#'
#' @details
#' 		This function uses Sunday as the first day of the week, and will round the
#' 		vector of dates to the first day of the week.  For other units of time
#' 		(e.g. month, year) \code{data.table:::round.IDate} is suggested.  Currently
#' 		IDate's round function for 'weeks' will split any week overlapping two
#' 		years into two week parts, which usually starts the rounded weeks in the
#' 		second year on a new day.  This function is a workaround for that behavior.
#'
#' @note
#' 		More details about week rounding issue (mentioned in details) here:
#' 		\url{https://github.com/Rdatatable/data.table/issues/747}
#'
#' 		Depends on \code{\link[data.table]{data.table}}
#'
#' @examples
#' 		require(data.table)
#' 		require(geneorama)
#'
#'  	## Create a sequence of dates (or IDates)
#' 		dd <- seq(as.IDate("2013-12-22"), as.IDate("2014-01-18"), 1)
#' 		## Weeks rounded using default data.table method:
#' 		round(dd, 'weeks')
#' 		## Weeks rounded using "round_weeks":
#' 		round_weeks(dd)
#' 		## Rounding methods shown side-by-side
#' 		data.table(date_original = dd,
#' 				   weeks_dt = round(dd, 'weeks'),
#' 				   weeks_new = round_weeks(dd),
#' 				   wday = wday(dd),
#' 				   weekday = weekdays(dd))
#'


round_weeks <- function(x){
	# require(data.table)
	
	day_adj <- day <- adj <- i <- NULL
	
	dt <- data.table(i = 1:length(x),
					 day = x,
					 weekday = weekdays(x))
	
	offset_table <- data.table(weekday = c('Sunday', 'Monday', 'Tuesday',
										   'Wednesday', 'Thursday', 'Friday',
										   'Saturday'),
							   adj = -(0:6))
	
	dt <- merge(dt, offset_table, by="weekday")
	
	## For some reason this assignment fails in the tests:
	dt[ , day_adj := day + adj]
	
	setkey(dt, i)
	
	return(dt[ , day_adj])
}

if(FALSE){
	##--------------------------------------------------------------------------
	## NORMAL TEST
	##--------------------------------------------------------------------------
	rm(list=ls())
	library(geneorama)
	detach_nonstandard_packages()
	library(geneorama)
	source("R/round_weeks.R")
	source('tests/test.round_weeks.R')
	test.round_weeks()
	identical(geneorama::round_weeks, round_weeks, ignore.environment = TRUE)
	
	##--------------------------------------------------------------------------
	## Manual test:
	##--------------------------------------------------------------------------
	rm(list=ls())
	geneorama::detach_nonstandard_packages()
	library(geneorama)
	source("R/round_weeks.R")
	dd <- seq(as.IDate("2013-12-22"), as.IDate("2014-01-18"), 1)
	round_weeks(dd)
	geneorama::round_weeks(dd)
	search()
	
	round_weeks
	geneorama::round_weeks
	
	data.table(date_original = dd,
			   weeks_dt = round(dd, 'weeks'),
			   weeks_new = round_weeks(dd),
			   wday = wday(dd),
			   weekday = weekdays(dd))
	
}







