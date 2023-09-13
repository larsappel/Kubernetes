#!/bin/bash

echo "Starting teardown..."

# Delete ToDo App
echo "Deleting ToDo App..."
kubectl delete -f todo-service.yaml
kubectl delete -f todo-deployment.yaml

# Wait for a few seconds to ensure resources are deleted
sleep 5

# Delete ToDo App ConfigMap
echo "Deleting ToDo App ConfigMap..."
kubectl delete -f todo-configmap.yaml

# Wait for a few seconds to ensure resources are deleted
sleep 5

# Delete MongoDB Initialization Job
echo "Deleting MongoDB Initialization Job..."
kubectl delete -f mongo-init-job.yaml

# Wait for a few seconds to ensure resources are deleted
sleep 5

# Delete Mongo-Express
echo "Deleting Mongo-Express..."
kubectl delete -f mongo-express-service.yaml
kubectl delete -f mongo-express-deployment.yaml

# Wait for a few seconds to ensure resources are deleted
sleep 5

# Delete MongoDB
echo "Deleting MongoDB..."
kubectl delete -f mongodb-service.yaml
kubectl delete -f mongodb-statefulset.yaml

echo "Teardown completed!"

