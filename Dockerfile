FROM snakemake/snakemake:v9.14.6

# Package list
ENV CONDA_PKGS="r::r bioconda::plink bioconda::plink2 bioconda::vcftools \
    conda-forge::cmake==3.31 bioconda::bcftools conda-forge::gcc_linux-64 \
    conda-forge::zlib"

RUN eval "$(micromamba shell hook --shell bash)" && \
    micromamba activate /opt/conda/envs/snakemake && \
    micromamba install -y ${CONDA_PKGS} && \
    git clone https://github.com/statgen/METAL && cd METAL && \
    sed -i "s|<zlib.h>|\"$CONDA_PREFIX/include/zlib.h\"|g" libsrc/InputFile.h && \
    mkdir build && cd build && \
    cmake -DCMAKE_BUILD_TYPE=Release .. && \
    make && \
    make install && \
    mv bin/metal /usr/bin/ && \
    cd ../.. && rm -rf METAL && \
    Rscript -e "install.packages(c('tidyverse', 'plinkFile', 'BiocManager'), repos='http://cran.r-project.org')" && \
    Rscript -e "BiocManager::install('GENESIS')" && \
    micromamba remove cmake gcc_linux-64 && \
    micromamba clean --all -y
