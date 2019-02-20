# bench_pca

Benchmarking (single-cell) PCA using the Bioconductor stack: BiocSingular -> DelayedArray -> HDF5 file.

Goal: we aim to do some exhaustive benchmark on the following data sets
- `pbmc8k` (small scRNA) - 8k cells
- `pbmc68k` (medium scRNA) - 68k cells, fits in memory
- the `brain` (large scRNA) - 1.3M neurons

Apart from benchmarking the `BiocSingular` pipeline, we will also do a number of custom, fast, implementations to get a lower bound on how well we can hope to do using our stack.

