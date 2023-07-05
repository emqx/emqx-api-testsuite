#!/bin/bash

echo "Enter dashboard username:"
read username

echo "Enter dashboard password:"
read -s password

token=$(curl -s --json "{\"username\": \"${username}\", \"password\": \"${password}\"}" http://localhost:18083/api/v5/login 2> /dev/null | jq -r '.token')

echo "Got token: ${token}"
