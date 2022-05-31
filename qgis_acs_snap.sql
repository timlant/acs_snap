SELECT 	tl_2010_04_zcta510.id, 
		acs_2019_snap.s2201_c01_001e AS households,
		acs_2019_snap.s2201_c01_034e AS median_income,
		acs_2019_snap.s2201_c02_021e AS percent_below_poverty,
		acs_2019_snap.c2201_c02_023e AS percent_w_disability,
		acs_2019_snap.c2201_c03_001e AS receiving_food_assistance,
		CAST(tl_2010_04_zcta510.zcta5ce10 AS integer) AS zipcode,
		geom

FROM	tl_2010_04_zcta510,
		acs_2019_snap
		
WHERE 

		CAST(substring(acs_2019_snap.name FROM 7 FOR 5) AS INTEGER) 
			= CAST(tl_2010_04_zcta510.zcta5ce10 AS integer)
		