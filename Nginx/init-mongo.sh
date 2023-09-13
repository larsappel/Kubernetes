#!/bin/bash
set -e

# Wait for MongoDB to be ready
for i in {1..30}; do
    if mongosh --host $MONGO_HOST --port $MONGO_PORT --eval "db.stats()" > /dev/null; then
        break
    fi
    echo "Waiting for MongoDB to start..."
    sleep 2
done

mongosh --host $MONGO_HOST --port $MONGO_PORT <<EOF
use ToDoAppDb
db.ToDoItems.insert({ Title: 'Todo1', IsCompleted: false, Details: 'Initialize MongoDB' })
db.ToDoItems.insert({ Title: 'Todo2', IsCompleted: true, Details: 'Run Kubernetes Job' })
EOF