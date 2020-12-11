# B-ALL-CAR-T : fastq pre-processing

## Overview

This repository contains the instructions and material to reproduce fastq pre-processing reported in the article. 
Required data and Singularity images are respectively available in SRA and Zenodo. 
Intructions to reproduce the analysis are provided below.

To reproduce the analysis, you have to first, prepare the environments (see "Prerequisites" section below), then execute the analysis described in the "Run the analysis" section below.

<i><b>If you don't want to redo data pre-processing directly go to https://github.com/Delphine-Potier/B-ALL-CAR-T/tree/master/1_Seurat_analysis</b></i>

## Setup

### Prerequisites (Singularity system & images and data)

Singularity container images are available in zenodo : 
<li>CellRanger : https://zenodo.org/record/4114854/files/cellranger3.0.1.img?download=1</li>
<li>CITE-seq-Count : https://zenodo.org/record/4114854/files/citeseq-count1.4.3.img?download=1</li>

Raw fastq files are available in SRA (SRP269742) 

Transcriptome is available at 10xGenomics website (https://cf.10xgenomics.com/supp/cell-exp/refdata-cellranger-GRCh38-3.0.0.tar.gz) and in Zenodo (https://zenodo.org/record/4114854/files/refdata-cellranger-GRCh38-3.0.0.tar.gz?download=1)

<pre><code>
#Download the transcriptome files to the reference folder and unzip it
wget https://zenodo.org/record/4114854/files/refdata-cellranger-GRCh38-3.0.0.tar.gz?download=1 -o $WORKING_DIR/0_fastq_pre-processing/data/reference/
</pre></code>

<br>
In order to prepare the environment for analysis execution, it is required to:

<ul>
	<li> Clone the github repository and set the WORKING_DIR environment variable</li> 
	<li> Download the singularity images</li> 
		<ul>
			<li>CITE-seq-count singularity image : https://zenodo.org/record/4114854/files/citeseq-count1.4.3.img?download=1 (to use with HTO fastq files)</li> 
			<li>CellRanger singularity image : https://zenodo.org/record/4114854/files/cellranger3.0.1.img?download=1 (to use with mRNA fastq files)</li> 
		</ul>
	<li> Load the singularity image you need on your system</li> 
	<li> Download the 4 fastq files</li> 
</ul>

<h3>1) Clone the github repository</h3>
Use you favorite method to clone this repository in a chosen folder. This will create a "B-ALL-CAR-T" folder with all the source code. 

You must set an environment variable called WORKING_DIR with a value set to the path to this folder.
For instance, if I have chosen to clone the Git repository in "/home/dpotier/workspace", then the WORKING_DIR variable will be set to "/home/dpotier/workspace/B-ALL-CAR-T"

On linux:
<pre><code>export WORKING_DIR=/home/dpotier/workspace/B-ALL-CAR-T</pre></code>



<h3>2) Download the singularity images</h3>
Singularity images are stored on Zenodo. Open a shell command and change dir to the root of the cloned Git repository. Then execute the following commands to download the images tar files to the right project folder:

<pre><code>wget https://zenodo.org/record/4114854/files/citeseq-count1.4.3.img?download=1 -o $WORKING_DIR/singularity/image/dpotier_B-ALL-CAR-T_CITE-seq-count/citeseq-count1.4.3.img

wget https://zenodo.org/record/4114854/files/cellranger3.0.1.img?download=1 -o $WORKING_DIR/singularity/image/dpotier_B-ALL-CAR-T_Cellranger/cellranger3.0.1.img </pre></code>


<h3>3) Launch singularity image</h3>
Singularity must be installed on your system.
In order to execute analysis, you must first launch the singularity image you want to use (See below). 



<h3>4) Download the fastq files </h3>
Fastq files available on SRA (accession ID : GSE153697 / SRP269742) can be processed with CellRanger (mRNA-pool_24oct2019_S003546_L001_R1_001.fastq.gz; mRNA-pool_24oct2019_S003546_L001_R2_001.fastq.gz) or CITE-seq-count (HTO_pool_24oct2019_S003546_L001_R1_001.fastq.gz ; HTO_pool_24oct2019_S003546_L001_R2_001.fastq.gz).


## Run the analysis 
 
### Cellranger analysis

Output will be generated in the <WORKING_DIR>/0_fastq_pre-processing/output where <WORKING_DIR> is the folder where you clone the git repository (and set the WORKING_DIR environment variable).

<b>Input</b>

Fastq files are avaible in SRA (SRP269742).
Pre-processed data can be generated following detailed commands to run fastq preprocessing are given in the "0_fastq_pre-processing" directory or directly downloaded in GEO (accession ID : GSM4649255). 

