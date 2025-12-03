FROM snakemake/snakemake:stable
ENV CONDA_PKGS bioconda::bioconductor-genesis conda-forge::r-tidyverse \
    conda-forge::r-ggally bioconda::plink bioconda::plink2 bioconda::vcftools \
    bioconda::bcftools
RUN micromamba install CONDA_PKGS && micromamba clean --all -y
