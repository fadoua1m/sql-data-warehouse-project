#!/bin/bash

DB_NAME="datawarehouse"

case "$1" in
  init)
    echo "Creating database if not exists..."
    # Create database from postgres database
    sudo -u postgres psql -c "SELECT 1 FROM pg_database WHERE datname = '$DB_NAME'" | grep -q 1 || \
    sudo -u postgres psql -c "CREATE DATABASE $DB_NAME;"
    echo "  Creating schemas..."
    sudo -u postgres psql -d $DB_NAME -f init_database.sql
    echo "  Database and schemas created successfully" 
    sudo -u postgres psql -d $DB_NAME -f bronze/ddl_bronze.sql
    echo "  Tables created successfully "
    sudo -u postgres psql -d $DB_NAME -f bronze/proc_load_bronze.sql
    echo "  Data is loaded successfully"
    ;;
  *)
    echo "Usage: ./db.sh init"
    ;;
esac
