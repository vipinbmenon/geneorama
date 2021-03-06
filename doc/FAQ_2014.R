# Getting started / FAQ for R

## Gene Leynes

## See also: http://www.statmethods.net/
## See also: http://rprogramming.net/how-tos/
## See also: http://manuals.bioinformatics.ucr.edu/home/programming-in-r
## See also: http://pirategrunt.com/
## See also: 

## Table of Contents:

## Startup / System / Environment
## Packages
## Objects and Methods
## Website / XML Parsing
## Functions

## Flow Control
## STRINGS
## DATES
## Matching, Subsetting, and Sets

## FACTORS
## recode
## expand.grid

## Tables, Shingles, lapply
## Wide to tall using data.table
## Reshape using Pivot function
## Reshape using dcast.data.table

## Tables and apply functions

## REPORTING

## Graphics
#### Make a nice set of colors using color ramp
#### Modify a previous plot
#### Plot the "convex hull"
#### Plot Stars
#### all the point types
#### plot a color wheel using RGB
#### plot color wheels using heat, topo, terrain, and cm
#### Get HSV colors (where "blue" becomes "#0000FF")
#### Side by side boxplots
#### Identify points on a plot
#### Make two plots on the same canvas, Legend, Random walk, Tsay book cover
#### Add a background color to just the plot

## Lattice Graphics
#### Make xyplot plot in order
#### xy plot example with panel

## Simple fitting / statistics / plots
#### curve
#### spline
#### par - mfrow
#### bandplot
#### Boxplot example with gl

## Useful Functions
#### II
#### IM
#### clipper
#### clipped
#### NAsummary

## Examples
#### Example - Great plot example (bank dot plot example)
#### Example - Check R scripts for presence of a word pattern
#### Example - Make a .First function that does stuff
#### Example - Programming - Try catch
#### 

##-----------------------------------------------------------
## Update R
##-----------------------------------------------------------
## First, install the new version of R
## Second, make v0 the path to your old library and v1 the 
## path to the new library
v0 = 'C:/Users/375492/Documents/R/R-3.1.0/library/'
v1 = 'C:/Program Files/R/R-3.1.1/library'

## These are the packages that didn't copy over:
list.files(v0)[!list.files(v0)%in%list.files(v1)]

## Now, just install geneorama and then the missing 
## packages!
install.packages('devtools')
devtools::install_github("geneorama/geneorama")
library(geneorama)
loadinstall_libraries(list.files(v0)[!list.files(v0) %in% list.files(v1)])

##-----------------------------------------------------------
## Startup / System / Environment
##-----------------------------------------------------------

## Very useful help:
?Startup

## See the help file examples executed
example(svd)

## Change warnings options
options(warn=0)  ## Default: stores warnings until function exit
options(warn=-1) ## No warnings
options(warn=1)  ## Warnings print immediately


## View, getting, and setting environmental variables
names(Sys.getenv())
Sys.getenv('R_USER')
Sys.setenv(R_USER='C:\\Users\\gene.leynes')
Sys.setenv(R_USER='C:\\Documents and Settings\\Gene\\My Documents')
Sys.getenv('HOME')
Sys.getenv('R_HOME')
Sys.getenv("R_LIBS_USER")

## Typical start: (OLD)
setwd('~/Dropbox/R/[CurrentProject]')
source('~/Dropbox/R/00 Standard Functions/sourceDir.R')
sourceDir('~/Dropbox/R/00 Standard Functions', FALSE)

## Get R version number
R.Version()

## Change directory using a script using "getSrcFilename"
## Once you have saved this to a script, you can drag it into
## a running R window and it will change the working directory
## to the path of the saved script.
curpath <- dirname(getSrcFilename(function(){}, full=TRUE))
setwd(curpath)
cat('Now in ', curpath, '\n')
print(dir())

## Trick for loading the initial global environment
## 1) In a running instance of R create a function called .First 
##    function that creates everything you will want.
## 2) Save an image file (.RData file) with only .First
## 3) Everytime you use that .RData image your .First function
##    will run first and create an environment that you specified.
##    You can also use it to run an initialization, load a file,
##    or start a process.

## SEE EXAMPLES FOR MORE COMPLEX EXAMPLE

## Delete everything so that you're only saving .First
rm(list=ls())
## Define your fuction
.First = function(){
	## Create or load your desired objects
	exampleFuncion <- function(x){x=x+1; x=x^2; return(x)}
	## Save the object names in the local namespace
	CurNames <- ls()
	## Put each local object into the global environment
	for(nm in CurNames){
		assign(x=nm, value=get(nm), envir=.GlobalEnv)
	}
	## The .First function now exits. All local copies of
	## created values are lost, but the global copies remain
	## accessible to the user.
}
## Save .First somewhere
save.image('test.RData')


