#!/usr/bin/env nextflow

process JELLYFISH {
    label 'process_medium'
    conda "$projectDir/envs/jellyfish_env.yml"
    cache 'lenient'
    publishDir params.outdir, mode: 'copy'

    input:
    tuple val(name), path(fa), val(nmer)

    output:
    tuple val(name), path("${name}_${nmer}mer.stats")

    shell:
    """
    jellyfish count -s 100M -m $nmer -o kmer.jf $fa
    jellyfish stats kmer.jf > ${name}_${nmer}mer.stats
    """
}










