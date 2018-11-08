#!/bin/bash
FLY=$GOPATH/bin/fly
$FLY -t dev login -c http://localhost:8080 -u test -p test
$FLY -t dev set-pipeline -p task-params-github-issue-454 -c pipeline.yaml -l pipeline.params -n
$FLY -t dev unpause-pipeline -p task-params-github-issue-454

echo "*** Running pipeline ***"
$FLY -t dev trigger-job -j task-params-github-issue-454/test -w

echo "*** Running task via fly execute ***"
$FLY -t dev execute -c task.yaml -j task-params-github-issue-454/test -l pipeline.params

