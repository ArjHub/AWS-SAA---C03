## What is this s3 object lock
To prtect from objects being deleted, can only be turned on at the creation of the bucket

## Types of object locks
Object lock handled two types 
retention periods -- fixed period of time during which an oject remains locked
legal holds -- remainslocked until we remove the hold

## Also note
can only be done through aws cli and not through console

## Create a bucket with object lock enabled

```sh
aws s3api create-bucket \
  --bucket my-object-lock-bucket-ajju \
  --region ap-south-1 \
  --object-lock-enabled-for-bucket \
  --create-bucket-configuration LocationConstraint=ap-south-1
```

## Enable Default Object Lock Configuration for all the objects being uploaded into the bucket (Optinal)

```sh
aws s3api put-object-lock-configuration \
    --bucket my-object-lock-bucket-ajju \
    --object-lock-configuration '{
        "ObjectLockEnabled": Enabled,
        "Rule": {
            "DefaultRetention": {
                "Mode": "GOVERNANCE",
                "Days": 30
            }
        }
    }'
```

## two types of modes

```md
- GOVERNANCE : users with special permissions can delete the object
- COMPLIANCE : no one can delete the object until the retention period is over
```

## Upload an object into the bucket lock applied

```sh
aws s3api put-object \
    --bucket my-object-lock-bucket-ajju \
    --key myfile.txt \
    --body myfile.txt \
    --object-lock-mode GOVERNANCE \
    --object-lock-retain-until-date "2025-12-31T00:00:00Z"
```
