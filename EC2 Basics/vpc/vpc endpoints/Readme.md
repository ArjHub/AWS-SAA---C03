## What are VPC Endpoints
VPC Endpoints enable private connections between your Virtual Private Cloud (VPC) and supported AWS services and VPC endpoint services powered by AWS PrivateLink. They allow you to connect to services without requiring an **internet gateway, NAT device, VPN connection, or AWS Direct Connect connection**. This enhances security by keeping traffic within the AWS network.
## Types of VPC Endpoints
There are three types of VPC Endpoints:
1. **Interface Endpoints**: These are powered by AWS PrivateLink and are used to connnect to service such as Amazon EC2, ECS and many more
2. **Gateway Endpoints**: These are used to connect to AWS services like Amazon S3 and DynamoDB.
3. **Gatewat Locad Balancer Endpoints**: These are used to connect to Application Load Balancers and Network Load Balancers within your VPC.

## Key points to remember
- VPC Endpoints are highly available, redundant and horizontally scaled.
- They help improve security by keeping traffic within the AWS network.
- They can be used to connect to AWS services as well as your own services hosted in VPCs.