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

Here’s a **clearer, more readable, and beginner-friendly** version, with added practical insights (cost, use cases, and comparisons). You can paste this directly into your README.

---

## EC2 Purchase Options

Amazon EC2 provides multiple pricing and purchase options so you can choose what best fits your workload, budget, and flexibility needs.

---

### **1. On-Demand Instances**

* Pay only for the compute time you use (per second or per hour).
* No long-term commitment.
* Easy to start and stop at any time.

**Best for:**

* Short-term workloads
* Development and testing
* Unpredictable traffic

**Cost:** Most expensive option over time.

---

### **2. Reserved Instances (RI)**

* Commit to a **1-year or 3-year term** for a discounted price.
* Available as **Standard** and **Convertible** RIs.
* Lower cost compared to On-Demand for steady usage.

**Best for:**

* Long-running production workloads
* Applications with predictable usage

**Savings:** Up to ~72% compared to On-Demand.

---

### **3. Savings Plans**

* Commit to a **consistent spend ($/hour)** instead of a specific instance type.
* Automatically applies to matching usage.
* More flexible than Reserved Instances.

**Best for:**

* Users who want discounts but flexibility
* Workloads that may change instance types or regions

**Savings:** Similar to Reserved Instances, with more flexibility.

---

### **4. Spot Instances**

* Use **unused EC2 capacity** at very low prices.
* Instances can be **interrupted** when AWS needs the capacity back.

**Best for:**

* Batch jobs
* Data processing
* CI/CD pipelines
* Fault-tolerant and stateless workloads

**Most cost-efficient option**
**Savings:** Up to **90% cheaper** than On-Demand

**Limitation:** Not suitable for critical or long-running workloads without interruption handling.

---

### **5. Dedicated Instances**

* Instances run on hardware dedicated to a single AWS customer.
* No instance sharing with other customers.
* Provides additional isolation.

**Best for:**

* Compliance or regulatory requirements
* Workloads requiring physical isolation

**Cost:** Higher than On-Demand.

---

### **6. Dedicated Hosts**

* A **physical EC2 server** fully dedicated to you.
* Full visibility and control over socket, core, and host placement.
* Allows use of **existing server-bound licenses** (e.g., Oracle, Windows).

**Best for:**

* License compliance
* Migration of legacy applications

**Cost:** Most expensive option, but needed for licensing reasons.

---

### **7. EC2 Capacity Reservations**

* Reserve EC2 capacity in a **specific Availability Zone**.
* No long-term contract required.
* Ensures capacity availability when you need it.

**Best for:**

* Mission-critical workloads
* Disaster recovery and failover planning

**Note:** Pricing is similar to On-Demand unless combined with Savings Plans or Reserved Instances.

---

### Quick Summary

| Option               | Cost         | Flexibility | Best Use Case              |
| -------------------- | ------------ | ----------- | -------------------------- |
| On-Demand            | High         | Very High   | Short-term & testing       |
| Reserved Instances   | Low          | Medium      | Steady workloads           |
| Savings Plans        | Low          | High        | Long-term with flexibility |
| Spot Instances       | **Very Low** | Low         | Fault-tolerant jobs        |
| Dedicated Instances  | High         | Medium      | Compliance                 |
| Dedicated Hosts      | Very High    | Low         | License-based workloads    |
| Capacity Reservation | On-Demand    | Medium      | Guaranteed capacity        |

---

### Key takeaway:

* **Spot Instances are the most cost-efficient option**, but only suitable for workloads that can handle interruptions.
* **Savings Plans** offer the best balance between cost savings and flexibility for most long-term users.

![alt text](<EC2 Instance Proce Comparison.png>)


Perfect — Spot is one of the **most important (and most misunderstood)** EC2 topics.
Below is a **deep, structured, README-ready explanation** that covers **Spot Instances, Spot Requests, Spot Fleet, interruption handling, and termination**.

---

# EC2 Spot Instances (In-Depth Guide)

## What is a Spot Instance?

Spot Instances allow you to use **unused EC2 capacity** at **very low prices** compared to On-Demand instances.

* Prices are determined by **supply and demand**
* Can be **up to 90% cheaper**
* AWS can **interrupt (terminate or stop)** the instance when capacity is needed

