#!/bin/bash

set -xe

there=$(dirname $(dirname "$0"))
TASKCLUSTER_ARTIFACTS=${TASKCLUSTER_ARTIFACTS:-/tmp/artifacts}

mkdir -p $TASKCLUSTER_ARTIFACTS
cd $there/build-static/ && tar -czf $TASKCLUSTER_ARTIFACTS/ds-swig.tar.gz .
