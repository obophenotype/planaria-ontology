#PATTERN=plana_terms_participates_in
#PATTERN=fragment
#PATTERN=progenitorCellTypes
#PATTERN=lumenOfAnatomicalEntity
#PATTERN=primordiumCellTypes
#PATTERN=plana_terms
PATTERN=plana_terms_editsNoParents
dosdp-tools generate --catalog=catalog-v001.xml --infile=../patterns/data/default/${PATTERN}.tsv --template=../patterns/dosdp-patterns/${PATTERN}.yaml --ontology=plana-edit.owl --obo-prefixes=true --outfile=${PATTERN}.test.owl

