#!/usr/bin/env nextflow

process NCBI_DATASETS_CLI {
    label 'process_single'
    conda "$projectDir/envs/ncbidatasets_env.yml"
    container 'ghcr.io/bf528/ncbi_datasets_cli:latest'
    cache 'lenient'

    input:
    tuple val(name), val(GCF)

    output:
    tuple val(name), path('dataset/**/*.fna')

    shell:
    """
    datasets download genome accession $GCF --include genome
    unzip ncbi_dataset.zip -d dataset/
    """
}