# Dbt_With_SnowFlake


### Table of Contents

- [Overview](#overview)
- [Data Build Tool](#data-build-tool)
- [Folder Structure](#folder-structure)
- [Program Flow](#program-flow)
- [Architecture and Design](#architecture-and-design)
- [Data Model](#data-model)
- [ETL Jobs](#etl-jobs)
- [Tools and Technologies](#tools-and-technologies)

---


### Overview

- The purpose of doing this was to learn how Tranformations can be made easy using dbt.
- Check what different functionalities does dbt support that can save time.
- Snowflake was used as a warehouse. Free 30 day trail.


---

### Data Build Tool

- dbt enables analytics engineers to transform data in their warehouses by simply writing select statements.
- dbt handles turning these select statements into tables and views.
- dbt does the T in ELT (Extract, Load, Transform) processes.

#### dbt Installation

- Install git and python 
- dbt installation on Linux has some problem and due to that we need install the dbt-core project.
- Will be doing this all in a virtual environment.

- This will create a virtual env
```bash
  python3 -m venv dbt-env
```

- Activate the env
```bash
  source dbt-env/bin/activate
```
- In this repo dbt is also ready there you can use that or clone there repo.
```bash
  git clone https://github.com/dbt-labs/dbt.git
```

- Go into the dbt folder
```bash
  cd dbt
  pip install -r requirements.txt
```

- Check if dbt installed
```bash
  dbt --version
```

- Download the Snowflake Plugin
```bash
  pip install dbt-snowflake
```

- Open your choice of editor, VS Code used in this demo. Running the command will populate with different folders (seeds, models etc)
```bash
  dbt init <project-name>
```

#### Connecting dbt with Snowflake

- Snowflake provides 30 day free trail.
- When dbt installed and configured, in home directory a **.dbt** will be visible.
- Two file will be present.
  - profile.yml
  - .user.yml
- In the profile.yml we provide our Snowflake credentials. Refer to dbt documentation.
- https://docs.getdbt.com/reference/warehouse-profiles/snowflake-profile
```bash
dbt_model:
  outputs:
    dev:
      account: ap12345.ap-south-1.aws
      database: <database>
      password: <password>
      role: <role-from-snowflake>
      schema: <schema>
      threads: 2
      type: snowflake
      user: <username>
      warehouse: <warehouse-name-from-snowflake>
  target: dev
```

- When snowflake profile has been set, execute this will tell, if connection made.
```bash
  dbt debug
 ```


---


### Folder Structure
- dbt &emsp; - dbt cloned repo used for installation
- dbt-evn &emsp;- python virtual env related
- dbt-model 
  - dbt-model &emsp; - after dbt init <name> this is created
    - analyses
    - macros &emsp; - create macros here and refer later
    - models &emsp; - tables, views, incremental load, merge 
    - seeds &emsp; - flat files incase want to load to staging using dbt
    - snapshots &emsp; - SCD tables
    - tests &emsp;&emsp; - tests on different models
    - dbt_project.yml &emsp; - one place to configure all
    - packages.yml &emsp; - dbt has many packages which can be downloaded


---

### Program Flow

<p align="center">
  <img src="Images/Flow_2.jpg" width="850" >
</p>




---

### Architecture and Design

- Now on to the interesting part. Firstly we needed to create a **Landing Zone** where our data files will be placed. This process was automated and Talend will wait for the files to appear and then will start the next processes. 
- In Talend we needed to provide our file schema in the metadata section.So, that it know what will be the format of the different files.
- Now will load the flat file to our **Staging Area/Staging Tables**.
  - Truncate and Load will happen. If any data exists that will be removed first and new data will be loaded.
  - The Staging Area is the first place where our data is loaded.
- When the data is in our Staging Area it is not in its purest form, from here do some transformation and load this data to our **Help Tables** which will be used to generate the surrogate keys, these are the keys used internally by the warehouse.
- The data from Staging Table and Help Table will be joined and loaded to the **Load Ready Tables**. 
  - These Load Ready Tables will have an extra column named as IUD (Insert, Update, Delete).
  - Based on the value in the column we will perform the operation and load to Core/Dim Tables.
  - The IUD marking will be empty for now.
- Now the **Load Ready Tables** will be checked with the respective **Core/Dim Tables** and the IUD marking will be performed. 
  - Lets take an example Id 1 does not exist in Core Table but exists in Load Ready Table, in Load ready this will be marked as I (Insert).
  - The Id 1 exists in both Load Ready Table and Core Table but lets say the address of the person changed can it will be marked as U (Update). Now update type can be of SCD-1, 2 or 3 this depends on the use case.
  - The Id 1 exists in Core table but is not present in Load Ready Table, in this case it will be marked as D (Delete).
- In our Core tables we will be implementing SCDs, now that will be based on our use case that what sort of details we can to capture.
- In Core tables will do the indexing so that based on keys we can find data efficiently and similarly will collect statistics as well. Teradata also provides us with different join indexes which are really helpful in the Fact and Dim situation.


---

### Data Model


<p align="center">
  <img src="Images/PDM.PNG" width="900" >
</p>

- The source system provides the Full Dump (all of the data every time).
- The Transactions table is append only data.
- Most the tables in Core/Dim are SCD Type 1 or Type 2.
- Country and City do not change much they can be loaded manually whenever needed.

---

### SMX Document

<p align="center">
  <img src="Images/Mapping.PNG" width="900" >
</p>

- An excel sheet was also created which explains what operations performed.
- Each of the table will have a detailed sheet which tells what tranformations happened, at what layer(Staging, Load Ready, Core/Dim).
- This is really helpful for other team member so see and interpret what happened.


---


### ETL Jobs

- The first time the user will place the files in the Landing area and Talend will start the job.
- It will truncate all the data if any in the Staging Tables (Contact, Account, Transaction etc) and will load this new data into the respective tables.
- After this we will populate our Help Tables with the Surogate keys and will be used in the next layers.
- Using the Help Tables and Staging we will check this with Core/Dim that what data is new, or updated, or has been deleted and will load and mark this new data in our Load Ready Tables.
- Once the data is in the Load Ready, based on the IUD column marking we will load this data into our Core tables.
- The Core tables will have the SCDs implemented and based on that either the rows will be updated or new row will be inserted.
- Statistics will collected on these tables and indexed will be created so that data can be used efficiently by end user.
- The data file in our Landing area will be archived.
- Next day again new data arrives and this cycle will start again.

<p align="center">
  <img src="Images/Arch_1.jpg" width="850" >
</p>


---

### Indexes and Statistics Collection

- Teradata provides many types of indexed
  - Unique Primary Index (UPI)
  - NON Unique Primary Index (NUPI)
  - Secondary Index (SI)
  - Non Unique Secondary Index (NUSI)

- Teradata also provides Join Indexes the result of these are stored and if any changes will be reflected in these join indexed as well
  - Single Table Join Index
  - Multiple Table Join Index
  - Aggregated Join Index

- After the data is loaded in the Core/Dim Tables we collect Statistics as well on different columns and the optimizer creates an execution strategy that is based on these statistics.


---
### Tools and Technologies

- Dbt
- Snowflake


