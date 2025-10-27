#!/bin/bash

# wait for MSSQL server to start
export STATUS=1
i=0

while [[ $STATUS -ne 0 ]] && [[ $i -lt 30 ]]; do
	i=$i+1
	/opt/mssql-tools18/bin/sqlcmd -S localhost -t 1 -U sa -P $SA_PASSWORD -C -Q "select 1" >> /dev/null
	STATUS=$?
done

if [ $STATUS -ne 0 ]; then 
	echo "Error: MSSQL SERVER took more than thirty seconds to start up."
	exit 1
fi

echo "======= MSSQL SERVER STARTED ========" | tee -a /opt/config/config.log
# Run the setup script to create the DB and the schema in the DB
/opt/mssql-tools18/bin/sqlcmd -S localhost -U sa -P $SA_PASSWORD -C -d master -i /opt/config/setup.sql

echo "======= MSSQL CONFIG COMPLETE =======" | tee -a /opt/config/config.log