#!/bin/bash

#PBS -l select=2:ncpus=24:mpiprocs=24:mem=120gb
#PBS -P CBBI1470
#PBS -q normal
#PBS -l walltime=10:00:00
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

set -eu
# Output directory for FastQC results
basedir="/mnt/lustre/users/pnjenga/trypanosome"
output_dir="${basedir}"/results/fastqctrimmed_output
input="${basedir}"/results/trimmed_reads
threads=48

mkdir -p "$output_dir"
mkdir -p "${basedir}"/results/multiqc_reports

touch ${basedir}/results/fast.out ${basedir}/results/fast.out

##list of the sanples
list1=("${input}/Sample_100-F308" "${input}/Sample_101-F309" "${input}/Sample_102-F310" "${input}/Sample_103-F311" "${input}/Sample_104-F313" "${input}/Sample_105-F315" "${input}/Sample_106-F316" "${input}/Sample_107-F317" "${input}/Sample_108-F318" "${input}/Sample_109-F319")
list2=("${input}/Sample_110-F322" "${input}/Sample_111-F325" "${input}/Sample_112-F326" "${input}/Sample_113-F327" "${input}/Sample_11-B90" "${input}/Sample_12-B94" "${input}/Sample_13-B97" "${input}/Sample_14-B100" "${input}/Sample_15-B104" "${input}/Sample_16-B106")
list3=("${input}/Sample_17-B110" "${input}/Sample_18-B111" "${input}/Sample_19-B128" "${input}/Sample_1-B05" "${input}/Sample_20-B130" "${input}/Sample_21-B141" "${input}/Sample_22-B148" "${input}/Sample_23-B157" "${input}/Sample_24-B167" "${input}/Sample_25-B168")
list4=("${input}/Sample_26-B184" "${input}/Sample_27-B191" "${input}/Sample_28-B192" "${input}/Sample_29-B212" "${input}/Sample_2-B31" "${input}/Sample_30-B215" "${input}/Sample_31-B216" "${input}/Sample_32-B226" "${input}/Sample_33-B233" "${input}/Sample_34-F41")
list5=("${input}/Sample_35-F50" "${input}/Sample_36-F73" "${input}/Sample_37-F118" "${input}/Sample_38-F215" "${input}/Sample_39-F219" "${input}/Sample_3-B33" "${input}/Sample_40-F224" "${input}/Sample_41-F225" "${input}/Sample_42-F226" "${input}/Sample_43-F227")
list6=("${input}/Sample_44-F228" "${input}/Sample_45-F229" "${input}/Sample_46-F231" "${input}/Sample_47-F232" "${input}/Sample_48-F233" "${input}/Sample_49-F234" "${input}/Sample_4-B44" "${input}/Sample_50-F235" "${input}/Sample_51-F236" "${input}/Sample_52-F237")
list7=("${input}/Sample_53-F238" "${input}/Sample_54-F239" "${input}/Sample_55-F240" "${input}/Sample_56-F243" "${input}/Sample_57-F244" "${input}/Sample_58-F245" "${input}/Sample_59-F246" "${input}/Sample_5-B49" "${input}/Sample_60-F248" "${input}/Sample_61-F249")
list8=("${input}/Sample_62-F250 " "${input}/Sample_63-F251" "${input}/Sample_64-F252" "${input}/Sample_65-F253" "${input}/Sample_66-F256" "${input}/Sample_67-F257" "${input}/Sample_68-F258" "${input}/Sample_69-F259" "${input}/Sample_6-B50" "${input}/Sample_70-F260")
list9=("${input}/Sample_71-F261" "${input}/Sample_72-F262" "${input}/Sample_73-F263" "${input}/Sample_74-F264" "${input}/Sample_75-F272" "${input}/Sample_76-F273" "${input}/Sample_77-F274" "${input}/Sample_78-F275" "${input}/Sample_79-F276" "${input}/Sample_7-B64")
list10=("${input}/Sample_80-F277" "${input}/Sample_81-F279" "${input}/Sample_82-F280" "${input}/Sample_83-F281" "${input}/Sample_84-F283" "${input}/Sample_85-F284" "${input}/Sample_86-F285" "${input}/Sample_87-F286" "${input}/Sample_88-F287" "${input}/Sample_89-F291")
list11=("${input}/Sample_90-F292" "${input}/Sample_91-F293" "${input}/Sample_92-F294" "${input}/Sample_93-F295" "${input}/Sample_94-F296" "${input}/Sample_95-F299" "${input}/Sample_96-F300" "${input}/Sample_97-F303" "${input}/Sample_98-F305" "${input}/Sample_99-F306")
list12=("${input}/Sample_8-B65" "${input}/Sample_9-B79" "${input}/Sample_10-B89")





#Loop thru all the samples
for sample in ${list12[@]};
do
    
sample_name=$(basename "$sample")

mkdir -p "${output_dir}"/"${sample_name}"
    
# Run fastqc
echo "Running fastqc..."

fastqc -o "${output_dir}"/"${sample_name}" -t 48 "${sample}"/*_R1_val_1.fq.gz "${sample}"/*_R2_val_2.fq.gz 

cp "${output_dir}"/"${sample_name}"/*.html "${basedir}"/results/multiqc_reports

done

multiqc ${output_dir}/${sample_name} -o "${basedir}"/results/multiqc_reports  --filename fastqc_multiqc_report.html

echo " fastqc and multiqc completed successfully"


