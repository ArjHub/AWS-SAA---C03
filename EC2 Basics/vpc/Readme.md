## What is a AWS VPC
A Virtual Private Cloud (VPC) is a virtual network dedicated to your AWS account. It is **logically isolated** from other virtual networks in the AWS Cloud, providing you with complete control over your networking environment, including selection of your own IP address range, creation of subnets, and configuration of route tables and network gateways.

## Core components of VPC
1. **Subnets**: Subnets are segments of a VPC's IP address range where you can place groups of isolated resources. You can create public, private, and VPN-only subnets within your VPC.
2. **Route Tables**: Route tables contain a set of rules, called routes, that determine where network traffic is directed.
3. **Internet Gateway**: An Internet Gateway is a horizontally scaled, redundant, and highly available VPC component that allows communication between instances in your VPC and the internet. (Basically enables acces to the internet)
4. **NAT Gateway**: A NAT Gateway lets instances in a private subnet access the internet or other AWS services by translating their private IPs to a public IP, while blocking any unsolicited inbound connections from the internet. (Think of it as a one-way internet exit gate for private instances.)
5. **Security Groups**: Security Groups act as virtual firewalls for your instances to control inbound and outbound traffic. (A guard at your instance level)
6. **Network ACLs**: Network Access Control Lists (ACLs) are an additional layer of security that act as a firewall for controlling traffic in and out of one or more subnets. (A guard at subnet level)
7. **VPC Peering**: VPC Peering allows you to connect two VPCs privately using AWS's network, enabling resources in either VPC to communicate with each other as if they are within the same network.

## Key features of VPC

1. **Region Specific**:
 - VPCs are created within specific AWS regions, allowing you to design your network architecture based on geographical requirements and compliance needs. 
    - We can use VPC peering to connect VPC's across regions.
    - We can create upto 5 VPCs per region.
    - Every region comes with a default VPC.
    - Can have 200 subnets per VPC.
    - 5 ipv4 and ipv6 CIDR block per VPC (Adjustable upto 50)
2. **Customizable Network Configuration**:
    - You have full control over your VPC's network configuration, including IP address ranges, subnets, route tables, and network gateways.
3. **Enhanced Security**:
    - VPCs provide multiple layers of security, including security groups and network ACLs, to protect your resources.
4. **Scalability and Flexibility**:
    - VPCs can be easily scaled to accommodate growing workloads and can be customized to meet specific application requirements.
5. **Integration with Other AWS Services**:
    - VPCs seamlessly integrate with various AWS services, such as EC2, RDS Lambda, and S3, enabling you to build complex and secure cloud architectures.
6. **Multiple Connectivity Options**:
    - VPCs support various connectivity options, including VPN connections, AWS Direct Connect, and VPC peering, allowing you to connect your VPC to on-premises networks or other VPCs.
7. **Support for IPv6**:
    - VPCs support both IPv4 and IPv6 addressing, enabling you to future-proof your applications and accommodate growing address space requirements.

## VPC Basics
- Each VPC spans all the Availability Zones in the region.
- Each subnet must reside entirely within one Availability Zone and cannot span zones.
- You can launch AWS resources into a specified subnet of your VPC.
- By default, each VPC comes with a default route table, default security group, and default network ACL.
- You can create a VPC using the AWS Management Console, AWS CLI, or AWS SDK
- You can assign both IPv4 and IPv6 addresses to your VPC and its resources.
- You can use VPC Flow Logs to capture information about the IP traffic going to and from network interfaces in your VPC.