#!/usr/bin/env nextflow

process SAMTOOLS_IDX {
    label 'process_single'
    conda "${projectDir}/envs/samtools_env.yml"
    cache 'lenient'
    
    input:
    tuple val(meta), path(bam)

    output:
    tuple val(meta), path(bam), path("*.bai"), emit: index

    shell:
    """
    samtools index --threads $task.cpus $bam
    """
}