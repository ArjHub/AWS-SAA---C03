## What is an AWS Sgnature
AWS Signature is a protocol for authenticating requests to AWS services when youe send APi requests. It ensures that the requests are securely **signed** using your AWS credentials, allowing AWS to verify the identity of the requester and authorize access to resources.

## Note
When you use AWS Cli and sdk the request are signed for you autoatically. The only place where you would need to sign it manuallu would be
when you are making direct HTTP requests to AWS services.

## AWS Signature Versions
There are two main versions of AWS Signature:
1. **Signature Version 2 (SigV2)**: An older version that is still
used by some AWS services. It uses HMAC-SHA1 for signing requests.
2. **Signature Version 4 (SigV4)**: The current and recommended version.
It uses HMAC-SHA256 for signing requests and provides enhanced security features.

## How AWS Signature Works
When you make a request to an AWS service, the following steps occur:
1. **Create a Canonical Request**: The request is transformed into a canonical format,
including the HTTP method, URI, query parameters, headers, and payload.
2. **Create a String to Sign**: A string is created that includes the algorithm,
request date, credential scope, and the hashed canonical request.
3. **Calculate the Signature**: The string to sign is hashed using your AWS secret access
key and the appropriate signing algorithm (HMAC-SHA1 or HMAC-SHA256).
4. **Add the Signature to the Request**: The calculated signature is added to the request
as an Authorization header or as a query parameter.

