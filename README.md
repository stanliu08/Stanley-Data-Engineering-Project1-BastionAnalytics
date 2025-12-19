## How to Run This Project

### 1. Requirements
- Required libraries for ETL:
  - pandas
  - numpy
  - os
- Required libraries for Visualizations:
  - matplotlib.pyplot
  - seaborn
  - FuncFormatter from matplotlib
- Tools:
  - Python / SQL server

### 2. Load Raw Data
- Put raw data into data/bronze_raw folder

### 3. Notebooks
- Run ETL notebooks in order but change the filepaths
- Load cleaned data in data/silver_cleaned folder

### 4. SQL server
- Create a new database in SSMS
- Change filepaths in bulk insert sql file
- Run the queries in order
- Download any queried views as a CSV file

### 5. Visuals
- Use seaborn and matplot on the CSV files from the queried views
