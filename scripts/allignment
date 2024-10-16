#PBS -l select=2:ncpus=24:mpiprocs=24:mem=120gb
#PBS -q normal
#PBS -l walltime=8:00:00
#PBS -o /mnt/lustre/users/pnjenga/trypanosome/results/trim.out
#PBS -e /mnt/lustre/users/pnjenga/trypanosome/results/trim.err
#PBS -m abe
#PBS -M puritynjenga895@gmail.com

set -eu

module load chpc/BIOMODULES
module load trim_galore/0.6.5
module load cutadapt/3.4

basedir="/mnt/lustre/users/pnjenga/trypanosome"
input="${basedir}"/Data_copy1
output="${basedir}"/results/trimmed_reads
threads=8


touch ${basedir}/results/trim.out ${basedir}/results/trim.out
mkdir -p ${basedir}/results/trimmed_reads

list1=(
    "$input/Sample_100-F308" "$input/Sample_101-F309" "$input/Sample_102-F310"
    "$input/Sample_103-F311" "$input/Sample_104-F313" "$input/Sample_105-F315"
    "$input/Sample_106-F316"
)

list2=(
    "$input/Sample_110-F322" "$input/Sample_111-F325" "$input/Sample_112-F326"
    "$input/Sample_113-F327" "$input/Sample_11-B90" "$input/Sample_12-B94"
    "$input/Sample_13-B97"
)

list3=(
    "$input/Sample_17-B110" "$input/Sample_18-B111" "$input/Sample_19-B128"
    "$input/Sample_1-B05" "$input/Sample_20-B130" "$input/Sample_21-B141"
    "$input/Sample_22-B148"
)

list4=(
    "$input/Sample_26-B184" "$input/Sample_27-B191" "$input/Sample_28-B192"
    "$input/Sample_29-B212" "$input/Sample_2-B31" "$input/Sample_30-B215"
    "$input/Sample_31-B216"
)

list5=(
    "$input/Sample_35-F50" "$input/Sample_36-F73" "$input/Sample_37-F118"
    "$input/Sample_38-F215" "$input/Sample_39-F219" "$input/Sample_3-B33"
    "$input/Sample_40-F224"
)

list6=(
    "$input/Sample_44-F228" "$input/Sample_45-F229" "$input/Sample_46-F231"
    "$input/Sample_47-F232" "$input/Sample_48-F233" "$input/Sample_49-F234"
    "$input/Sample_4-B44"
)

list7=(
    "$input/Sample_53-F238" "$input/Sample_54-F239" "$input/Sample_55-F240"
    "$input/Sample_56-F243" "$input/Sample_57-F244" "$input/Sample_58-F245"
    "$input/Sample_59-F246"
)

list8=(
    "$input/Sample_62-F250" "$input/Sample_63-F251" "$input/Sample_64-F252"
    "$input/Sample_65-F253" "$input/Sample_66-F256" "$input/Sample_67-F257"
    "$input/Sample_68-F258"
)

for sample in ${list1[@]};
do

sample_name=$(basename $sample)

mkdir -p ${output}/${sample_name}

# Run trim_galore
echo "Running Trim_galore..."
trim_galore \
--paired ${sample}/*_R1.*  ${sample}/*_R2.* \
--cores "${threads}" \
--output_dir ${output}/${sample_name}


echo "Trimming with trim_galore completed successfully!"

done
