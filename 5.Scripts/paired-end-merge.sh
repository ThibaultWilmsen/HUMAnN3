#!/bin/bash
#####################################################################################

# MERGE SCRIPT FOR PAIRED END SEQUENCING DATA

#####################################################################################

# Look for the directory containing the raw fastq files
DATA_DIR="3.Data"
OUTPUT_DIR="3.Data/Merged"

# create the output directory if it doesn't exist yet
mkdir -p "$OUTPUT_DIR" 

# Loop through all sample directories in 3.Data
for SAMPLE_DIR in "$DATA_DIR"/RNA*/; do
    SAMPLE=$(basename "$SAMPLE_DIR")
    echo "Processing sample: $SAMPLE"

    # Find R1 and R2 files using your naming pattern (e.g. RNA035463_S16_R1_001.fastq.gz)
    R1=$(find "$SAMPLE_DIR" -name "*_R1_001.fastq.gz")
    R2=$(find "$SAMPLE_DIR" -name "*_R2_001.fastq.gz")

    # Check if both files were found
    if [[ -z "$R1" || -z "$R2" ]]; then
        echo "WARNING: Could not find R1/R2 files for $SAMPLE, skipping..."
        continue
    fi

    echo "  R1: $R1"
    echo "  R2: $R2"

    # Merge the files
    cat "$R1" "$R2" > "$OUTPUT_DIR/${SAMPLE}_merged.fastq.gz"
    echo "  Done: ${SAMPLE}_merged.fastq.gz"
    echo "-----------------------------------"
done

echo "All samples merged!"