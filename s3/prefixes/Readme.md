## Create a bucket

```md
aws s3 mb s3://prefixes-fun-ajju
```

## Creating a folder

```md
aws s3api put-object --bucket prefixes-fun-ajju --key myfolder/
```

## Creating many folder to check the limit in folders

```md
aws s3api put-object --bucket prefixes-fun-ajju --key myfolder/.... till 1024 words and anything more than that would throw error prefix too long
```

