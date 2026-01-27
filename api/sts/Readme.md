## Create a user with no permissions
This example creates an IAM user with no permissions.
```sh
aws iam create-user --user-name no-permission-user
```
## Adding access keys for cli login
This example adds access keys for the user created above.
```sh
aws iam create-access-key --user-name no-permission-user --output table
```

## Create a credential file 
This example creates a credential file for the user created above.
```sh
aws configure --profile no-perms
```

## using the role created
This example uses the role created above to assume the role and get temporary security credentials.
```sh
export AWS_PROFILE=no-perms
```

## Create the bucket specified in the role using cloud formation see that template.yaml

## Now that we have the bucket and the user not we need to assume the role
```sh
aws sts assume-role \
--role-arn arn:aws:iam::635465244923:role/sts-assume-role-demo-STSRoles-PrvMcMjIJWH5 \
--role-session-name s3-sts-fun
```
## Outputting something like this 
```json
{
    "Credentials": {
        "AccessKeyId": "",
        "SecretAccessKey": "",
        "SessionToken": ,
        "Expiration": "2025-11-13T03:40:07+00:00"
    },
    "AssumedRoleUser": {
        "AssumedRoleId": ":s3-sts-fun",
        "Arn": ""
    }
}
```

## Clean up
This example deletes the user created above.
```sh
aws iam delete-user --user-name no-permission-user
```
## Note
Make sure to delete any access keys associated with the user before deleting the user itself.
```sh
aws iam delete-access-key --user-name no-permission-user --access-key-id ASIAZH5FOED563JUVM4D
```
## Conclusion
In this example, we created an IAM user with no permissions, added access keys for CLI login, created a credential file, assumed a role to get temporary security credentials, and finally cleaned up by deleting the user.
Remember to replace `YOUR_ACCESS_KEY` with the actual access key ID you want to delete.