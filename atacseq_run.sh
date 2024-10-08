#!/bin/bash

set -eu
DATE=$(date +"%F_%H-%M")
NFX_CONFIG=./atacseq_nextflow.config
PARAMS_JSON=./params.json
#The output prefix on filenames for reports/logs
REPORT=${1:-"pipeline_report"}

# Nextflow run to execute the workflow 
# TO DO: --singularity_module $SINGULARITY #the in nextflow.config could access this as params.SINGULARITY
PREFIX="${REPORT}_${DATE}"
nextflow run nf-core/atacseq \
    -r 2.1.2 \
    -params-file ${PARAMS_JSON} \
    -c ${NFX_CONFIG} \
    -profile sasquatch \
    -with-report reports/${PREFIX}_report.html \
    -with-dag dag/${PREFIX}_dag.html \
    -cache TRUE \
    -resume
