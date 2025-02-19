#!/usr/bin/env nextflow

process SAMTOOLS_FAIDX_SUBSET {
    label 'process_single'
    conda "${projectDir}/envs/samtools_env.yml"
    cache 'lenient'
    publishDir params.outdir, mode: 'copy'

    input:
    tuple val(name), path(fa), path(fai), path(region)


    output:
    tuple val(name), path('*region.subset.fna')
    val 'test'

    shell:
    """
    samtools faidx $fa -r $region > ${name}_region.subset.fna
    """
}