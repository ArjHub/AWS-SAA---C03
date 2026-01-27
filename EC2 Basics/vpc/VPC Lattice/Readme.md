## What is a VPC Lattice 
Is a fully manages application networking service that you use to connect secure and monitor the services for ur applications
Easiy turning AWS resources into services for a micro services architecture.

## Key Features of VPC Lattice
Works with a single/multiple VPC
Works across multiple AWS accounts
Supports services hosted on EC2 instances, ECS, EKS and Fargate
Integrates with IAM 
Supports HTTP/HTTPS and TCP protocols
Performs NAT for IPv4/6 and overlapping networks
Supports VPC endpoint services
Suppports custom domain names

## Components
1. Services: A service is an application component that you want to make available for communication within your VPC Lattice. Services can be hosted on various AWS resources, such as EC2 instances, ECS tasks, or Lambda functions.
2. Service Network: A service network is a logical boundary that defines the communication scope for services
within a VPC Lattice. It allows you to group services together and control their communication.
3. Listeners: Listeners are used to define how incoming traffic is routed to services within
a service network. They specify the protocol and port for communication.
4. Targets: Targets are the actual endpoints that receive traffic from services. They can be EC
2 instances, ECS tasks, or Lambda functions.
5. Routing Rules: Routing rules determine how traffic is directed to different targets based on conditions such
as path patterns or host headers.
6. Service Directory: Service Directory is a managed service that helps you register and discover services within your VPC Lattice. It provides a centralized registry for services, making it easier to manage and locate them.
![alt text](<VPC Lattice.png>)