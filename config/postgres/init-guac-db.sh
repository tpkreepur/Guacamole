#!/bin/bash
set -e

psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "$POSTGRES_DB" <<-EOSQL
	CREATE USER guacamole_user WITH PASSWORD 'guacamole_user';
	GRANT SELECT,INSERT,UPDATE,DELETE ON ALL TABLES IN SCHEMA public TO guacamole_user;
	GRANT SELECT,USAGE ON ALL SEQUENCES IN SCHEMA public TO guacamole_user;
EOSQL