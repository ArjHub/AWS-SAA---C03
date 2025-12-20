## Amazon Elastic file system (EFS)
EFS is a managed NFS that can be mounted on many EC2 and works with EC2 instance sin multi AZs. Its highly available scalable and expensenive (3x gp2), pay per use.
* EFS is a **network file system** that can be mounted on multiple EC2 instances simultaneously
* It provides **scalable storage** that grows and shrinks automatically as you add or remove files
* Designed for **high availability and durability** across multiple AZs within a region
* Ideal for **shared file storage** for applications that require concurrent access from multiple instances
---
## Key Characteristics (Simple Terms)
### 1. **Network File System (NFS)**
* EFS uses the **NFSv4 protocol** to allow multiple EC2 instances to
    * Read from
    * Write to
    the same file system concurrently
* This makes it suitable for applications that need shared access to files, such as web servers or content management systems
---
### 2. **Scalable Storage**
* EFS automatically scales your file system storage capacity up or down based on your usage
* You only pay for the storage you use, making it cost-effective for variable workloads
---
### 3. **High Availability and Durability**
* EFS stores data redundantly across multiple AZs within a region
* This ensures that your data remains available even if one AZ experiences issues
---
### 4. **Performance Modes**
* EFS offers two performance modes:
    * **General Purpose**: Suitable for most applications, offering low latency and high throughput
    * **Max I/O**: Designed for applications that require high levels of aggregate throughput and can tolerate slightly higher latencies
* You can choose the performance mode based on your application needs
---
### 5. **Use Cases**
* EFS is ideal for:
    * Web serving and content management
    * Big data and analytics
    * Media processing workflows
    * Container storage
    * Home directories
---
### Perfromance
- **EFS Scale**:
    - Scales to petabytes
    - Can support thousands of concurrent NFS connections, 10 GB+ throughput
- **Performace Mode (set at EFS creation tme)**:
    - General Purpose (default): low latency, ideal for most apps
    - Max I/O: higher throughput, slightly higher latencies, ideal for big data apps
- **Throughput Mode**:
    - Bursting (default): throughput scales with storage size
    - Provisioned: set specific throughput independent of storage size
    - Elastic: to automaticallly scales throughoput up and down based on ur workload, great fit for unpredictable workloads
---
### Storage Classes (lifecycle management feature - move file after n days)
- **Standard** (default): for frequently accessed files
- **Infrequent Access (EFS-IA)**: for files accessed less frequently, lower cost but
    higher retrieval fees
- **Archive**:  for files rarely accessed, lowest cost but higher retrieval fees
- Implement lifecycle policies to move the files between storage tiers
    based on access patterns to optimize costs
- In case of Availablity and durablity:
    - Both Standard and EFS-IA provide high availability and durability by storing data across multiple AZs great for prod
    - Archive storage class also maintains high durability but may have
    - One Zone AZ, great for dev beackup enabled by default compatible with IA (EFS One zone IA)
- Overall by choosing the right option for storage we can store up 90% of the cost

---
### One-Line Summary
> **Amazon EFS is a scalable, highly available network file system that allows multiple EC2
> instances to share data concurrently, making it perfect for applications requiring shared access to files.**
 