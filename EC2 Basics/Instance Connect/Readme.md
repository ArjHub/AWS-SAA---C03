## What is EC2 Instance Connect ?
Amazon EC2 Instance Connect provides a way to securely connect to your EC2 instances using Secure Shell (SSH) without needing to share and manage **SSH keys**. It simplifies the process of connecting to your instances by allowing you to use temporary SSH keys that are generated on-the-fly.
A easier alternative to SSH which can be used in any type of OS, cause its browser based.

## Key Features of EC2 Instance Connect
1. **Temporary SSH Keys**: EC2 Instance Connect generates temporary SSH keys that are valid for a short period, enhancing security by reducing the risk of key compromise.
2. **No Key Management**: You don't need to manage and distribute SSH keys manually, making it easier to connect to instances.
3. **Integration with IAM**: EC2 Instance Connect integrates with AWS Identity and Access Management (IAM), allowing you to control access to your instances using IAM policies.
4. **Browser-Based Access**: You can connect to your instances directly from the AWS Management Console using a web-based SSH client.
5. **CLI Support**: EC2 Instance Connect can also be used via the AWS Command Line Interface (CLI), providing flexibility for users who prefer command-line tools.

## How EC2 Instance Connect Works
1. When you initiate a connection to an EC2 instance using EC2 Instance Connect, a temporary SSH key pair is generated.
2. The public key is sent to the instance and added to the `~/.ssh/authorized_keys` file of the specified user.
3. The private key is used to establish the SSH connection to the instance.
4. After a short period, the temporary public key is automatically removed from the instance, ensuring that access is revoked.

## NOTE
Its using SSH in the background so the sg should be having access to the port 22 so that the instance can get the access to it.