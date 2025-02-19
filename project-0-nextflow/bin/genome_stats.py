#!/usr/bin/env python

# You can refer to the help manual by `python genome_stats.py -h`

# argparse is a library that allows you to make user-friendly command line interfaces
import argparse

# here we are initializing the argparse object that we will modify
parser = argparse.ArgumentParser()

# we are asking argparse to require a -i or --input flag on the command line when this
# script is invoked. It will store it in the "filenames" attribute of the object
# we will be passing it via snakemake, a list of all the outputs of verse so we can
# concatenate them into a single matrix using pandas 

parser.add_argument("-i", "--input", help='a FASTA file containing a genomic sequence', dest="input", required=True)
parser.add_argument("-o", "--output", help='The output file where we will write our statistics', dest="output", required=True)

# this method will run the parser and input the data into the namespace object
args = parser.parse_args()

# you can access the values on the command line by using `args.input` or 'args.output`

# biopython
from Bio import SeqIO
from Bio.SeqUtils import GC


record = SeqIO.read(args.input, "fasta")
bio_gc = GC(record.seq)


# plain python
from collections import Counter

seqs = []
with open(args.input, 'rt') as f:
    header = next(f)
    for line in f:
        seqs.append(line.strip())

genome = ''.join(seqs)

counter = Counter(genome)
norm_gc = ((counter['G'] + counter['C']) / len(genome)) * 100

with open(args.output, 'wt') as w:
    w.write("The GC content from biopython is: {}\n".format(bio_gc))
    w.write("The GC content calculated from python is: {}\n".format(norm_gc))
    w.write("The total genome length is: {}\n".format(len(genome)))