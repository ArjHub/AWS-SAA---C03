## Create a new bucket
```sh
aws s3api create-bucket --bucket my-acl-fun-bucket --region ap-south-1 \
--create-bucket-configuration LocationConstraint=ap-south-1
```
## Turn off block public access for ACLs
```sh
aws s3api put-public-access-block --bucket my-acl-fun-bucket \
--public-access-block-configuration "BlockPublicAcls=false, IgnorePublicAcls=false, \
BlockPublicPolicy=true, RestrictPublicBuckets=true"
```

## Get the public accesss block details
```sh
aws s3api get-public-access-block --bucket my-acl-fun-bucket
```

## Also we have to enable ACLs on Object Ownership
```sh
aws s3api put-bucket-ownership-controls \
--bucket my-acl-fun-bucket \
--ownership-controls 'Rules=[{ObjectOwnership=BucketOwnerPreferred}]'
```
```sh
aws s3api get-bucket-ownership-controls --bucket my-acl-fun-bucket
```
## Change ACLs to allow users in a specific AWS account, we are providing all kinds of access to the bucket
```sh
aws s3api put-bucket-acl --bucket my-acl-fun-bucket \
--grant-full-control 'id=aws-account-id' \
```

## creta anotehr aws account with teh same card details and give the account details of that in the above snippet
## Inside the other AWS account
```sh
touch acl-file.txt
aws s3 cp acl-file.txt s3://my-acl-fun-bucket/
aws s3 ls s3://my-acl-fun-bucket/
```
## Now remove the ACLs from the bucket
```sh
aws s3api put-bucket-acl --bucket my-acl-fun-bucket \
--acl private
```

## Now try to access the bucket from the other AWS account
```sh
aws s3 ls s3://my-acl-fun-bucket/
```
## You will get Access Denied error
## Clean up
```sh
aws s3 rb s3://my-acl-fun-bucket --force
```