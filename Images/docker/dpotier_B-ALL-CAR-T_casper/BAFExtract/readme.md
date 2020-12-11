<h2>This image contains</h2>
<ul><li>BAFExtract</li>
<li>Samtools 1.2</li>
<li>subset-bam_linux</li>
<li>bedtools-2.25.0</li>
<li>Various packages</li></ul>



<h3>1- Get the docker image</h3>

<b> You can 
<ul><li>Use our docker image</b></li>

#####   Download the image

<pre><code>wget https://zenodo.org/record/4114854/files/BAFExtract.tar?download=1 -o $WORKING_DIR/Images/docker/dpotier_B-ALL-CAR-T_casper/BAFExtract/BAFExtract.tar</pre></code>


#####   Load the image
<pre><code>docker load < BAFExtract.tar</pre></code>
</ul>
<b>OR 
<ul><li>use the docker file to produce your own with the following steps : </b></li>

#####   Compile the image
<pre><code>docker build -t bafextract <WORKING_DIR>/B-ALL-CAR-T/Images/Docker/dpotier_B-ALL-CAR-T_casper/BAFExtract</pre></code>

#####   Save the image
<pre><code>docker save bafextract ><WORKING_DIR>/B-ALL-CAR-T/Images/Docker/dpotier_B-ALL-CAR-T_casper/BAFExtract.tar</pre></code>
</ul>

<h3>2- RUN THE IMAGE</h3>

<pre><code>docker run -it -v $WORKING_DIR/:$WORKING_DIR/  -u $(id -u ${USER}):$(id -g ${USER}) bafextract</pre></code>




