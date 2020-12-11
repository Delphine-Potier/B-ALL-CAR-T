# B-ALL-CAR-T : CaSpER analysis

The scripts ran to obtain Figure S2 are in the script folder.

## Overview

This repository contains the instruction to reproduce CaSpER analysis reported in the article.
Required data and builded Docker images are respectively available in GEO and Zenodo. 
Intructions to reproduce the analysis are provided below.

To reproduce the analysis, you have to first, prepare the environments (see "Prerequisites" section below), then execute the analysis step by step (see "Run the analysis" section below).

## Setup

### Prerequisites (Docker system & containers and data)

Docker container images are available in zenodo : https://doi.org/10.5281/zenodo.4114854

Robject containing the essential data for the analysis is available in zenodo or can be produced following instructions given here : https://github.com/Delphine-Potier/B-ALL-CAR-T/tree/master/1_Seurat_analysis/ 


In order to prepare the environment for analysis execution, it is required to:

<ul>
<li> Clone the github repository and set the WORKING_DIR environment variable</li> 
<li> Download the docker images tar file</li> 
<ul>
<li> BAFExtract/CaSpER docker images : https://zenodo.org/record/4114854/files/BAFExtract.tar?download=1 & https://zenodo.org/record/4114854/files/casperseurat315.tar?download=1</li>
</ul>
<li> Load the docker images on your system</li>  
<li> Get the Robject obtained after Seurat analysis and needed reference files available in Zenodo</li> 
</ul>

<b>1) Clone the github repository</b>

Use you favorite method to clone this repository in a chosen folder. This will create a "B-ALL-CAR-T" folder with all the source code. You must set an environment variable called WORKING_DIR with a value set to the path to this folder.

For instance, if I have chosen to clone the Git repository in "/home/potierd/workspace", then the WORKING_DIR variable will be set to "/home/potierd/workspace/B-ALL-CAR-T"

On linux:
<pre><code>export WORKING_DIR=/home/potierd/workspace/B-ALL-CAR-T</pre></code>



<b>2) Download the docker images</b>

Docker images tar files are stored on Zenodo. Open a shell command and change dir to the root of the cloned Git repository. Then execute the following commands to download the images tar files to the right project folder:


<pre><code>wget https://zenodo.org/record/4114854/files/BAFExtract.tar?download=1 -o $WORKING_DIR/Images/docker/dpotier_B-ALL-CAR-T_casper/BAFExtract/BAFExtract.tar</pre></code>

<pre><code>wget https://zenodo.org/record/4114854/files/casperseurat315.tar?download=1 -o $WORKING_DIR/Images/docker/dpotier_B-ALL-CAR-T_casper/CaSpER/casperseurat315.tar</pre></code>

<b>3) Load docker images</b>

In order to execute analysis, you must load the provided docker images onto your Docker. Docker must be installed on your system. See https://docs.docker.com/install/ for details on Docker installation. Open a shell command, change dir to the folder in which you cloned the project and type:

<pre><code>docker load -i $WORKING_DIR/Images/docker/dpotier_B-ALL-CAR-T_casper/BAFExtract/BAFExtract.tar</pre></code>
<pre><code>docker load -i $WORKING_DIR/Images/docker/dpotier_B-ALL-CAR-T_casper/CaSpER/casperseurat315.tar</pre></code>

Those commands may take some time. 

<b>4) Produce or download the seurat Robject from zenodo</b>

Seurat Robject is available in zenodo : https://zenodo.org/record/4114854/files/Seurat_final_BALL-CART.Robj?download=1

