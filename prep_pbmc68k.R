library(TENxPBMCData)
tenx <- TENxPBMCData("pbmc68k")
wh <- which(rowSums(counts(tenx)) != 0)
cT.matrix <- t(as.matrix(counts(tenx)[wh,]))
centers <- colMeans(cT.matrix)
scales <- colSds(cT.matrix)

pbmc68k.matrix <- list(matrix = cT.matrix, center = centers, scale = scales)
save(pbmc68k.matrix, file = "objects/pbmc68k.matrix.rda")

library(Matrix)
cT.sparseMatrix <- as(cT.matrix, "sparseMatrix")

pbmc68k.sparseMatrix <- list(matrix = cT.sparseMatrix, center = centers, scale = scales)
save(pbmc68k.sparseMatrix, file = "objects/pbmc68k.sparseMatrix.rda")
