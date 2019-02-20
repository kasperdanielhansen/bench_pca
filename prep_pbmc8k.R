library(TENxPBMCData)
tenx <- TENxPBMCData("pbmc8k")
c.matrix <- as.matrix(counts(tenx))
wh <- which(rowSums(c.matrix) != 0)
c.matrix <- c.matrix[wh,]

cT.matrix <- t(c.matrix)
centers <- rowMeans(c.matrix)
scales <- rowSds(c.matrix)

pbmc8k.matrix <- list(matrix = cT.matrix, center = centers, scale = scales)
save(pbmc8k.matrix, file = "objects/pbmc8k.matrix.rda")

library(Matrix)
cT.sparseMatrix <- as(cT.matrix, "sparseMatrix")

pbmc8k.sparseMatrix <- list(matrix = cT.sparseMatrix, center = centers, scale = scales)
save(pbmc8k.sparseMatrix, file = "objects/pbmc8k.sparseMatrix.rda")
