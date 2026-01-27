## Bucket policies
Bucket policies are used to grant access permissions to your S3 buckets and the objects within them. They are written in JSON format and can specify who has access to the bucket, what actions they can perform, and under what conditions.

## Access control lists (ACL). [Leagcy Feature]
Access control lists (ACLs) are another way to manage access to your S3 buckets and objects. ACLs are also written in JSON format and allow you to specify permissions for individual AWS accounts or predefined groups.

## AWS PrivateLine for Amazon s3
AWS PrivateLine for Amazon S3 enables you to access S3 buckets over a private connection, enhancing security and performance by avoiding the public internet.
It can incur additional costs, such as charges for VPC endpoints and data processing, but it can also lead to significant savings by reducing data transfer costs compared to using public internet access.

## Cross Origin resource Sharing(CORS)
Cross-Origin Resource Sharing (CORS) is a mechanism that allows web applications running on one domain to request resources from a different domain. In the context of Amazon S3, CORS can be configured on S3 buckets to enable cross-origin requests for objects stored in the bucket.

## S3 Blaock public access [Safety feature enabled by default]
Amazon S3 Block Public Access is a security feature that helps you manage and restrict public access to your S3 buckets and objects. It provides a centralized way to block public access settings at both the account and bucket levels, ensuring that your data remains private and secure.

## IAM Access Analyzer for s3
IAM Access Analyzer for S3 is a feature that helps you identify and analyze access policies for your S3 buckets. It scans your bucket policies, access control lists (ACLs), and other related configurations to determine if any of them allow public or cross-account access.

## Internetwork Traffic Privacy
Ensures data privacy by encrypting data in transit using SSL/TLS protocols when accessing S3 buckets and objects.

## Object Ownership
Object Ownership is a feature in Amazon S3 that allows you to manage ownership of objects within your S3 buckets. It provides options
to control whether the bucket owner or the object uploader owns the objects, which can help simplify access management and permissions.

## Access points
S3 Access Points are a feature that allows you to create unique access endpoints for your S3 buckets. Each access point has its own
policy and network configuration, enabling you to manage access to shared datasets more easily and securely.

## Access Grants
Access Grants in Amazon S3 are permissions that you can assign to users or groups to control their access to S3 buckets and objects.
Grants can be specified using bucket policies, ACLs, or IAM policies, allowing you to define who can read, write, or manage your S3 resources.

## Versioning
Versioning in Amazon S3 is a feature that allows you to keep multiple versions of an object in the same bucket. When versioning is enabled,
each time you upload a new version of an object, S3 assigns it a unique version ID. This helps protect against accidental deletions or overwrites,
as you can easily retrieve previous versions of an object.

## MFA Delete
MFA Delete is a security feature in Amazon S3 that adds an extra layer of protection to Objects. When MFA Delete is enabled, certain operations,
such as permanently deleting an object version or changing the versioning state of a bucket, require the user to provide multi-factor authentication (MFA)
in addition to their regular credentials. This helps prevent unauthorized deletions and enhances the overall security of your S3 data.

## Object Tags
Object Tags in Amazon S3 are key-value pairs that you can assign to S3 objects to help organize and manage them. Tags can be used for various purposes,
such as categorizing objects, controlling access, and managing lifecycle policies. You can assign up to 10 tags per object, and they can be used
in conjunction with S3 features like bucket policies and lifecycle rules.

## In-Transit encryption
In-Transit encryption in Amazon S3 refers to the practice of encrypting data as it moves between your application and S3. This is typically achieved using
Secure Sockets Layer (SSL) or Transport Layer Security (TLS) protocols, which help protect data from interception and tampering during transmission over the
internet or other networks.

## Server-Side Encryption
Server-Side Encryption (SSE) in Amazon S3 is a feature that automatically encrypts your data at rest within S3. When you upload an object to an S3 bucket
with SSE enabled, S3 encrypts the object using encryption keys before storing it on disk. There are three main types of SSE available in S3:
1. SSE-S3: Amazon S3 manages the encryption keys for you.
2. SSE-KMS: You can use AWS Key Management Service (KMS) to manage your encryption keys.
3. SSE-C: You provide your own encryption keys for S3 to use when encrypting and decrypting your data.

## Client-Side Encryption
Client-Side Encryption in Amazon S3 refers to the process of encrypting data on the client side before it is uploaded to S3. This means that
the data is encrypted by the application or user before it is sent to S3, and S3 stores the encrypted data as-is without performing any additional encryption.
With client-side encryption, you are responsible for managing the encryption keys and ensuring that the data is decrypted when it is retrieved from S3.
There are two main approaches to client-side encryption:
1. Using AWS SDKs that provide built-in support for client-side encryption.
2. Implementing your own encryption logic using libraries or tools of your choice.

## Compliance Validation for S3
Ensuring that your S3 buckets and objects adhere to various regulatory and organizational compliance standards.

## Infrastructure Security
Implementing best practices to secure the underlying infrastructure that supports your S3 storage, including network security and access controls.
