library(Matrix)
library(irlba)
load("objects/pbmc8k.matrix.rda")
load("objects/pbmc8k.sparseMatrix.rda")


setClass("testMult", representation(matrix = "Matrix",
                                    center = "numeric",
                                    scale = "numeric"))
dim.testMult <- function(x) dim(x@matrix)
nrow.testMult <- function(x) nrow(x@matrix)
ncol.testMult <- function(x) ncol(x@matrix)
setMethod("%*%", signature(x = "testMult", y = "numeric"),
          function(x,y) {
    x %*% y
})

setMethod("%*%", signature(x = "numeric", y = "testMult"),
          function(x,y) {
    x %*% y
})

test <- new("testMult")
test@matrix <- pbmc8k.matrix$matrix
test@center <- pbmc8k.matrix$center
test@scale <- pbmc8k.matrix$scale

test <- new("testMult")
test@matrix <- pbmc8k.sparseMatrix$matrix
test@center <- pbmc8k.sparseMatrix$center
test@scale <- pbmc8k.sparseMatrix$scale



system.time({
    pca1 <- prcomp_irlba(pbmc8k.matrix$matrix, n = 10,
                         center = FALSE, scale. = FALSE,
                         retx = TRUE, verbose = TRUE)
})

system.time({
    pca2 <- prcomp_irlba(pbmc8k.sparseMatrix$matrix, n = 10,
                         center = FALSE, scale. = FALSE,
                         retx = TRUE, verbose = TRUE)
})
