#!/usr/bin/env perl
use strict;
use warnings;

#Usage: perl draw_SV_wrap.pl combined_SV.txt
#The combined_SV.txt contains population SVs generated by combine_SV.pl
#Shujun Ou (shujun.ou.1@gmail.com) 06/24/2020

my $GenomeRegionAligView = "~/las/git_bin/SVsFromGenomes/SVGdrawing/GenomeRegionAligViewSO.pl";
my $genome_path = "/home/oushujun/jfw/TE/MaizeNAM/SV/LY_pipeline/genomes/";
my $min_len = 100; #entries shorter than this will be passed.

while (<>){
	my ($target_id, $t_s, $t_e, $type, $len, undef, undef, undef, $query) = (split /\s+/, $_, 9);
	next if $len < $min_len;
	my $target = $1 if $target_id =~ /^(\w+)\./;;
	my @query = (split /\s+/, $query);
	foreach (@query){
		next if /$target_id/;
		s/:.*//g;
		my ($query_id, $q_s, $q_e) = (split /_/, $_);
		my $query = $1 if $query_id =~ /^(\w+)\./;;
		print "Drawing SV: $target_id $t_s $t_e $type $query_id $q_s $q_e\n";
		`echo "$target_id $t_s $t_e $type $query_id $q_s $q_e" | perl $GenomeRegionAligView -sv - -target $genome_path/$target.*fasta -query $genome_path/$query.*fasta -len $len`;
		}
	}
