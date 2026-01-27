# 🔐 Amazon EBS Encryption

## What is EBS Encryption?

**Amazon EBS encryption** protects your data by automatically encrypting:

* Data **at rest** on the EBS volume
* Data **in transit** between the EC2 instance and the EBS volume
* All **snapshots** created from the volume

Encryption happens transparently at the storage layer using **AWS Key Management Service (KMS)**. No application changes are required.

---

## How EBS Encryption Works

* When an encrypted EBS volume is created, AWS generates a **data encryption key**
* This data key is protected using a **KMS Customer Master Key (CMK)**
* All read/write operations are automatically encrypted and decrypted by AWS
* Encryption and decryption are handled by AWS infrastructure (Nitro), not by the EC2 CPU

You can use:

* **AWS-managed CMK** (default and simplest)
* **Customer-managed CMK** (more control over access, rotation, and auditing)

---

## Encrypting an Existing Unencrypted EBS Volume

You **cannot directly encrypt** an existing unencrypted EBS volume.
To encrypt it, follow this process:

1. Create a **snapshot** of the unencrypted EBS volume
2. Create a **new encrypted EBS volume** from that snapshot
3. Detach the unencrypted volume from the EC2 instance
4. Attach the new encrypted volume to the instance
5. Update any application or configuration references if required
6. Delete the unencrypted volume if it is no longer needed

---

## Important Points to Remember

* EBS encryption is supported for **all EBS volume types** (gp2, gp3, io1, io2, st1, sc1)
* Encrypted volumes can only be attached to **instances that support EBS encryption**

  * Most modern (Nitro-based) EC2 instances support this
* **No additional cost** for EBS encryption
* **No noticeable performance impact** (encryption is handled by AWS hardware)
* Snapshots created from encrypted volumes are **always encrypted**
* Volumes created from encrypted snapshots remain **encrypted by default**

---

## One-Line Summary

> **EBS encryption ensures that your data is always protected—at rest, in transit, and in backups—using AWS KMS, with no performance overhead or application changes.**
