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
open TSV, $tsv or die "Cant open $tsv\n";

my $header = <TSV>;
chomp $header;
my $prop_start;
my $parent_start;
my %plana_terms;

my @headers = split "\t" , $header;
for (my $i=0; $i<@headers ; $i++){
  if ($headers[$i] eq 'part_of'){
    $prop_start = $i;
  }elsif($headers[$i] eq 'parent_entity' ){
    $parent_start = $i;
  }
}

my %props;
my %terms;
while (my $line = <TSV>){
  next if $line =~/^\s*$/;
  chomp $line;
  my @line = split /\t/, $line;
  my ($patterned,$term_id,$term_label) = @line;
  next if $patterned ne 'none';
  $term_id =~s/^\s+//;
  $term_id =~s/\s+$//;
  $term_label =~s/^\s+//;
  $term_label =~s/\s+$//;
  $terms{$term_id}=$term_label;

  my @parent_ids = split /\|/ , $line[$parent_start];
  my @parent_labels = split /\|/ , $line[$parent_start+1];
  
  for (my $i=0; $i<@parent_ids; $i++){
    for (my $j=1 ; $j<$prop_start ; $j++){
      if ($j == $parent_start){
        push @{$plana_terms{$term_id}{$parent_ids[$i]}},$parent_ids[$i];
      }
      elsif ($j == $parent_start+1){
        push @{$plana_terms{$term_id}{$parent_ids[$i]}},$parent_labels[$i];

      }else{
        if (defined $line[$j]){
          push @{$plana_terms{$term_id}{$parent_ids[$i]}},$line[$j];
        }else{
          #warn "PROBLEMS HERE with uninitialized columns: {$term_id}{$parent_ids[$i]}\n";
          push @{$plana_terms{$term_id}{$parent_ids[$i]}},'';
        }
      }
    }
  }
#print Dumper \%plana_terms;

  for(my $i=$prop_start; $i < @line; $i+=2){
    my @ids = split /\|/, $line[$i];
    my @labels = split /\|/, $line[$i+1];
    warn "$term_id:$term_label has unequal pairing of prop ids and labels" if scalar @ids != scalar @labels;
    for (my $j=0; $j<@ids; $j++){
      my $id = $ids[$j];
      my $label = $labels[$j];
      $id =~s/^\s+//;
      $id =~s/\s+$//;
      $label =~s/^\s+//;
      $label =~s/\s+$//;
      $props{$headers[$i]}{$term_id}{$ids[$j]}=$labels[$j];
    }
  } 
} 
#print Dumper \%props;
open PLANA_OUT, ">plana_terms.tsv" or die "Can't open plana_terms.tsv for writing\n";
## print header line
my @out_headers;
for (my $i = 1; $i<$prop_start; $i++){
  push @out_headers, $headers[$i];
}
print PLANA_OUT  join("\t",@out_headers),"\n";
## end print header line

foreach my $term_id (sort keys %plana_terms){ 
  foreach my $parent_id (sort keys %{$plana_terms{$term_id}}){
    print PLANA_OUT join ("\t",@{$plana_terms{$term_id}{$parent_id}}),"\n";
  }
}

foreach my $prop (sort keys %props){
  open OUT, ">plana_terms_$prop.tsv" or die "Can't open plana_terms_$prop.tsv for writing\n";
  print OUT join("\t",$headers[1],$headers[2],$prop,$prop."_label"),"\n";
  foreach my $term_id(sort keys %{$props{$prop}}){
    next if !scalar keys %{$props{$prop}{$term_id}};
    foreach my $prop_id(keys %{$props{$prop}{$term_id}}){
      print OUT join("\t", $term_id,$terms{$term_id},$prop_id,$props{$prop}{$term_id}{$prop_id}),"\n";
    }
  }
  close OUT;
}
#print Dumper \%props;
