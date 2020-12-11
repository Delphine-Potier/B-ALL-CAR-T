# B-ALL-CAR-T

Single-cell profiling identifies pre-existing CD19-negative subclones in a B-ALL patient with CD19-negative relapse after CAR-T therapy


Authors: Tracy Rabilloud†, Delphine Potier†, Saran Pankaew, Mathis Nozais, Marie
Loosveld\*, Dominique Payet-Bornet\*

†These authors contributed equally ; \* Corresponding authors



link to the article (to come)

## Overview

This repository contains the instructions and material to reproduce the analysis reported in the article. 
Source code is available in the github repository. 
Required data and builded Docker/singularity images are available respectively in SRA/GEO and Zenodo. 
Intructions to reproduce the analysis are provided in the different subdirectories:
<ul>
<li>Fastq preprocessing is described in the "fastq_pre-processing" directory</li>
<li>Seurat analysis is described in the "Seurat_analysis" directory</li>
<li>SCENIC analysis is described in the "SCENIC_analysis" directory</li>
<li>CaSpER analysis is described in the "CaSpER_analysis" directory</li>
</ul>

## Data availability

### Fastq preprocessing

<ul>
<li> 4 fastq files are available in SRA under the accession ID SRP269742:
	<ul>
		<li> 2 fastq files containing paired-end reads sequenced from the mRNA library</li>
		<li> 2 fastq files containing paired-end reads sequenced from the HTO library</li></li>
	</ul>
<li> Cellranger output and CITE-seq-count output that can be load in seurat are available in GEO (GSE153697) respectively under accession number GSM4649255 and GSM4649254 : 
    <ul>    
        <li>https://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSM4649255</li>
        <li>https://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSM4649254</li>
    </ul>
</li>
</ul>

### Seurat analysis

<ul>
<li> Filtered expression matrices (raw and normalized) as well as metadata are available in GEO (GSE153697) : 
        <ul><li>https://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE153697</li></ul>
</li>
<li> Seurat html report containing figures generated in R from article can be download here : 
        <ul><li> https://github.com/Delphine-Potier/B-ALL-CAR-T/blob/master/1_Seurat_analysis/analysis/analysis_CarT_paper_V2.html </li>
        and the Rmd script used to produce it can be seen here : 
        <li>https://github.com/Delphine-Potier/B-ALL-CAR-T/blob/master/1_Seurat_analysis/scripts/analysis_CarT_paper_V2.Rmd</li></ul>
</li>
</ul>

### SCENIC analysis

<li> SCENIC analysis output is available here : https://zenodo.org/record/4114854/files/SCENIC_output.tar.gz?download=1 </li>
<li> The ipython notebook to reproduce the analysis is available here : https://github.com/Delphine-Potier/B-ALL-CAR-T/tree/master/2_SCENIC_analysis/script </li>
<li> The docker container with all tools is available here : https://zenodo.org/record/4114854/files/jupyscenic2.tar?download=1</li>
<li> Explanations to reproduce the analysis are given here : https://github.com/Delphine-Potier/B-ALL-CAR-T/tree/master/2_SCENIC_analysis/</li>

### CASPER analysis

<li> CASPER analysis output is available here : https://zenodo.org/record/4114854/files/final_CaSpER_object.Robj?download=1 </li>
<li> Full explanations to reproduce the analysis are given here : https://github.com/Delphine-Potier/B-ALL-CAR-T/tree/master/3_CaSpER_analysis</li>
<li> The Rmd script to reproduce the R part of analysis is available here : https://github.com/Delphine-Potier/B-ALL-CAR-T/tree/master/3_CaSpER_analysis/script </li>
<li> The docker container with all tools are available here : https://zenodo.org/record/4114854/files/BAFExtract.tar?download=1  and https://zenodo.org/record/4114854/files/casperseurat315.tar?download=1</li>


### Docker/Singularity images

<li> Singularity/Docker images are all availabe in Zenodo : https://doi.org/10.5281/zenodo.4114854</li>





