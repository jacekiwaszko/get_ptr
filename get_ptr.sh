#!/bin/bash

# Check if domain name is provided
if [ "$#" -ne 1 ]; then
	    echo "Usage: $0 domain-name"
	        exit 1
fi

# Get the domain name from the command line argument
domain_name=$1

# Use the host command to get the IP address of the domain
ip_address=$(host "$domain_name" | grep -oE "([0-9]{1,3}[\.]){3}[0-9]{1,3}" | head -n 1)

# Check if the IP address was found
if [ -z "$ip_address" ]; then
	    echo "Could not resolve IP address for domain: $domain_name"
	        exit 1
fi

# Use the host command to get the PTR record of the IP address
ptr_record=$(host "$ip_address" | grep "domain name pointer" | awk '{print $5}')

# Check if the PTR record was found
if [ -z "$ptr_record" ]; then
	    echo "No PTR record found for IP address: $ip_address"
	        exit 1
fi

# Output the PTR record
echo "PTR Record for $ip_address: $ptr_record"

