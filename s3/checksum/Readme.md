## Create a new bucket

```md
aws s3 mb s3://checksum-example-ajju
``` 

## My file for checksum

Create a file named `example.txt` with the following content:

```
echo "For checksum" > My_file.txt
```

## Get checksum of the file md5

```md
md5sum My_file.txt 
# ff77d9b7391867344b6ecf6fb9565233  My_file.txt
```

# Upload our file to s3

```md
aws s3 cp My_file.txt s3://checksum-example-ajju
aws s3api head-object --bucket checksum-example-ajju --key My_file.txt
```