##-----------------------------------------------------------
## Packages
##-----------------------------------------------------------

## See also: http://manuals.bioinformatics.ucr.edu/home/programming-in-r#TOC-Building-R-Packages

## Detach package
detach(pos = match("package:graphics", search()))

## List all installed packages
rownames(installed.packages())

##list all commands in all packages
for(i in 1:length(search())) {print(ls(i))}

## Install a package from r-forge (or any other website)
install.packages("DierckxSpline", 
				 repos = '"http://r-forge.r-project.org"')

## Download and install Geneorama from source
local({
	installed_pacakges <- .packages(all.available = TRUE)
	
	if(!'geneorama' %in% installed_pacakges){
		## Get webfile and unzip to a temp directory
		webfile <- 'http://geneorama.com/code/geneorama_1.1.tar.gz'
		tmp <- tempdir()
		tmpfile <- file.path(tmp, basename(webfile))
		download.file(webfile, tmpfile)
		install.packages(tmpfile, type = "source", repos = NULL)
		unlink(tmpfile)
		unlink(tmp)
	}
})

## Copy out all the functions in a package
## Gene Leynes (4/27/11)
getFormals <- function(x){
	Names <- names(formals(x))
	Vals <- as.character(formals(x))
	#Vals[Vals==''] <- "INPUT"
	ret <- paste(Names,Vals,sep='=',collapse=', ')
	ret <- gsub('\\=$', '', ret)
	ret <- gsub('\\=,', ',', ret)
	ret <- paste('(',ret,')', sep='')
	ret
}
library(data.table)
funs <- ls(which(search()=="package:data.table"))
funargs <- sapply(funs, getFormals)
ret <- cbind(Functions = funs, Function_Arguments = funargs)
clipper(ret)



##-----------------------------------------------------------
## Objects and Methods
##-----------------------------------------------------------

## structure returns the given object with further attributes set.
structure(1:6, dim = 2:3)

## Information about an object
typeof(tempdf)
is.what(tempdf)
class(tempdf)
mode(tempdf)

## list all methods
methods(class="data.frame")
methods(class="systemfit")
methods(plot)

## Make a png file
png(file = "plot23000x23000.png", width = 23000, height = 23000, res = 2400)
print(myplot)
dev.off()

# Printing within a loop
# if using the GUI, turn off buffering, 
# or use 'flush.console()' after 'cat'.



##------------------------------------------------------------------------------
## Website / XML Parsing
##------------------------------------------------------------------------------

##-----------------------------------------------------------
## xcode example
## http://dataissexy.wordpress.com/2013/06/01/10-second-rss-parsing-in-r-and-xpath/
##-----------------------------------------------------------
library(XML)
library(RCurl)

xml.url<-"http://dataissexy.wordpress.com/feed/"
rssdoc <- xmlParse(getURL(xml.url))
rsstitle <- xpathSApply(rssdoc, '//item/title', xmlValue)
rssdesc <- xpathSApply(rssdoc, '//item/description', xmlValue)
rssdate <- xpathSApply(rssdoc, '//item/pubDate', xmlValue)



##------------------------------------------------------------------------------
## Functions
##------------------------------------------------------------------------------

## Use "mapply" to re-use function arguments in subsequent calls
FunctionWithManyArguments <- function(x1, x2, x3, x4, x5, x6, x7, x8, x9){
	ans <- x1 + x2 + x3 + x4 + x5 + x6 + x7 + x8 + x9
	return(ans)
}
FunctionWithManyArguments(1, 2, 3, 4, 5, 6, 7, 8, 9)
ArgsThatRarelyChange <- list(x3=3, x4=4, x5=5, x6=6, x7=7, x8=8, x9=9)
mapply(somefun, x1 = 1,x2 = 2, MoreArgs=ArgsThatRarelyChange)

## Check for function arguments (manually)
SomeFunction <- function(x,y){
	if(nargs()!=length(formals(f)))
		stop('Something is missing...')
}
SomeFunction(x=1:10)

## Check for function arguments (automatically)
SomeFunction <- function(x,y){
	curfun <- deparse(match.call()[1])
	curfun <- substr(curfun, 1, nchar(curfun) - 2)
	if(length(formals(curfun)) != nargs())
		stop('Something is missing...')
}
SomeFunction()

## Two ways to get the arguments of a function using match.call
ReturnArgs <- function(aa, bb){
	mcall <- match.call()
	for(i in 1:length(mcall)){
		cat(i, '\n')
		print(mcall[i])
		cat(substr(mcall[i], 1, nchar(mcall[i])))
		cat('\n\n')
	}
	invisible()
}
ReturnArgs(aa = 'onething', bb = 1:100)

# deparse substitute
PrintDeparsedVals <- function(aa, bb){
	print(deparse(substitute(aa)))
	print(deparse(substitute(bb)))
	invisible()
}
PrintDeparsedVals(aa = 'onething', bb = 1:100)



