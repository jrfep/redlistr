#' Colour codes for IUCN RLE categories.
#'
#' \code{IUCNclr} is a named vector of colours according to Appendix 3 of 
#' the IUCN Red List of Ecosystem guidelines
#'
#' @return a named vector of colours 
#' @author José R. Ferrer Paris \email{jose.ferrer@@provitaonline.org}
#' @family misc functions
#' @references Bland, L.M., Keith, D.A., Miller, R.M., Murray, N.J. and
#'   Rodriguez, J.P. (eds.) 2017. Guidelines for the application of IUCN Red
#'   List of Ecosystems Categories and Criteria, Version 1.1. Gland,
#'   Switzerland: IUCN. ix + 94pp. Available at the following web site:
#'   \url{https://iucnrle.org/}


IUCNclr <- rgb(c(0,255,255,255,173,0,128,255),
                 c(0,0,165,255,255,128,128,255),
                 c(0,0,0,0,47,0,128,255),maxColorValue=255)
names(UICNclr) <- c("CO","CR","EN","VU","NT","LC","DD","NE")