Alternatively, this seurat Robject can be produced following the Seurat analysis instructions (https://github.com/Delphine-Potier/B-ALL-CAR-T/tree/master/1_Seurat_analysis).

Other files need for the analysis are available in Zenodo : https://zenodo.org/record/4114854/files/refdata-cellranger-GRCh38-3.0.0.tar.gz?download=1
copy refdata-cellranger-GRCh38-3.0.0.tar.gz to $WORKING_DIR/0_fastq_pre-processing/data/reference/ and unzip.

<pre><code>wget https://zenodo.org/record/4114854/files/refdata-cellranger-GRCh38-3.0.0.tar.gz?download=1 -o $WORKING_DIR/0_fastq_pre-processing/data/reference/</pre></code>




## Run the CaSpER analysis 

CaSpER analysis needs 2 inputs (for more details see, https://rpubs.com/akdes/673120):
1- B-allele frequencies (BAF) from mapped sequenced reads
2- Normalized gene expression data


#### A) Generation of the allele-based frequency signal from RNA-Seq BAM files

##### Inputs
For part A) you will need the following input files :
<li>GSE153697_filtered_metadata_matrix.tsv (already present in github)</li>
<li>possorted_genome_bam.bam , from CellRanger output can be produced or download as explained above</li>
<li>cellranger_GRCh38.chrom.sizes (already present in github)</li>
<li>refdata-cellranger-GRCh38-3.0.0/fasta/genome.fa, the fasta file has to be downloaded from zenodo to the $WORKING_DIR/0_fastq_pre-processing/data/refdata-cellranger-GRCh38-3.0.0/fasta/genome.fa folder/file as explained above</li>

##### Exection
Get into the BAFExtract environnement to run the analysis using the following command:

<pre><code>docker run -it -v $WORKING_DIR:$WORKING_DIR -u $(id -u ${USER}):$(id -g ${USER}) bafextract</pre></code>

<u>Step 1 : Get cell subset specific bam files</u>

Get a cluster*.bc file for each studied group : cluster0 (T1 tumor); cluster1 (T2 tumor); clusters 2, 3, 4 and 5 (physiological cells); and a cluster0/T1CD19neg extra group to check the BAFs for this specific population

<pre><code>
cat $WORKING_DIR/3_CaSpER_analysis/data/GSE153697_filtered_metadata_matrix.tsv | awk '$3=='0' {print $1"-1"}'>$WORKING_DIR/3_CaSpER_analysis/data/cluster0.bc
cat $WORKING_DIR/3_CaSpER_analysis/data/GSE153697_filtered_metadata_matrix.tsv | awk '$3=='1' {print $1"-1"}'>$WORKING_DIR/3_CaSpER_analysis/data/cluster1.bc
cat $WORKING_DIR/3_CaSpER_analysis/data/GSE153697_filtered_metadata_matrix.tsv | awk '($3=='2' || $3=='3' ||  $3=='4' ||  $3=='5')  {print $1"-1"}'>$WORKING_DIR/3_CaSpER_analysis/data/clusters2345.bc</pre></code>


<i>NB</i> the $WORKING_DIR/3_CaSpER_analysis/data/GSE153697_filtered_metadata_matrix.tsv file is present in the github but can also be downloaded from GEO or produced following the 1_Seurat_analysis instructions.

<pre><code>for i in `ls $WORKING_DIR/3_CaSpER_analysis/cluster_subset/cluster*.bc | sed s/.*cluster/cluster/g`; do echo $i; opt/subset-bam_linux --bam $WORKING_DIR/0_fastq_pre-processing/output/B-ALL_CarT_GRCh38/outs/possorted_genome_bam.bam --cell-barcodes $WORKING_DIR/3_CaSpER_analysis/data/${i} --out-bam $WORKING_DIR/3_CaSpER_analysis/output/${i}_possorted_genome_bam.bam</pre></code>

<u>Step 2 : Generate bedgraph files for each subset</u>
<pre><code>for i in `ls $WORKING_DIR/3_CaSpER_analysis/cluster_subset/*bam.bam`; do bedtools2/bin/genomeCoverageBed -bga -ibam ${i}.bam -g $WORKING_DIR/3_CaSpER_analysis/data/cellranger_GRCh38.chrom.sizes >${i}.bg; done</pre></code>


<u>Step 3 : Create directories for each subset</u> 

<pre><code>mkdir $WORKING_DIR/3_CaSpER_analysis/output/cluster_subset/cluster0/
mkdir $WORKING_DIR/3_CaSpER_analysis/output/cluster_subset/cluster1/
mkdir $WORKING_DIR/3_CaSpER_analysis/output/cluster_subset/clusters2345/</pre></code>

<u>Step 4 : run BAFExtract</u>
First, produce the reference genome pileup

<pre><code>BAFExtract -preprocess_FASTA $WORKING_DIR/0_fastq_pre-processing/data/refdata-cellranger-GRCh38-3.0.0/fasta/genome.fa $WORKING_DIR/0_fastq_pre-processing/data/refdata-cellranger-GRCh38-3.0.0/genome_fasta_pileup/

cd $WORKING_DIR/0_fastq_pre-processing/data/refdata-cellranger-GRCh38-3.0.0/genome_fasta_pileup/

for i in *; do a=`echo ${i} | sed s/.dna.*REF//g`; mv "$i" "$a" ; done</pre></code>



Run the analysis

<pre><code>for i in `ls $WORKING_DIR/3_CaSpER_analysis/output/cluster_subset/*_possorted_genome_bam.bam | sed s/.*cluster_subset.//g | sed s/_possorted_genome_bam.bam//g `; do echo $i; samtools view $WORKING_DIR/3_CaSpER_analysis/output/cluster_subset/${i}_possorted_genome_bam.bam | opt/BAFExtract/bin/BAFExtract -generate_compressed_pileup_per_SAM stdin $WORKING_DIR/3_CaSpER_analysis/data/cellranger_GRCh38.chrom.sizes $WORKING_DIR/3_CaSpER_analysis/output/cluster_subset/${i}/ 50 0 ; /opt/BAFExtract/bin/BAFExtract -get_SNVs_per_pileup $WORKING_DIR/3_CaSpER_analysis/data/cellranger_GRCh38.chrom.sizes $WORKING_DIR/3_CaSpER_analysis/output/cluster_subset/${i}/ $WORKING_DIR/0_fastq_pre-processing/data/reference/refdata-cellranger-GRCh38-3.0.0/genome_fasta_pileup/ 20 4 0.1 $WORKING_DIR/3_CaSpER_analysis/output/cluster_subset/${i}_baf.snp</pre></code>



Warning : for the CaSpER R analysis, only the used .snp file should stay in the $WORKING_DIR/3_CaSpER_analysis/output/cluster_subset/ directory, please move cluster0_T1CD19neg_baf.snp file to /Other_BAF/ sub-directory as describe below.

<pre><code>mkdir $WORKING_DIR/3_CaSpER_analysis/output/cluster_subset/Other_BAF/
mv $WORKING_DIR/3_CaSpER_analysis/output/cluster_subset/cluster0_T1CD19neg_baf.snp $WORKING_DIR/3_CaSpER_analysis/output/cluster_subset/Other_BAF/cluster0_T1CD19neg_baf.snp
</pre></code>

If this step is not done, you'll get an error using the runCaSpER() function.

##### Ouputs
For each group of interest (cluster0, Cluster1, Clusters2345 and cluster0_T1CD19neg_only), part A) will produce:
<li>a file containing cell barcodes(.bc files)</li>
<li>a subset bam file (.bam files)</li>
<li>a subset bedgraph file (.bg files)</li>
<li>a pileup directory (containing .bin files for each chromosome) + one for the genome </li>
<li>a allele frequency file (.snp files)</li>