**Most cost-efficient EC2 option**
**Not guaranteed to run forever**

---

## How Spot Pricing Works

* AWS publishes a **Spot price per instance type per AZ**
* You pay the **current Spot price**, not your bid
* Price changes gradually (no sudden spikes)

You are charged:

* Per second (Linux)
* Per hour (Windows)

---

## Spot Instance Lifecycle

1. You request Spot capacity
2. AWS fulfills the request if capacity is available
3. Instance runs at the current Spot price
4. AWS may interrupt the instance
5. Instance is stopped or terminated

**Interruption notice:**
AWS sends a **2-minute warning** before interruption.

---

## Spot Interruption Behavior

You can choose what happens when Spot capacity is reclaimed:

| Behavior                | What Happens                     |
| ----------------------- | -------------------------------- |
| **Terminate** (default) | Instance is deleted              |
| **Stop**                | Instance stops (EBS-backed only) |
| **Hibernate**           | Instance state saved to EBS      |

---

## How to Detect Spot Interruption

Inside the instance, AWS provides metadata:

```bash
curl http://169.254.169.254/latest/meta-data/spot/instance-action
```

If interruption is coming, this returns:

```json
{
  "action": "terminate",
  "time": "2025-01-01T12:00:00Z"
}
```

Used to gracefully shut down apps or save state.

---

## Spot Requests

### What is a Spot Request?

A Spot Request is a request to launch Spot Instances based on conditions you define.

### Types of Spot Requests

#### 1. **One-Time Request**

* Instance is launched once
* When interrupted, it is **not replaced**
* Good for short batch jobs

#### 2. **Persistent Request**

* AWS automatically tries to **relaunch** the instance after interruption
* Good for long-running but fault-tolerant workloads

---

## Spot Fleet

### What is a Spot Fleet?

A Spot Fleet is a **collection of Spot Instances (and optionally On-Demand)** that meets a target capacity.

Instead of requesting one instance type, you specify:

* Multiple instance types
* Multiple AZs
* Target capacity (vCPU, memory, or instance count)

AWS automatically:

* Chooses the cheapest capacity
* Rebalances when interruptions occur
* Launches replacements

**Highly resilient & cost-optimized**

---

## Spot Fleet Allocation Strategies

| Strategy                         | Description                             |
| -------------------------------- | --------------------------------------- |
| **LowestPrice**                  | Uses the cheapest available Spot pools  |
| **CapacityOptimized**            | Chooses pools least likely to interrupt |
| **CapacityOptimizedPrioritized** | Best balance of stability & cost        |
| **PriceCapacityOptimized**       | Mix of price + capacity                 |

**Best practice:**
Use **CapacityOptimized** for production-like workloads.

---

## Spot Fleet with Mixed Instances

You can combine:

* Spot Instances (cheap)
* On-Demand Instances (stable)

Guarantees baseline capacity
Optimizes cost for burst workloads

---

## Spot Fleet Termination Behavior

When you delete a Spot Fleet:

* You can choose to **terminate**, **stop**, or **keep** instances
* By default, instances are terminated

---

## Spot Instance vs Spot Fleet

| Feature                 | Spot Instance | Spot Fleet |
| ----------------------- | ------------- | ---------- |
| Single instance         |             | ❌          |
| Multiple instance types | ❌             |          |
| Auto-replacement        | ❌             |          |
| Cost optimization       | Limited       | Excellent  |
| Production ready        | ❌             |          |

---

## Best Practices for Using Spot

Use **stateless applications**
Store data in **S3 / DynamoDB / EFS**
Use **Auto Scaling + Spot Fleet**
Handle interruptions gracefully
Combine Spot + On-Demand
Use **CapacityOptimized** strategy

---

## Real-World Use Cases

### CI/CD Pipelines

* Jenkins, GitHub runners
* Build and test jobs

### Big Data & Analytics

* Spark, EMR, Hadoop

### Machine Learning

* Model training
* Hyperparameter tuning

### Media Processing

* Video encoding
* Image processing

---

## Key Takeaways

* Spot Instances = **cheapest EC2 option**
* Interruption is expected — design for it
* Spot Fleet adds **resilience and automation**
* Never use Spot alone for critical workloads
* Always combine with On-Demand or ASG

