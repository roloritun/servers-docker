FROM mcr.microsoft.com/mssql/server:2022-latest

# Switch to root to create directories and set permissions
USER root

# Create a config directory in /opt which is writable
RUN mkdir -p /opt/config
WORKDIR /opt/config

# Bundle config source
COPY . /opt/config

# Grant permissions for our scripts to be executable
RUN chmod +x /opt/config/entrypoint.sh
RUN chmod +x /opt/config/configure-db.sh

# Change ownership to mssql user
RUN chown -R mssql:root /opt/config

# Switch back to mssql user
USER mssql

# Set environment variable for the tools
ENV PATH="$PATH:/opt/mssql-tools18/bin"

ENTRYPOINT ["/opt/config/entrypoint.sh"]

# Tail the setup logs to trap the process
CMD ["tail -f /dev/null"]

HEALTHCHECK --interval=30s --timeout=10s --start-period=60s --retries=3 \
    CMD /opt/mssql-tools18/bin/sqlcmd -S localhost -U sa -P $SA_PASSWORD -C -Q "select 1" && grep -q "MSSQL CONFIG COMPLETE" /opt/config/config.log