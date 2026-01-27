## Create a bucket
```sh
aws s3 mb s3://my-first-encryption-ajju-bucket
```

## Create a file
```sh
echo "This is my secret file" > secret.txt
```

## uplaod the file to s3
```sh
aws s3 cp secret.txt s3://my-first-encryption-ajju-bucket
```

## Put object with encryption of kms
```sh
aws s3api put-object \
--bucket my-first-encryption-ajju-bucket \
--key secret.txt \
--body secret.txt \
--server-side-encryption aws:kms \
--ssekms-key-id alias/aws/s3
```

## Creating a key
```sh
export ENCODED_KEY=$(openssl rand -base64 32)
echo $ENCODED_KEY
```
## get the md5 hash
```sh
export MD5_HASH=$(echo -n $ENCODED_KEY | base64 --decode | openssl dgst -md5 -binary | base64)
echo $MD5_HASH
```

## put object with SSE-C
```sh
aws s3api put-object \
--bucket my-first-encryption-ajju-bucket \
--key secret.txt \
--body secret.txt \
--sse-customer-algorithm AES256 \
--sse-customer-key $ENCODED_KEY \
--sse-customer-key-md5 $MD5_HASH
```

## how to get or head the object with SSE-C
```sh
aws s3api head-object \
--bucket my-first-encryption-ajju-bucket \
--key secret.txt \
--sse-customer-algorithm AES256 \
--sse-customer-key $ENCODED_KEY \
--sse-customer-key-md5 $MD5_HASH
```

