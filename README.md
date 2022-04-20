# acs_snap
First step is to pull the full data file from ACS website.  It will come in a  zipfile with a name like 
`ACSST5Y2019.S2201_2022-02-14T162257.zip`

That name is messy, so we are going to create a symbolic link to it using the `ls` command
```
ln -s ACSST5Y2019.S2201_2022-02-14T162257/ACSST5Y2019.S2201_data_with_overlays_2022-02-14T162245.csv dataset.csv;
```
Now we can just refer to it as `dataset.csv` (which doesn't actually exist except as a shortcut or link).  

You need to identify which fields you really want because these files are big.  
I highlighted the fields in the 
