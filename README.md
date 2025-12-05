# Docker Database Servers

A collection of Docker Compose configurations for common database and data infrastructure servers. Each service can be run independently or combined for local development and testing.

## 📋 Available Services

### Databases

- **PostgreSQL** - Relational database with init scripts support
- **MySQL** - Popular relational database with custom configuration
- **MSSQL (SQL Server)** - Microsoft SQL Server 2022 with initialization
- **MongoDB** - NoSQL document database with sample data
- **Cassandra** - Distributed NoSQL database
- **Redis** - In-memory data store with persistence

### Message Queues

- **Kafka** - Distributed event streaming platform with Prometheus metrics
- **RabbitMQ** - Message broker with management UI

### Search & Analytics

- **Elasticsearch** - Search and analytics engine
- **Kibana** - Elasticsearch visualization dashboard
- **Logstash** - Data processing pipeline

### Monitoring & Visualization

- **Prometheus** - Monitoring and alerting toolkit
- **Grafana** - Analytics and monitoring dashboards with Kafka/Flink preconfigured
- **Zeppelin** - Web-based notebook for data analytics
- **Adminer** - Database management UI

## 🚀 Quick Start

### Prerequisites

- Docker Desktop installed
- At least 4GB RAM available for Docker
- Ports available (check the port mappings below)

### Starting a Service

To start any service, use the corresponding docker-compose file:

```bash
# Start PostgreSQL
docker-compose -f docker-compose.postgres.yml up -d

# Start MSSQL
docker-compose -f docker-compose.mssql-linux.yml up -d

# Start MongoDB
docker-compose -f docker-compose.mongo.yml up -d

# Start multiple services
docker-compose -f docker-compose.postgres.yml -f docker-compose.redis.yml up -d
```

### Stopping a Service

```bash
# Stop a service
docker-compose -f docker-compose.postgres.yml down

# Stop and remove volumes (⚠️ deletes data)
docker-compose -f docker-compose.postgres.yml down -v
```

## 🔌 Connection Details

### PostgreSQL

- **Host:** localhost
- **Port:** 5432
- **Database:** postgres
- **Username:** postgres
- **Password:** postgres

```bash
# Connection string
postgresql://postgres:postgres@localhost:5432/postgres
```

### MySQL

- **Host:** localhost
- **Port:** 3306
- **Database:** sample
- **Username:** root
- **Password:** password

```bash
# Connection string
mysql://root:password@localhost:3306/sample
```

### MSSQL (SQL Server)

- **Host:** localhost
- **Port:** 1433
- **Database:** tax.db (created on startup)
- **Username:** sa
- **Password:** Pass@word

```bash
# Connection string
Server=localhost,1433;Database=tax.db;User Id=sa;Password=Pass@word;TrustServerCertificate=True;
```

### MongoDB

- **Host:** localhost
- **Port:** 27017
- **Database:** hiromaily (sample data included)
- **Username:** (none by default)
- **Password:** (none by default)

```bash
# Connection string
mongodb://localhost:27017/hiromaily
```

### Redis

- **Host:** localhost
- **Port:** 6379
- **Password:** (none)

```bash
# Connection string
redis://localhost:6379
```

### Cassandra

- **Host:** localhost
- **Port:** 9042
- **Username:** cassandra
- **Password:** cassandra

### RabbitMQ

- **Host:** localhost
- **Port:** 5672 (AMQP), 15672 (Management UI)
- **Username:** guest
- **Password:** guest
- **Management UI:** <http://localhost:15672>

### Kafka

- **Bootstrap Server:** localhost:9092
- **Zookeeper:** localhost:2181

### Elasticsearch

- **Host:** localhost
- **Port:** 9200
- **HTTP:** <http://localhost:9200>

### Kibana

- **URL:** <http://localhost:5601>1>

### Adminer

- **URL:** <http://localhost:8080>
- Use to manage PostgreSQL, MySQL, MSSQL databases

### Grafana

- **URL:** <http://localhost:3000>
- **Username:** admin
- **Password:** admin
- Pre-configured dashboards for Kafka and Flink

### Prometheus

- **URL:** <http://localhost:9090>0>

### Zeppelin

- **URL:** <http://localhost:8080>

## 📁 Data Persistence

Most services use Docker volumes for data persistence:

- `postgres_data` - PostgreSQL data
- `mysql_data` - MySQL data
- `mssql_data` - MSSQL data
- `mongo_data` - MongoDB data
- `redis_data` - Redis data
- `cassandra_data` - Cassandra data

To view volumes:

```bash
docker volume ls
```

To remove a volume (⚠️ deletes all data):
```bash
docker volume rm <volume_name>
```

## 🛠️ Customization

### Custom Initialization Scripts

#### PostgreSQL

Place `.sql` or `.sh` files in `postgresql/init.d/` - they will run on first startup.

#### MySQL

Place `.sql` files in `mysql/init.d/` - they will run on first startup.

#### MSSQL

Edit `mssql/setup.sql` to customize database initialization.

#### MongoDB

Edit `mongo/init.js` to customize database initialization.

### Environment Variables

You can create a `.env` file to override default values:

```bash
# .env example
POSTGRES_PASSWORD=mysecretpassword
MYSQL_ROOT_PASSWORD=mysecretpassword
SA_PASSWORD=MyStrongP@ssw0rd
```

### Custom Configuration

- **MySQL:** Edit `mysql/conf/custom.cnf`
- **PostgreSQL:** Add config in docker-compose or mount custom postgresql.conf
- **Elasticsearch:** Edit `elasticsearch/config/elasticsearch.yml`
- **Kibana:** Edit `kibana/config/kibana.yml`
- **Logstash:** Edit `logstash/config/logstash.yml` and `logstash/pipeline/logstash.conf`

## 🔍 Troubleshooting

### Container won't start

```bash
# Check container logs
docker logs <container_name>

# Check if port is already in use
lsof -i :<port_number>

# Check container status
docker ps -a
```

### Permission issues (MSSQL on macOS)

MSSQL 2022 runs as non-root user. The Dockerfile is configured to use `/home/mssql/config` directory.

### Out of memory

Increase Docker Desktop memory allocation:

- Docker Desktop → Settings → Resources → Memory

### Network issues

All services use the `servers_net` bridge network. Ensure it's not conflicting:

```bash
docker network ls
docker network inspect servers_net
```

### Reset everything

```bash
# Stop all containers
docker-compose -f docker-compose.*.yml down

# Remove all volumes (⚠️ deletes all data)
docker volume prune

# Remove all images
docker image prune -a
```

## 📚 Extensions

Additional services are available in the `extensions/` directory:

- **APM Server** - Application Performance Monitoring for Elastic Stack
- **Curator** - Elasticsearch index management
- **Enterprise Search** - Elastic Enterprise Search
- **Logspout** - Docker log router

See individual README files in `extensions/` for details.

## 🤝 Contributing

Feel free to add more services or improve existing configurations. Common patterns:

1. Use volumes for data persistence
2. Use the `servers_net` network
3. Include health checks where applicable
4. Document default credentials and ports
5. Provide initialization scripts for setup

## 📝 License

This repository is provided as-is for development and testing purposes.

## ⚠️ Security Warning

**DO NOT use default passwords in production environments!** These configurations are intended for local development only. Always use strong, unique passwords and proper security measures in production.
