#!/usr/bin/env nextflow

process PROKKA {
    label 'process_single'
    conda "${projectDir}/envs/prokka_env.yml"
    //container 'staphb/prokka:1.14.6'
    cache 'lenient'
    publishDir params.outdir

    input:
    tuple val(name), path(fa)

    output:
    path("$name/")
    tuple val(name), path("**/*.gff"), emit: gff

    shell:
    """
    prokka --cpus 1 --outdir $name --prefix $name $fa
    """
}