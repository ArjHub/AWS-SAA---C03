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

We have a total of 6 types

| Type          | Best For                         |
| ------------- | -------------------------------- |
| **gp3**       | General purpose (most workloads) |
| **gp2**       | Older general purpose            |
| **io1 / io2** | High IOPS databases              |
| **st1**       | Large sequential workloads       |
| **sc1**       | Cold data, lowest cost           |

### Genral purpose SSD
  - Cost effective storage and low latency.
  - We can use it for system boot , virtual desktops and test enviroinments
  - size varies from 1 GiB to 16 TiB
  - gp3 newer version and baseline we will be doing 3000IOPS and throughput of 125 MiB/s which can be increased upto 16,000 and throughtput upto 1000MiB/s independently
  - gp2 older version and baseline we will be doing 3 IOPS per GiB of volume size. can go upto 16,000 IOPS. 3 IOPS per gibs eans at 5334 GiB we are the max IOPS
### Provisioned IOPS SSD (High IOPS)
  - Used for critical business applications that need high performance like (more than 16000) large relational or NoSQL databases
  - size varies from 4 GiB to 16 TiB
  - io1 can go upto 64,000 IOPS and io2 (block express) can go upto 256,000 IOPS
  - we can have maximum of 500 IOPS per GiB for io1 and 1,000 IOPS per GiB for io2
  - we can use Multi-Attach feature to attach a single volume to multiple EC2 instances in the same AZ
  - great for database workloads (sesnsitivce to storage perf and consistency)
### Throughput Optimized HDD
  - low cost HDD volume designed for frequently accessed, throughput intensive workloads
  - size varies from 500 GiB to 16 TiB
  - used for big data, data warehouses, log processing
  - maximum throughput of 500 MiB/s
### Cold HDD
  - lowest cost HDD volume designed for less frequently accessed workloads
  - size varies from 500 GiB to 16 TiB
  - used for colder data requiring fewer scans per day
  - maximum throughput of 250 MiB/s

---

## EBS Multi Attach - io1/io2 family
![alt text](<EBS Multi attach.png>)
* Allows a single EBS volume to be attached to up to **16** Nitro-based EC2 instances within the **same AZ**
* Enables applications to achieve high availability and scalability by allowing multiple instances to access the same data concurrently
* Thus all the instances can read and write at the same time. This is dangerous unless followed with some strict rules
* Only supported on io1 and io2 volume types and use a file system thats cluster aware (meaning provided below)
* Use cases include clustered databases and distributed file systems

### Getting an undestanding on cluster aware file system

**File systems like:**
 - ext4
 - xfs
Assume:
Only one OS controls the disk
One kernel updates metadata (file size, locks, inode tables)
No coordination with other machines
If two EC2 instances mount the same ext4 disk:
Both think they own it
Metadata gets corrupted
Data loss is guaranteed (not “possible” — guaranteed)

**A cluster-aware file system:**
Knows multiple machines are using the disk
Uses distributed locking
Coordinates:
Who can write
When metadata changes
Prevents overwrite conflicts
Think of it as:
A shared Google Doc with real-time locking, not a Word file on a USB stick.
Examples
 - GFS2 (Red Hat clusters)
 - OCFS2 (Oracle clusters)

### Why only io1 / io2?
This is not arbitrary.
io1 / io2 are high-end, low-latency, strongly consistent block storage
AWS can guarantee write ordering and durability
Cheaper volumes (gp2, gp3, st1, sc1) cannot safely coordinate concurrent writes
So AWS limits Multi-Attach to volumes that can technically survive this chaos.
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

 