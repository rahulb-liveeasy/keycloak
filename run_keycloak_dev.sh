#!/bin/bash

module_name=$1
no_build=$2

if [ "$no_build" != "no_build" ]; then
    if [ -z "$module_name" ]; then
        mvn clean install -DskipTests
    else
        mvn clean install -DskipTests -pl "$module_name" -am
    fi
else
    echo "Skipping build as 'no_build' flag is passed."
fi

zip_file="./quarkus/dist/target/keycloak-26.2.4.zip"
if [ -f "$zip_file" ]; then
    echo "Unzipping $zip_file..."
    unzip -o "$zip_file" -d ./quarkus/dist/target/
else
    echo "Error: $zip_file not found. Ensure the build step completed successfully."
    exit 1
fi

docker-compose -f docker-compose-dev.yaml up --build --force-recreate --remove-orphans

# command to run to run without building
# ./run_keycloak_dev.sh "" no_build