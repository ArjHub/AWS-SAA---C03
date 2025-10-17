Import-Module AWS.Tools.S3

$region = "ap-south-1"
$bucketName = Read-Host "Enter the S3 bucket name"



function BucketExists{
    param (
        [string]$bucketName
    )
    try {
        Get-S3Bucket -BucketName $bucketName -ErrorAction quiwt
        return $true
    } catch {
        return $false
    }
}

if(-not (BucketExists -bucketName $bucketName)) {
    Write-Host "Bucket does not exist. Creating bucket..."
    Write-Host "Creating S3 bucket '$bucketName' in region '$region'..."
    New-S3Bucket -BucketName $bucketName -Region $region -BucketConfiguration @{ LocationConstraint = $region }
} else {
    Write-Host "Bucket already exists. Exiting script."
    exit
}
