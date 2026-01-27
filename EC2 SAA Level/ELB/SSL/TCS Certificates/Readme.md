This is a **big concept**, so I’ll build it **from the ground up**, using one concrete story and repeating it across pieces until it clicks. No crypto math, no buzzwords.

---

## First: what problem does SSL/TLS solve?

Imagine this flow **without** SSL/TLS:

```
Browser ───(plain text)───> Server
```

If someone sits in the middle (Wi-Fi hotspot, ISP, attacker), they can:

* Read passwords
* Modify responses
* Impersonate your site

So the real problem is:

> ❓ **How does a browser know it’s talking to the right server — and how do they talk secretly?**

That’s what **SSL/TLS certificates** solve.

---

## What is SSL/TLS (plain English)

> **SSL/TLS is a system that does two things:**
>
> 1. **Encrypts data** (privacy)
> 2. **Verifies identity** (authenticity)

Today, **TLS** is the correct term.
“SSL” is the old name — people still say it out of habit.

---

## What is an SSL/TLS certificate?

> A certificate is a **digital ID card** for a website.

It says:

* “I am `www.example.com`”
* “Here is my public key”
* “A trusted authority confirms this is true”

This certificate is **public**.
The **private key** stays secret on the server.

---

## Step-by-step: what happens when you open `https://example.com`

