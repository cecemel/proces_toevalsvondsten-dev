#!/bin/sh

set -e

###########################
# PROCES_TOEVALSVONDSTEN
###########################

# Perform all actions as $POSTGRES_USER
export PGUSER="$POSTGRES_USER"
export POSTGRES_DB="proces_toevalsvondsten"

#create projects-db for projects_service
psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" <<-EOSQL
    CREATE DATABASE $POSTGRES_DB;
    GRANT ALL PRIVILEGES ON DATABASE $POSTGRES_DB TO $POSTGRES_USER;
    CREATE ROLE proces_toevalsvondsten_dml;
    CREATE ROLE pgvioe;
    CREATE ROLE proces_toevalsvondsten_ddl;
    CREATE ROLE vioedba;
EOSQL

# Load PostGIS into both template_database and $POSTGRES_DB
for DB in "$POSTGRES_DB"; do
	echo "Loading PostGIS extensions into $DB"
	"${psql[@]}" --dbname="$DB" <<-'EOSQL'
		CREATE EXTENSION IF NOT EXISTS postgis;
		CREATE EXTENSION IF NOT EXISTS postgis_topology;
		CREATE EXTENSION IF NOT EXISTS fuzzystrmatch;
		CREATE EXTENSION IF NOT EXISTS postgis_tiger_geocoder;
EOSQL
done

# create test DB
export POSTGRES_DB="proces_toevalsvondsten_test"

#create projects-db for projects_service
psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" <<-EOSQL
    CREATE DATABASE $POSTGRES_DB;
    GRANT ALL PRIVILEGES ON DATABASE $POSTGRES_DB TO $POSTGRES_USER;
EOSQL

# Load PostGIS into both template_database and $POSTGRES_DB
for DB in "$POSTGRES_DB"; do
	echo "Loading PostGIS extensions into $DB"
	"${psql[@]}" --dbname="$DB" <<-'EOSQL'
		CREATE EXTENSION IF NOT EXISTS postgis;
		CREATE EXTENSION IF NOT EXISTS postgis_topology;
		CREATE EXTENSION IF NOT EXISTS fuzzystrmatch;
		CREATE EXTENSION IF NOT EXISTS postgis_tiger_geocoder;
EOSQL
done

###########################
# DOSSIERDATA
###########################

# Perform all actions as $POSTGRES_USER
export PGUSER="$POSTGRES_USER"
export POSTGRES_DB="dossierdata"

#create projects-db for projects_service
psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" <<-EOSQL
    CREATE DATABASE $POSTGRES_DB;
    GRANT ALL PRIVILEGES ON DATABASE $POSTGRES_DB TO $POSTGRES_USER;
    CREATE ROLE dossiers_dml;
    CREATE ROLE dossiers_ddl;
EOSQL

# Load PostGIS into both template_database and $POSTGRES_DB
for DB in "$POSTGRES_DB"; do
	echo "Loading PostGIS extensions into $DB"
	"${psql[@]}" --dbname="$DB" <<-'EOSQL'
		CREATE EXTENSION IF NOT EXISTS postgis;
		CREATE EXTENSION IF NOT EXISTS postgis_topology;
		CREATE EXTENSION IF NOT EXISTS fuzzystrmatch;
		CREATE EXTENSION IF NOT EXISTS postgis_tiger_geocoder;
EOSQL
done

# create test DB
export POSTGRES_DB="dossierdata_test"

#create projects-db for projects_service
psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" <<-EOSQL
    CREATE DATABASE $POSTGRES_DB;
    GRANT ALL PRIVILEGES ON DATABASE $POSTGRES_DB TO $POSTGRES_USER;
EOSQL

# Load PostGIS into both template_database and $POSTGRES_DB
for DB in "$POSTGRES_DB"; do
	echo "Loading PostGIS extensions into $DB"
	"${psql[@]}" --dbname="$DB" <<-'EOSQL'
		CREATE EXTENSION IF NOT EXISTS postgis;
		CREATE EXTENSION IF NOT EXISTS postgis_topology;
		CREATE EXTENSION IF NOT EXISTS fuzzystrmatch;
		CREATE EXTENSION IF NOT EXISTS postgis_tiger_geocoder;
EOSQL
done


###########################
# VONDSTMELDINGEN
###########################

# Perform all actions as $POSTGRES_USER
export PGUSER="$POSTGRES_USER"
export POSTGRES_DB="vondstmeldingen"

#create projects-db for projects_service
psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" <<-EOSQL
    CREATE DATABASE $POSTGRES_DB;
    GRANT ALL PRIVILEGES ON DATABASE $POSTGRES_DB TO $POSTGRES_USER;
    CREATE ROLE vondstmeldingen;
EOSQL

# Load PostGIS into both template_database and $POSTGRES_DB
for DB in "$POSTGRES_DB"; do
	echo "Loading PostGIS extensions into $DB"
	"${psql[@]}" --dbname="$DB" <<-'EOSQL'
		CREATE EXTENSION IF NOT EXISTS postgis;
		CREATE EXTENSION IF NOT EXISTS postgis_topology;
		CREATE EXTENSION IF NOT EXISTS fuzzystrmatch;
		CREATE EXTENSION IF NOT EXISTS postgis_tiger_geocoder;
EOSQL
done


###########################
# DOCUMENTGENERATOR
###########################

# create storage provider db
export POSTGRES_DB="documentgenerator"

#create projects-db for projects_service
psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" <<-EOSQL
    CREATE DATABASE $POSTGRES_DB;
    GRANT ALL PRIVILEGES ON DATABASE $POSTGRES_DB TO $POSTGRES_USER;
    CREATE ROLE documentgenerator_dml;
    CREATE ROLE documentgenerator_ddl;
    CREATE ROLE dgen_dml;
    CREATE ROLE dgen_ddl;
EOSQL
