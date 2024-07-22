TK_138: Clustering of Ab sequences

# Run cd-hit clustering
```
# Use cd-hit/4.8.1
sbatch ./run_cd_hit.sh
```

# Estimate cluster sizes
```
./parse_cdhit_clusters.pl -c NK1R_ORFs_NR_100.clstr
```

# Sort cluster sizes by size
```
sort -k3,3n cluster_counts.txt > cluster_counts.sorted.txt
```

# Extract top30 cluster ids
```
tail -30 cluster_counts.sorted.txt|sort -k3,3nr|cut -f 2 > top30.ids
```

# Extract top30 counts
```
tail -30 cluster_counts.sorted.txt|sort -k3,3nr > top30.count
```

# Extract representative sequences for top30 clusters
```
module load seqtk/1.4
seqtk subseq NK1R_ORFs_Galaxy_processing.NR.fasta top30.ids > top30.fasta
```

# COnvert fasta into tabulated file
```
cat top30.fasta |paste - - > top30.fasta.txt
```

# Clean IDs from tabulated file
```
cat top30.fasta.txt|cut -f 1,5 -d ' '|sed -e 's/ .\{14\}//'|sed 's/>//' > top30.fasta.clean.txt
```

# merge top30 counts with top30 sequences
```
xlookup.pl -d top30.fasta.clean.txt -dri 1 -i top30.counts -ii 1 > top30.counts.seqs.txt
```

  
