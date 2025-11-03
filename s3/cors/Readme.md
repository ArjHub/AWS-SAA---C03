## Create a bucket
```sh 
aws s3 mb s3://my-first-cors-ajju-bucket

## Change block public access
```sh
aws s3api put-public-access-block --bucket my-first-cors-ajju-bucket \
--public-access-block-configuration "BlockPublicAcls=true,IgnorePublicAcls=true,BlockPublicPolicy=false,RestrictPublicBuckets=false"
```

## Create a bucket policy
This policy i used for static website hosting
```sh
aws s3api put-bucket-policy --bucket my-first-cors-ajju-bucket \
--policy '{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Principal": "*",
            "Action": "s3:GetObject",
            "Resource": "arn:aws:s3:::my-first-cors-ajju-bucket/*"
        }
    ]
}'
```

## Turn on static website hosting
```sh
aws s3api put-bucket-website --bucket my-first-cors-ajju-bucket \
--website-configuration '{
    "IndexDocument": {
        "Suffix": "index.html"
    },
    "ErrorDocument": {
        "Key": "error.html"
    }
}'
```

## Upload our index.html file and include a resource that would be cross-origins
```sh
aws s3 cp index.html s3://my-first-cors-ajju-bucket/index.html
aws s3 cp error.html s3://my-first-cors-ajju-bucket/error.html
```

## Get the website endpoint for s3 from console
```md
http://my-first-cors-ajju-bucket.s3-website.eu-north-1.amazonaws.com
```

## Create API gateway with mock response and test the endpoint
```md
curl -X POST \
  -H "Content-Type: application/json" \
  https://lwdp541679.execute-api.eu-north-1.amazonaws.com/dev/hello

```
## Then we got the cors error, saying we cant access this https://lwdp541679.execute-api.eu-north-1.amazonaws.com/dev/hello

## Set cors on our bucket
```sh
aws s3api put-bucket-cors --bucket my-first-cors-ajju-bucket --cors-configuration file://cors.json
```
### Dont forget to enable cors in the stage in API Gateway and once done and deployed the API after the CORS error is gone

## Cleanup
```sh
aws s3 rb s3://my-first-cors-ajju-bucket --force
```
