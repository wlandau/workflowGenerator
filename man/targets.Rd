% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/ui.R
\name{targets}
\alias{targets}
\title{Function \code{targets}}
\usage{
targets(...)
}
\arguments{
\item{...}{Named collection of data frames of \code{remake} commands.}
}
\value{
YAML-like list of targets.
}
\description{
Puts a named collection of data frames of \code{remake} 
commands all together to make a YAML-like list of targets.
Unnamed arguments are permitted for data frames with exactly one row.
Targets \code{"all"}, \code{"clean"}, and \code{"target_name"},  
are already used by \code{remake} and cannot be overwritten by the user.
In addition, all target names must be unique. For instance,
\code{targets(d = data.frame(target = c("x", "x"), command = c("ls()", "ls()")))}
is illegal, and so is 
\code{targets(x = data.frame(target = c("x", "y"), command = c("ls()", "ls()")))}.
Use the \code{\link{help_remakeGenerator}} function to get more help.
}
\details{
Use the \code{\link{help_remakeGenerator}} function to get more help.
}
\seealso{
\code{\link{help_remakeGenerator}}
}