##------------------------------------------------------------------------------
## Flow Control
##------------------------------------------------------------------------------
# else if
xx=c(0,1,2,3)
tester=function(x){
	if(x==0){
		print('zero')
	} else if(x==1){
		print('one')
	} else {
		print('more than one')
	}
}
for (i in 1:length(xx)) tester(xx[i])

# stopifnot (displays error message if condition is false)
stopifnot(F)



##------------------------------------------------------------------------------
## STRINGS
##------------------------------------------------------------------------------

## Replace // with \
chartr('\\', '/', R.home())

## Find characters in a string
x <- deparse(mean)[2]           # "UseMethod(\"mean\")"
gregexpr('u', deparse(mean)[2])  # -1
gregexpr('s', deparse(mean)[2])  # 2
gregexpr('\"', deparse(mean)[2]) # 11 16

## add a leading 0
sprintf("%02.0f", pi)

## Format a number to be a string with n digits
formatC(pi, digits=0, width=5, flag='0')

##------------------------------------------------------------------------------
## DATES
##------------------------------------------------------------------------------
# show sub second time
options(digits.secs=4)

# For details see
?DateTimeClasses

## Example date / times
set.seed(100)
datetime <- ISOdatetime(year=2012, month=10, day=29, hour=0, min=0, sec=0)
datetimes <- datetime + sort(runif(5, min=0, max=60 * 60 * 24 * 30))
datetimes
# [1] "2012-10-30 16:35:45 CDT" "2012-11-05 16:31:27 CST" 
# [3] "2012-11-07 04:35:29 CST" "2012-11-12 00:21:19 CST" 
# [5] "2012-11-14 12:40:19 CST"
unclass(datetimes)
# [1] 1351632945 1352154687 1352284530 1352701280 1352918420
data.frame(unclass(as.POSIXlt(datetimes)))
#        sec min hour mday mon year wday yday isdst
# 1 45.12583  35   16   30   9  112    2  303     1
# 2 27.12267  31   16    5  10  112    1  309     0
# 3 29.75937  35    4    7  10  112    3  311     0
# 4 19.74392  21    0   12  10  112    1  316     0
# 5 19.74719  40   12   14  10  112    3  318     0

as.POSIXct(1472562988, origin = "1960-01-01") # local
as.POSIXct(1472562988, origin = ISOdatetime(1960,1,1,0,0,0)) # local
as.POSIXct(1472562988, origin = "1960-01-01", tz = "GMT") # UTC

# strftime is a wrapper for "fromat"
format(datetimes, "%H:%M:%OS3")
format(datetimes, "%Y-%m-%d")

# Output of strftime is char
# Use round to get dates, but convert to POSIXct; default format is lt
as.POSIXct(round(datetimes, "day"))

# strptime can convert char to date / time (sometimes)
strptime(c("02/27/92 23:03:20", "02/27/92 22:29:56"), "%m/%d/%y %H:%M:%S")



# Get WeekNumber from dates (add one?)
dates <- c("15-08-2005", "01-01-2005", 
		   "15-01-2005", "08-08-2005", "08-08-2005")
as.factor(format(as.Date(dates,"%d-%m-%Y"),"%W"))



##------------------------------------------------------------------------------
## Matching and Subsetting, and Sets
##------------------------------------------------------------------------------
## Match and %in%
match('OH', state.abb) # 35
match(state.abb, 'OH') # NA,NA,...,NA,NA,1,NA,NA,NA,NA,...
'OH' %in% state.abb # TRUE
state.abb %in% 'OH' # FALSE FALSE FALSE.... TRUE FALSE FALSE....

# Subset
head(airquality)
head(subset(airquality, Temp > 80, select = c(Ozone, Temp)))
head(subset(airquality, Day == 1, select = -Temp))
head(subset(airquality, select = Ozone:Wind))

# Combine
require(gdata)
a  <-  matrix(rnorm(12),ncol=4,nrow=3)
b  <-  1:4
combine(a, b)
combine(x=a, b)
combine(x=a, y=b)
combine(a, b, names=c("one","two"))

# set functions
?identical
(x <- c(sort(sample(1:20, 9)),NA))
(y <- c(sort(sample(3:23, 7)),NA))
union(x, y)
intersect(x, y)
setdiff(x, y)
setdiff(y, x)
setequal(x, y)
is.element(x, y)# length 10
is.element(y, x)# length  8

# all.equal
?identical()
d45 <- pi*(1/4 + 1:10)
all.equal(tan(d45), rep(1,10))         # TRUE, but
all      (tan(d45) == rep(1,10))       # FALSE, since not exactly
all.equal(tan(d45), rep(1,10), tol=0)  # to see difference


##==============================================================================
## FACTORS
## Create a sample string and convert it to factors and ordered factors
##==============================================================================

