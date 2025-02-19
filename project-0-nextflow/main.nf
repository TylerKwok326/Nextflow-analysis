include {PROKKA} from './modules/prokka/'
include {GC_CONTENT} from './modules/gc_content'
include {SAMTOOLS_FAIDX} from './modules/samtools_faidx'
include {SAMTOOLS_FAIDX_SUBSET} from './modules/samtools_faidx_subset'
include {NCBI_DATASETS_CLI} from './modules/ncbi_datasets_cli'
include {EXTRACT_REGION} from './modules/extract_region'
include {JELLYFISH} from './modules/jellyfish'

workflow {

   Channel.fromPath(params.samplesheet)
    | splitCsv(header: true)
    | map { row -> tuple(row.name, row.assembly) }
    | set{ download_ch }

    NCBI_DATASETS_CLI(download_ch)

    PROKKA(NCBI_DATASETS_CLI.out)
    GC_CONTENT(NCBI_DATASETS_CLI.out)
    SAMTOOLS_FAIDX(NCBI_DATASETS_CLI.out)
    
    kmer_range = channel.from(1..21)
    NCBI_DATASETS_CLI.out.combine(kmer_range)
    | set { kmer_ch }

    JELLYFISH(kmer_ch)

    EXTRACT_REGION(PROKKA.out.gff)
    
    SAMTOOLS_FAIDX.out.join(EXTRACT_REGION.out)
    | set{ subset_ch }

    SAMTOOLS_FAIDX_SUBSET(subset_ch)



}
   
   
   
