#!/bin/bash
#SBATCH --cpus-per-task=32 --mem=64g --time=24:00:00  
module load cd-hit

time cd-hit -i ./NK1R_ORFs_Galaxy_processing.NR.fasta -o NK1R_ORFs_NR_100 -c 1.0 -n 5 -g 1 -G 0 -aS 1.0  -d 0 -p 1 -T 32 -M 64000 > NK1R_ORFs_100.log