## Population of possibilities
pop_vec <- c('green', 'red', 'yellow', NA)
pop_vec_ordered <- c('green', 'yellow', 'red', NA)

## Sample from the population
set.seed(14)
ex_str <- sample(x = pop_vec, size = 20, replace = TRUE, 
				 prob =c(.29, .29, .29, .13))

## Conversion examples
factor(x = ex_str, exclude = NA)           ## Exclude NA (default behavior)
factor(x = ex_str, exclude = c(NA, 'red')) ## Exclude NA and "red"
factor(x = ex_str, exclude = NULL)         ## Exclude nothing; use NA as a level

## Create factor vectors
ex_fac <- factor(x = ex_str, exclude = NULL, levels = pop_vec)
ex_ord <- factor(x = ex_str, exclude = NULL, levels = pop_vec_ordered, ordered=TRUE)
ex_ord

## Modify the levels of the example factor vectors:

## Rename all 1 level at a time:
## This should replace "green" with "good", but it also will forget the NA 
## level!  (created by the exclude = NULL part of the original call)
## levels(ex_fac_rename)[1] <- "good"

## Rename all 4 levels at once:
ex_fac_rename <- ex_fac  ## Make a copy
ex_ord_rename <- ex_ord  ## Make a copy
levels(ex_fac_rename) <- c('good', 'bad', 'ok', 'missing')
levels(ex_ord_rename) <- c('good', 'ok', 'bad', 'missing')

## Make missing slightly better than bad, but worse than ok
ex_ord_rename_relevel <- ex_ord_rename
ex_ord_rename_relevel <- ordered(ex_ord_rename_relevel, 
								 c("good", "ok", "missing", "bad"))
## relevel doesn't work for this... relevel has a very narrow usage
## relevel(ex_ord_rename_relevel, c("good", "ok", "missing", "bad"))

data.frame(ex_str, 
		   ex_fac, 
		   ex_ord,
		   ex_ord_rename,
		   ex_ord_rename_relevel,
		   ex_fac_rename,
		   unclass(ex_fac), 
		   unclass(ex_ord),
		   unclass(ex_ord_rename),
		   unclass(ex_ord_rename_relevel),
		   unclass(ex_fac_rename))[order(ex_ord), ]

##------------------------------------------------------------------------------
## recode
## See also: http://rprogramming.net/recode-data-in-r/
##------------------------------------------------------------------------------
(x <- rep(1:3,3))
## [1] 1 2 3 1 2 3 1 2 3
recode(x, "c(1,2)='A'; else='B'")
## [1] "A" "A" "B" "A" "A" "B" "A" "A" "B"
recode(x, "1:2='A'; 3='B'")
## [1] "A" "A" "B" "A" "A" "B" "A" "A" "B"


##------------------------------------------------------------------------------
## expand.grid
##------------------------------------------------------------------------------
jcetable <- expand.grid(
	event = c('Wheezing at any time',
			  'Wheezing and breathless',
			  'Wheezing without a cold',
			  'Waking with tightness in the chest',
			  'Waking with shortness of breath',
			  'Waking with an attack of cough',
			  'Attack of asthma',
			  'Use of medication'),
	method = c('Mail', 'Telephone'), 
	sex = c('Male', 'Female'),
	what = c('Sensitivity', 'Specificity'))


##------------------------------------------------------------------------------
## Tables, Shingles, lapply
##------------------------------------------------------------------------------
# Nice way to summarize by groups
data(warpbreaks)
lapply(split(warpbreaks, warpbreaks$tension), summary)

# Make buckets of equal size
# see also: shingle
library(lattice)
equal.count(rnorm(100))

##------------------------------------------------------------------------------
## Wide to tall using data.table
##------------------------------------------------------------------------------
library(data.table)
dt <- data.table(uid=c("a","b"), var1=c(1,2), var2=c(100,200))
dt
melt(dt, id=c("uid"))
## Confusing way:
dt[, list(variable = names(.SD), value = unlist(.SD, use.names = F)), by = uid]

##------------------------------------------------------------------------------
## Reshape with dcast.data.table
##------------------------------------------------------------------------------
library(data.table)

dt <- data.table(id = c(1,1,2,2), 
				 region = c("a","b","a","b"),
				 date = Sys.Date(),
				 count = c(6,7,8,9))
dt
dcast.data.table(data = dt, 
				 formula = id ~ region + date)
dcast.data.table(data = dt, 
				 formula = id ~ region + date,
				 value.var = "count")
dcast.data.table(data = dt,
				 formula = id ~ date,
				 value.var = "count")
dcast.data.table(data = dt,
				 formula = id ~ region,
				 value.var = "date")

## Reshape and aggregate by "sum"
dcast.data.table(data = dt,
				 fun.aggregate = sum,
				 formula = id ~ date,
				 value.var = "count")


