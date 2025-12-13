## What are EBS Volumes?

**Amazon Elastic Block Store (EBS)** provides **block-level storage** for EC2 instances.

In simple terms:
👉 **EBS is like a virtual hard disk for your EC2 instance.**

* It is **network-attached**, not physically inside the server
* Data **persists even if the EC2 instance stops or terminates**
* Designed to be **highly available and reliable**

Think of an EBS volume as an **external hard drive in the cloud** that you can attach to an EC2 instance.

---

## Key Characteristics (Simple Terms)

### 1. **Network Drive (Not Physical)**

* EBS communicates with EC2 over the AWS network
* Slight latency compared to local (instance store) disks
* In return, you get **durability and flexibility**

---

### 2. **Data Persists Independently**

* EC2 instance can be:

  * Stopped
  * Rebooted
  * Terminated
* **EBS data remains safe** (unless explicitly deleted)

This makes EBS ideal for databases and application data.

---

### 3. **Attach / Detach Flexibility**

* An EBS volume can be:

  * Detached from one EC2 instance
  * Attached to another EC2 instance **in the same AZ**

**One EBS volume → one EC2 instance at a time**
(except `io1/io2` with Multi-Attach)

---

### 4. **Availability Zone Bound**

* An EBS volume lives in **one specific AZ**
* You **cannot attach it to an instance in another AZ**

To move data across AZs:

1. Take a **snapshot**
2. Create a new volume from the snapshot in another AZ

---

### 5. **Provisioned Capacity**

* You choose:

  * Volume size (GB)
  * Volume type (gp3, io2, etc.)
* Size and performance can be **increased without downtime**

---

## Simple Real-World Examples

---

### **Example 1: Web Server with Persistent Data**

* EC2 instance runs Apache
* EBS volume stores website files

If EC2 crashes:

1. Launch a new EC2 instance
2. Attach the same EBS volume
3. Website files are still there

No data loss

---

### **Example 2: Database Storage**

* EC2 runs MySQL
* EBS stores database files

Even if the instance reboots:

* Database data remains intact

This is why **databases always use EBS**

---

### **Example 3: Moving Data to Another Instance**

* Instance A is slow or broken
* Detach EBS from Instance A
* Attach EBS to Instance B

Result:

* Instance B has **all previous data**

---

## EBS Volume Types (High-Level)

| Type          | Best For                         |
| ------------- | -------------------------------- |
| **gp3**       | General purpose (most workloads) |
| **gp2**       | Older general purpose            |
| **io1 / io2** | High IOPS databases              |
| **st1**       | Large sequential workloads       |
| **sc1**       | Cold data, lowest cost           |

---

## Snapshots (Very Important)

### What is an EBS Snapshot?

* A **backup of your EBS volume**
* Stored in **Amazon S3**
* Incremental (only changes are saved)

### Why Snapshots Matter

* Backup and restore
* Move data across AZs or regions
* Disaster recovery

### EBS Snap shot Features
* Can create new EBS volumes from snapshots
* Snapshots can be shared with other AWS accounts
* Snapshots can be copied to other regions for redundancy
* EBS Snapshot Archieve
  * Long-term storage option for snapshots
  * Lower cost (75% cheaaper), but longer retrieval times (24-72 hours)
* Recycle Bun for EBS Snapshots
  * Deleted snapshots are moved to Recycle Bin.
  * From recycle bin it can be restored within retention period specified (1 day to 1 year)
* Fast snapshot restore
  * Enables volumes created from a snapshot to be instantly available with the performance of a fully-warmed volume
  * Used if the snapshott is so big and also thisa costs a lot


---

## Deleting an EC2 Instance vs EBS
### Delete on Termination controls whether an EBS volume is deleted automatically when its EC2 instance is terminated
* Root volume:

  * Deleted by default on termination
* Additional EBS volumes:

  * **Not deleted unless specified**

Always check **Delete on Termination** setting.

---

## Common Misconceptions (Clarified)

❌ EBS is not a physical disk
❌ EBS cannot be shared by default
❌ EBS is not region-wide
EBS is AZ-scoped, durable, and flexible

---

## One-Line Summary

> EBS volumes are durable, network-attached disks for EC2 that keep your data safe even when instances fail, stop, or are replaced.

