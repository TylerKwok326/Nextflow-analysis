#!/usr/bin/env nextflow

process SAMTOOLS_FAIDX {
    label 'process_single'
    conda "${projectDir}/envs/samtools_env.yml"
    cache 'lenient'
    publishDir params.outdir
    

    input:
    tuple val(meta), path(fa)

    output:
    tuple val(meta), path(fa), path("*.fai")

    shell:
    """
    samtools faidx $fa
    """
}