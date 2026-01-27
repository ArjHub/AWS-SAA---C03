# Deregisatration Delay
## First: the problem this feature solves

You’re running an app behind a load balancer in **Amazon Web Services**:

```
User ──> Load Balancer ──> EC2 instances
```

Now imagine:

* An EC2 instance needs to be **removed**

  * scale-in
  * deployment
  * maintenance
  * instance unhealthy

The scary question:

> ❓ What happens to users who are **currently using that instance**?

If AWS just kills it immediately:

* File uploads break
* API calls fail
* Users get logged out
* Requests are cut mid-flight ❌

That’s exactly what **Connection Draining / Deregistration Delay** prevents.

---

## What is Connection Draining / Deregistration Delay? (plain English)

> **It is a grace period that allows in-flight requests to finish before an instance is removed from traffic.**

AWS changed the name:

* **Classic Load Balancer** → *Connection Draining*
* **ALB / NLB / GWLB** → *Deregistration Delay*

Same idea. Different name.

---

## Simple real-life analogy

Think of a restaurant 🍽️

* You stop letting **new customers** in
* But you **don’t kick out people already eating**
* Once they finish → restaurant closes

That’s deregistration delay.

---

## Step-by-step: what actually happens

![Image](https://user-images.githubusercontent.com/1332227/226095406-d885efc7-2912-46f4-92eb-56efd273f6ca.png)

![Image](https://kodekloud.com/kk-media/image/upload/v1752859072/notes-assets/images/AWS-Certified-Developer-Associate-Elastic-LoadBalancer-Overview/connection-draining-elb-instances.jpg)

### Step 1 — Instance is marked for removal

This can happen when:

* Auto Scaling scales in
* You deploy a new version
* You manually deregister the instance
* Health check fails

---

### Step 2 — Load Balancer stops NEW traffic

Immediately:

* ❌ No new requests sent to this instance
* ✅ Existing connections are allowed to continue

This is the **key behavior**.

---

### Step 3 — Grace period starts (the delay)

You configure a timer, for example:

```
Deregistration delay = 300 seconds (5 minutes)
```

During this time:

* Ongoing requests finish
* Long-lived connections get time to close cleanly

---

### Step 4 — Instance is fully removed

Whichever happens first:

* All connections finish ✅
* Delay timer expires ⏱️

Then:

* Instance is fully deregistered
* It can now be safely terminated

---

## Where is this configured?

Not on the listener.
Not on the load balancer.

👉 **It’s configured on the Target Group**.

That’s important.

---

## Typical default values

| Load Balancer | Name                 | Default         |
| ------------- | -------------------- | --------------- |
| ALB           | Deregistration delay | **300 seconds** |
| NLB           | Deregistration delay | **300 seconds** |
| GWLB          | Deregistration delay | **300 seconds** |
| CLB           | Connection draining  | **300 seconds** |

(You can set it from **0 to 3600 seconds** depending on LB type.)

---

## Why this matters (real scenarios)

### Scenario 1: File upload

User uploads a 200MB file
Upload takes 2 minutes

Without delay ❌
→ connection killed mid-upload

With delay ✅
→ upload completes

---

### Scenario 2: Deployment

You deploy a new version:

* Old instances draining
* New instances receiving traffic

Users see **zero disruption**.

---

### Scenario 3: Sticky sessions

If stickiness is enabled:

* Users tied to an instance
* Immediate removal would log them out

Deregistration delay gives them time to finish.

---

## Important limitations (don’t misunderstand this)

❌ It does NOT:

* Accept new requests
* Make an unhealthy instance healthy
* Save requests longer than the timeout

❌ If delay expires:

* Remaining connections are force-closed

So the delay must match your **real request duration**.

---

## How to choose the right value

| App type                 | Suggested delay    |
| ------------------------ | ------------------ |
| Simple web pages         | 30–60 sec          |
| REST APIs                | 60–120 sec         |
| File uploads             | 300+ sec           |
| Long polling / streaming | Higher or redesign |

---

## One-sentence mental model

> **Deregistration delay = “Stop sending me new work, let me finish what I’m doing.”**

---

## One-screen summary

| Term                 | Meaning                   |
| -------------------- | ------------------------- |
| Connection Draining  | Old name (CLB)            |
| Deregistration Delay | New name (ALB/NLB/GWLB)   |
| Purpose              | Finish in-flight requests |
| Configured on        | Target Group              |
| Default              | 300 seconds               |


