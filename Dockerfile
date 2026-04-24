FROM snakemake/snakemake:v9.14.6
ENV CONDA_PKGS="r::r bioconda::plink bioconda::plink2 bioconda::vcftools \
    bioconda::bcftools"
RUN eval "$(micromamba shell hook --shell bash)" && \
    micromamba activate /opt/conda/envs/snakemake && \
    micromamba install ${CONDA_PKGS} && \
    micromamba clean --all -y && \
    Rscript -e "install.packages(c('plinkFile', 'tidyverse', 'BiocManager'), repos='http://cran.r-project.org')" && \
    Rscript -e "BiocManager::install('GENESIS')"