##------------------------------------------------------------------------------
## Reshape using Pivot function
## http://stackoverflow.com/questions/5307313/fastest-tall-wide-pivoting-in-r
##------------------------------------------------------------------------------
tall <- data.frame( 
	int = rep(1:100, 100),
	fac = rep( paste('v',1:100,sep=''), each = 100),
	val = 1:1000) [-(1:5), ]
tall <- tall[sample(1:nrow(tall)), ]

pivot  <-  function(col, row, value) {
	# browser() }
	col = as.factor(col)
	row = as.factor(row)
	mat = array(
		dim = c(nlevels(row), nlevels(col)), 
		dimnames = list(levels(row), levels(col)))
	mat[(as.integer(col) - 1L) * nlevels(row) + as.integer(row)] = value
	mat
}

wide <- with(tall, pivot(fac, int, val))
tall[1:10, 1:3]
wide[1:10, 1:10]
system.time( replicate(100, wide <- with(tall, tapply( val, list(int, fac), identity))))
system.time( replicate(100, wide <- with(tall, pivot(fac, int, val))))


##------------------------------------------------------------------------------
## Tables and apply functions 
##------------------------------------------------------------------------------

## aggregate.table
## Depricated: Now use data.table
library(gdata)
g1 <- sample(letters[1:5], 1000, replace=TRUE)
g2 <- sample(LETTERS[1:3], 1000, replace=TRUE )
dat <- rnorm(1000)
stderr <- function(x) sqrt( var(x,na.rm=TRUE) / nobs(x) )

(means   <- aggregate.table( dat, g1, g2, mean ))
(stderrs <- aggregate.table( dat, g1, g2, stderr ))
(ns      <- aggregate.table( dat, g1, g2, nobs ))

## apply - some of the examples
## Depricated: Now use data.table
## Compute row and column sums for a matrix:
(x <- cbind(x1 = 3, x2 = c(4:1, 2:5)))
dimnames(x)[[1]] <- letters[1:8]
apply(x, 2, mean, trim = .2)
col.sums <- apply(x, 2, sum)
row.sums <- apply(x, 1, sum)
rbind(cbind(x, Rtot = row.sums), Ctot = c(col.sums, sum(col.sums)))

(ma <- matrix(c(1:4, 1, 6:8), nrow = 2))
apply(ma, 1, table)  #--> a list of length 2
apply(ma, 1, stats::quantile)# 5 x n matrix with rownames

## tapply "Pivot Table"
tapply(airquality$Ozone, airquality$Month, length)
tapply(airquality$Ozone, airquality$Month, mean, na.rm = T)

## sapply
newdf$nUnique = sapply(sapply(df[,1:ncol(df)],unique),length) 

## Example of mapply
# The function:
fx2 <- function (x,a) (x-a)^2+1
# Just for fun:
optimize(fx2,c(0,1),tol=.00001,a=1/3)

# A line where a is constant
xx <- seq(0, 1, .05)
aa <- rep(1/3, 21)
yy <- mapply(fx2, x = xx, a = aa)
plot(xx, yy, type='l')

# A line where a varies
xx <- seq(0, 1, .05)
aa <- seq(1/4, 5/12, (5/12-1/4)/(length(xx)-1))
yy <- mapply(fx2, x=xx, a=aa)
lines(xx, yy, col='blue')


##------------------------------------------------------------------------------
## REPORTING
##------------------------------------------------------------------------------

## http://stackoverflow.com/questions/10646665/how-to-convert-r-markdown-to-html-i-e-what-does-knit-html-do-in-rstudio-0-9
## Add this line to the Rmd file to see R Studio's messages
Sys.sleep(30)

# Create .md, .html, and .pdf files
# http://danieljhocking.wordpress.com/2013/09/25/knitting-beautiful-documents-in-rstudio/
knit("File.Rmd")
markdownToHTML('File.md', 'File.html', options=c("use_xhml"))
system("pandoc -s File.html -o File.pdf")
## Command to fix margins in latex (from blog post above)
\usepackage[vmargin=1in,hmargin=1in]{geometry}

# Create .md, .html, and .pdf files
# http://rprogramming.net/create-html-or-pdf-files-with-r-knitr-miktex-and-pandoc/
# Step 1: Install MiKTeX
# Step 2: Install Pandoc
# Step 3: Install Knitr and Markdown
# Step 4: Create a .Rmd File Containing Your Analysis
# Step 5: Create a .R File to Run the .Rmd File
# # Set working directory
# setwd("C:/Documents and Settings/name")

# # Load packages
# require(knitr)
# require(markdown)

# # Create .md, .html, and .pdf files
# knit("My_Analysis.Rmd")
# markdownToHTML('My_Analysis.md', 'My_Analysis.html', options=c("use_xhml"))
# system("pandoc -s My_Analysis.html -o My_Analysis.pdf")

