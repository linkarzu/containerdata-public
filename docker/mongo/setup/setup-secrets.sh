#!/bin/bash

# Filename: ~/github/containerdata-public/docker/mongo/setup/setup-secrets.sh

# Define MongoDB credentials
# The password below `testpass` is just a placeholder, replace your real
# password there
# DO NOT UPLOAD THIS FILE BACK TO A GITHUB REPO ONCE IT HAS THE ACTUAL PASS!!!!!!!
MONGO_USER="unifi"
MONGO_PASS="testpass"

# Create or overwrite .txt files for Docker secrets
SECRETS_DIR="$(dirname "$0")/../.secrets"

# Use printf because echo was assing a newline character at the end
mkdir -p $SECRETS_DIR
printf "%s" "${MONGO_USER}" >"${SECRETS_DIR}/MONGO_USER.txt"
printf "%s" "${MONGO_PASS}" >"${SECRETS_DIR}/MONGO_PASS.txt"
# echo "${MONGO_USER}" >"${SECRETS_DIR}/MONGO_USER.txt"
# echo "${MONGO_PASS}" >"${SECRETS_DIR}/MONGO_PASS.txt"

# Generate the MongoDB init script in the .secrets directory
cat <<EOF >"${SECRETS_DIR}/init-mongo.js"
db.getSiblingDB("unifi").createUser({
  user: "$MONGO_USER",
  pwd: "$MONGO_PASS",
  roles: [{role: "dbOwner", db: "unifi"}]
});

db.getSiblingDB("unifi_stat").createUser({
  user: "$MONGO_USER",
  pwd: "$MONGO_PASS",
  roles: [{role: "dbOwner", db: "unifi_stat"}]
});
EOF

echo
echo "Script executed"
