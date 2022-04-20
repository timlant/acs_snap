#!
# Scripting file for loading CENSUS ACS data into postgres.

# create symbolic link to datafile so that this script is reusable
ln -s ACSST5Y2019.S2201_2022-02-14T162257/ACSST5Y2019.S2201_data_with_overlays_2022-02-14T162245.csv dataset.csv;

#select fields to download.  This is a manual process.  edit 'select_fields.awk'
awk -F, -f select_fields.awk dataset.csv > acs_snap_2019_w_race.csv         

#  Remove blanks and special characters
sed -i '.old' -e 's/"-"//g' acs_snap_2019_w_race.csv  

awk -F, -f make.awk -v tablename=acs_snap_2019_w_race acs_snap_2019_w_race.csv > acs_snap_2019_w_race.sql

 awk -F, -f upload.awk -v tablename=acs_snap_2019_w_race acs_snap_2019_w_race.csv

