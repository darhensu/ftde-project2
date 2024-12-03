# DBT Hands-On

This project demonstrates how to set up and work with DBT (Data Build Tool) using a PostgreSQL database. The database is pre-populated with sample data from the DVDRental dataset, and we will build data models using the Medallion Architecture pattern.

## Table of Contents
1. [Setup PostgreSQL Database](#setup-postgresql-database)
2. [DBT Setup](#dbt-setup)
3. [Data Modeling](#data-modeling)
4. [DBT UI](#dbt-ui)

## Setup PostgreSQL Database

### For Docker Users

1. If you're running PostgreSQL with Docker, use the following command to mount the `dvdrental` directory to your container:

   ```bash
   docker run --name postgres-test -e PGDATA=/var/lib/postgresql/data -e POSTGRES_PASSWORD=postgres -e POSTGRES_USER=postgres -e POSTGRES_DB=postgres -p 5433:5432 -v ./dvdrental:/dvdrental -v dbt-postgres:/var/lib/postgresql/data -d postgres-test:12

2. Restore the backup file using the following commands:

bash
Copy code
docker exec -it <postgres container name> bash
create database data_warehouse
\q

# Run in terminal
pg_restore -U postgres -d data_warehouse /dvdrental

### For Non-Docker Users

Open your Terminal/PowerShell and run:

bash
Copy code
psql -U postgres
create database data_warehouse
\q

# Run in terminal
pg_restore -U postgres -d data_warehouse /path/to/dvdrental

DBT Setup
1. Create a Python Virtual Environment
bash
Copy code
python3 -m venv env
2. Activate the Virtual Environment
On Linux/macOS:

bash
Copy code
source env/bin/activate
On Windows:

bash
Copy code
.\env\Scripts\activate
3. Install DBT Libraries
bash
Copy code
pip3 install dbt-core
pip3 install dbt-postgres
4. Initialize DBT Project
bash
Copy code
dbt init
5. Create profiles.yml
Create a profiles.yml file in the ~/.dbt directory with the following configuration:

yaml
Copy code
data_warehouse:
  outputs:
    dev:
      dbname: data_warehouse
      host: localhost
      pass: postgres
      port: 5433
      schema: dbt_dev
      threads: 1
      type: postgres
      user: postgres
    prod:
      dbname: data_warehouse
      host: localhost
      pass: postgres
      port: 5433
      schema: dbt
      threads: 1
      type: postgres
      user: postgres
  target: dev
6. Test DBT Connection
Run the following command to ensure the connection is successful:

bash
Copy code
dbt debug
Data Modeling
1. Create Schema for Medallion Architecture
Raw Data: dbt_dev_raw
Intermediate Data: dbt_dev_intermediate
Mart Data: dbt_dev_mart
Run the following commands in PostgreSQL:

bash
Copy code
\c data_warehouse
create schema dbt_dev_raw;
create schema dbt_dev_intermediate;
create schema dbt_dev_mart;
2. Create Raw Models
Write raw models using DBT to load the following tables into the dbt_dev_raw schema:

payment
rental
staff
customer
address
inventory
film
film_actor
actor
Create sources.yml to define your sources:

yaml
Copy code
version: 2

sources:
  - name: public
    database: data_warehouse
    schema: public
    tables:
      - name: payment
3. Create Intermediate Models
Create intermediate models and write them to the dbt_dev_intermediate schema. These models should include:

fact_payment
dim_rental
dim_staff
dim_customer
dim_address
dim_inventory
dim_film
dim_film_actor
dim_actor
4. Create Mart Models
Create Mart models and write them to the dbt_dev_mart schema. The following queries should be implemented:

Monthly Total Revenue
Best Selling Film
Actor with the Most Film Roles
DBT UI
1. Generate DBT Documentation
Generate the documentation for your DBT models:

bash
Copy code
dbt docs generate
2. Serve the DBT Documentation
Run the following command to launch the DBT documentation server:

bash
Copy code
dbt docs serve
