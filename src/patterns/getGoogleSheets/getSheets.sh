curl "https://docs.google.com/spreadsheets/d/1NzQznwebR_rvOejJzZax7UmZvvFk01bRksCdFtUl5rk/export?format=tsv&id=1NzQznwebR_rvOejJzZax7UmZvvFk01bRksCdFtUl5rk&gid=0" -o term_management/plana_terms.tsv


for i in `cat googleSheets.txt`; do curl "https://docs.google.com/spreadsheets/d/1NzQznwebR_rvOejJzZax7UmZvvFk01bRksCdFtUl5rk/export?format=tsv&id=1NzQznwebR_rvOejJzZax7UmZvvFk01bRksCdFtUl5rk&gid=$i" -o sheets.$i.tsv; done


for i in sheets*.tsv ; do FILE=`head -1 $i | perl -p -e 's/.+\t(\S+)\.yaml\t.+/$1.tsv/' |  perl -p -e 's/\s+//g'`  ; tail -n +2 $i > $FILE; echo "" >> $FILE ; perl -pi -e 's/\r//g'  $FILE ; done

rm sheets*.tsv