![Image](https://hpbn.co/assets/diagrams/b83b75dbbf5b7e4be31c8000f91fc1a8.svg)

![Image](https://cf-assets.www.cloudflare.com/slt3lc6tev37/5aYOr5erfyNBq20X5djTco/3c859532c91f25d961b2884bf521c1eb/tls-ssl-handshake.png)

![Image](https://images.openai.com/static-rsc-3/Xwzctk6njxdpZS9Zh7KV9a81FWJUKogvU3FWpPEa6XLMRc8SkUHtM_xXtVq1BBUfoE1HIkaSUJ_NpqKPK25vrvGGi71j0OQF15-0paH3z7U?purpose=fullsize)

### Step 1 — Client says hello

Browser:

```
Hi, I want HTTPS.
Here are the TLS versions & ciphers I support.
```

---

### Step 2 — Server sends certificate

Server replies:

```
Here is my SSL/TLS certificate.
```

Certificate contains:

* Domain name (`example.com`)
* Public key
* Signature of a trusted authority

---

### Step 3 — Browser verifies identity

Browser checks:

* Is this domain name correct?
* Is the certificate signed by a trusted CA?
* Is it expired or revoked?

If ❌ → you see a scary browser warning
If ✅ → continue

---

### Step 4 — Secure key exchange

Browser:

* Creates a **shared secret**
* Encrypts it using the server’s **public key**
* Sends it to the server

Only the server can decrypt it (private key).

---

### Step 5 — Encrypted communication

From now on:

```
Browser ⇄ Server
(all data encrypted)
```

✔️ Passwords safe
✔️ Data unmodified
✔️ Server identity verified

---

## Why SSL/TLS is needed (non-negotiable today)

Without it:

* Login credentials exposed
* Cookies stolen
* Man-in-the-middle attacks
* Browsers mark your site “Not Secure”

With it:

* HTTPS
* Trust
* Compliance
* SEO benefits

---

## Where does the Load Balancer come in?

Now let’s place this inside **Amazon Web Services**.

```
User
 ↓ HTTPS
Load Balancer
 ↓ HTTP or HTTPS
EC2 instances
```

---

## SSL termination (critical concept)

A load balancer can **handle SSL for you**.

This is called:

> **SSL/TLS termination**

### What it means

* HTTPS ends at the Load Balancer
* Load Balancer decrypts traffic
* Backend servers receive **plain HTTP**

### Why this is good

* EC2 instances don’t need certificates
* Easier rotation
* Better performance
* Centralized security

---

## Who stores the certificate?

In AWS, certificates are usually stored in
**AWS Certificate Manager** (ACM).

The Load Balancer:

* Uses the certificate from ACM
* Handles TLS handshakes
* Forwards clean traffic

---

## Different ways SSL can be handled

| Pattern             | Description           |
| ------------------- | --------------------- |
| SSL at LB only      | Most common           |
| SSL at LB + backend | High security         |
| SSL at backend only | Rare, not recommended |

---

## Now: what is SNI?

SNI is **simple once you see the problem**.

---

## The problem SNI solves

One Load Balancer
Many websites
One IP address

Example:

```
www.shop.com
www.blog.com
www.api.com
```

Each needs a **different certificate**.

But:

* TLS handshake happens **before HTTP**
* The server doesn’t yet know which site the user wants

So how does it choose the right certificate?

---

## What is SNI (Server Name Indication)

> **SNI allows the browser to tell the server which hostname it wants during the TLS handshake.**

### What actually happens

Browser says:

```
I want HTTPS
I am requesting: www.shop.com
```

Load Balancer:

* Reads the hostname
* Picks the correct certificate
* Completes TLS handshake

All on the **same IP**.

---

## Without SNI (old days)

* One certificate per IP
* One IP per website
* Expensive and messy

---

## With SNI (modern web)

* Many domains
* One Load Balancer
* Many certificates
* Zero extra IPs

---

## How ALB uses SNI

**Application Load Balancer**:

* Supports **multiple certificates**
* Uses **SNI automatically**
* You just attach certificates to listeners

You don’t configure SNI manually — it’s built-in.

---

## Mental model (lock this in)

* **Certificate** = Website’s passport
* **TLS** = Secure tunnel
* **Load Balancer** = Security guard handling passports
* **SSL termination** = Guard checks IDs so rooms don’t have to
* **SNI** = Visitor tells guard *which building* they’re visiting

---

## Final one-screen summary

| Term            | Meaning                            |
| --------------- | ---------------------------------- |
| SSL/TLS         | Encryption + identity verification |
| Certificate     | Digital ID of a domain             |
| HTTPS           | HTTP over TLS                      |
| SSL termination | TLS ends at LB                     |
| SNI             | Hostname sent during TLS handshake |
| ACM             | AWS certificate storage            |


Great, this is a **core ALB concept**, and once you get it, a lot of other things (HTTPS, rules, certificates) suddenly make sense.

Let’s go **slow, literal, and concrete**.

---

## First: where a Listener fits

We’re in **Amazon Web Services** land.

Basic flow:

```
User ──> ALB ──> EC2 / ECS / Lambda
```

Now the key question:

> ❓ **How does the ALB know *which traffic* it should accept and *what to do* with it?**

That’s the job of a **Listener**.

---

## What is an ALB Listener? (plain English)

> **An ALB Listener is a rule that says:**
>
> “I am listening on *this port* and *this protocol*,
> and when traffic arrives, I will handle it *this way*.”

If the ALB is a **reception desk**,
the **listener is the receptionist sitting at a specific window**.

---

## What a Listener actually contains

A listener has **three core things**:

1. **Protocol** (HTTP or HTTPS)
2. **Port** (80, 443, etc.)
3. **Rules** (how to route requests)

---

## Example 1: HTTP Listener (simplest)

### Setup

```
Protocol: HTTP
Port: 80
```

### Meaning

> “ALB, accept HTTP traffic coming to port 80.”

### Traffic flow

1. User opens:

   ```
   http://foodapp.com
   ```
2. Traffic hits ALB on port 80
3. HTTP listener picks it up
4. Listener rules decide where to send it

No listener = traffic is rejected.

---

## Example 2: HTTPS Listener (very important)

![Image](https://docs.aws.amazon.com/images/elasticloadbalancing/latest/application/images/component_architecture.png)

![Image](https://miro.medium.com/v2/resize%3Afit%3A1400/0%2AT33fHAa0pR89d31y.jpg)

### Setup

```
Protocol: HTTPS
Port: 443
Certificate: example.com
```

### Meaning

> “ALB, accept encrypted HTTPS traffic on port 443,
> and use this certificate to prove identity.”

### What happens internally

1. User connects via HTTPS
2. Listener:

   * Performs TLS handshake
   * Uses certificate
3. Traffic is decrypted
4. Listener rules are evaluated
5. Request is forwarded to targets

👉 **Without a listener, HTTPS cannot work.**

---

## Listener Rules (this is where ALB becomes powerful)

Each listener has **rules**.

### Default rule (always exists)

```
IF nothing else matches
→ forward to Target Group A
```

### Custom rules (you add these)

Examples:

* Path-based
* Host-based
* Header-based

---

## Example: One listener, multiple rules

```
Listener: HTTPS :443
```

Rules:

| Condition                | Action                   |
| ------------------------ | ------------------------ |
| path = /api/*            | forward to API servers   |
| path = /images/*         | forward to image servers |
| host = admin.foodapp.com | forward to admin servers |
| default                  | forward to frontend      |

So the **listener receives traffic**,
**rules decide the destination**.

---

## Important: Listener vs Target Group (common confusion)

| Listener                 | Target Group                  |
| ------------------------ | ----------------------------- |
| Accepts traffic          | Contains backend servers      |
| Listens on port/protocol | Knows *where* to send traffic |
| Has rules                | Has health checks             |

**Listener does NOT talk to EC2 directly.**
It forwards traffic to a **Target Group**.

---

## How many listeners can an ALB have?

Multiple.

Common pattern:

```
HTTP :80  → redirect to HTTPS
HTTPS:443 → serve traffic
```

Example rule on HTTP listener:

```
IF any request
→ redirect to https://...
```

---

## What happens if a listener does not exist?

| Request                        | Result             |
| ------------------------------ | ------------------ |
| HTTPS request, no 443 listener | ❌ Connection fails |
| HTTP request, no 80 listener   | ❌ Connection fails |

The ALB literally has **no door open**.

---

## Mental model (lock this in)

* **ALB** = building
* **Listener** = open door on a specific port
* **Certificate** = ID check at HTTPS door
* **Rules** = directions inside the building
* **Target Group** = rooms with workers

No door → nobody enters.
Wrong door → rejected.
Right door → routed correctly.

---

## One-screen summary

| Term         | Meaning                 |
| ------------ | ----------------------- |
| ALB Listener | Entry point for traffic |
| Protocol     | HTTP / HTTPS            |
| Port         | 80 / 443                |
| Rules        | Decide routing          |
| Certificate  | Required for HTTPS      |
