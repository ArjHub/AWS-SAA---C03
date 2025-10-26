## Has two type of metadata

System defined and user defined

## System defined metadata

Data that only amazon can control - users usulayy cannot set their values for these metadata values.
Examples
- content-type
- cache control
- content disposition
- content encoding
- content language
** Some sytem defined metadata con be modified like the content type **

## User defined metadata

Data that the user can set and modify. The key of the metadata must start with x-amz-meta- ..

## Create bucket

```md
aws s3 mb s3://metadata-fun-ajju
```
## Upload a file with user defined metadata

```md
echo "This is my file for metadata" > myfile.txt
aws s3 cp myfile.txt s3://metadata-fun-ajju --metadata x-amz-meta-mykey=myvalue
```

## Get the matadata

```md
aws s3api head-object --bucket metadata-fun-ajju --key myfile.txt
```
## Cleanup

```md
aws s3 rb s3://metadata-fun-ajju --force
```