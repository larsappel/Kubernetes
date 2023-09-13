#!/bin/bash

progress_bar() {
    local duration=$1
    local increment=$((100/duration))
    local progress=0

    echo -n "["
    
    # While duration is not yet zero
    while [ $duration -gt 0 ]; do
        # Sleep for 1 second
        sleep 1
        # Decrement the duration
        ((duration--))
        # Increase the progress
        ((progress+=increment))

        # Print the progress bar
        printf -v f "%$(tput cols)s"
        printf "\r[%-${progress}s" "#" 
    done

    echo "]"
}

echo "Starting deployment..."

# Deploy MongoDB
echo "Deploying MongoDB..."
kubectl apply -f mongodb-statefulset.yaml
kubectl apply -f mongodb-service.yaml

# Wait for MongoDB to be up and running
echo "Waiting for MongoDB to be ready..."
progress_bar 30  # This can be adjusted or replaced with a loop to check the pod's status

# Deploy Mongo-Express
echo "Deploying Mongo-Express..."
kubectl apply -f mongo-express-deployment.yaml
kubectl apply -f mongo-express-service.yaml

# Wait for Mongo-Express to be up and running
echo "Waiting for Mongo-Express to be ready..."
progress_bar 20  # This can be adjusted or replaced with a loop to check the pod's status

# Initialize MongoDB
echo "Initializing MongoDB..."
kubectl apply -f mongo-init-job.yaml
progress_bar 5

# Deploy ToDo App ConfigMap
echo "Deploying ToDo App ConfigMap..."
kubectl apply -f todo-configmap.yaml
progress_bar 5

# Deploy ToDo App
echo "Deploying ToDo App..."
kubectl apply -f todo-deployment.yaml
kubectl apply -f todo-service.yaml

echo "Deployment completed!"
