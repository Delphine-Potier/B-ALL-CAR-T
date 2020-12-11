# B-ALL-CAR-T : Seurat analysis

## Overview

This repository describes how the scRNAseq data Seurat analysis was performed. 
It contains the instructions and material to reproduce the analysis reported in the article (and more). 
<br>Source code is available in the github repository (https://github.com/Delphine-Potier/B-ALL-CAR-T/tree/master/1_Seurat_analysis/scripts). 
<br>Required data and builded Docker images are available in SRA/GEO and Zenodo. 
Intructions to reproduce the analysis are provided below.

To reproduce the analysis, you have to first, prepare the environments (see "Prerequisites" section below), then execute the analysis as explained in the "Run the analysis" section below.

## Setup

### Prerequisites (Docker system & containers and data)

Docker container image is available on zenodo : https://zenodo.org/record/4114854/files/seurat301.tar?download=1<br>
Pre-processed data is available in github and GEO (GSE153697) : https://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE153697 <br>
Analysis html output file is available on github : https://github.com/Delphine-Potier/B-ALL-CAR-T/blob/master/1_Seurat_analysis/output/analysis_CarT_paper.html <br>


In order to prepare the environment for analysis execution, it is required to:

<ul>
	<li> Clone the github repository and set the WORKING_DIR environment variable</li> 
	<li> Download the RStudio / Seurat docker image tar file</li> 
	<li> Load the docker image on your system</li> 
	<li> Download Cellranger and CITE-seq-count results (available in GEO : GSE153697) or pre-processed fastq data</li> 
</ul>

<h2>1) Clone the github repository</h2>
Use your favorite method to clone this repository in a chosen folder. This will create a "B-ALL-CAR-T" folder with all the source code. You must set an environment variable called WORKING_DIR with a value set to the path to this folder.

For instance, if I have chosen to clone the Git repository in "/home/potierd/workspace", then the WORKING_DIR variable will be set to "/home/potierd/workspace/B-ALL-CAR-T"

On linux:
<pre><code>export WORKING_DIR=/home/potierd/workspace/B-ALL-CAR-T</pre></code>



<h2>2) Download the docker images</h2>
Docker image tar file is stored on Zenodo. Open a shell command and change dir to the root of the cloned Git repository. Then execute the following commands to download the images tar files to the right project folder:

<pre><code>wget https://zenodo.org/record/4114854/files/seurat301.tar?download=1 -o $WORKING_DIR/Images/docker/dpotier_B-ALL-CAR-T_seurat/seurat301.tar</pre></code>

<h2>Load docker images</h2>
In order to execute analysis, you must load the provided docker images onto your Docker. Docker must be installed on your system. See https://docs.docker.com/install/ for details on Docker installation. Open a shell command, change dir to the folder in which you cloned the project and type:

<pre><code>docker load -i $WORKING_DIR/Images/docker/dpotier_B-ALL-CAR-T_seurat/seurat301.tar</pre></code>

Those commands may take some time. 

<h2>Get the pre-processed data</h2>
The pre-processed data is already in github directory you cloned, alternatively, you can:<br>
Download or produce the pre-processed data (CellRanger / CITE-seq-count results) <br>
Pre-processed data (CellRanger / CITE-seq-count results) are available on GEO (accession ID : GSE153697): <br>
    - https://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSM4649255
    - https://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSM4649254
<ul>
	<li>mRNA count per cells : </li>
	<ul>
		<li>mRNA_barcodes.tsv.gz</li>
		<li>mRNA_features.tsv.gz</li>
		<li>mRNA_matrix.mtx.gz</li>
	</ul>
	<li>HTO count per cells :</li> 
	<ul>
		<li>HTO_barcodes.tsv.gz</li>
		<li>HTO_features.tsv.gz</li>
		<li>HTO_matrix.mtx.gz</li>
	</ul>
</ul>
If you prefer to perform the fastq data pre-processing, instructions are described in https://github.com/Delphine-Potier/B-ALL-CAR-T/tree/master/fastq_pre-processing. <br>


### Run the R/Seurat analysis  

Analysis can be directly run inside docker containers by compiling Rmarkdown files. The Rmarkdown file compilation will launch the required analysis for the step and produce a final HTML report.

