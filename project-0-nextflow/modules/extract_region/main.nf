#!/usr/bin/env nextflow

process EXTRACT_REGION {
    conda "$projectDir/envs/biopython_env.yml"
    label 'process_single'
    publishDir params.outdir, mode: 'copy'
    cache 'lenient'

    input:
    tuple val(name), path(gff)

    output:
    tuple val(name), path("*.txt")

    script:
    """
    extract_region.py -i $gff -o region_of_interest.txt
    """

}