#!/bin/bash

echo "Enter your username:"
read username

echo "Enter your password:"
read -s password

credentials="${username}:${password}"
base64_credentials=$(echo -n $credentials | base64)

echo "Generated token: ${base64_credentials}"
