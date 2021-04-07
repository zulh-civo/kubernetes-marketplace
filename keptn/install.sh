#!/bin/bash

kubectl config get-contexts

kubectl cluster-info

curl -sL https://get.keptn.sh | bash

echo "{}" > creds.json

keptn install --endpoint-service-type=NodePort --creds ./creds.json
