#!/usr/bin/env bash

set -e

# Get the VPC name from argument
if [ -z "$1" ]; then
  echo "Usage: $0 <vpc-name>"
  exit 1
fi

VPC_NAME=$1

# Get the VPC ID
VPCID=$(aws ec2 describe-vpcs \
  --filters "Name=tag:Name,Values=$VPC_NAME" \
  --region ap-south-1 \
  --output text \
  --query 'Vpcs[0].VpcId')

if [ "$VPCID" = "None" ] || [ -z "$VPCID" ]; then
  echo "VPC '$VPC_NAME' not found!"
  exit 1
fi

echo "VPC ID: $VPCID"

# Get IGW ID attached to the VPC and detach it
IGWID=$(aws ec2 describe-internet-gateways \
  --filters "Name=attachment.vpc-id,Values=$VPCID" \
  --region ap-south-1 \
  --output text \
  --query 'InternetGateways[0].InternetGatewayId')

if [ "$IGWID" = "None" ] || [ -z "$IGWID" ]; then
  echo "No Internet Gateway attached to VPC."
else
  echo "Detaching IGW: $IGWID"
  aws ec2 detach-internet-gateway \
    --internet-gateway-id $IGWID \
    --vpc-id $VPCID \
    --region ap-south-1

  echo "Deleting IGW: $IGWID"
  aws ec2 delete-internet-gateway \
    --internet-gateway-id $IGWID \
    --region ap-south-1
fi

# Get all Subnet IDs in the VPC and delete them
SUBNET_IDS=$(aws ec2 describe-subnets \
  --filters "Name=vpc-id,Values=$VPCID" \
  --region ap-south-1 \
  --output text \
  --query 'Subnets[].SubnetId')
for SUBNETID in $SUBNET_IDS; do
  echo "Deleting Subnet: $SUBNETID"
  aws ec2 delete-subnet \
    --subnet-id $SUBNETID \
    --region ap-south-1
done

# Get all Route Table IDs in the VPC and delete custom ones
RTB_IDS=$(aws ec2 describe-route-tables \
  --filters "Name=vpc-id,Values=$VPCID" \
  --region ap-south-1 \
  --output text \
  --query 'RouteTables[].RouteTableId')
for RTBID in $RTB_IDS; do
  # Skip the main route table
  IS_MAIN=$(aws ec2 describe-route-tables \
    --route-table-ids $RTBID \
    --region ap-south-1 \
    --output text \
    --query 'RouteTables[0].Associations[?Main==`true`]')
  if [ -n "$IS_MAIN" ]; then
    echo "Skipping main Route Table: $RTBID"
    continue
  fi
  echo "Deleting Route Table: $RTBID"
  aws ec2 delete-route-table \
    --route-table-id $RTBID \
    --region ap-south-1
done

# Finally delete the VPC
echo "Deleting VPC: $VPCID"
aws ec2 delete-vpc \
  --vpc-id $VPCID \
  --region ap-south-1

echo "VPC '$VPC_NAME' deleted successfully."
