## Security Groups (SG) — Updated Overview

### What is a Security Group?

A **Security Group (SG)** acts as a **stateful virtual firewall** for your EC2 instances. It controls **inbound** and **outbound** traffic at the instance level. Every EC2 instance must be associated with at least one security group.

If you do not specify one during creation, AWS assigns the **default security group** for that VPC.

---

## Default Behavior

* **Inbound:** All inbound traffic is **denied by default**.
* **Outbound:** All outbound traffic is **allowed by default**.

---

## Key Features (Accurate 2024–2025)

### ✔ Stateful

Security groups are **stateful**, meaning:

* If you allow inbound traffic, the **response outbound traffic is automatically allowed**, even if no outbound rule exists.
* If you allow outbound traffic, the **response inbound traffic is automatically allowed**.

### ✔ Only ALLOW rules

* SGs do **not support DENY** rules.
* To explicitly block IPs or CIDRs, you must use **Network ACLs**.

### ✔ Multiple SGs

* You can attach **up to 5** security groups to an EC2 instance.

### ✔ Dynamic updates

* Updating rules applies **immediately** to all attached instances.

### ✔ Cross-SG and intra-SG communication

* SGs **can** reference themselves to allow communication between instances in the same SG.
* SGs **can** reference other SGs to allow communication between groups.

### ✔ VPC-bound

* SGs can only reference other SGs **within the same VPC**.

---

## What You *Cannot* Do

* ❌ Cannot add DENY rules
* ❌ Cannot reference SGs from a different VPC
* ❌ Cannot delete a security group that is in use
* ❌ Cannot delete the default security group
* ❌ Cannot remove the default outbound allow rule from the default SG

---

## Limits to Remember

* **60 inbound rules** per SG
* **60 outbound rules** per SG
* **Up to 2,500 security groups per VPC** by default (can be increased to **5,000** via support ticket)
* **Up to 5 SGs per instance**

---

## Quick Comparison

| Component          | Purpose                                         |
| ------------------ | ----------------------------------------------- |
| **Security Group** | Instance-level, stateful firewall (allow-only)  |
| **Network ACL**    | Subnet-level, stateless firewall (allow + deny) |

---

If you want, I can also add sections describing NACLs, VPCs, or EC2 connectivity notes.
