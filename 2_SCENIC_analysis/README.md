# B-ALL-CAR-T : SCENIC analysis

## Overview

This repository contains the instruction to reproduce SCENIC analysis reported in the article.
Required data and builded Docker images are respectively available in GEO and Zenodo. 
Intructions to reproduce the analysis are provided below.

To reproduce the analysis, you have to first, prepare the environments (see "Prerequisites" section below), then execute the analysis step by step (see "Run the analysis" section below).

## Setup

### Prerequisites (Docker system & containers and data)

Docker container image is available in zenodo : https://zenodo.org/record/4114854/files/jupyscenic2.tar?download=1

Raw count expression matrix file is available in GEO (GSE153697) : GSE153697_filtered_raw_expression_matrix.tsv.gz
https://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE153697


In order to prepare the environment for analysis execution, it is required to:

<ul>
	<li> Clone the github repository and set the WORKING_DIR environment variable</li> 
	<li> Download the docker images tar file</li> 
		<ul>
			<li>SCENIC docker image : https://zenodo.org/record/4114854/files/jupyscenic2.tar?download=1</li>
		</ul>
	<li> Load the docker images on your system</li> 
	<li> Download the raw expression matrix obtained after Seurat analysis</li> 
</ul>

<h2>1)Clone the github repository</h2>
Use you favorite method to clone this repository in a chosen folder. This will create a "B-ALL-CAR-T" folder with all the source code. You must set an environment variable called WORKING_DIR with a value set to the path to this folder.

For instance, if I have chosen to clone the Git repository in "/home/potierd/workspace", then the WORKING_DIR variable will be set to "/home/potierd/workspace/B-ALL-CAR-T"

On linux:
<pre><code>export WORKING_DIR=/home/potierd/workspace/B-ALL-CAR-T</pre></code>



<h2>2)Download the docker images</h2>
Docker images tar file are stored on Zenodo. Open a shell command and change dir to the root of the cloned Git repository. Then execute the following commands to download the images tar files to the right project folder:

<pre><code>wget https://zenodo.org/record/4114854/files/jupyscenic2.tar?download=1 -o $WORKING_DIR/Images/docker/dpotier_B-ALL-CAR-T_scenic/jupyscenic2.tar</pre></code>

<h2>Load docker images</h2>
In order to execute analysis, you must load the provided docker images onto your Docker. Docker must be installed on your system. See https://docs.docker.com/install/ for details on Docker installation. Open a shell command, change dir to the folder in which you cloned the project and type:

<pre><code>docker load -i $WORKING_DIR/Images/docker/dpotier_B-ALL-CAR-T_scenic/jupyscenic2.tar</pre></code>

Those commands may take some time. 

<h2>Download the raw expression matrix</h2>

Raw count expression matrix file is available in GEO (GSE153697) : GSE153697_filtered_raw_expression_matrix.tsv.gz 
Alternatively, this expression matrix can be produced following the Seurat_analysis instructions.


### Run the SCENIC analysis

The analysis will be performed in a jupyter notebook. The corresponding notebook is avalable here: 
https://github.com/Delphine-Potier/B-ALL-CAR-T/tree/master/2_SCENIC_analysis/script


<b>Input</b><br>
Input files have to be download to <WORKING_DIR>/2_SCENIC_analysis/data/
<ul>
	<li> Raw expression matrix file : GSE153697_filtered_raw_expression_matrix.tsv</li>
	<li> All other required files are available in aertslab github or resources
	<ul>
		<li> data/hg19-tss-centered-10kb-7species.mc9nr.feather !!1Gb (https://resources.aertslab.org/cistarget/databases/homo_sapiens/hg19/refseq_r45/mc9nr/gene_based/hg19-tss-centered-10kb-7species.mc9nr.feather)</li> 
		<li> data/motifs-v9-nr.hgnc-m0.001-o0.0.tbl ( https://resources.aertslab.org/cistarget/motif2tf/motifs-v9-nr.hgnc-m0.001-o0.0.tbl )</li> 
		<li> data/hs_hgnc_tfs.txt is already in this git (but can also be found here : https://github.com/aertslab/pySCENIC/blob/master/resources/hs_hgnc_tfs.txt)</li></li> 
	</ul>
</ul>

<br>
<b>Execution</b><br>
1) Run "jupyscenic2" docker container
<pre><code>docker run -d --name jupyscenic2 -p 8888:8888 -v $WORKING_DIR:/home/jovyan/work jupyscenic2</pre></code>
2) Use the "SCENIC_analysis.ipynb" jupyternotebook present in /B-ALL-CAR-T/2_SCENIC_analysis/script/ folder to reproduce the analysis
<br>
<br>
<b>Results</b><br>
Once the analysis done, you may obtain all the output files in <WORKING_DIR>/B-ALL-CAR-T/2_SCENIC_analysis/output directory.
<br>
<ul>
<li> regulons.p</li>
<li> motifs.csv</li>
<li> expr_mat.adjacencies.csv</li>
<li> regulons.tsv</li>
<li> auc_mtx.csv</li>
</ul>

auc_mtx.csv, is the only file used to make the supplementary figure 3.
