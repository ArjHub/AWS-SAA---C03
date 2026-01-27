## What is Network Address Translation ?
Network Address Translation (NAT) is a method used in computer networking to modify network address information in the IP header of packets while they are in transit across a traffic routing device. The primary purpose of NAT is to improve security and reduce the number of IP addresses an organization needs.
NAT enables multiple devices on a local network to share a single public IP address when accessing external networks, such as the internet. This is particularly useful in conserving the limited number of available IPv4 addresses.

## Use cases of NAT
![alt text](<NAT_Use_Cases.png>)

## NAT Gateway
A NAT Gateway is a managed network address translation service provided by AWS that enables instances in a private subnet to connect to the internet or other AWS services, while preventing inbound traffic from the internet from directly reaching those instances. NAT Gateways are designed to be highly available, scalable, and easy to use.

### Key Features of NAT Gateway:
1. **High Availability**: NAT Gateways are deployed in multiple Availability Zones (AZs
) within a region, ensuring that they remain operational even if one AZ experiences an outage.
2. **Scalability**: NAT Gateways automatically scale to accommodate the bandwidth requirements of your network traffic, eliminating the need for manual intervention.
3. **Managed Service**: As a fully managed service, AWS handles the maintenance, patch
ing, and monitoring of NAT Gateways, allowing you to focus on your applications.
4. **Cost-Effective**: NAT Gateways are billed based on the amount of data
processed and the duration they are provisioned, making them a cost-effective solution for enabling internet access for private subnets.
### When to Use NAT Gateway:
- When you need to provide internet access to instances in private subnets without exposing them to inbound
traffic from the internet.
- When you require a highly available and scalable solution for network address translation.
- When you want to offload the management and maintenance of NAT services to AWS.
### Limitations of NAT Gateway:
- NAT Gateways do not support port forwarding, which may be a limitation for certain applications.
- They are not suitable for scenarios that require static IP addresses for outbound traffic, as NAT Gate
ways use dynamic IP addresses.
- NAT Gateways can incur additional costs based on data processing and hourly usage, which should be considered in budgeting.

## NAT Instances
A NAT Instance is an Amazon EC2 instance configured to perform network address translation (NAT) for instances in a private subnet. NAT Instances allow these instances to access the internet while preventing inbound traffic from reaching them directly. Is a legacy service, still seen as a cost effective alternative to NAT agteway. But AWS stopped its support as of 2023. 