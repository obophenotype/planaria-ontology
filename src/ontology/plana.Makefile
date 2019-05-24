## Customize Makefile settings for plana
## 
## If you need to customize your Makefile, make
## changes here rather than in the main Makefile

# ----------------------------------------
# Top-level targets
# ----------------------------------------

ASSETS += $(ONT).csv

$(ONT).csv: 
	$(ROBOT) query -use-graphs true -f csv -i $(SRC) --query ../sparql/plana_terms.sparql $@ && perl -pi -e 's/\r//' $@
