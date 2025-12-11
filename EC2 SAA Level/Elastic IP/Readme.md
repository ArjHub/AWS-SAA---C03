## Private Vs Publc IPv4
- Network has two sorts of IPs, IPv4 and IPv6. We focus on IpV4 for now.
- Public IPv4: These are routable on the internet. They are assigned by IANA and distributed by RIRs. Public IPs can be reached from any device connected to the internet.
- Private IPv4: These are not routable on the internet and are used within private networks. They are defined by RFC 1918 and include the following ranges:
    ![alt text](<publicVsprivateIP.png>)

- Private IPs are used for internal communication within a network, such as within a home, office, or data center. They provide a layer of security by isolating internal devices from direct exposure to the internet.

### Fundamental difference
- Public IPs are globally unique and can be accessed from anywhere on the internet, while private IPs are unique only within their specific private network and cannot be accessed directly from the internet.
- Devices with private IPs can communicate with the internet through a process called Network Address Translation (NAT), which allows multiple devices on a private network to share a single public IP address for internet access.
### Use Cases
- Public IPs are used for web servers, email servers, and any service that needs to be accessible from the internet.
- Private IPs are used for internal devices like computers, printers, and servers within a local network.

## Elastic IP
- When you stop and start an Ec2 Instance it can change the publi IP, so if you need to have a fixed public IP for your instance, you need an Elastic IP. It makes us own an IPv4 address and can only be attached to one instane at a time.
- An Elastic IP address is a static, public IPv4 address designed for dynamic cloud computing. It is associated with your AWS account and can be allocated to any instance in your account.
- With this you can mask the failure of an instance or software by rapidly remapping the address to another instance in your account. In other owrds, Elastic IP lets you keep a constant public IP and quickly move it to another EC2 instance, hiding instance or software failures from users.
- You can have only 5 Elastic IP in yyour account.
- If you associate an Elastic IP address with a stopped instance, the Elastic IP address remains associated with the instance. When you start the instance, the Elastic IP address is still associated with it.
- If you do not associate an Elastic IP address with an instance, you will be charged for
- Each Elastic IP address is associated with a specific region. You cannot use an Elastic IP address in a different region than the one in which it was allocated.
- If you release an Elastic IP address, it is returned to the pool of available addresses and can be allocated to another AWS account. You may not be able to get the same Elastic IP address again.
- AWS provides one Elastic IP address per region for free as long as it is associated with a running instance. However, if the Elastic IP address is not associated with a running instance, or if you have more than one Elastic IP address associated with your account, you may incur charges.
- Elastic IP addresses are designed for use with EC2 instances, but they can also be used with other AWS services that require public IP addresses.

### Try avoiding using Elastic IPs because
- They are a scarce public resource.
- They can lead to architecture that is not scalable.
- They can lead to a single point of failure.
- Instead, consider using a load balancer or DNS service to manage traffic to your instances.
- Use Elastic IPs only when you need a static public IP address for your instance, such as for a web server or database server that needs to be accessible from the internet.