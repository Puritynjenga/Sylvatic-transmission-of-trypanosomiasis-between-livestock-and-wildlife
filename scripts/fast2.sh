#!/bin/bash
set -eu


#PBS -l select=10:ncpus=24:mpiprocs=24:nodetype=haswell_reg
#PBS -P CBBI1470
#PBS -q normal
#PBS -l walltime=01:00:00
#PBS -o /mnt/lustre/users/pnjenga/trypanosome/fast.out
#PBS -e /mnt/lustre/users/pnjenga/trypanosome/fast.err
#PBS -m abe
#PBS -M puritynjenga895@gmail.com


# module purge
# module add gcc/5.1.0
# module add chpc/openmpi/1.8.8/gcc-5.1.0
# module load chpc/parallel_studio_xe/64/16.0.1/2016.1.150
module load chpc/BIOMODULES
module load fastqc/0.12.1
module load multiqc/1.15 multiqc/1.23
BASEDIR="/mnt/lustre/users/pnjenga/trypanosome"

# Directories containing FASTQ zip files

SAMPLEDIRS="$BASEDIR/Data_copy1"
DIRS="$SAMPLEDIRS/Sample_*"

# Output directory for FastQC results
OUTPUT_DIR="$BASEDIR/results/fastqc_output"
mkdir -p "$OUTPUT_DIR"
MULTIQC="$BASEDIR/results/multiqc_report"
mkdir -p MULTIQC
# Function to run FastQC 
run_fastqc() {
    local fastq_file="$1"
   

    local output_html="$OUTPUT_DIR/$(basename "$fastq_file" .fastq.gz)_fastqc.html"
    local output_zip="$OUTPUT_DIR/$(basename "$fastq_file" .fastq.gz)_fastqc.zip"


# check if the file exists
    if [ -f "$output_html" ] && [ -f "$output_zip" ]; then
        echo "FastQC output for $fastq_file already exists. Skipping."


    else
        fastqc -o "$OUTPUT_DIR" "$fastq_file"

    fi
}
# Loop through each directory
for dir in $DIRS; do

        echo "Processing directory: $dir"

       # Find all .fastq files in the directory and run FastQC 
        for fastq_file in "$dir"/*.fastq.gz; do
            #  if [ -f "$fastq_file" ]; then
                run_fastqc "$fastq_file" & 
    
            
        done
done
echo "FastQC analysis complete!"


miltiqc $OUTPUT_DIR -o $MULTIQC


