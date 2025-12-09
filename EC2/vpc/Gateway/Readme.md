# AWS Gateways — Comprehensive Overview

Gateways in AWS enable communication between networks, control traffic flow, and provide secure connectivity to and from your VPC. Different gateways serve different purposes depending on whether you want **internet access**, **hybrid connectivity**, **private access**, or **security inspection**.

This guide explains the major AWS gateways in simple terms with clear examples.

---

# 1. Internet Gateway (IGW)

### **Purpose:**

Enables **public internet access** for resources (EC2 instances, NAT gateways, ALBs) that have a **public IPv4 or IPv6 address**.

### **Key Points:**

* Supports **inbound + outbound** traffic
* Required for public subnets
* Free to use
* Must be attached to the VPC

### **Route Example:**

```
0.0.0.0/0 → igw-xxxx
::/0       → igw-xxxx
```

---

# 2. NAT Gateway (NAT-GW)

### **Purpose:**

Allows **private subnet instances** to access the internet **outbound only**.

### **Why:**

Private instances need internet access (patches, SSM, downloads) but must remain unreachable from the outside.

### **Key Points:**

* Outbound-only internet
* **No inbound** connections allowed
* Costly (per hour + data)
* IPv4 only

### **Route Example:**

```
0.0.0.0/0 → nat-xxxx
```

---

# 3. Egress-Only Internet Gateway (EOIGW)

### **Purpose:**

IPv6 equivalent of NAT Gateway.
Allows **IPv6 outbound** internet traffic, blocks **all inbound traffic**.

### **Key Points:**

* IPv6 only
* Outbound only
* Free
* No IPv4 equivalent (NAT is for IPv4)

### **Route Example:**

```
::/0 → egress-only-igw-xxxx
```

---

# 4. VPC Endpoint (Gateway Type)

### **Purpose:**

Allows private access to certain AWS services **without using IGW or NAT**.

### **Two types:**

* **Gateway Endpoint:** S3, DynamoDB
* **Interface Endpoint (powered by PrivateLink):** All other AWS services

### **Key Points:**

* Private, secure, scalable
* No internet needed
* No NAT required for private subnets

### **Route Example (for S3):**

```
pl-xxxx → vpce-xxxx
```

---

# 5. Virtual Private Gateway (VGW)

### **Purpose:**

AWS side of a **Site-to-Site VPN** connection.

### **Key Points:**

* Works with **Customer Gateway**
* Used for hybrid cloud (on-prem ↔ AWS)
* Supports BGP routing

### **Route Example:**

```
On-Prem Network (10.20.0.0/16) → vgw-xxxx
```

---

# 6. Customer Gateway (CGW)

### **Purpose:**

Represents your **on-premises router/firewall** in AWS during a VPN connection.

### **Key Points:**

* Stores on-prem router public IP
* Defines routing type and BGP ASN
* Paired with a Virtual Private Gateway or Transit Gateway

### **Think of it as:**

“The AWS object representing your physical router.”

---

# 7. Transit Gateway (TGW)

### **Purpose:**

Connects **multiple VPCs**, on‑prem networks, and AWS accounts through a central hub.

### **Key Points:**

* Scalable, high bandwidth
* Replaces complex VPC peering meshes
* Supports VPN + Direct Connect

### **Use Case:**

Multi-account, multi-VPC enterprise networks.

---

# 8. Gateway Load Balancer (GWLB)

### **Purpose:**

Specialized load balancer that distributes **network traffic** across **security appliances**.

Examples:

* Firewalls
* Intrusion detection systems
* Packet inspection devices
* Partner products (Palo Alto, Fortinet, Trend Micro, etc.)

### **Key Points:**

* Uses the GENEVE protocol
* Transparent to the client
* Auto scales security appliances

### **Think of it as:**

“A load balancer built specifically for firewalls.”

---

# Summary Table

| Gateway Type                | Direction                | IPv4/IPv6 Support | Primary Function               |
| --------------------------- | ------------------------ | ----------------- | ------------------------------ |
| **Internet Gateway**        | Inbound + Outbound       | IPv4 + IPv6       | Public internet access         |
| **NAT Gateway**             | Outbound only            | IPv4 only         | Private subnet → Internet      |
| **Egress-Only IGW**         | Outbound only            | IPv6 only         | Secure IPv6 outbound           |
| **Gateway Endpoint**        | Outbound to AWS services | IPv4/6            | Private access to S3/DynamoDB  |
| **Virtual Private Gateway** | Inbound + Outbound       | IPv4/6            | VPN to on-prem                 |
| **Customer Gateway**        | N/A                      | IPv4/6            | Represents your on‑prem router |
| **Transit Gateway**         | Inbound + Outbound       | IPv4/6            | Interconnect VPCs / on‑prem    |
| **Gateway Load Balancer**   | Depends on routing       | IPv4/6            | Security appliance scaling     |

