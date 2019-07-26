PATTERN=plana_terms
dosdp-tools generate --catalog=catalog-v001.xml --infile=../patterns/data/default/${PATTERN}.tsv --template=../patterns/dosdp-patterns/${PATTERN}.yaml --ontology=plana-edit.owl --obo-prefixes=true --outfile=${PATTERN}.test.owl

