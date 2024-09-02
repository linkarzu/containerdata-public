# Contents

<!-- toc -->

<!-- tocstop -->

## Create a common network

- This will be used so that both containers can communicate to each other

```bash
docker network create common_network
```

## Test mongo

- `docker ps` shows it's up

```bash
docker exec mongo mongosh -u mongo -p mongo --authenticationDatabase admin --eval "db.adminCommand({listDatabases: 1})"
```
