## Dualstack Endpoints

Amazon S3 dual-stack endpoints support both IPv4 and IPv6 traffic. By using dual-stack endpoints, you can ensure that your applications can connect to Amazon S3 regardless of the IP version they are using.

Standard endpoint supporting just IPV4 traffic -- https://s3.us-east-1.amazonaws.com

Dual-stack endpoint supporting both IPV4 and IPV6 traffic -- https://s3.dualstack.us-east-1.amazonaws.com

## Example of using dual-stack endpoint
### Create a bucket using dual-stack endpoint

```sh
aws s3api create-bucket --bucket my-dualstack-bucket --region us-east
```
### Upload an object using dual-stack endpoint

```sh
aws s3api put-object --bucket my-dualstack-bucket --key myobject.txt
--body myfile.txt
```
### Access an object using dual-stack endpoint

```sh
curl https://my-dualstack-bucket.s3.dualstack.us-east-1.amazonaws
.com/myobject.txt
```
## Note
Using dual-stack endpoints can help improve connectivity and performance for applications that need to support both IPv4
and IPv6 traffic.
It is recommended to use dual-stack endpoints when possible to ensure compatibility with both IP versions.
AWS cli uses dualstack under the hood.