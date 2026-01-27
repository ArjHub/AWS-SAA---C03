# Auto scaling Group

Alright, this is a **big pillar of AWS**, so I’ll explain **Auto Scaling Groups (ASG)** from absolute zero → real production behavior, using **one continuous example**, no hand-waving.

Take your time reading this — once this clicks, **ALB + ASG** will feel obvious.

---

## First: why Auto Scaling Group exists

Imagine you run a website on **one EC2 instance**.

Problems:

* Traffic spikes → server crashes ❌
* Server dies → site goes down ❌
* Traffic drops → you still pay for unused capacity ❌

So the real need is:

> ❓ **How do I automatically add servers when load increases,
> and remove servers when load decreases — safely?**

That is exactly what an **Auto Scaling Group** does.

---

## What is an Auto Scaling Group? (plain English)

> **An Auto Scaling Group (ASG) is a manager that maintains the *right number* of EC2 instances for you.**

It ensures:

* You always have **enough** instances
* You never have **too many**
* Failed instances are **replaced automatically**

All without manual intervention.

This is part of **Amazon Web Services**.

---

## High-level picture (lock this in)

![Image](https://docs.aws.amazon.com/images/autoscaling/ec2/userguide/images/elb-tutorial-architecture-diagram.png)

![Image](https://miro.medium.com/v2/resize%3Afit%3A1200/1%2A3g6mZf05YhzN-wJ4dvwR8Q.png)

```
Users
 ↓
Load Balancer
 ↓
Auto Scaling Group
 ↓
EC2 instances (changing count)
```

You don’t manage instances individually — **ASG does**.

---

## Core responsibilities of an ASG

An ASG does **four main jobs**:

1. **Launch instances**
2. **Terminate instances**
3. **Replace unhealthy instances**
4. **Scale based on demand**

---

## The 3 numbers that define an ASG (VERY IMPORTANT)

Every ASG has these:

| Setting     | Meaning                 |
| ----------- | ----------------------- |
| **Minimum** | Never go below this     |
| **Desired** | Target number right now |
| **Maximum** | Never go above this     |

### Example

```
Min = 2
Desired = 4
Max = 10
```

Meaning:

* Always keep **at least 2** instances
* Normally try to run **4**
* Never exceed **10**

---

## Launch Template (how ASG creates instances)

ASG does NOT magically know how to create EC2s.

It uses a **Launch Template**, which defines:

* AMI
* Instance type
* Security groups
* IAM role
* User data (startup script)

> Think of it as a **blueprint**.

Every instance in the ASG is created from this blueprint.

---

## Step-by-step: instance lifecycle inside ASG

### Step 1 — ASG launches instances

ASG launches instances to reach **Desired Capacity**.

---

### Step 2 — Health checks

ASG constantly checks instance health:

* EC2 health
* Load Balancer health (if attached)

---

### Step 3 — Instance becomes unhealthy

If an instance:

* Crashes
* Fails health checks
* Becomes unreachable

ASG does this automatically:

```
Terminate unhealthy instance
Launch a new one
```

✔️ Self-healing system

---

## ASG + Load Balancer (very important combo)

![Image](https://docs.aws.amazon.com/images/autoscaling/ec2/userguide/images/elb-tutorial-architecture-diagram.png)

![Image](https://miro.medium.com/1%2A7cR8VLOUL3oZpgQsbUwElw.png)

When attached to an ALB:

* ASG **registers instances** with the Target Group
* ALB sends traffic only to healthy instances
* ASG respects **deregistration delay**

This enables:

* Zero-downtime scaling
* Safe instance replacement

---

## How scaling actually happens

### Scaling Policies decide WHEN to scale

---

## 1️⃣ Target Tracking Scaling (most common)

> “Keep a metric near a target value.”

Example:

```
Keep CPU around 50%
```

What happens:

* CPU > 50% → add instances
* CPU < 50% → remove instances

This is **set-and-forget**.

---

## 2️⃣ Step Scaling

You define steps:

| CPU   | Action       |
| ----- | ------------ |
| > 70% | +2 instances |
| > 90% | +4 instances |

More control, more complexity.

---

## 3️⃣ Scheduled Scaling

Scale based on time:

* Scale out at 9 AM
* Scale in at 9 PM

Great for predictable workloads.

---

## Cooldown Period (prevents chaos)

After scaling:

* ASG waits before scaling again
* Prevents rapid scale-in/scale-out loops

---

## Availability Zones & ASG

ASG can span **multiple AZs**.

Benefits:

* High availability
* Fault tolerance

ASG tries to:

* Distribute instances evenly across AZs

---

## What happens during scale-in (instance removal)?

This is where **Deregistration Delay** matters.

1. ASG chooses an instance
2. Tells Load Balancer:

   ```
   Stop sending new traffic
   ```
3. Waits for in-flight requests to finish
4. Terminates instance

✔️ No broken user requests

---

## Instance termination policies (advanced but useful)

ASG decides **which instance to remove** using rules like:

* Oldest instance
* Closest to next billing hour
* Least healthy AZ

This saves cost and improves stability.

---

## What ASG does NOT do (important)

❌ Does not deploy code
❌ Does not manage databases
❌ Does not store session state
❌ Does not replace Load Balancers

It only manages **EC2 instance count & health**.

---

## Typical real-world architecture

```
Internet
 ↓
ALB
 ↓
Auto Scaling Group
 ↓
EC2 instances
```

This trio gives:

* Scalability
* High availability
* Cost efficiency

---

## One-sentence mental model

> **Auto Scaling Group = Smart manager that hires and fires servers automatically.**

---

## One-screen summary

| Concept             | Meaning                  |
| ------------------- | ------------------------ |
| ASG                 | Manages EC2 count        |
| Launch Template     | Instance blueprint       |
| Min / Desired / Max | Capacity boundaries      |
| Scaling Policy      | When to scale            |
| Health Checks       | Replace failed instances |
| ALB integration     | Safe traffic routing     |

