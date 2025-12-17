# Amazon Machine Image (AMI)

An **Amazon Machine Image (AMI)** is a **pre-configured template** used to launch EC2 instances.

In simple terms:
👉 **An AMI is a blueprint for creating EC2 instances.**

An AMI defines:

* The **Operating System** (Amazon Linux, Ubuntu, etc.)
* Pre-installed **software and packages**
* System and application **configuration**
* Root EBS volume settings
* Launch permissions
 
Every EC2 instance **must be launched from an AMI**.

---

## Types of AMIs

### 1. **AWS-Provided (Public) AMIs**

* Created and maintained by AWS
* Regularly patched and updated
* Example: Amazon Linux, Ubuntu

### 2. **AWS Marketplace AMIs**

* Created by third-party vendors
* Often include licensed software
* Can be free or paid

### 3. **Custom AMIs**

* Created by you
* Based on your own EC2 configuration
* Used for consistency and automation

---

## Key Characteristics of AMIs

* AMIs are **immutable** (cannot be modified)
* AMIs are **region-specific**
* AMIs can be **copied across regions**
* AMIs reference **EBS snapshots**
* AMIs are used **only at launch time**

---

## AMI Creation Process (Step-by-Step)

### Step 1: Launch an EC2 Instance from an AMI

When you launch an EC2 instance:

* AWS uses the selected AMI
* New **EBS volumes are created from the AMI’s snapshots**
* Volumes are attached to the instance
* The instance boots

📌 At this point, the AMI’s job is done.
It is **not attached** to the running instance.

---

### Step 2: Customize the Running Instance

You now configure the instance exactly as needed:

* Install software (Apache, Nginx, Docker, Java, etc.)
* Apply OS-level settings
* Add configuration files
* Patch and update the system
* Set environment variables

All changes are written to the **EBS volumes**, not the AMI.

---

### Step 3: Stop the Instance (Best Practice)

Before creating a new AMI, stop the instance to:

* Ensure disk consistency
* Prevent partial or corrupted writes
* Flush OS buffers safely

⚠️ You *can* create an AMI from a running instance, but stopping is **recommended**.

---

### Step 4: Create a New AMI from the Instance

When you select **Create Image**:

* AWS takes **snapshots of all attached EBS volumes**
* A **new AMI** is created
* The AMI references these new snapshots

⚠️ This new AMI is **different** from the original AMI used at launch.

---

### Step 5: Launch New Instances from the New AMI

You can now:

* Launch multiple EC2 instances
* All instances start with **identical configuration**
* Each instance gets its **own EBS volumes**

---

## Visual Mental Model

```
Original AMI
     ↓ (used once)
EC2 Instance → Customize → Stop
                    ↓
               Create NEW AMI
                    ↓
        Launch many identical EC2s
```

---

## What Happens Behind the Scenes

* AMI = Metadata + pointers to EBS snapshots
* Snapshots are stored in Amazon S3 (managed by AWS)
* Each new instance gets fresh EBS volumes from snapshots
* Instances do **not** share disks

---

## Common Use Cases

* Auto Scaling Groups
* Blue/Green deployments
* Disaster recovery
* Faster server provisioning
* Environment consistency (Dev / Test / Prod)

---

## Important Topics You Should Know (Often Missed)

### AMI vs EBS Snapshot

| AMI                          | Snapshot           |
| ---------------------------- | ------------------ |
| Blueprint for EC2            | Backup of a volume |
| Used at launch time          | Used for restore   |
| Can include multiple volumes | Single volume      |

---

### AMI vs User Data

* **AMI** → Pre-baked configuration
* **User Data** → Runtime bootstrapping

Best practice:
👉 Bake heavy setup into AMI, keep user data minimal.

---

### AMIs and Auto Scaling

* Auto Scaling Groups **always use AMIs**
* Scaling = launching more instances from the same AMI
* Ensures consistency across instances

---

## One-Line Summary

> An AMI is an immutable blueprint created from EBS snapshots that allows you to launch identical, pre-configured EC2 instances reliably and repeatedly.

