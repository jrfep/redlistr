#' Plot of relative severity and extent for any functional subcriterion
#'
#' \code{RelativeSeverityPlot} computes the empirical cumulative distribution
#' function of any indicator of relative severity of environmental degradation
#' or disruption of biotic processes and interactions along ecosystem
#' distribution  and helps to compute the category according to RLE thresholds.
#'
#' @param ecosystem.data Raster object of an ecosystem.
#'   Please use a CRS with units measured in metres.
#' @param relative.severity Raster object of the relative severity based on
#' an indicator of environmental degradation or disruption of biotic processes
#' @param criterion Subcriterion considered
#' @return A plot displaying the relationship between \code{relative.severity}
#' and extent and the assigned category.
#' @author José R. Ferrer-Paris \email{jferrer@@provitaonline.com}
#' @family Functional criteria
#' @references Bland, L.M., Keith, D.A., Miller, R.M., Murray, N.J. and
#'   Rodriguez, J.P. (eds.) 2017. Guidelines for the application of IUCN Red
#'   List of Ecosystems Categories and Criteria, Version 1.1. Gland,
#'   Switzerland: IUCN. ix + 94pp. Available at the following web site:
#'   \url{https://iucnrle.org/}
#' @import raster

RelativeSeverityPlot <- function(ecosystem.data,
                                 relative.severity,
                                 criterion=c("D1")) {

    if (criterion %in% c("C1","C2a","C2b",
                       "D1","D2a","D2b"))
        thresholds <- c(0,30,50,80,100)
    if (criterion %in% c("C3","D3"))
        thresholds <- c(0,50,70,90,100)
    sev.vals <- values(relative.severity)[values(ecosystem.data) %in% 1]


    RSE <- ecdf(-1*sev.vals)
    
    Cat <- "LC"
    if (RSE(-1*thresholds[4])>thresholds[2]/100) {Cat <- "VU"}
    if (RSE(-1*thresholds[3])>thresholds[3]/100) {Cat <- "VU"}
    if (RSE(-1*thresholds[2])>thresholds[4]/100) {Cat <- "VU"}
    if (RSE(-1*thresholds[4])>thresholds[3]/100) {Cat <- "EN"}
    if (RSE(-1*thresholds[3])>thresholds[4]/100) {Cat <- "EN"}
    if (RSE(-1*thresholds[4])>thresholds[4]/100) {Cat <- "CR"}

    plot(RSE,col=NA,axes=F,xlab="Relative severity",ylab="Extent",main=sprintf("Criterion %s : Category %s",criterion,Cat))
    axis(2,thresholds/100,sprintf("%d %%",thresholds))
    axis(1,-1*thresholds[5:1],sprintf("%d %%",thresholds[5:1]))
    rect(-1*thresholds[5],thresholds[4]/100,-1*thresholds[4],thresholds[5]/100,col=IUCNclr["CR"])
    rect(-1*thresholds[5],thresholds[3]/100,-1*thresholds[4],thresholds[4]/100,col=IUCNclr["EN"])
    rect(-1*thresholds[5],thresholds[2]/100,-1*thresholds[4],thresholds[3]/100,col=IUCNclr["VU"])
    rect(-1*thresholds[4],thresholds[4]/100,-1*thresholds[3],thresholds[5]/100,col=IUCNclr["EN"])
    rect(-1*thresholds[4],thresholds[3]/100,-1*thresholds[3],thresholds[4]/100,col=IUCNclr["VU"])
    rect(-1*thresholds[3],thresholds[4]/100,-1*thresholds[2],thresholds[5]/100,col=IUCNclr["VU"])
    lines(ecdf(-1*sev.vals),col="maroon",lty=3,lwd=1)
    text(c(-1*thresholds[2:4]),RSE(-1*thresholds[2:4]),sprintf("%0.1f %%",RSE(-1*thresholds[2:4])*100),adj=-.1,font=2,cex=1.2)
}


