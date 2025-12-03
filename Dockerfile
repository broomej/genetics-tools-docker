FROM greyltc/archlinux-aur:latest
USER root
RUN pacman -Syu --noconfirm && aur-install plink plink1.9-git plink2-mkl-git snakemake vcftools bcftools
