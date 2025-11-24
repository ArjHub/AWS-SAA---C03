## Route Tables — Clear and Complete Overview

### What is a Route Table?

A **Route Table** in AWS defines how network traffic flows **out of a subnet**. Every subnet must be associated with exactly one route table. Routes in this table determine where packets should be sent based on their **destination IP address**.

Each route consists of two key parts:

* **Destination** — where the traffic is trying to go
* **Target** — the resource that forwards the traffic toward its destination

---

## Key Concepts

### ✔ Destination

Defines **the IP range or address** the traffic is intended for.
Examples:

* `10.0.0.0/16` → VPC CIDR
* `0.0.0.0/0` → All IPv4 internet traffic
* `::/0` → All IPv6 traffic
* `192.168.1.0/24` → Specific private network
* Prefix lists (e.g., `pl-0123456789abcdef0`)

**Think of it as: *Where is the packet trying to go?***

---

### ✔ Target

Determines **how to get traffic to that destination**.
Examples:

* `local` → Stay inside the VPC
* `igw-xxxx` → Internet Gateway
* `nat-xxxx` → NAT Gateway
* `eni-xxxx` → Network Interface
* `vgw-xxxx` → Virtual Private Gateway (VPN)
* `tgw-xxxx` → Transit Gateway
* `vpce-xxxx` → VPC Endpoint (Interface or Gateway)

**Think of it as: *Which gateway/device should handle this traffic?***

---

## How Routing Works (Simple Explanation)

When an EC2 instance sends a packet:

1. AWS checks the **Destination** IP.
2. It finds the matching route in the route table.
3. It sends the packet to the corresponding **Target**.

Example:

```
Destination      Target
0.0.0.0/0        igw-0ab12345
```

Meaning:

> Send all internet-bound traffic through the Internet Gateway.

---

## Types of Subnets Based on Routing

### 🌐 Public Subnet

Has this route:

```
0.0.0.0/0 → igw-xxxx
```

This allows outbound/inbound internet traffic.

### 🔒 Private Subnet

Has this route:

```
0.0.0.0/0 → nat-xxxx
```

Traffic reaches the internet **only through a NAT Gateway**.
No inbound internet access.

### 🔐 Isolated Subnet

Has **no route to internet**.
Only local VPC traffic allowed.

---

## Local Route (Always Present)

Every route table automatically contains:

```
Destination: VPC-CIDR
Target: local
```

This enables communication **inside the VPC**.
It cannot be modified or deleted.

---

## Common Route Targets Explained

### **Internet Gateway (IGW)**

Allows **public internet access** for resources with public IPs.
Used in public subnets.

### **NAT Gateway (NAT)**

Allows private subnets to reach the internet **for outbound only**.
Prevents inbound internet access.

### **VPC Endpoint (VPCE)**

Allows private communication to AWS services **without Internet Gateway or NAT**.
Used for S3, DynamoDB, SSM, EC2Messages, etc.

### **Transit Gateway (TGW)**

Used to connect multiple VPCs or on‑prem with central hub.

### **Virtual Private Gateway (VGW)**

Used for VPN connections to on‑premise networks.

---

## Important Facts

* A subnet can only be associated with **one** route table.
* A route table can be associated with **multiple** subnets.
* The **main route table** applies to any subnet not explicitly associated with another table.
* You cannot delete the `local` route.
* You cannot have overlapping destinations.

---

## Quick Summary

| Term                | Meaning                                           |
| ------------------- | ------------------------------------------------- |
| **Destination**     | Where traffic is going                            |
| **Target**          | How traffic gets there                            |
| **Route Table**     | A set of rules deciding traffic flow from subnets |
| **Public Subnet**   | Uses IGW                                          |
| **Private Subnet**  | Uses NAT                                          |
| **Isolated Subnet** | No internet route                                 |

---

If you want, I can generate a combined VPC + Subnet + Route Table diagram or add examples for real architectures.
