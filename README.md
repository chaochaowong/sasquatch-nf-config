

This repos contains the Nextflow config files designed specifically for the SCRI sasquatch cluster. 
- `sasquatch.config` 
- `atacseq_nextflow.config`
- `atatseq_test.config`
- `atacseq_nextflow.config`

## run `nf-core/atacseq` for testing on Sasquatch

Use the default testig config from `nf-core/atacseq`:
```shell
conf_file='sasquatch.config' 
nextflow run nf-core/atacseq \
    -r 2.1.2 \
    -c $conf_file
	-profile test,sasquatch 
```

Or use customized config file, `atacseq_seq.config`, to run the testing and change default peak calling to narrow peak, skip consensus calls, and set q-value to 0.01:

```shell
conf_file='atacseq_nextflow.config' 
nextflow run nf-core/atacseq \
    -r 2.1.2 \
    -c $conf_file
    --narrow_peak \
    --macs_fdr 0.01 \
    --skip_consensus_peaks \
	-profile sasquatch 
```

## Run `nf-core/atacseq` for our ATAC-seq data
To run `nf-core/atacseq` using the custom `atacseq_nextlfow.config`, `params.json`, simply run `atacseq_run.sh`. Code below is `atacseq_run.sh`:

```shell
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
```

To run `nf-core/atacseq` by `./atacseq_run.sh`, make sure to edit (1) `atacseq_nextflow.config` for adaquate slurm account information, output directory, FASTA and gft path, and (2) `params.json` for other parameters to replace the default setting of `nf-core/atacseq`.

