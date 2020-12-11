<h2>This image contains</h2>
<ul><li>CaSpER</li>
<li>Seurat3.1.5</li>
<li>Rstudio</li>
<li>Various packages</li></ul>



<h3>1- Get the docker image</h3>

<b> You can 
<ul><li>Use our docker image</b></li>

#####   Download the image

<i>https://zenodo.org/record/4114854/files/casperseurat315.tar?download=1</i>
<pre><code>wget https://zenodo.org/record/4114854/files/casperseurat315.tar?download=1 -o $WORKING_DIR/Images/docker/dpotier_B-ALL-CAR-T_casper/CaSpER/casperseurat315.tar</pre></code>

#####   Load the image
<pre><code>docker load < casperseurat315.tar</pre></code>
</ul>
<b>OR 
<ul><li>use the docker file to produce your own with the following steps : </b></li>

#####   Compile the image
<pre><code>docker build -t casperseurat315 <WORKING_DIR>/B-ALL-CAR-T/Images/Docker/dpotier_B-ALL-CAR-T_casper</pre></code>

#####   Save the image
<pre><code>docker save casperseurat315 ><WORKING_DIR>/B-ALL-CAR-T/Images/Docker/dpotier_B-ALL-CAR-T_casper/casperseurat315.tar</pre></code>
</ul>

<h3>2- RUN THE IMAGE</h3>

<pre><code>docker run -d --name casperseurat315 -p 8787:8787 -v $WORKING_DIR/:$WORKING_DIR/ -e USER=$(whoami) -e USERID=$(id -u) -e GROUPID=$(id -g) -e PASSWORD=chooseYourOwnPWD casperseurat315</pre></code>




