<h2>This image contains cellranger 3.0.1</h2>

Once the image downloaded, if singularity is installed on your system you can directly use it

#####   Download the image

<pre><code>https://zenodo.org/record/4114854/files/cellranger3.0.1.img?download=1 -o $WORKING_DIR/singularity/image/dpotier_B-ALL-CAR-T_Cellranger/cellranger3.0.1.img</pre></code>

#####   Launch the image
<pre><code>singularity shell cellranger3.0.1.img</pre></code>
<pre><code>bash</pre></code>

You can run the analysis.


<i>If needed, the docker file used to produce this singularity image is present in this directory</i>
