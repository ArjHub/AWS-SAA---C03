import aws_cdk as cdk
from s3_cdk.s3_cdk_stack import S3CdkStack

app=cdk.App()

S3CdkStack(app, "S3CdkStack", env=cdk.Environment(
    account="635465244923",
    region="ap-south-1"  # change region if needed
))

app.synth()