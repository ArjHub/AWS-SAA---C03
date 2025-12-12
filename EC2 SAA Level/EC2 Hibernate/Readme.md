## What happens when an EC2 is started?
On start the follwing happens,
1. First Start: the OS boots and the Ec2 User Data script is run
2. Subsequent Starts: the OS boots normally without running the User Data script again.
3. Then the application starts, caches get warmed up and that can take time, going more in depth
4. The instance status checks are performed to ensure the instance is healthy
5. The instance is now ready to accept traffic.

## We know we can stop/terminate instances
Stop - the data on disk(EBS) is kept intact in the next start
Terminate - the data on disk(EBS) is deleted in the next start
But what happens when an EC2 is hibernated?

## What happens when an EC2 is hibernated ?
When an EC2 instance is hibernated, the in-memory state (RAM) of the instance is saved to the root EBS volume. This allows the instance to resume from where it left off when it is started again making it much faster.
Under the hood,
1. The instance is stopped.
2. The contents of the instance's RAM are saved to the root EBS volume.
3. The instance is then in a hibernated state.
4. When the instance is started again, the saved RAM contents are loaded back into memory.
5. The instance resumes operation from the exact point it was hibernated.

## Why user Hibernate if we can stop the instance ?
Hibernation is useful for applications that require a quick restart time and need to maintain their in-memory state. It is particularly beneficial for workloads that have long initialization times or complex state information that would be time-consuming to recreate upon a standard stop/start cycle.

## Important points to note about Hibernation
* Hibernation is supported only for certain instance types and operating systems.
* The root EBS volume must be encrypted.
* There are limits on the amount of RAM that can be hibernated, depending on the instance type
* Hibernation incurs additional storage costs for the saved RAM state on the EBS volume.
* Hibernation is not supported for instances with instance store volumes.
* Hibernation can only be initiated by the user; it is not automatically triggered by AWS
* Hibernation may not be suitable for all applications, especially those that require high availability or have strict uptime requirements.
* When an instance is hibernated, any data stored in instance store volumes is lost.
* Hibernation is not supported for instances that are part of an Auto Scaling group.
* The instance must be in a VPC to support hibernation.
* Hibernation may not be available in all AWS regions.
* The instance must have an IAM role that allows it to write to the EBS volume.
* Hibernation may not be suitable for instances that require frequent updates or changes to their in-memory state.
* Hibernation is not supported for instances that are launched from certain types of AMIs, such as those with encrypted root volumes or those that use certain types of storage.
* The instance must be stopped before it can be hibernated.

## Conclusion
Hibernation is a useful feature for certain workloads that require quick restarts and need to maintaintheir in-memory state. However, it is important to consider the limitations and costs associated with hibernation before using it in production environments.
