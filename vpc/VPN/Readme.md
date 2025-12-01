## What is a AWS VPN
AWS VPN (Virtual Private Network) is a service that enables you to securely connect your on-premises network or remote clients to your Amazon Virtual Private Cloud (VPC) over an encrypted connection. This allows for secure communication between your local infrastructure and AWS resources. AWS VPC uses IPSec.

## Types of AWS VPN
There are two main types of AWS VPN:
1. **Site-to-Site VPN**: This type of VPN connects your on-premises network to your AWS VPC over an IPsec VPN tunnel. It is typically used for connecting entire networks.
2. **Client VPN**: This is a managed client-based VPN service that allows individual users to securely connect to your AWS VPC from remote locations using OpenVPN-based clients.

## Key features of AWS VPN
- **Secure Connections**: AWS VPN uses strong encryption protocols to ensure that data transmitted between your on-premises network and AWS VPC is secure.
- **High Availability**: AWS VPN is designed for high availability, with automatic failover capabilities to ensure continuous connectivity.
- **Scalability**: AWS VPN can easily scale to accommodate growing network demands.
- **Integration with AWS Services**: AWS VPN integrates seamlessly with other AWS services, allowing for easy management and monitoring of your VPN connections.
## Use Cases
- **Hybrid Cloud Architectures**: Connect on-premises data centers with AWS VPCs
- **Remote Workforce Access**: Enable remote employees to securely access AWS resources
- **Disaster Recovery**: Establish secure connections for backup and disaster recovery solutions

## Site to site VPN
Site-to-Site VPN connections use IPsec tunnels to securely connect your on-premises network or branch office site to your Amazon VPC. This is typically used for connecting entire networks.
![alt text](<site-to-site vpn.png>)
### Key Features:![alt text](<site-site-vpn features.png>)
- **Redundancy**: AWS Site-to-Site VPN automatically creates two tunnels for each 
    VPN connection for redundancy.
- **Dynamic Routing**: Supports Border Gateway Protocol (BGP) for dynamic routing.
- **Static Routing**: Allows you to configure static routes for your VPN connection.
### Use Cases:
- **Connecting Data Centers**: Link your on-premises data centers to AWS VPCs
- **Branch Office Connectivity**: Connect branch offices to your AWS resources

## Virtual Private Gateway (VGW)
A Virtual Private Gateway (VGW) is a virtual router on the AWS side of a VPN connection. It enables communication between your VPC and your on-premises network or other AWS VPCs.
- When you create a VGW (which is neccessary for the Site-to-Site VPN) we should be assignion ga Amazon ASN (Autonomous System NUmber) or Custom ASN. Default ASN is 64512. Once created we cant change the ASN

---
# NOTE:
## What is an ANS?
An Autonomous System Number (ASN) is a unique identifier assigned to each autonomous system (AS) thats in the Internet for use in Border Gateway Protocol (BGP) routing. An AS is a collection of IP networks and routers under the control of a single organization that presents a common routing policy to the internet. ASNs are used to facilitate the exchange of routing information between different autonomous systems on the internet.
---

## Customer Gateway
A Customer Gateway (CGW) is a physical or software appliance on the customer side of a VPN connection. It represents your on-premises network and is used to establish the VPN connection to the AWS Virtual Private Gateway (VGW).
When configuring CGW we will be needing 
- Public IP address of the CGW device
- BGP ASN for customer gateway external device
- Private certificate provisioned by AWS Certificate Manager (ACM)


## Client VPN
AWS Client VPN is a managed client-based VPN service that enables you to securely connect your users to
your AWS VPC from any location using OpenVPN-based clients.