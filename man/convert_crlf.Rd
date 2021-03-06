% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/convert_crlf.R
\name{convert_crlf}
\alias{convert_crlf}
\title{convert crlf to lf in Windows}
\usage{
convert_crlf(infile)
}
\arguments{
\item{infile}{File to be converted}
}
\description{
Rewrite a file and substitute LF for CRLF.
}
\details{
LF is Unix.  Note that writeChar, writeLines, and other options don't 
		work (as far as I can tell). Using cat on a wb file connection is the 
		key.
}
\examples{
		## NOT RUN:
	# files <- list.files(".", recursive = T, full.names = T)
	# sapply(files, convert_crlf)

}
\author{
Gene Leynes
}
\seealso{
\code{\link{cat}}, \code{\link{readLines}}, \code{\link{file}}
}

