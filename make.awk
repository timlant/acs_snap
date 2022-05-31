#MAKE PGSQL TABLE
#WRITTEN BY TIM LANT - DECISION THEATER AT ASU
#THIS AWK SCRIPT PARSES CENSUS FILES TO CREATE POSTGRES DATABASE TABLES.
#APRIL 30, 2007

#CREATES SQL TABLE.  REMEMBER TO CHANGE THE TABLE NAME IN THE FIRST LINE
BEGIN {
	#	tablename="acs_snap"
	#	print tablename;
		print "DROP TABLE IF EXISTS "tablename";\n"
		print "BEGIN;\nCREATE TABLE "tablename" ("
	}

#PARSE FIRST ROW FOR FIELD NAMES
NR==1 {	for(i=1; i<=NF; i++)
		VA[i]=tolower($i)
		cols = NF
	}

#PARSE ALL ROWS FOR MAXIMUM FIELD LENGTH AND DATA TYPES
NR>=2 && $0 !~ /#/	{	for(i=1; i<=cols; i++)
					if ($i ~ /[a-z,A-Z,\/]+/  ) maxlength[i] = (maxlength[i] >= length($i) ? maxlength[i] : length($i) )
					else if ($i ~ /^ *[0-9]*\.[0-9]* *$/) decimal[i]=1
					else if ($i ~ /^ *[0-9]+ *$/ && $i <= 1000 && (-1)*$i <= 1000) intlength[i] = (intlength[i]>=2 ? intlength[i] : 2)
					else if ($i ~ /^ *[0-9]+ *$/ && $i <= 100000000) intlength[i] = 4
					else if ($i ~ /[0-9]+/ ) maxlength[i] = (maxlength[i] >= length($i) ? maxlength[i] : length($i) )
					else maxlength[i] = (maxlength[i] >= length($i) ? maxlength[i] : length($i) )
			#		if(NF != cols) print "WARNING!!!" "NF: " NF "cols: " cols " row: " $0
				}


#WRITE TABLE FORMAT AND DATA TYPES
END {   for(i=1; i<= (cols-1); i++){
		if (maxlength[i] > 0) print  VA[i]  " varchar(" maxlength[i] "),"
		else if (decimal[i] == 1) print  VA[i]  " numeric,"
		else if (intlength[i] == 2) print  VA[i]  " int2,"
		else if (intlength[i] == 4) print  VA[i]  " int4,"
		else print  VA[i]  " varchar(8),"
		}

		if (maxlength[cols] > 0) print  VA[cols]  " varchar(" maxlength[cols] ")"
		else if (decimal[cols] == 1) print  VA[cols]  " numeric"
		else if (intlength[cols] == 2) print  VA[cols]  " int2"
		else if (intlength[cols] == 4) print  VA[cols]  " int4"
		else print  VA[cols]  " varchar(8)"
		print");"
	print "END;"
	}
