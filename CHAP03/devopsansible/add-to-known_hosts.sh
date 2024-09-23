#!/bin/bash

# Path to your inventory file
inventory_path="inventory"

# Extract ansible_host values and add them to known_hosts
grep ansible_host= $inventory_path | while read -r line ; do
    host=$(echo $line | awk '{print $2}' | sed 's/ansible_host=//')
    ssh-keyscan -H $host >> ~/.ssh/known_hosts
done

echo "All hosts have been added to known_hosts."