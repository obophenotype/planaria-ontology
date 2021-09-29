# master term sheet. put it in term_management directory
#curl "https://docs.google.com/spreadsheets/d/1NzQznwebR_rvOejJzZax7UmZvvFk01bRksCdFtUl5rk/export?format=tsv&id=1NzQznwebR_rvOejJzZax7UmZvvFk01bRksCdFtUl5rk&gid=0" -o term_management/plana_terms.tsv
curl "https://docs.google.com/spreadsheets/d/1NzQznwebR_rvOejJzZax7UmZvvFk01bRksCdFtUl5rk/gviz/tq?tqx=out:csv&gid=0" -o plana_terms.csv; ./csv2tab.py < plana_terms.csv > term_management/plana_terms.tsv ;  perl -pi -e 's/\r//' term_management/plana_terms.tsv


## reform plana_terms
## nervous to do this without checking the above download
#perl term_management/format_plana_terms.pl term_management/plana_terms.tsv

# download the rest
# update googleSheets.txt if we have a new tab in the plana term management google sheet
#for i in `cat googleSheets.txt`; do curl "https://docs.google.com/spreadsheets/d/1NzQznwebR_rvOejJzZax7UmZvvFk01bRksCdFtUl5rk/export?format=tsv&id=1NzQznwebR_rvOejJzZax7UmZvvFk01bRksCdFtUl5rk&gid=$i" -o sheets.$i.tsv; done

for i in `cat googleSheets.txt`; do curl "https://docs.google.com/spreadsheets/d/1NzQznwebR_rvOejJzZax7UmZvvFk01bRksCdFtUl5rk/gviz/tq?tqx=out:csv&gid=$i" -o sheets.$i.csv; ./csv2tab.py < sheets.$i.csv > sheets.$i.tsv ;  perl -pi -e 's/\r//' sheets.$i.tsv ; done

 
# rename files based on the pattern yaml file name included in first line of tsv file
for i in sheets*.tsv ; do FILE=`head -1 $i | perl -p -e 's/.+\t(\S+)\.yaml\t.+/$1.tsv/' |  perl -p -e 's/\s+//g'`  ; tail -n +2 $i > $FILE; echo "" >> $FILE ; perl -pi -e 's/\r//g'  $FILE ; done

# remove the original downloaded tsv files
rm sheets*.tsv
rm sheets*.csv

# git status
git status
