#!/bin/bash

set -eu
DATE=$(date +%F)
NFX_CONFIG=./atacseq_nextflow.config
#Options: "atac_seq"
NFX_ENTRY="atac_seq"
#The output prefix on filenames for reports/logs
REPORT=${1:-"pipeline_report"}

# Nextflow run to execute the workflow 
# TO DO: --singularity_module $SINGULARITY #the in nextflow.config could access this as params.SINGULARITY
PREFIX="${REPORT}_${DATE}"
nextflow run nf-cor/atacset \
    -c ${NFX_CONFIG} \
    -log reports/${PREFIX}_nextflow.log \
    -entry ${NFX_ENTRY} \
    -profile sasquatch \
    -with-report reports/${PREFIX}_report.html \
    -with-dag dag/${PREFIX}_dag.html \
    -cache TRUE \
    -resume