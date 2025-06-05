# take module name in first argument
#!/bin/bash

module_name=$1

# Build the project
if [ -z "$module_name" ]; then
    mvn clean install -DskipTests
else
    mvn clean install -DskipTests -pl "$module_name" -am
fi

# Check if the ZIP file exists before unzipping
zip_file="./quarkus/dist/target/keycloak-26.2.4.zip"
if [ -f "$zip_file" ]; then
    echo "Unzipping $zip_file..."
    unzip -o "$zip_file" -d ./quarkus/dist/target/
else
    echo "Error: $zip_file not found. Ensure the build step completed successfully."
    exit 1
fi

docker-compose -f docker-compose-dev.yaml up --build --force-recreate --remove-orphans