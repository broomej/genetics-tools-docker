#! /usr/bin/env bash

mkdir /buildtmp && cd /buildtmp
# METAL
git clone https://github.com/statgen/METAL 
cd METAL 
sed -i "s|<zlib.h>|\"$CONDA_PREFIX/include/zlib.h\"|g" libsrc/InputFile.h 
mkdir build && cd build 
cmake -DCMAKE_BUILD_TYPE=Release .. 
make 
make install 
mv bin/metal /usr/bin/ 
cd ../.. && rm -rf METAL 

# Metasoft and ForestPMPlot
curl -O http://genetics.cs.ucla.edu/meta/repository/2.0.1/Metasoft.zip 
python3 -m zipfile -e Metasoft.zip /opt/Metasoft/ 
curl -O http://genetics.cs.ucla.edu/ForestPMPlot/repository/1.0.3/ForestPMPlot.zip 
python3 -m zipfile -e ForestPMPlot.zip tmp/ 
mv tmp/ForestPMPlot /opt/ForestPMPlot 

# Cleanup
micromamba remove cmake gcc_linux-64 
micromamba clean --all -y 
rm -rf /tmp/* /var/tmp/* 
find /opt/conda -type d -name __pycache__ -exec rm -rf {} + 2>/dev/null || true 
rm -rf /opt/conda/envs/snakemake/share/doc 
rm -rf /opt/conda/envs/snakemake/share/man
cd / && rm -rf /buildtmp
