## What is EC2
Amazon Elastic Compute Cloud (EC2) is a web service that provides resizable compute capacity in the cloud. It allows users to run virtual servers, known as instances, on-demand, enabling them to scale their computing resources up or down based on their needs. EC2 is designed to make web-scale cloud computing easier for developers by providing a simple and flexible way to deploy and manage applications.

## EC2 Components:
- **Instances**: Virtual servers that run applications.
- **Amazon Machine Images (AMIs)**: Pre-configured templates for launching instances.
- **Instance Types**: Different configurations of CPU, memory, storage, and networking capacity for instances.
- **Elastic Block Store (EBS)**: Persistent block storage for instances.
- **Security Groups**: Virtual firewalls that control inbound and outbound traffic to instances.
- **Key Pairs**: Secure login credentials for instances.
- **ELB**: Elastic Load Balancing distributes incoming application traffic across multiple instances for better fault tolerance and availability
- **ASG**: Auto Scaling Groups automatically adjust the number of instances based on demand to maintain performance and cost-efficiency.

## EC2 Sizing and Configuration options
- **Operting system**:
    - Choose from various operating systems, including Linux distributions (e.g., Ubuntu, Amazon Linux) and Windows Server versions.
- **Instance types**:
    - Select from a wide range of instance types optimized for different use cases, such as general
        purpose, compute-optimized, memory-optimized, storage-optimized, and GPU instances.
- **Storage options**:
    - Choose between different storage options, such as EBS for persistent block storage and instance store
        for temporary storage.
- **Networking**:
    - Configure networking options, including Virtual Private Cloud (VPC) settings, security groups,
        and Elastic IP addresses.
- **Scaling options**:
    - Set up Auto Scaling to automatically adjust the number of instances based on demand.
- **RAM & CPU**: 
    - Select instance types based on required RAM and CPU resources for your applications.
- **Bootstrap Script**:
    - Use *user data* scripts to automate instance configuration and software installation during first launch.

## EC2 User Data
EC2 User Data is a feature that allows you to provide custom scripts or commands that are executed automatically when an EC2 instance is launched. This is commonly used for bootstrapping instances, such as installing software, configuring settings, or performing other initialization tasks.

That Script is only run once when the instance is first launched. If you stop and start the instance again, the user data script will not run again unless you specifically configure it to do so.

EC2 User Data script runs with the root user , so it has full administrative privileges on the instance. This allows the script to perform tasks that require elevated permissions, such as installing software packages or modifying system configurations.
### Example:
```sh
#!/bin/bash
# Install httpd (Linux Version 2)
yum update -y
yum install -y httpd
systemctl start httpd
systemctl enable httpd
echo "<h1> Hello World from $(hostname -f)</h1>" > /var/www/html/index.html
```
## EC2 Instance Types
EC2 instance types are categorized based on their intended use cases and performance characteristics. Here are some common EC2 instance types:
- **General Purpose**: Balanced performance for a wide range of applications (e.g., t2.micro, m5.large).
- **Compute Optimized**: High CPU performance for compute-intensive workloads (e.g., c5.large, c-series).
- **Memory Optimized**: High memory capacity for memory-intensive applications (e.g., r5.large, r-series and also x and z ones).
- **Storage optimized**: Greate for storag-intensive tasls that require high and sequetial read and write operations (e.g i-series, d-series and h1)

#### ec2.instance.info - has list of all the instances we have in AWS


### NOTE
- When you stop an EC2 instance and then start it again, the public IPv4 address might change because, by default, EC2 instances are assigned dynamic public IP addresses from a pool of available addresses. When an instance is stopped, its associated public IP address is released back to the pool, and when the instance is started again, it may be assigned a different public IP address.
- To maintain a consistent public IP address for your EC2 instance, you can use an Elastic IP address, which is a static IPv4 address designed for dynamic cloud computing. You can associate an Elastic IP address with your EC2 instance, and it will remain the same even if you stop and start the instance.
- If you require a static private IP address within your Virtual Private Cloud (VPC), you can specify a private IP address when launching the instance or configure it in the instance's network interface settings. This private IP address will remain consistent as long as the instance is running within the same VPC.
- EC2 instances launched in a default VPC automatically receive a public IPv4 address unless you specify otherwise during the instance launch process.
- If you need to retain the same public IP address across instance stops and starts without using an Elastic IP, consider using a VPC with a NAT gateway or a VPN connection that allows for more controlled network configurations.