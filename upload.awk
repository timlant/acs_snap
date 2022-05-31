#UPLOAD PGSQL TABLE
#WRITTEN BY TIM LANT - DECISION THEATER AT ASU
#THIS AWK SCRIPT PARSES CENSUS FILES TO CREATE POSTGRES DATABASE TABLES.
#APRIL 30, 2007

#UPLOADS SQL TABLE.  REMEMBER TO CHANGE THE TABLE NAME IN THE FIRST LINE

BEGIN { 
		# tablename="tracts"
		insertstring = "INSERT INTO "tablename" ("
	}

#PARSE FIRST ROW FOR FIELD NAMES
NR==1 {	for(i=1; i<=NF; i++){
			VA[i]=tolower($i)
			if(i < NF) insertstring = insertstring  VA[i] ", "
			else insertstring = insertstring  VA[i] "\") VALUES ("
			}
		cols = NF
	}

NR >= 2 && $0 !~ /#/	{ print insertstring
					for(i=1; i<=cols; i++){
					if(i < cols) 
						if (length($i) > 0)
							 print  $i "," 
						else print "NULL, "
					else if (length($i) > 0)
							print  $i ");" 
						 else print "NULL); "	
			}	
		}