An already generated report is available in the <WORKING_DIR>/1-Seurat_analysis/output.

<b>Input</b>

Pre-processed data is already in github. Alternatively, it can be generated following detailed commands to run fastq preprocessing are given in the "fastq_pre-processing" directory or directly downloaded in GEO (accession ID : GSE153697). 
<ul>
	<li>mRNA count per cells : </li>
	<ul>
		<li>mRNA_barcodes.tsv.gz</li>
		<li>mRNA_features.tsv.gz</li>
		<li>mRNA_matrix.mtx.gz</li>
	</ul>
	<li>HTO count per cells :</li> 
	<ul>
		<li>HTO_barcodes.tsv.gz</li>
		<li>HTO_features.tsv.gz</li>
		<li>HTO_matrix.mtx.gz</li>
	</ul>
</ul>

If downloaded or generated (need to copy or move files in the directories listed below), mRNA and HTO files have to be in separated directories as following:
<ul>
	<li> <WORKING_DIR>/1_Seurat_analysis/data/HTO/barcodes.tsv.gz</li>
	<li> <WORKING_DIR>/1_Seurat_analysis/data/HTO/features.tsv.gz</li>
	<li> <WORKING_DIR>/1_Seurat_analysis/data/HTO/matrix.mtx.gz</li>
	<li> <WORKING_DIR>/1_Seurat_analysis/data/mRNA/barcodes.tsv.gz</li>
	<li> <WORKING_DIR>/1_Seurat_analysis/data/mRNA/features.tsv.gz</li>
	<li> <WORKING_DIR>/1_Seurat_analysis/data/mRNA/matrix.mtx.gz</li>
</ul>

SCENIC output needed (auc_mtx.csv) to get all figures in the Seurat analysis is present in github and is already in the cloned directory but can also be produced following the detailed commands given in "SCENIC_analysis" directory.

Rmd script to run :
<WORKING_DIR>/1_Seurat_analysis/scripts/Seurat_analysis_B-ALL-CAR-T.Rmd


<b>Output</b>

After running the analysis, the ouput directory will contain:
<ul>
	<li> An html report of the analysis</li>
	<li> 2 Seurat objects (intermediate and final) :  Seurat_clean-subset_BALL-CART.Robj and Seurat_final_BALL-CART.Robj</li>
	<li> Some DEG analysis result csv files and save objects : Their names always start by FindMarkers (or FindAllMarkers) followed by an explicit naming of the comparison made (e.g. FindMarkers_T1-CD19p_vs_T1-CD19n_subset-tum_BALL-CART.csv)</li>
	<li> 2 mRNA expression matrices : raw and normalized UMI counts, GSE153697_filtered_raw_expression_matrix.tsv and GSE153697_filtered_normalized_expression_matrix.tsv that can later be used by SCENIC</li>
	<li> metadata informations : GSE153697_filtered_metadata_matrix.tsv</li>
</ul>



<b>Execution</b>

To run the Seurat analysis, ensure you have correctly downloaded the pre-processed data in the folder <WORKING_DIR>/1-Seurat_analysis/data/mRNA and <WORKING_DIR>/1-Seurat_analysis/data/HTO. 

To run all at once use the following command:

<pre><code>docker run -v $WORKING_DIR:$WORKING_DIR -e WORKING_DIR=$WORKING_DIR dpotier_B-ALL-CAR-T_seurat R -e 'WORKING_DIR=Sys.getenv( "WORKING_DIR");rmarkdown::render( input=file.path( WORKING_DIR, "1-Seurat_analysis/scripts/Seurat_analysis_B-ALL-CAR-T.Rmd"), output_dir = file.path( WORKING_DIR, "1-Seurat_analysis/analysis/output"), output_file = "my_report.html", quiet=FALSE)'</pre></code>

To get into the RStudio environnement and run the analysis yourself use the following command:

<pre><code>docker run -v $WORKING_DIR:$WORKING_DIR -e WORKING_DIR=$WORKING_DIR dpotier_B-ALL-CAR-T_seurat R -e 'WORKING_DIR=Sys.getenv("WORKING_DIR")'</pre></code>


<b>Results</b>

Once the analysis done, the results should be in you WORKING_DIR/1_Seurat_analysis/output/ folder.


