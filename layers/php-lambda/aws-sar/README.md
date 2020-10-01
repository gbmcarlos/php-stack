### PHP Runtime

By deploying this Serverless Application, a Lambda Layer and an SSM Parameter will be created in your account.

The Lambda Layer contains the binaries required to execute PHP, and a full implementation of AWS Lambda API Runtime.

The SSM Parameter contains the ARN of the Layer (more details below).

### Using the PHP Runtime

To use this PHP Runtime, configure a Lambda Function to use a custom runtime, and add the Layer to it.

If you use an *Infrastructure as Code* tool, such as CloudFormation, the SSM Parameter can be used to get the ARN of the layer, instead of hardcoding it.

Visit [gbmcarlos/php-runtime](https://github.com/gbmcarlos/php-runtime) for more details on the Function Handler