# Step 6: Produce HTML and PDF Output Files with R



##------------------------------------------------------------------------------
## Graphics
##------------------------------------------------------------------------------

# Make a nice set of colors using color ramp
ramp <- colorRamp(c("red", "blue"))
rgb( ramp(seq(0, 1, length = 5)), max = 255)
plot(1:15, 1:15, pch=16, cex=10, col=
	 	rgb( ramp(seq(0, 1, length = 15)), max = 255))


# Modify a previous plot
par(mfrow=c(3,1))
pars <- list()
for(i in 1:3){
	set.seed(10)
	plot(1:(10*i)*i, main=paste('examp', i))
	pars[[i]] = par('usr')
}
for(i in 1:3){
	par(mfg=c(i,1))
	par(usr=pars[[i]])
	lines(1:(10*i)*i, col=i+1)
}

# Plot the "convex hull"
plot(cars)
polygon( cars[chull(cars),], col="pink", lwd=3)
points(cars)

# Plot Stars
palette(rainbow(12, s = 0.6, v = 0.75))
stars(mtcars[, 1:7], len = 0.8, key.loc = c(12, 1.5),
	  main = "Motor Trend Cars", draw.segments = TRUE)

# all the point types
nn <- 1:50;    plot(nn,nn,type='n');for(i in nn)points(i,i,pch=i);rm(i,nn)
nn <- 51:100;  plot(nn,nn,type='n');for(i in nn)points(i,i,pch=i);rm(i,nn)
nn <- 101:150; plot(nn,nn,type='n');for(i in nn)points(i,i,pch=i);rm(i,nn)

# plot a color wheel using RGB
r <- 1:100/100; g <-.05; b <- .05
pie(rep(1,100), col=rgb(r,g,b))

# plot color wheels using heat, topo, terrain, and cm
par(mfrow=c(2,2), mar=c(0,0,1.5,0))
pie(rep(1,40),col=heat.colors(40)[1:40], main='heat.colors')
pie(rep(1,40),col=terrain.colors(40)[1:40], main='terrain.colors')
pie(rep(1,40),col=topo.colors(40)[1:40], main='topo.colors')
pie(rep(1,40),col=cm.colors(40)[1:40], main='cm.colors')

# Get HSV colors (where "blue" becomes "#0000FF")
(hc <- rgb2hsv(col2rgb("blue")))
(SomeHSV <- hsv(hc[1,1],hc[2,1],hc[3,1]))
pie(1, col = SomeHSV)

# Side by side boxplots
boxplot(len ~ dose, data = ToothGrowth,
		boxwex = 0.25, at = 1:3 - 0.2,
		subset = supp == "VC", col = "yellow",
		main = "Guinea Pigs' Tooth Growth",
		xlab = "Vitamin C dose mg",
		ylab = "tooth length",
		xlim = c(0.5, 3.5), ylim = c(0, 35), yaxs = "i")
boxplot(len ~ dose, data = ToothGrowth, add = TRUE,
		boxwex = 0.25, at = 1:3 + 0.2,
		subset = supp == "OJ", col = "orange")
legend(2, 9, c("Ascorbic acid", "Orange juice"),
	   fill = c("yellow", "orange"))

# Add a simple fitted line
plot(cars)
(z <- line(cars))
abline(coef(z))


# Identify points on a plot
plot(mtcars$mpg,mtcars$hp)
identify(mtcars$mpg,mtcars$hp,label=rownames(mtcars))

# Make two plots on the same canvas
# Legend
# Random walk 
# Tsay book cover
set.seed(123456)
## White noise
e <- rnorm(500)
## Random walk
randwalk <- cumsum(e)
## Trend
trend <- 1:500
## Plots
par(mar=rep(5,4))
## deterministic trend + noise
plot.ts(0.5 * trend + e, lty=1, ylab='', xlab='')
## random walk with drift
lines(0.5 * trend + cumsum(e), lty=2)
## random walk (same scale)
lines(randwalk, lty=3, col='red')
par(new=T)
## random walk (own scale)
plot.ts(randwalk, lty=3, axes=FALSE, col='red')
axis(4, pretty(range(randwalk)))
legend(10, 18.7, legend=c('deterministic trend + noise (left)',
						  'random walk w/ drift (left)', 
						  'random walk (left+right)'),
	   lty=c(1, 2, 3), col=c('black', 'black', 'red')) 


# Add a background color to just the plot
# (Boxplot example)
dat <- data.frame(x=gl(10,20),y=rnorm(10*20))
plot(dat)
# ADD THE BACKGROUND
tmp <- par()$usr
rect(tmp[1], tmp[3], tmp[2], tmp[4], col = "lightyellow")
plot(dat, add=TRUE)

