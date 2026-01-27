# IPv6 Egress‑Only Internet Gateway Lab (With SSM) — Full README

This lab demonstrates how to build a VPC that has **IPv6‑only outbound internet access** using an **Egress‑Only Internet Gateway (EOIGW)**, while **IPv4 outbound is intentionally blocked** — even though NAT Gateway + IGW exist. This proves that **route tables**, not resources, determine outbound access.

The EC2 instance will be accessed using **AWS Systems Manager (SSM)** with **no public IPs**.

---

# ## 🟥 Lab Goal

* Create a dual‑stack VPC (IPv4 + IPv6)
* Provide **IPv6 outbound internet** ONLY
* Block **IPv4 outbound** (no 0.0.0.0/0 route)
* Use **DNS64 + NAT64** so IPv6 instance can reach IPv4 websites
* Demonstrate traffic behavior inside the EC2 instance
* Access EC2 using **SSM Session Manager** (no SSH)

---

# ## 1️⃣ Create a VPC (IPv4 + AWS‑provided IPv6)

AWS assigns a **/56 IPv6 block** to the VPC.

```sh
aws ec2 create-vpc \
  --cidr-block 10.0.0.0/16 \
  --amazon-provided-ipv6-cidr-block
```

**Why?**

* VPC gets IPv4 = 10.0.0.0/16
* VPC gets an Amazon‑provided IPv6 /56 block
* Dual‑stack environment for testing both IP versions

---

# ## 2️⃣ Create a Subnet (IPv4 + IPv6)

Use a **/64 IPv6 block** carved from the VPC’s /56.

```sh
aws ec2 create-subnet \
  --vpc-id <vpc-id> \
  --ipv6-cidr-block <your-/64> \
  --cidr-block 10.0.2.0/24
```

**Why?**

* Each subnet must use a /64 for IPv6
* Subnet will support both IPv4 + IPv6 address assignment

---

# ## 3️⃣ Enable DNS64 (required for NAT64)

```sh
aws ec2 modify-subnet-attribute \
  --subnet-id <subnet-id> \
  --enable-dns64
```

**Why?**

* DNS64 synthesizes IPv6 addresses for IPv4‑only domains
* Required so IPv6‑only EC2 can reach IPv4 websites

---

# ## 4️⃣ Create an Egress‑Only Internet Gateway

```sh
aws ec2 create-egress-only-internet-gateway \
  --vpc-id <vpc-id>
```

**Why?**

* Provides **IPv6 outbound internet only**
* Blocks all inbound IPv6 traffic
* Equivalent to NAT Gateway, but for IPv6

---

# ## 5️⃣ Create an Internet Gateway (for demonstration)

```sh
aws ec2 create-internet-gateway
```

**Why?**

* Needed ONLY to show that IPv4 outbound can exist
* But we intentionally will NOT add an IPv4 route

---

# ## 6️⃣ Attach the IGW to the VPC

```sh
aws ec2 attach-internet-gateway \
  --internet-gateway-id <igw-id> \
  --vpc-id <vpc-id>
```

**Why?**

* IGW is required for NAT Gateway operations
* Still, **IPv4 will not work** without a route

---

# ## 7️⃣ Allocate an Elastic IP (for NAT Gateway)

```sh
aws ec2 allocate-address
```

**Why?**

* NAT Gateway requires an Elastic IP
* This allows IPv6→IPv4 translation (NAT64)

---

# ## 8️⃣ Create a NAT Gateway

```sh
aws ec2 create-nat-gateway \
  --subnet-id <subnet-id> \
  --allocation-id <eipalloc-id>
```

**Why?**

* NAT64 uses IPv4 NAT Gateway for IPv4 destinations
* Needed only for NAT64 — not for IPv4 outbound

---

# ## 9️⃣ Create a Route Table

```sh
aws ec2 create-route-table \
  --vpc-id <vpc-id>
```

**Why?**

* Custom route table for IPv6 and NAT64 routing

---

# ## 🔟 Add IPv6 outbound route (EOIGW)

```sh
aws ec2 create-route \
  --route-table-id <rtb-id> \
  --destination-ipv6-cidr-block ::/0 \
  --egress-only-internet-gateway-id <eigw-id>
```

**Why?**

* Allows ALL IPv6 outbound traffic
* Ensures **no inbound IPv6**

---

# ## 1️⃣1️⃣ NAT64 Route

```sh
aws ec2 create-route \
  --route-table-id <rtb-id> \
  --destination-ipv6-cidr-block 64:ff9b::/96 \
  --nat-gateway-id <nat-id>
```

**Why?**

* The prefix `64:ff9b::/96` maps IPv6 → IPv4
* Allows IPv6‑only instance to reach IPv4 sites

---

# ## 1️⃣2️⃣ Associate Route Table with Subnet

```sh
aws ec2 associate-route-table \
  --subnet-id <subnet-id> \
  --route-table-id <rtb-id>
```

**Why?**

* Subnet now becomes an **IPv6‑only outbound subnet**
* IPv4 outbound still blocked due to NO 0.0.0.0/0 route

---

# ## 1️⃣3️⃣ Create IAM Role for SSM

```sh
aws iam attach-role-policy \
  --role-name LabInstanceRole \
  --policy-arn arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore
```

**Why?**

* Allows EC2 to register with SSM
* No SSH needed

---

# ## 1️⃣4️⃣ Create Instance Profile + Attach Role

```sh
aws iam create-instance-profile --instance-profile-name LabInstanceRole
```

```sh
aws iam add-role-to-instance-profile \
  --instance-profile-name LabInstanceRole \
  --role-name LabInstanceRole
```

**Why?**

* EC2 uses this instance profile at launch

---

# ## 1️⃣5️⃣ Launch EC2 Instance

```sh
aws ec2 run-instances \
  --image-id <ami-id> \
  --count 1 \
  --instance-type t2.micro \
  --subnet-id <subnet-id> \
  --iam-instance-profile Name=LabInstanceRole
```

**Why?**

* Places EC2 inside IPv6‑only outbound subnet
* EC2 will:

  * ✔ Reach IPv6 websites
  * ✔ Reach IPv4 websites (via NAT64)
  * ❌ NOT reach internet via IPv4 directly
  * ✔ Connect via SSM Session Manager

---

# ## ✔ What You Demonstrate in the Lab

Inside the instance (via SSM Session Manager):

### ✔ IPv6 outbound works

```
curl https://ipv6.google.com
```

### ✔ IPv4 websites work (via NAT64)

```
curl https://aws.amazon.com
```

### ❌ Direct IPv4 outbound fails

```
ping 8.8.8.8
curl https://1.1.1.1
```

Because you did **not** create:

```
0.0.0.0/0 → igw
```

or

```
0.0.0.0/0 → nat
```

---

# ## 🎯 Summary

This lab clearly demonstrates:

| Traffic Type            | Result    | Reason              |
| ----------------------- | --------- | ------------------- |
| IPv6 outbound           | ✔ Works   | EOIGW route ::/0    |
| IPv6 inbound            | ❌ Blocked | EOIGW design        |
| IPv4 outbound           | ❌ Fails   | No 0.0.0.0/0 route  |
| IPv4 outbound via NAT64 | ✔ Works   | DNS64 + NAT64       |
| EC2 access              | ✔ Works   | SSM Session Manager |

---