#### B) CaSpER R analysis

##### Inputs
For part A) you will need the following input files :
<li>The hg38_cytoband.rda file (already present in 3_CaSpER_analysis/data/ in github)</li>
<li>$WORKING_DIR/1_Seurat_analysis/output/Seurat_final_BALL-CART.Robj, from 1_Seurat_analysis output that can be produced or download as explained above</li>
<li>The genome annotation file : annotation_CaSpER.Robj (already present in 3_CaSpER_analysis/data/ in github)</li>
<li>The 4 baf.snp file produced above in part A) which are also already available in github</li>


##### Exection
To run all at once, use the following command:


<pre><code>docker run -v $WORKING_DIR:$WORKING_DIR -e WORKING_DIR=$WORKING_DIR dpotier_B-ALL-CAR-T_seurat R -e 'WORKING_DIR=Sys.getenv( "WORKING_DIR");rmarkdown::render( input=file.path( WORKING_DIR, "1-Seurat_analysis/scripts/Seurat_analysis_B-ALL-CAR-T.Rmd"), output_dir = file.path( WORKING_DIR, "1-Seurat_analysis/analysis/output"), output_file = "my_report.html", quiet=FALSE)'</pre></code>

OR

To get into the RStudio environnement and run the analysis described in script/CaSpER_analysis.Rmd yourself: 

1) use the following command
<pre><code>docker run -d --name seurat301casper -p 8787:8787 -v $WORKING_DIR:$WORKING_DIR -e USER=$(whoami) -e USERID=$(id -u) -e GROUPID=$(id -g) -e PASSWORD=ChooseYourOwnPwd seurat301casper</pre></code>

2) Go to  http://your.own.ip.adress:8787/ in your favorite browser (you can get it using ifconfig).

3) Use $(whoami) as login and the password you specified running Seurat docker ("ChooseYourOwnPwd").

4) Use the CaSpER_analysis.Rmd to run the analysis (https://github.com/Delphine-Potier/B-ALL-CAR-T/tree/master/3_CaSpER_analysis/CaSpER_analysis.Rmd).


##### Ouputs

Once the analysis done, the results should be in you $WORKING_DIR/3_CaSpER_analysis/output/ folder.
An hmtl, result file is already present in the github output directory. Produced CaSpER/Seurat R objects will also be saved to this folder.



