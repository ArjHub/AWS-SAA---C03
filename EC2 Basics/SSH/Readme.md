# SSH & EC2 Access Guide

## What is SSH?

SSH (Secure Shell) is a cryptographic network protocol used for secure communication between a client and a server over an unsecured network. It provides a secure channel for remote login and remote command execution, allowing users to access and manage servers securely.

SSH is commonly used for:

* Remote server administration
* Secure file transfers (SCP / SFTP)
* Tunneling and port forwarding
* Secure access to cloud resources like EC2
* Automated authentication in DevOps pipelines

SSH uses **public–private key cryptography**:

* The **public key** is stored on the server (EC2).
* The **private key (.pem)** is kept by the client.
  All communication is encrypted to ensure confidentiality and integrity.

---

## How to SSH into an EC2 Instance

### 1. **Identify the correct SSH username (based on AMI)**

Different AMIs use different default usernames:

| AMI Type                      | Username   |
| ----------------------------- | ---------- |
| Amazon Linux / Amazon Linux 2 | `ec2-user` |
| Ubuntu                        | `ubuntu`   |
| Debian                        | `admin`    |
| Red Hat (RHEL)                | `ec2-user` |
| CentOS                        | `centos`   |
| Fedora                        | `fedora`   |
| SUSE / OpenSUSE               | `ec2-user` |

---

### 2. **Use the correct SSH command**

```bash
ssh -i <your-key.pem> <username>@<public-ip>
```

Example:

```bash
ssh -i mykey.pem ec2-user@3.110.188.208
```

---

### 3. **Fix key permissions**

SSH requires strict permissions on the `.pem` file:

```bash
chmod 400 mykey.pem
```

---

### 4. **Security Group requirements**

To allow SSH:

* **Port:** 22
* **Protocol:** TCP
* **Source:** Your IP or `0.0.0.0/0` (not secure)

---

### 5. First Time SSH Warning

When connecting for the first time:

```
The authenticity of host can't be established...
Are you sure you want to continue connecting? yes
```

This is normal — SSH is adding the server fingerprint to `known_hosts`.

---

### 6. Common SSH Error: “Permission denied (publickey)”

This error usually means:

* Using the wrong username
* Not using the key file
* Wrong `.pem` file (did not match the instance’s key pair)
* Incorrect file permissions
* You lost the key pair

---

## What I Learned

* SSH uses **public-key authentication**, not passwords.
* You must always use the **correct AMI username**.
* You must provide the **.pem key** used at instance launch.
* EC2 user data runs **only on first boot**, unless manually rerun.
* Apache’s default page `"It works!"` appears when your `index.html` doesn’t overwrite correctly.
* Smart quotes (`“ ”`) break shell scripts; always use plain quotes (`" "`).
* Key permissions must be set using `chmod 400`.
* A fingerprint trust warning on first SSH connection is normal.
* “Permission denied (publickey)” means SSH rejected the key.

---

## What I Should Learn Next (SSH Essentials)

### 🔹 1. SSH Key Management

* Generating SSH key pairs
* Adding public keys to `authorized_keys`
* Key rotation best practices

### 🔹 2. SSH Troubleshooting

* Debugging with verbose mode:

  ```bash
  ssh -vvv -i key.pem ec2-user@<ip>
  ```
* Fixing issues caused by SG, NACLs, or private subnets

### 🔹 3. EC2 Instance Connect

* Connecting without .pem keys
* Injecting temporary SSH keys

### 🔹 4. SSH Agent & Multiplexing

* Using `ssh-agent` to load keys
* Reusing existing SSH connections

### 🔹 5. SSH Tunneling / Port Forwarding

* Local and remote port forwarding
* Creating secure tunnels

### 🔹 6. SCP & SFTP (File Transfer)

```bash
scp -i key.pem file.txt ec2-user@<ip>:/home/ec2-user/
```

### 🔹 7. Recovering Access When the Key is Lost

* Detaching the root volume
* Modifying `authorized_keys` from a rescue instance
* Reattaching and booting safely


