#!/usr/bin/env bash
# This script creates a basic VPC with a public subnet, internet gateway, and route table.
set -e

# Create our VPC
VPCID=$(aws ec2 create-vpc \
--cidr-block "172.1.0.0/16" \
--region ap-south-1 \
--tag-specifications 'ResourceType=vpc, Tags=[{Key=Name,Value=my-first-cli-vpc}]' \
--output text \
--query 'Vpc.VpcId')

echo "Created VPC with ID: $VPCID"

## Get the VPC name
VPC_NAME=$(aws ec2 describe-vpcs \
  --vpc-id $VPCID \
  --output text \
  --region ap-south-1) \
  --query "Vpcs[0].Tags[?Key=='Name'].Value | [0]"

echo "VPC Name: $VPC_NAME"

## Turn on dns hostnames for the VPC
aws ec2 modify-vpc-attribute \
--vpc-id $VPCID \
--enable-dns-hostnames "{\"Value\":true}" \
--region ap-south-1

# Create an Internet Gateway(IGW)
IGWID=$(aws ec2 create-internet-gateway \
--region ap-south-1 \
--tag-specifications 'ResourceType=internet-gateway, Tags=[{Key=Name,Value=my-first-cli-igw}]' \
--output text \
--query 'InternetGateway.InternetGatewayId')

echo "Created Internet Gateway with ID: $IGWID"

# Attach the igw to the vpc
aws ec2 attach-internet-gateway \
--internet-gateway-id $IGWID \
--vpc-id $VPCID \
--region ap-south-1

echo "Attached Internet Gateway $IGWID to VPC $VPCID"

# create a new Subnet
SUBNETID=$(aws ec2 create-subnet \
--vpc-id $VPCID \
--cidr-block "172.1.0.0/20" \
--region ap-south-1 \
--tag-specifications 'ResourceType=subnet, Tags=[{Key=Name,Value=my-first-cli-subnet}]' \
--output text \
--query 'Subnet.SubnetId')

echo "Created Subnet with ID: $SUBNETID"

# Cretae a route table explicitly
RTBID=$(aws ec2 create-route-table \
--vpc-id $VPCID \
--region ap-south-1 \
--tag-specifications 'ResourceType=route-table, Tags=[{Key=Name,Value=my-first-cli-rtb}]' \
--output text \
--query 'RouteTable.RouteTableId')

echo "Created Route Table with ID: $RTBID"

# Associate the Route Table with the Subnet
RTBID=$(aws ec2 describe-route-tables \
--filters "Name=vpc-id,Values=$VPCID" \
--region ap-south-1 \
--output text \
--query 'RouteTables[0].RouteTableId')

echo "Route Table ID: $RTBID"

aws ec2 associate-route-table \
--route-table-id $RTBID \
--subnet-id $SUBNETID \
--region ap-south-1

echo "Associated Route Table $RTBID with Subnet $SUBNETID"

# Add a Route to the Internet Gateway in the Route Table
aws ec2 create-route \
--route-table-id $RTBID \
--destination-cidr-block "0.0.0.0/0" \
--gateway-id $IGWID \
--region ap-south-1

echo "Added route to Internet Gateway $IGWID in Route Table $RTBID"

echo "VPC setup complete!"

#Delete the vpc now
echo "Deleting VPC $VPCID and all associated resources..."
echo "sh ./delete_vpc.sh $VPC_NAME"