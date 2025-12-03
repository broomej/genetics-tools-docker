FROM greyltc/archlinux-aur:latest
USER root
RUN pacman -Syu --noconfirm && aur-install plink1.9-git snakemake vcftools bcftools
