#!/bin/bash
set -x
exec > /tmp/master.log 2>&1

sudo emrfs create-metadata -r 50 -w 10

export AWS_DEFAULT_REGION=eu-west-1

echo "Launch StepFunction"
aws stepfunctions start-execution --state-machine-arn arn:aws:states:eu-west-1:XXXXXXXXXXX:stateMachine:devfest --input '{"message": {"message": "DevFest Issue"}}'

aws stepfunctions start-execution --state-machine-arn arn:aws:states:eu-west-1:XXXXXXXXXXX:stateMachine:devfest --input "{\"message\": {\"message\": \"DevFestIssue\"}}"

INPUT='{"message": {"message": "DevFest Issue"}}'
echo "$INPUT" >> /tmp/input.json

aws stepfunctions start-execution --state-machine-arn arn:aws:states:eu-west-1:XXXXXXXXXXX:stateMachine:devfest --input /tmp/input.json
