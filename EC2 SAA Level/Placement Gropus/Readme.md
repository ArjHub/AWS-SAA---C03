## Placement Groups (AWS EC2)

**Placement Groups** control **how EC2 instances are placed on underlying hardware** to optimize for **performance, latency, or availability**.

Think of it as telling AWS *where* (relative to each other) your instances should run.

---

## Why Placement Groups exist

By default, AWS spreads instances randomly.
Placement Groups let you **intentionally place instances** for:

* Low latency
* High network throughput
* Fault isolation

---

## Types of Placement Groups

### 1. **Cluster Placement Group**

Instances are placed **physically close together** in the **same AZ**.

**Benefits**

* Very low network latency
* High network throughput (up to 100 Gbps)

**Best for**

* High-performance computing (HPC)
* Big data analytics
* Distributed ML training

**Trade-offs**

* If hardware fails, **many instances can fail together**
* Limited instance type support

---

### 2. **Spread Placement Group**

Instances are placed on **separate hardware racks**.

**Benefits**

* Maximum fault tolerance
* Reduces correlated failures

**Best for**

* Critical instances
* Small number of instances (max ~7 per AZ)

**Trade-offs**

* Higher latency
* Not scalable for large fleets

---

### 3. **Partition Placement Group**

Instances are spread across **logical partitions**, each on separate hardware.

**Benefits**

* Balance between scale and fault isolation
* Failures in one partition don’t affect others

**Best for**

* Distributed systems
* Kafka, Cassandra, HDFS, Hadoop

**Trade-offs**

* Slightly higher latency than Cluster

---

## Simple Comparison

| Type      | Focus        | Fault Tolerance | Scale  | Latency  |
| --------- | ------------ | --------------- | ------ | -------- |
| Cluster   | Performance  | Low             | Medium | Very Low |
| Spread    | Availability | Very High       | Low    | High     |
| Partition | Balanced     | High            | High   | Medium   |

---

## Real-World Examples

* **Cluster** → ML training nodes talking constantly
* **Spread** → Primary DB + critical services
* **Partition** → Kafka brokers across partitions

---

## Key Rules to Remember

* Placement Groups are **AZ-specific**
* You can’t move a running instance into a group
* Some instance types don’t support all group types

---

## One-line takeaway

> Placement Groups let you control *how close or how isolated* EC2 instances are at the hardware level to optimize performance or availability.
