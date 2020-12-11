# B-ALL-CAR-T

## Output overview

### CaSpER part 1 (BAFExtract)


For each group of interest (cluster0, Cluster1, Clusters2345 and cluster0_T1CD19neg_only), part A) will produce:
<li>a file containing cell barcodes(.bc files)</li>
<li>a subset bam file (.bam files)</li>
<li>a subset bedgraph file (.bg files)</li>
<li>a pileup directory (containing .bin files for each chromosome) + one for the genome </li>
<li>a allele frequency file (.snp files)</li>




### CaSpER part 2 (CaSpER R analysis)


Once the analysis done, the results should be in you $WORKING_DIR/3_CaSpER_analysis/output/ folder.

It will contains 2 R CaSpER/Seurat objects  
<li>obj_CaSpER.Robj (can be downloaded here: https://zenodo.org/record/4114854/files/obj_CaSpER.Robj?download=1 )</li>
<li>final_CaSpER_object.Robj (can be downloaded here: https://zenodo.org/record/4114854/files/final_CaSpER_object.Robj?download=1 )</li>

An hmtl result file will also be produced (and is already present in the github output directory). 