# Add a background color to just the plot
# (Non-boxplot example)
dat <- data.frame(x=gl(10,20),y=rnorm(10*20))
dat$x <- as.numeric(dat$x)
plot(dat, type='n')
# ADD THE BACKGROUND
tmp <- par("usr")
rect(tmp[1], tmp[3], tmp[2], tmp[4], col = "lightyellow")
points(dat)


##------------------------------------------------------------------------------
## Lattice Graphics
## also, see end for "great plot example"
##------------------------------------------------------------------------------

# Make xyplot plot in order
lattice.options(default.args = list(as.table = TRUE)) 

# xy plot example with panel
phi <- matrix(rnorm(19000), nrow=1000, ncol=19)
av <- .03 + .05 * phi
av <- t(apply(1+av, 1, cumprod))
spx <- (.03 + .05 * phi)^2
spx <- t(apply(1+spx, 1, cumprod))
#plot(av[1,],ylim=range(av));apply(av,1,lines)
#plot(spx[1,],ylim=range(spx));apply(spx,1,lines)
dat <- data.frame(
	av=as.vector(av),
	spx=as.vector(spx),
	dif=as.vector(av-spx),
	time = rep(2:20,each=1000))

lattice.options(default.args = list(as.table = TRUE)) 
xyplot(dif~spx|time, dat, 
	   strip = strip.custom(strip.levels = TRUE),
	   scales = "free",
	   panel=function(x,y){
	   	panel.xyplot(x,y)
	   	panel.abline(h=c(0,1,1.5),lty=2)
	   }
)



##------------------------------------------------------------------------------
## Simple fitting / statistics / plots
##------------------------------------------------------------------------------
## curve
curve(x^3-3*x, -2, 2)
curve(x^2-2, add = TRUE, col = "violet")

## spline
n <- 9
x <- 1:n
y <- rnorm(n)
plot(x, y, main = paste("spline[fun](.) through", n, "points"))
lines(spline(x, y))
lines(spline(x, y, n = 201), col = 2)

## par - mfrow
par(mfrow = c(3,1))
for (i in 1:3) plot(matrix(rnorm(21), nrow=7))

## bandplot #2 (and lm)
x <- abs(rnorm(500))
y <- rnorm(500, mean=2*x, sd=2+2*x)
plot(x,y )
reg <- lm(y~x)
summary(reg)
bandplot(x,y)
bandplot(predict(reg),resid(reg))

## Boxplot Example with gl
g = factor(round(10*runif(10*100)))
x = rnorm(10*100)+sqrt(as.numeric(g))
xg = split(x,g)
boxplot(xg, col='lavender', notch=T, var.width=T)

##------------------------------------------------------------------------------
## Useful Functions
##------------------------------------------------------------------------------
II <- function(x) I(as.character(x))
IM <- function(x) as.data.frame(as.matrix(x))
clipper <- function(x){
	#writeClipboard(x,format=1)
	write.table(x, "clipboard", sep="\t", col.names=NA)
}

clipped = function(){
	read.delim("clipboard")
}
NAsummary <- function(df){
	newdf <- data.frame(Count = rep(nrow(df),ncol(df)))
	rownames(newdf) = colnames(df)
	newdf$nNA <- nrow(df)-sapply(df,function(x)length(na.omit(x)))
	newdf$rNA <- newdf$nNA / newdf$Count
	newdf$rNA <- trunc(newdf$rNA*10000)/10000
	newdf$nUnique <- sapply(df, function(x)length(unique(x)))
	newdf$rUnique <- newdf$nUnique / newdf$Count
	newdf$rUnique <- trunc(newdf$rUnique*10000)/10000
	return(newdf)
}


##------------------------------------------------------------------------------
## Data Frame VS. Matrix
##------------------------------------------------------------------------------
df <- data.frame(x=1:10, y=rnorm(10))  ;  
mat <- matrix(c(x=1:10, y=rnorm(10)), ncol=2)
colnames(mat) = c('x','y')

df['x']   ;  mat['x']    # Data frame   vs. NA
df[,'x']  ;  mat[,'x']   # Vector    vs. Vector
df[['x']] ;  mat[['x']]  # Vector    vs. subscript out of bounds
df$'x'    ;  mat$'x'     # Vector    vs. ERROR: operator is invalid for atomic vectors
df$x      ;  mat$x       # Vector    vs. ERROR: operator is invalid for atomic vectors
df$x[1]   ;  mat$x[1]    # Vector    vs. ERROR: operator is invalid for atomic vectors
df[[1,2]] ;  mat[[1,2]]  # Numeric Vec   vs. Numeric Vec
df[1,2]   ;  mat[1,2]    # Numeric Vec  vs. NAMED Vec





##-----------------------------------------------------------
## Example - Great plot example (bank dot plot example)
##-----------------------------------------------------------
## xyplot
library(lattice)
library(grid)

