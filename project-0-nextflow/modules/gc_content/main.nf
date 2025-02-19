#!/usr/bin/env nextflow

process GC_CONTENT {
    conda "envs/biopython_env.yml"
    container "ghcr.io/bf528/biopython:latest"
    label 'process_single'
    publishDir params.outdir, mode: 'copy'
    cache 'lenient'

    input:
    tuple val(name), path(fa)

    output:
    path("*.txt")

    script:
    """
    genome_stats.py -i $fa -o ${name}_genome_stats.txt
    """

}