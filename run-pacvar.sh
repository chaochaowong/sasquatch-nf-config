#!/usr/bin/env bash

# 1) define Project
PROJECT="JR26_MPAL_HM5736_GRCh38_Fiberseq_20260321"
PROJECT_ID="JR26"

# 2) Define common base directories if you like
BASE="/data/hps/assoc/private/sarthy_lab/NGS/FiberSeq_Results/${PROJECT}"
WORKDIR="/data/hps/assoc/private/sarthy_lab/user/${USER}/tmp/${PROJECT_ID}"

# 3) run chaochaowong/pacvar, add_fibertools branch
nextflow run nf-core/pacvar -r 1.1.0 \
        -c sasquatch-cpu-pacvar.config \
        -profile sasquatch \
        -w "${WORKDIR}" \
        --workflow wgs \
        --genome GATK.GRCh38 \
        --skip_demultiplexing true \
        --skip_fiberseq false \
        --outdir "${BASE}" \
        --input "${BASE}/pipeline_params/nf-sample-sheet.csv" \
        -resume
