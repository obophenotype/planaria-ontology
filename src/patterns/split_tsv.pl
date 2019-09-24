#!/usr/bin/perl
use strict;
use warnings;
use Data::Dumper;

=pod
=head1 split pattern tsv on object Properties

=item splits the objectProperites that start at column $prop_start into separate TSVs

=item a new pattern will be needed for each new TSV. This pattern only needs the relation, classand var declaration for the objProp value (ie part_of), and the subclass of description.

=item essentially the term gets added first from the plana_terms.yaml and is modified with these objectProp expansion patterns
 
=item pattern.yaml example

pattern_name: plana_terms_part_of.yaml
pattern_iri: https://tbd
description: "adding ObjectProperty:part_of to PLANA terms"

contributors:
  - https://orcid.org/0000-0002-3528-5267

relations:
  part of: BFO:0000050

classes:
  part_of: BFO:0000040

vars:
  part_of: "'part_of'"

subClassOf:
    text: "'part of' some  %s"
    vars:
      - part_of

=cut

# perl ../split_tsv.pl plana_terms.tsv 14
my $tsv = shift;
my $prop_start = shift; ## first col=0. most recently it is 10 --> now 14
open TSV, $tsv or die "Cant open $tsv\n";

my $header = <TSV>;
chomp $header;
my @header = split "\t", $header;
my %props;
my %terms;
while (my $line = <TSV>){
  next if $line =~/^\s*$/;
  chomp $line;
  my @line = split /\t/, $line;
  my ($term_id,$term_label) = @line;
  $term_id =~s/^\s+//;
  $term_id =~s/\s+$//;
  $term_label =~s/^\s+//;
  $term_label =~s/\s+$//;
  $terms{$term_id}=$term_label;

  for(my $i=$prop_start; $i < @line; $i+=2){
    my @ids = split /\|/, $line[$i];
    my @labels = split /\|/, $line[$i+1];
    warn "$term_id:$term_label has unequal pairing of prop ids and labels" if scalar @ids != scalar @labels;
    for (my $j=0; $j<@ids; $j++){
      #$props{$term_label}{$header[$i]}{$ids[$j]}=$labels[$j]
      my $id = $ids[$j];
      my $label = $labels[$j];
      $id =~s/^\s+//;
      $id =~s/\s+$//;
      $label =~s/^\s+//;
      $label =~s/\s+$//;
      $props{$header[$i]}{$term_id}{$ids[$j]}=$labels[$j];
    }
  } 
} 
#print Dumper \%props;

foreach my $prop (sort keys %props){
  open OUT, ">plana_terms_$prop.tsv" or die "Can't open plana_terms_$prop.tsv for writing\n";
  print OUT join("\t",$header[0],$header[1],$prop,$prop."_label"),"\n";
  foreach my $term_id(sort keys %{$props{$prop}}){
    next if !scalar keys %{$props{$prop}{$term_id}};
    foreach my $prop_id(keys %{$props{$prop}{$term_id}}){
      print OUT join("\t", $term_id,$terms{$term_id},$prop_id,$props{$prop}{$term_id}{$prop_id}),"\n";
    }
  }
  close OUT;
}
#print Dumper \%props;
