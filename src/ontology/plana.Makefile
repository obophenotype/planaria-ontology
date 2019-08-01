## Customize Makefile settings for plana
## 
## If you need to customize your Makefile, make
## changes here rather than in the main Makefile

# ----------------------------------------
# Top-level targets
# ----------------------------------------

ASSETS += $(ONT).csv

$(ONT).csv: 
	$(ROBOT) query -use-graphs true -f csv -i $(ONT).owl --query ../sparql/plana_terms.sparql $@ && perl -pi -e 's/\r//' $@ && cp $@ ../..


imports/uberon_import.owl: mirror/uberon.owl imports/uberon_terms_combined.txt
	$(ROBOT) extract -i $< -T imports/uberon_terms_combined.txt --method BOT \
	reason \
        filter --term-file imports/uberon_terms_combined.txt --axioms "subclass equivalent" --select "self annotations" --trim true \
        annotate --ontology-iri $(ONTBASE)/$@ --version-iri $(ONTBASE)/releases/$(TODAY)/$@ --output $@

.PRECIOUS: imports/uberon_import.owl

