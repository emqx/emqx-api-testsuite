#!/bin/bash

echo "Enter dashboard username:"
read username

echo "Enter dashboard password:"
read -s password

credentials="${username}:${password}"
base64_credentials=$(echo -n $credentials | base64)

echo "Generated HTTP basic auth token: ${base64_credentials}"
