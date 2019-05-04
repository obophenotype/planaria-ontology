## Customize Makefile settings for plana
## 
## If you need to customize your Makefile, make
## changes here rather than in the main Makefile

# ----------------------------------------
# Top-level targets
# ----------------------------------------

all: all_imports patterns all_main all_subsets sparql_test all_reports all_assets $(ONT).csv
test: sparql_test all_reports

$(ONT).csv: 
	$(ROBOT) query -use-graphs true -f csv -i $(SRC) --query ../sparql/plana_terms.sparql $@ && cp $@ ../.. 


