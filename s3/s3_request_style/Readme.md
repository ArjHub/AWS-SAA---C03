## Types of request style
Amazon S3 supports multiple request styles for accessing buckets and objects. The two primary styles are:
1. Virtual Hosted-Style Requests
2. Path-Style Requests

### 1. Virtual Hosted-Style Requests
In virtual hosted-style requests, the bucket name is part of the domain name in the URL.
For example:
```
http://mybucket.s3.amazonaws.com/myobject
```
This style is the preferred method for accessing S3 resources, as it allows for better scalability and
performance. It also supports SSL certificates for custom domain names.

### 2. Path-Style Requests
In path-style requests, the bucket name is part of the URL path.
For example:
```
http://s3.amazonaws.com/mybucket/myobject
```
Path-style requests are still supported but are being phased out in favor of virtual hosted-style requests.

## Examples of Virtual hosted-style
### Create a bucket using virtual hosted-style
```sh
aws s3api create-bucket --bucket my-virtual-bucket --region us-east-1
```
### Upload an object using virtual hosted-style
```sh
aws s3api put-object --bucket my-virtual-bucket --key myobject.txt --
body myfile.txt
```
### Access an object using virtual hosted-style
```sh
curl http://my-virtual-bucket.s3.amazonaws.com/myobject.txt
```

## Examples of Path-style
### Create a bucket using path-style
```sh
aws s3api create-bucket --bucket my-path-bucket --region us-east-1
```
### Upload an object using path-style
```sh
aws s3api put-object --bucket my-path-bucket --key myobject.txt --body
myfile.txt
```
### Access an object using path-style
```sh
curl http://s3.amazonaws.com/my-path-bucket/myobject.txt
```
## Note
While both request styles are supported, it is recommended to use virtual hosted-style requests for better performance