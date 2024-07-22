#!/usr/local/Perl/5.36/bin/perl
use strict;

my $usage = "$0 -c <cluster_file>\n\n";
my %arg = @ARGV;
die $usage unless $arg{-c};

open( my $fhi, "<$arg{-c}") || die "ERROR, I cannot open $arg{-c}: $!\n\n";
my ($cluster_id, %cluster_count, %membership, %represent);
while(<$fhi>){
    chomp;
    if (m/^>Cluster\s(\d+)/){
        $cluster_id = $1; 
    } elsif (m/^(\d+)\t(\d+)aa,\s>(\d+_\d+_\d+)\..+(.)$/) {
        my ($idx, $len, $seqid) = ($1, $2, $3);
        
        push @{$membership{$cluster_id}}, $seqid;
        
        # Count cluster member
        $cluster_count{$cluster_id}++;

        if($4 eq "*"){
            # This is the representative seq of the cluster
            $represent{$cluster_id} = $seqid; 
        }

    } 
}
close $fhi;

open (my $fho, ">cluster_counts.txt");
for my $cid (keys %cluster_count){ 
    print $fho "Cluster_$cid\t$represent{$cid}\t$cluster_count{$cid}\n";
}
close $fho;

