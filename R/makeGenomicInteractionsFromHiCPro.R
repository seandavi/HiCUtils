#' build GenomicInteraction from matrix files
#' 
#' The hicpro software generates a sparse matrix format that 
#' includes three columns:
#' 
#' bin_i
#' bin_j
#' count_ij
#' 
#' A BED file (either _abs or _ord bed file is fine) is also generated
#' that includes a fourth column, the bin number. A join on
#' the bin numbers and the bed file is necessary to produce a 
#' GenomicInteractions object.
#' 
#' @param matrixfile
#' @param bedfile
#' 
#' @importFrom readr read_tsv
#' @importFrom rtracklayer import
#' @import GenomicInteractions
#'   
#' @export
makeGenomicInteractionsFromHiCPro <- function(matrixfile,bedfile) {
  beddf = rtracklayer::import(bedfile)
  matrixdf = read_tsv(matrixfile,col_names=FALSE)
  colnames(matrixdf) = c('bini','binj','count')
  GenomicInteractions(beddf[matrixdf[['bini']]],beddf[matrixdf[['binj']]],matrixdf[['count']])
}
