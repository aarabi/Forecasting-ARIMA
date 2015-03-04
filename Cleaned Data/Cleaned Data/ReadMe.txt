Data Files - Crabbs Peninsula, Antigua Study
-------------------------------------------------------------------------------------------
Sustainable Engineering Lab, October 2014.
Data provided by Thomas Hamlin.

AntiguaWind.csv
-------------------------------------------------------------------------------------------
This file contains collected wind SPEED data, in m/s, for five locations around the twin-island nation of Antigua and Barbuda:
	- Crabbs Peninsula Site
	- Guinea Bush Line Site
	- Mount McNish Site
	- Freetown Site
	- Barbuda Site
	
The data set was collected in ten-minute resolution, and describes the period between 9:40AM Jan 6th 2011 - 8:50AM August 14th 2012. (This amounts to just under 585 days worth of data.) Each site has average, standard deviation, maximum, and minimum values for each ten-minute time period.

AntiguaSolar.csv
-------------------------------------------------------------------------------------------
This file contains collected solar irradiation data, in W/m2, collected in the Crabbs Peninsula Site of the twin-island nation of Antigua and Barbuda. The data set was collected in ten-minute resolution, and describes the period between 9:40AM Jan 6th 2011 - 8:50AM August 14th 2012. (This amounts to just under 585 days worth of data.) This data set contains average, standard deviation, maximum, and minimum values for each ten-minute time period, and can be considered representative of the entire country for our estimations here. (As all of the sites considered are within 50km of one another, apparent solar irradiation is not expected to vary greatly between them.)

Note: Data values have an apparent measurement cap of 1351.7W/m2.

AntiguaTemp.csv
-------------------------------------------------------------------------------------------
This file contains collected temperature data, in degrees Celcius, collected in the Crabbs Peninsula Site of the twin-island nation of Antigua and Barbuda. The data set was collected in ten-minute resolution, and describes the period between 9:40AM Jan 6th 2011 - 8:50AM August 14th 2012. (This amounts to just under 585 days worth of data.) This data set contains average, standard deviation, maximum, and minimum values for each ten-minute time period, and can be considered representative of the entire country for our estimations here. (As all of the sites considered are within 50km of one another, local temperature is not expected to vary greatly between them.)

AntiguaLoad.csv
-------------------------------------------------------------------------------------------
This file contains power dispatch data for the twin-island nation of Antigua and Barbuda, in MW, provided by the Antigua Public Utilities Authority (APUA). This data was collected by recording of half-hourly or hourly data power outputs over an entire year; for time stamps where one hour elapsed between points, the value is listed twice over two half hour data points such that the entire set has half hour resolution. Anomolously high or low readings (< 25000 MW and > 59000 MW) were assumed to be incorrectly recorded and were manually set to those values.

This file has a different time resolution and time range compared to the other temporal data files here, and should be processed accordingly for consistency across datasets.
