### get VPC ID
```sh
aws ec2 describe-vpcs \
    --filters "Name=tag:Name,Values=nacl-example-vpc" \
    --query "Vpcs[0].VpcId" \
    --output text
```
## Get the latest AMI ID for Amazon linux 2
```sh
aws ec2 describe-images \
  --owners amazon \
  --filters "Name=name,Values=amzn2-ami-hvm-*-x86_64-gp2" \
  --query "sort_by(Images, &CreationDate)[-1].ImageId" \
  --output text \
  --region ap-south-1
```

## Create a NACL
```sh
aws ec2 create-network-acl --vpc-id vpc-00485e7631ea0848a
```

## Went on with the attaching a public ipv4 address to the instance which costed, so left the practival and saw the video (15:00:00)