<b>Output</b>

The ouput directory contains the classical cellranger output with the pre-processed data that is used later in the Seurat analysis and a hmtl report.
<ul>
    <li>mRNA count per cells : </li>
    <ul>
    <li>mRNA_barcodes.tsv.gz</li>
    <li>mRNA_features.tsv.gz</li>
    <li>mRNA_matrix.mtx.gz</li>
    </ul>
</ul>

<b>Execution</b>

To run the cellranger analysis, ensure you have correctly downloaded the fastq files in the folder <WORKING_DIR>/fatsq_pre-processing/data/ and run the following command:

<pre><code>
# Launch singularity image
singularity shell <WORKING_DIR>/B-ALL-CAR-T/singularity/image/dpotier_B-ALL-CAR-T_Cellranger/cellranger3.0.1.img

bash

# Go to the ouput directory
cd <WORKING_DIR>/B-ALL-CAR-T/0_fastq_pre-processing/output

#Run cellranger
/usr/local/share/cellranger/cellranger-3.0.1/cellranger count --id=B-ALL_CarT_GRCh38 --transcriptome=../data/cellranger_GRCh38/refdata-cellranger-GRCh38-3.0.0/  --fastq=../data/ --sample=mRNA-pool_24oct2019 --expect-cell=6000

</pre></code>

<b>Results</b>

Once the analysis done, you should get result files in the <WORKING_DIR>/B-ALL-CAR-T/0_fastq_pre-processing/output folder  (with the newly created "B-ALL_CarT_GRCh38" folder)



### CITE-seq-count analysis

Output will be generated in the <WORKING_DIR>/0_fastq_pre-processing/output where <WORKING_DIR> is the folder where you clone the git repository (and set the WORKING_DIR environment variable).

<b>Input</b>

Fastq files are avaible in SRA (SRP269742).
Pre-processed data can be generated following detailed commands to run fastq preprocessing are given in the "0_fastq_pre-processing" directory or directly downloaded in GEO (accession ID : GSM4649254). 


<b>Output</b>

The ouput directory contains:
<ul>
	<li>HTO count per cells :</li> 
	<ul>
		<li>HTO_barcodes.tsv.gz</li>
		<li>HTO_features.tsv.gz</li>
		<li>HTO_matrix.mtx.gz</li>
	</ul>
</ul>

<b>Execution</b>

To run the CITE-seq-count analysis, ensure you have correctly downloaded the fastq files in the folder <WORKING_DIR>/0_fastq_pre-processing/data/ and run the following command:

<pre><code># Get barcodes list from cell ranger. 
# this file is already present in the data directory, if you want to reproduce it use (else skip it) :
zcat <WORKING_DIR>/B-ALL-CAR-T/0_fastq_pre-processing/B-ALL_CarT_hg19/outs/raw_feature_bc_matrix/barcodes.tsv.gz ><WORKING_DIR>/B-ALL-CAR-T/0_fastq_pre-processing/data/barcodes_cellranger_nofilter_CarTCD19.tsv

# Go to the image directory 
cd <WORKING_DIR>/B-ALL-CAR-T/singularity/image/dpotier_B-ALL-CAR-T_CITE-seq-count/

# Start the image
singularity shell dpotier_B-ALL-CAR-T_CITEseq-count1.4.3.img

bash

# Go to the ouput directory
cd <WORKING_DIR>/B-ALL-CAR-T/0_fastq_pre-processing/output

# Run CITE-seq-count
CITE-seq-Count -R1 <WORKING_DIR>/B-ALL-CAR-T/0_fastq_pre-processing/data/HTO_pool_24oct2019_S003546_L001_R1_001.fastq.gz -R2 <WORKING_DIR>/B-ALL-CAR-T/0_fastq_pre-processing/data/HTO_pool_24oct2019_S003546_L001_R2_001.fastq.gz -t <WORKING_DIR>/B-ALL-CAR-T/0_fastq_pre-processing/data/Tag_HTO_CarTCD19.csv -cbf 1 -cbl 16 -umif 17 -umil 26 --max-errors 2 --whitelist <WORKING_DIR>/B-ALL-CAR-T/0_fastq_pre-processing/data/barcodes_cellranger_nofilter_CarTCD19.tsv -cell 40000 -T 12 -o CITE-seq-count143_output
</pre></code>

<b>Results</b>

Once the analysis done, you should get result files in the <WORKING_DIR>/B-ALL-CAR-T/0_fastq_pre-processing/output folder  (with the newly created "CITE-seq-count143_output" folder)


