# 1. Description of Data Source
 * Our primary data is a table from the Organisation for Economic Cooperation and Development (OECD). The table consists of 24,948 rows and 8 columns. The columns include Country, the type of pollutant being measured (Subject), the scale of measurement (Measure), the value of the measurement (Value), and the year it was taken (Time). It also includes undefined Flag Codes, Indicator, and Frequency columns.
 
   **Citation:**
OECD (2017), Air and GHG emissions (indicator). doi: 10.1787/93d10cf7-en URL: https://data.oecd.org/air/air-and-ghg-emissions.htm (Accessed on 10 October 2017)

 * 	We will supplement this data with a table of urbanization by per cent of population from World Bank. This table consists of  265 rows and 54 columns. Each row represents a country or a summary for a geographic region. Columns represent the series name and code, the country name and code, and the percent of population living in urban areas for each year from 1967 through 2016.

   **Citation:**
The World Bank: Urban Population (% of Total): The United Nations Population Divisions World Urbanization Prospects. URL: https://data.worldbank.org/indicator/SP.URB.TOTL.IN.ZS (Accessed on 10 October 2017)

 * 	We will also use a table of world population by country from World Bank. This table consists of 264 rows and 61 columns. Each row represents a country or a summary for a geographic region. Columns represent the country name and code, the indicator name and code, and the population of each country or region for each year from 1965 through 2017.

   **Citation:**
The World Bank: Urban Population (% of Total): The United Nations Population Divisions World Urbanization Prospects. URL: https://data.worldbank.org/indicator/SP.POP.TOTL?page=2 (Accessed on 11 October 2017)

# 2. Intellectual Property Constraints
 * **OECD Data:**
In consideration of the Subscription Fee, and the agreement to abide by these Terms and Conditions, the OECD grants the Customer a non-exclusive and non-transferable right to access and display on its secure internal network, for use by Authorised Users only, the online service "OECD iLibrary" (http://www.oecd-ilibrary.org) and the title (or titles) and content contained therein which has (or have) been subscribed to including the back catalogue of PDFs where available (hereinafter referred to as the "Work"). The Work may be accessed by End Users either directly from the OECD itself, or from a designated Third Party (e.g. Publishing Technology) either on the Customer's premises or from a remote location. Irrespective of the method of access, the conditions of use, as described in these Terms and Conditions, remain in force. The OECD affirms that it holds all rights granted herein, and reserves all those not expressly granted to the Customer.  
"Authorised Users" are defined as being; 
a) For Academic and Not-For-Profit Organisations - those members of faculty or staff, either permanent, temporary, contract, visiting or retired, or students, or alumni or other persons permitted to use the institution's library services.  

* **World Bank Data:** 
Open License

# 3. Description of Metadata	
* **OECD Data:**
No official metadata is available for the data. There is an interactive tool on the website allowing the user to look up what country each three-letter code represents, and what environmental toxins are represented by each abbreviation. 

*  **World Bank Data:**
Metadata is available as a link on the World Bank site. It describes the source, importance, and method of collecting data. 

# 4. Data Issues

**A. OECD Data:**

**Missing values** 

 * Flag code column has missing values.

 * Missing values in Value column.

**Undefined Variables**

 * Column ‘Flag Code’ has undefined entries ‘L’ and ‘B’.  Flag codes, in order of frequency from least to greatest are B (30), L (3693), and blank (21225). Flag codes of B do not apply to any GHG (Greenhouse Gases) or CO2 (Carbon Dioxide) records, and do contain Values. Flag Codes of B come from Poland (1995), Turkey, USA, and Mexico (the latter three all from 2005 and 2008). All Flag Codes of L correspond to C02 readings and all Values are blank for these records. 
 * Column ‘Frequency’ has uniform entries of ‘A’ which is undefined.
 * Column ‘Indicator’ has uniform entries of ‘AirEmission’ which is undefined.
 
**B. World Bank Data:**
 
 **Missing values:** 
 
 * There is no Urbanization data nor Population data for Taiwan (aka Chinese Taipei).
 
 * There is no Urbanization data nor Population data for Eritrea from 2011 through 2014.
 
 * There is no Population data for Kuwait from 1992 through 1994.

# 5. Rationale for Data Remediation
We are interested in comparing individual country greenhouse gas emissions to one another and to world totals and OECD member country totals. We felt that the other summaries of data (EU28 being 28 member nations of the EU, G20 nations, OEU and OECDE both being the European members of OECD) should be eliminated since they were summarized data.

Flag codes were not explained but we observed that any flag code of L corresponded to CO2 records with no value. These were the only records that contained no value. We did not feel we had adequate information to make any assumptions about the missing values so we eliminated those records.

One of our questions requires us to use data about population and urbanization rates so we appended that information to our data. 
 
# 6. Script or Description of Data Cleaning Process

**Source Files :** World Bank data (Urbanization_Percent.csv, Population.csv) 
OECD data( air_ghg_emissions.csv)

**Target File :**  OECD Data (air_ghg_emissions.csv)

## **Step 1:**   
### Clean  air_ghg_emissions.csv:
* Eliminate data for country codes ‘EU28’, ‘G20’, ‘OECDE’, ‘OEU’, and ‘TWN’.  
* Change ‘OECD’ code to ‘OED’ for consistency with other files.  
* Eliminate CO2 values that have flag code ‘L’.  
* 20728 records remain  
* Take average of 1991 and 1995 population figures for Kuwait and use for population for 1992, 1993, and 1994  
* Calculate the percent increase in urbanization for the last ten years in Eritrea. Average these increases and apply that percent increase to the 2011 urbanization rate for 2012, continue through 2016.  
* Population growth in Eritrea slowed significantly from 2001 to 2011, but each of the last four years was approximately 1.9%, so we applied a 1.9% growth rate to 2011 population for 2012, and continued through 2016.  

## **Step 2:**   
### Merge Urbanization and Emissions data  
* Create a new tab called “Urbanization” in air_ghg_emissions data file and paste
 in Urbanization data   
* Create an index column in air_ghg_emissions data file to use in vlookup:  
 `=IF(F3=1960,4,F3-1960+4)`  
* Where F3 is the TIME column.  
* Do vlookup for urbanization data:  
 `=VLOOKUP(A3,Urbanization!$B$2:$BI$265,I3)`  
* Where A3 is the three letter country code column,   
* Country name column is not included in the LookUp table (note the range begins with column B),   
and I3 is the index created in the previous step.  

## **Step 3:**   
### Merge Population.csv and air_ghg_emissions.csv data  
* Create a new tab called “Population” in air_ghg_emissions data file and paste in Population data   
* Do vlookup for population data:  
`=VLOOKUP(A3,Population!$B$2:$BI$265,I3)`  
* Where A3 is the three letter country code column,   
* Country name column is not included in the LookUp table (note the range begins with column B), and  
* I3 is the index created in the Urbanization merge (urbanization and population are from the same source and formatted in the same manner).  

## **Step 4:**   
### Create final csv file  
* Copy the new expanded table, and paste as values into a new file. Save as air_ghg_data.csv.
