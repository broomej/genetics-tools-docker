FROM snakemake/snakemake:stable
ENV CONDA_PKGS="bioconda::bioconductor-genesis conda-forge::r-tidyverse \
    conda-forge::r-ggally bioconda::plink bioconda::plink2 bioconda::vcftools \
    bioconda::bcftools"
RUN eval "$(micromamba shell hook --shell bash)" && \
    micromamba activate /opt/conda/envs/snakemake && \
    micromamba install bioconda::snakemake-minimal=9.14.1 && \
    micromamba install ${CONDA_PKGS} && \
    micromamba clean --all -y
