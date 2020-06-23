#!/usr/bin/perl
use strict;
use warnings;

my @sheets;
foreach my $each (<DATA>){
  chomp $each;
  push @sheets,  "QUERY({'$each'!A3:B10000},\"select Col1,Col2, '$each' where Col1 <>''\")";
}

print "={" , join(';',@sheets) , "}" ;

__DATA__
plana_terms
proposed plana_terms
anatomicalSpaceAndAnatomicalEntity.txt
cellTypes.tsv
cellType_cellCycle.tsv
primordiumCellTypes.tsv
lumenOfAnatomicalEntity.tsv
progenitorCellTypes.tsv
fragment.tsv
anatomicalSpaceAndFragmentEntity.tsv
anatomicalSpaceAndCellType.tsv
blastemaDevelopsIntoAnatomicalEntity.tsv
