FROM snakemake/snakemake:v9.14.6

COPY install_scripts/ /dockerbld/install_scripts/

# Package list
ENV CONDA_PKGS="r::r bioconda::plink bioconda::plink2 bioconda::vcftools \
    conda-forge::cmake==3.31 bioconda::bcftools conda-forge::gcc_linux-64 \
    conda-forge::zlib conda-forge::openjdk"

RUN eval "$(micromamba shell hook --shell bash)" && \
    micromamba activate /opt/conda/envs/snakemake && \
    micromamba install -y ${CONDA_PKGS} && \
    chmod +x /dockerbld/install_scripts/* && \
    /dockerbld/install_scripts/install.R && \
    /dockerbld/install_scripts/install.sh