### read the data
fname <- "http://addictedtor.free.fr/graphiques/data/150/data.txt"
d <- read.csv(file(fname))

### workaround so that lattice does not order bank names alphabetically
d$bank <- ordered(d$bank, levels=d$bank)

### setup the key
k <- simpleKey(c("Q2 2007",  "January 20th 2009"))
k$points$fill <- c("lightblue", "lightgreen")
k$points$pch <- 21
k$points$col <- "black"
k$points$cex <- 1

list1=list(pch=21, fill = c("lightblue", "lightgreen"), 
		   cex = 4, col = "black")

### create the plot
dotplot(bank ~ MV2007 + MV2009, data=d, horiz=T,
		par.settings = list(superpose.symbol = list1),
		xlab = "Market value ($Bn)", key=k,
		panel = function(x, y, ...){
			panel.dotplot(x, y, ...)
			grid.text(
				unit(x, "native"), unit(y, "native"),
				label = x, gp = gpar(cex=.7))
		})



##------------------------------------------------------------------------------
## Example - Check R scripts for presence of a word pattern
##------------------------------------------------------------------------------
ff <- list.files(recursive = TRUE, pattern = '\\.R$')
dat <- lapply(ff, readLines)
hasplot <- unlist(sapply(dat, function(x)
	length(grep(x, pattern='plot')))) != 0
missingreset <- unlist(sapply(dat, function(x)
	length(grep(x, pattern='resetGraph'))))==0
# Shows files that have "plot" but is missing "resetGraph"
ff[hasplot&missingreset]


##------------------------------------------------------------------------------
## Profile code
##------------------------------------------------------------------------------

# Profile some code:
nr <- 100
nc <- 10
yy <- c()
y <- matrix(rnorm(nr*nc), nrow=nr, ncol=nc)
Rprof("test.out")
readLines("test.out")
for (i in 1:nrow(y)){
	yy[i] <- lm(y[i,] ~ I(1:nc))$coefficients[1]
}
Rprof(NULL)
summaryRprof("test.out")
file.remove("test.out")
rm(nr, nc, yy, y)


##-----------------------------------------------------------
## Make a .First function that does stuff
##-----------------------------------------------------------
## 5/20/12
.First=function(){
	
	library(base)
	library(stats)
	library(mgcv)
	
	library(graphics)
	library(grDevices)
	library(utils)
	library(datasets)
	library(methods)
	library(PBSmodelling)
	#if(!require(gdata)) stop()
	#if(!require(zoo)) stop()
	#if(!require(lattice)) stop()
	#if(!require(quadprog)) stop()
	
	# The following code is specific to the GUI stuff...
	cat('Starting GUI\n')
	#assign(x='DebugMode', value=1, envir=.GlobalEnv)
	DebugMode <<- FALSE
	options(stringsAsFactors=FALSE)
	
	## LOAD FUNCTIONS
	source('Functions/appLoadFunctions.R')
	appLoadFunctions()
	
	## SET CurrentMode MANUALLY AND CREATE GUI
	CurrentMode <<- 1
	loadGUI()
	
	cat('Finished Loading Application\n')
}

save.image(file='loadgui.RData')






##------------------------------------------------------------------------------
## Example - Programming - Try catch
##------------------------------------------------------------------------------

## Try catch
tryCatch(expr = {1 + '1'}, 
		 error = function(x) return('it\'s ok, everybody makes mistakes'))

## Raise an Error:
e = simpleError("some annoying error")

## Example - try to write a file
WriteAttempt <- try(expr = write.table(x = x, file=fpname, append = F, 
									   quote = FALSE, sep = ",", eol = "\n",
									   na = "", dec = ".", row.names = FALSE,
									   col.names = TRUE, 
									   qmethod = c("escape", "double")),
					silent=TRUE)
if("try-error" %in% class(WriteAttempt)){
	write.table(x = x, file = fpnameTemp, append = F,
				quote = FALSE, sep = ",", eol = "\n",
				na = "", dec = ".", row.names = FALSE,
				col.names = TRUE,
				qmethod = c("escape", "double"))
	openFile(fpnameTemp)
}else{
	openFile(fpname)
}

## Example - try to install packages
libs <- c('mgcv','pppppppp')
xx <- sapply(X = libs, 
			 FUN = function(x) try(expr = library(package = x, 
			 									 character.only = TRUE), 
			 					  silent = TRUE))
xx <- sapply(X = xx, 
			 FUN = function(x) 'try-error' %in% class(x))
xx <- xx[xx]
sapply(X = names(xx), 
	   FUN = function(x) install.packages(pkgs = x, 
	   								   repos = 'http://cran.r-project.org'))
sapply(X = names(xx), 
	   FUN = function(x) try(expr = library(package = x, 
	   									 character.only = TRUE)))
