<h2>This image contains</h2>
<ul><li>Rstudio</li>
<li>Seurat3</li>
<li>Various packages (check the docker file for more infos)</li></ul>



<h3>1- Get the docker image</h3>

<b> You can 
<ul><li>Use our docker image</b></li>

#####   Download the image

<pre><code>wget https://zenodo.org/record/4114854/files/seurat301.tar?download=1 -o $WORKING_DIR/Images/docker/dpotier_B-ALL-CAR-T_seurat/seurat301.tar</pre></code>

#####   Load the image
<pre><code>docker load < seurat301.tar</pre></code>
</ul>
<b>OR 
<ul><li>use the docker file to produce your own with the following steps : </b></li>

#####   Compile the image
For this step you will also need a userconf.sh file. An exemple that you can adapt is given in this directory.
<pre><code>docker build -t seurat301 <WORKING_DIR>/Images/Docker/dpotier_B-ALL-CAR-T_seurat</pre></code>

#####   Save the image
<pre><code>docker save seurat301 ><WORKING_DIR>/B-ALL-CAR-T/Images/Docker/dpotier_B-ALL-CAR-T_seurat/seurat301.tar</pre></code>
</ul>


<h3>2- RUN THE IMAGE</h3>


<pre><code>docker run -d --name seurat301 -p 8787:8787 -v $WORKING_DIR/:$WORKING_DIR/ -e USER=$(whoami) -e USERID=$(id -u) -e GROUPID=$(id -g) seurat301</pre></code>







