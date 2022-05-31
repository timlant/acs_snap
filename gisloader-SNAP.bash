#!
# USAGE:	$1=schema.tablename
#			$2=filename (without .txt extension)
#			$3=dbname
#			$4=username
#			$5=server


#    Need to add in 
#	awk -F, -f select_fields.awk dataset.csv

echo putting ${2}.txt into table ${1}.  

awk -F, -f make.awk -v tablename=${1} ${2}.csv > ${2}.sql
awk -F, -f upload.awk -v tablename=${1} ${2}.csv >> ${2}.sql
psql -d ${3} -U ${4} -h ${5} -f ${2}.sql
