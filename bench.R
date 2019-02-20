library(BiocSingular)
library(TENxPBMCData)
library(irlba)
library(DelayedArray)
tenx <- TENxPBMCData("pbmc8k")

c.matrix <- as.matrix(counts(tenx))
wh <- which(rowSums(c.matrix) != 0)
c.matrix <- c.matrix[wh,]
cT.matrix <- t(c.matrix)

centers <- rowMeans(c.matrix)
scales <- rowSds(c.matrix)

cT.DA_memory <- DelayedArray(seed = cT.matrix)
cT.DA_HDF5 <- t(counts(tenx)[wh,]) # not completely fair because this has delayed operations (subsetting / transpose)

ipam <- IrlbaParam(tol=1e-5, extra.work=7)
system.time({
    pca1 <- prcomp_irlba(cT.matrix)
})  
##   user  system elapsed 
## 31.539   1.209   7.405 

system.time({
    pca2 <- runPCA(cT.matrix, rank = 3, BSPARAM = ipam, center = centers, scale = FALSE)
}) 
##   user  system elapsed 
## 30.442   0.606   5.247 

system.time({

profvis({    
    pca3 <- runPCA(cT.DA_memory, rank = 3, BSPARAM = ipam, center = centers, scale = FALSE)
}) 
 ##   user  system elapsed 
 ## 51.546  34.082  64.234 


system.time({
    pca4 <- runPCA(cT.DA_HDF5, rank = 3, BSPARAM = ipam)
}) 
##    user  system elapsed 
## 520.728  42.743 540.907 