---

If you want, I can also add:

* Flow diagrams for each gateway type
* Route table examples
* Difference: NAT vs IGW vs EOIGW
* Interview‑ready Q&A for gateways

---

# Interview‑Ready Q&A (Gateways)

### **Q1: What is the difference between an Internet Gateway and a NAT Gateway?**

**Answer:**

* **Internet Gateway** allows **inbound and outbound** internet traffic for public IP-enabled resources.
* **NAT Gateway** allows **only outbound** internet access for private subnets. Inbound traffic is blocked.

### **Q2: When would you use an Egress‑Only Internet Gateway?**

**Answer:**
Use it when you have **IPv6-enabled instances** in private subnets that need **outbound-only** internet access. EOIGW blocks inbound IPv6 traffic.

### **Q3: What is a Customer Gateway?**

**Answer:**
A Customer Gateway is an AWS resource that represents your **on‑premises router** in a Site‑to‑Site VPN connection.

### **Q4: What is the purpose of a Virtual Private Gateway?**

**Answer:**
A Virtual Private Gateway is the **AWS side of a VPN tunnel**, used to connect your on‑prem network to AWS.

### **Q5: When do you use a Transit Gateway instead of VPC Peering?**

**Answer:**
Use Transit Gateway when connecting **multiple VPCs or accounts** in a hub‑and‑spoke model. Peering becomes unmanageable in large environments.

### **Q6: What is a Gateway Load Balancer used for?**

**Answer:**
It distributes traffic across **security appliances** such as firewalls and IDS/IPS.

---

# Flow Diagrams for Each Gateway Type

### **Internet Gateway (IGW)**

```
EC2 (Public IP) ---> Route Table ---> IGW ---> Internet
Internet ---> IGW ---> Route Table ---> EC2 (Public IP)
```

### **NAT Gateway (Private Subnet Flow)**

```
EC2 (Private Subnet)
        |
        v
   Route Table
        |
0.0.0.0/0 → NAT Gateway
        |
        v
     IGW
        |
        v
    Internet
```

### **Egress‑Only Internet Gateway**

```
IPv6 EC2 Instance
        |
        v
   Route Table
        |
::/0 → Egress‑Only IGW
        |
        v
     Internet (Outbound only)
```

### **Virtual Private Gateway (VPN Connection)**

```
On‑Prem Router (CGW)
        |
   Encrypted VPN Tunnel
        |
        v
 Virtual Private Gateway (VGW)
        |
        v
       VPC
```

### **Customer Gateway (CGW) Relationship**

```
On‑Prem Router ---> Customer Gateway (AWS)
                       |
                       v
                 Virtual Private Gateway
```

### **Transit Gateway (TGW) Hub Model**

```
           +--------+
 VPC A --->|        |
           |  TGW   |<--- On‑Prem
 VPC B --->|        |
           +--------+
                 ^
                 |
              VPC C
```

### **Gateway Load Balancer (GWLB)**

```
Incoming Traffic
       |
       v
+---------------------+
|  Gateway Load Balancer |
+---------------------+
       |
       | (GENEVE)
       v
Security Appliances (Firewalls)
       |
       v
Return Traffic
```

---

# Route Table Examples

### **1. Public Subnet Route Table**

```
Destination        Target
10.0.0.0/16        local
0.0.0.0/0          igw-123456
::/0               igw-123456
```

### **2. Private Subnet Route Table (IPv4)**

```
Destination        Target
10.0.0.0/16        local
0.0.0.0/0          nat-09abcf
```

### **3. Private Subnet Using EOIGW (IPv6)**

```
Destination        Target
10.0.0.0/16        local
::/0               egress-only-igw-abc12
```

### **4. VPC Endpoint (S3 Gateway Endpoint)**

```
Destination        Target
pl-68a54001        vpce-0abc123
10.0.0.0/16        local
```

### **5. VPN or Direct Connect Route Table**

```
Destination        Target
10.10.0.0/16       vgw-1234abcd
10.0.0.0/16        local
```
