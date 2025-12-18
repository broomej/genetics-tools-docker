FROM snakemake/snakemake:v9.14.6
ENV CONDA_PKGS="bioconda::bioconductor-genesis conda-forge::r-tidyverse \
    conda-forge::r-ggally bioconda::plink bioconda::plink2 bioconda::vcftools \
    bioconda::bcftools"
RUN eval "$(micromamba shell hook --shell bash)" && \
    micromamba activate /opt/conda/envs/snakemake && \
    micromamba install ${CONDA_PKGS} && \
    micromamba clean --all -y
