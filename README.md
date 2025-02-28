[![Edwards Lab](https://img.shields.io/badge/Bioinformatics-EdwardsLab-03A9F4)](https://edwards.flinders.edu.au)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
![GitHub language count](https://img.shields.io/github/languages/count/npbhavya/baczy)
[![](https://img.shields.io/static/v1?label=CLI&message=Snaketool&color=blueviolet)](https://github.com/beardymcjohnface/Snaketool)
![GitHub last commit (branch)](https://img.shields.io/github/last-commit/npbhavya/baczy)
[![CI](https://github.com/npbhavya/baczy/actions/workflows/testing.yml/badge.svg)](https://github.com/npbhavya/baczy/actions/workflows/testing.yml)

[![install with pip](https://img.shields.io/static/v1?label=Install%20with&message=PIP&color=success)](https://pypi.org/project/baczy/)
[![Pip Downloads](https://static.pepy.tech/badge/baczy)](https://www.pepy.tech/projects/baczy)
[![install with bioconda](https://img.shields.io/badge/install%20with-bioconda-brightgreen.svg?style=flat)](http://bioconda.github.io/recipes/baczy/README.html)
[![Bioconda Downloads](https://img.shields.io/conda/dn/bioconda/baczy)](https://img.shields.io/conda/dn/bioconda/baczy)

# Baczy
<p align="center">
  <img src="baczy.png#gh-light-mode-only" width="300">
  <img src="baczy.png#gh-dark-mode-only" width="300">
</p>

## Overview

**Baczy** is a **Snakemake-based workflow** for **assembling and annotating bacterial host genomes**. It extends **[Sphae](https://github.com/linsalrob/sphae)**, which assembles and annotates phage genomes, by enabling host genome assembly and functional annotation. 

🔹 **Features:**  
✔ **Quality control** ([Fastp](https://github.com/OpenGene/fastp))  
✔ **Genome assembly** ([MEGAHIT](https://github.com/voutcn/megahit), [Hybracter](https://github.com/gbouras13/hybracter))  
✔ **Functional annotation** ([Bakta](https://github.com/oschwengers/bakta))  
✔ **Taxonomic classification** ([GTDB-Tk](https://github.com/Ecogenomics/GTDBTk))  
✔ **Taxonomic tree** ([GTDB-Tk](https://github.com/Ecogenomics/GTDBTk)) 
✔ **Defense & resistance profiling** ([Defense-Finder](https://github.com/mdmparis/defense-finder), [AMRFinderPlus](https://github.com/ncbi/amr), [CapsuleDB](https://research.pasteur.fr/en/tool/capsulefinder/))  
✔ **Prophage detection** ([PhiSpy](https://github.com/linsalrob/PhiSpy))  
✔ **Pan-genome analysis** ([Panaroo](https://github.com/gtonkinhill/panaroo))  

## Installion

### Prerequisites installation 
- Install singularity or load the module
    On deepthought cluster \
    `module load apptainer`

- Install miniconda
    Download and install Miniconda:
    [Miniconda Installation Guide](https://docs.anaconda.com/miniconda/install/)

### Steps for installing workflow 

**Setting up a conda environment**

  ```bash
  conda create -n baczy python=3.12
  conda activate baczy
  ```
Using one of the methods below baczy can be downloaded within this environment

**Option 1: Source Installation**

  ```bash
  #clone repository
  git clone https://github.com/npbhavya/baczy.git

  #move to sphae folder
  cd baczy

  #install
  pip install -e .

  #confirm the workflow is installed by running the below command 
  baczy --help
  ```
**Option 2: Pip installation**
Note: This installation doesnt include singualrity/docker, so that has to be downloaded separately.

  ```bash

  pip install baczy

  ```
**Option 3:Conda installation**
  Note: This is currently not working - fixing this with the next version. Until then, use `pip install`
  
  ```bash
  mamba install bioconda::baczy
  ```

## Database setup

Download and place the required databases to a directory:

  - [CheckM2_database](https://github.com/chklovski/CheckM2?tab=readme-ov-file#database)
  - [GTDBTK database](https://ecogenomics.github.io/GTDBTk/installing/index.html)
  - [Capsuledb](https://gitlab.pasteur.fr/gem/capsuledb/-/tree/master/CapsuleFinder_models?ref_type=heads)

Set the databases path to variable `$BACZY_DATABASE_PATH`

  `export $BACZY_DATABASE_PATH=/home/user/database`

  Update the path `/home/user/database` to the correct database directory path 
  
## Running the workflow

Run Baczy using a single command!

**Before starting the run**
The taxonomic tree is generated using [GTDB-Tk](https://github.com/Ecogenomics/GTDBTk), so update the lines 
  
  ```
  gtdbtk:
    outgroup: "d__Archaea"
    taxa_filter: "d__Bacteria"
  ```

This can be set to more specific genera: 
  
  ```
  gtdbtk:
    outgroup: "g__Escherichia"
    taxa_filter: "g__Achromobacter"
  ```

**For paired end reads**

  ```
  baczy run --input sample-data/illumina --cores 32 --use-singularity --sdm apptainer --output test -k --use-conda
  ```

**For long reads**

  ```
  baczy run --input sample-data/nanopore --sequencing longread --cores 32 -k --use-singularity --sdm apptainer --output test -k --use-conda
  ```
### Intermediate files 
Stored in:


  `baczy.out/PROCESSING`

### Final Results and Output
Stored in `RESULT-short` for short reads or `RESULTS-long` for long reads

Each folder contains:
  - **{sample} folder**
    - {sample}_amrfinderplus table: identified AMR genes in the genome
    - {sample}_contigs.fa or {sample}_final.fasta : assembled genomes for each genome
    - {sample}.faa : identified proteins
    - {sample}.fna : identified genes
    - {sample}.gbff
    - {sample}.gff3
    - {sample}.png and {sample}.svg : genome visualized
    - {sample}.txt: summary 
    - {sample}_prophage_coordinates.tsv: location of the identified prophages using Phispy
  - **amrfinder_summary.tsv** : a table with all the AMRFinder genes in all the samples
  - **bakta_summary.tsv** : Bakta summary for all the samples saved to one table
  - **checkm2_quality_report.tsv** : Checkm2 completenes results
  - **defensefinder_summary.tsv** : All the defense systems found in all the samples 
  - **gtdbtk.ba120_summary.tsv** : GTDBTK summary with the predicted taxa for each of the samples
  - **gtdbtk.bac120.decorated.tree** , *gtdbtk.bac120.tree.table* : GTDBTK tree and the tree table
    - visualize the tree on iTOL
  - **prophage_regions.tsv** : Location of the prophage regions in al the samples
  - **Panaroo folder**
    - output from running [panaroo](https://github.com/gtonkinhill/panaroo)  
