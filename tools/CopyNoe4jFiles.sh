#!/bin/bash
cd ./neo4j/csv
find *.* | xargs -i{} kubectl cp {} imaging/neo4j-core-0:/var/lib/neo4j/import/csv/{}
