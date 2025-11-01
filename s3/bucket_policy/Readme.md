## Create a bucket

```sh
aws s3 mb s3://my-bucket-policy-ajju-bucket
```
## Put the policy to the bucket
removing access to a specific bucket for the all accessible user
```sh
aws s3api put-bucket-policy --bucket my-bucket-policy-ajju-bucket \
--policy file://policy.json
```

# Inside the user to access the bucket

```sh
touch bootcamp.txt
aws s3 cp bootcamp.txt s3://my-bucket-policy-ajju-bucket/
aws s3 ls s3://my-bucket-policy-ajju-bucket
```