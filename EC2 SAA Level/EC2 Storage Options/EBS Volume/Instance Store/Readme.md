# EC2 Instances & Instance Store (Made Simple)

## What is an EC2 Instance?

An **EC2 Instance** is a **virtual server** running in AWS data centers.
You use it to run applications just like you would on a physical computer or VM.

In simple terms:
👉 **EC2 = a computer in the cloud that you control**

With EC2, you can:

* Choose CPU, memory, storage, and network capacity
* Install any OS (Linux, Windows)
* Install software (Apache, Docker, databases, etc.)
* Start, stop, resize, or terminate when needed

### Example

* Running a web server (Apache / Nginx)
* Hosting a backend API
* Running batch jobs or scripts
* Hosting Docker containers or Kubernetes nodes

---

## Types of Storage for EC2

An EC2 instance can use **two main types of storage**:

1. **EBS (Elastic Block Store)** – Network-attached storage
2. **Instance Store** – Physically attached storage

This section focuses on **Instance Store**.

---

## What is EC2 Instance Store?

**EC2 Instance Store** provides **temporary, block-level storage** that is **physically attached to the host machine** where your EC2 instance is running.

In simple terms:
👉 **Instance Store = fast, local disk attached directly to the EC2 machine**

---

## Key Characteristics of Instance Store

### 🔹 1. Temporary (Ephemeral) Storage

* Data is **lost** if:

  * Instance is stopped
  * Instance is terminated
  * Host machine fails
* Data **persists only while the instance is running**

⚠️ **Never use Instance Store for important or long-term data**

---

### 🔹 2. Very High Performance

* Because it is **local disk**, there is:

  * Very low latency
  * Very high IOPS and throughput
* Faster than EBS for certain workloads

👉 This is the **main reason** Instance Store exists.

---

### 🔹 3. Cannot Be Detached or Reattached

* Instance Store is:

  * Attached at launch time
  * Cannot be detached
  * Cannot be attached to another instance

Unlike EBS:

* You cannot move it
* You cannot snapshot it

---

### 🔹 4. Comes with Certain Instance Types

* Not all EC2 instances support Instance Store
* Typically available with:

  * `i3`, `i4`, `d2`, `c5d`, `m5d`, etc.

---

## Why Not Always Use EBS?

EBS is excellent, but it has **trade-offs**.

### EBS Limitations (Compared to Instance Store)

* EBS is a **network drive**
* Communicates over the network
* Slightly higher latency
* Performance is provisioned (IOPS / throughput limits)

👉 For **ultra-high performance**, network storage can become a bottleneck.

---

## When Should You Use Instance Store?

### ✅ Best Use Cases

Instance Store is ideal for **temporary, high-performance data**, such as:

* Caching (Redis cache without persistence)
* Buffers
* Temporary files
* Scratch space
* Big data processing (Hadoop, Spark shuffle data)
* Video rendering scratch disks
* Load balancer temporary storage

### Example

A data processing job:

* Reads raw data from S3
* Processes data using EC2
* Stores intermediate files on Instance Store
* Writes final output back to S3
* Instance terminates → data loss is acceptable

---

## When Should You Use EBS Instead?

### ✅ Use EBS when:

* Data must survive instance stop/termination
* You need backups (snapshots)
* You need to move storage between instances
* You need predictable durability

### Example

* Databases
* Application state
* Logs
* User data

---

## Instance Store vs EBS (Quick Comparison)

| Feature          | Instance Store    | EBS                |
| ---------------- | ----------------- | ------------------ |
| Storage Type     | Local (Physical)  | Network            |
| Data Persistence | ❌ Temporary       | ✅ Persistent       |
| Performance      | 🚀 Very High      | High (but limited) |
| Detachable       | ❌ No              | ✅ Yes              |
| Snapshots        | ❌ No              | ✅ Yes              |
| Use Case         | Cache / Temp data | Databases / OS     |

---

## Important Things People Often Miss 🚨

* ❌ Instance Store data is **lost on Stop**
* ❌ You cannot back it up
* ❌ You cannot resize it
* ❌ You cannot attach it later
* ✅ You **must design apps to tolerate data loss**
* ✅ Combine with **S3 / EBS** for durability

---

## Final Mental Model

* **EC2** → A computer
* **EBS** → External hard drive (network-attached, persistent)
* **Instance Store** → Built-in SSD (very fast, but temporary)

---

## One-Line Summary

> Use **Instance Store** when you need **speed** and can afford **data loss**.
> Use **EBS** when you need **durability and persistence**.
