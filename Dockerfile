FROM snakemake/snakemake:v9.13.7
ENV CONDA_PKGS="bioconda::bioconductor-genesis conda-forge::r-tidyverse \
    conda-forge::r-ggally bioconda::plink bioconda::plink2 bioconda::vcftools \
    bioconda::bcftools"
RUN eval "$(micromamba shell hook --shell bash)" && \
    micromamba activate /opt/conda/envs/snakemake && \
    micromamba install ${CONDA_PKGS} && \
    micromamba clean --all -y && \
    Rscript -e "install.packages('plinkFile', repos='http://cran.r-project.org')"
