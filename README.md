(view the versioned images on [Docker Hub](https://hub.docker.com/repository/docker/broome/genetics-tools/))

# Genetics tools Docker image

This image includes common tools for manipulating/QCing common formats of
genetic data, and relatedness (GRM/kinship matrices) and ancestry (PC)
estimation. Images are built and pushed when the base image is updated.

## Included software

* PLINK v1.9 and v2.0
* VCFtools
* BCFtools
* R packages
    * GENESIS and dependencies (gdsfmt, SeqArray, SeqVarTools, etc.)
    * Tidyverse packages (dplyr, tidyr, ggplot2, etc.) and GGally
    * plinkFile
* Snakemake

All software is installed with micromamba except `plinkFile`. See the Dockerfile
for which repositories specific packages are installed from.

## Usage

The primary use-case for this image, and the reason it uses
`snakemake/snakemake` as its base image, is to be invoked from a Snakemake
workflow. Add the line

```sh
container: "docker://broome/genetics-tools"
```

near the top of your snakefile (to run all rules in this environment), or within
a rule definition (to run only for a specific rule); and use the
`--use-apptainer` flag when invoking snakemake.

You can also do `docker run broome/genetics-tools`. Refer to the docker
documentation for executing a specific command or script with `docker run`.

## Building and versioning

This image inherits the `<MAJOR>.<MINOR>.<PATCH>` version from the
`snakemake/snakemake` base image. Additionally,

* versions of this image are appended with `.<RELEASE>`. The first release will
  be appended with `.0` e.g. `v9.14.5.0`, the first update will be tagged with
  `v9.14.5.1`, etc.
* The most up-to-date versions of this image will also be tagged with the
  corresponding major, minor and patch versions, and `stable` and `latest`, e.g.
  `v9.14.5.1` from the previous examplewould also be tagged `stable`, `latest`,
  `v9.14.5`, `v9.14` and `v9`.
  * Image `v9.13.7` also still has the tag `v9.13` as it was the last image
  built from a `v9.13` image.

_If your analysis requires a stable and persistent environment, **only refer to the**_
`<MAJOR>.<MINOR>.<PATCH>.<RELEASE>` _**tags**_. These are the only tags that
will persistently point to a specific image.

Images are built automatically via GitHub Actions when a new version of
`snakemake/snakemake` is released, to ensure up-to-date images and images with
each version of Snakemake are available and so the provenance of the images is
verifiable. See
[logs from the GitHub repo](https://github.com/broomej/genetics-tools-docker/actions)
to verify, or build your own image with

```
git clone git@github.com:broomej/genetics-tools-docker.git
cd genetics-tools-dockers
docker build -t genetics-tools:local .
```

## A note on the image size

Snakemake requires a lot of dependencies, and the base image is > 900MB as of
this writing. This image adds additional software and dependencies and is around
1.6GB.

I had started to build smaller, application-focused images with just PLINK,
VCFTools or BCFTools, but my workflow requires Snakemake to be installed inside
of the container. That meant I had four > 1GB images instead of one 1.6GB image.
If these smaller containers would be useful for you, or have ideas about how
to keep the image size down, open an
[issue in the GitHub repo](https://github.com/broomej/genetics-tools-docker/issues).
