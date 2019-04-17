#!/bin/sh
#SBATCH --job-name=parallel_job_test # Job name
#SBATCH --mail-type=ALL              # Mail events (NONE, BEGIN, END, FAIL, ALL)
#SBATCH --mail-user=d.ence@mail.ufl.edu  # Where to send mail	
#SBATCH --nodes=1                    # Use one node
#SBATCH --ntasks=1                   # Run a single task	
#SBATCH --cpus-per-task=4            # Number of CPU cores per task
#SBATCH --mem=5gb                  # Total memory limit
#SBATCH --time=10:00:00              # Time limit hrs:min:sec
#SBATCH --output=parallel_%j.out     # Standard output and error log
#SBATCH --qos=kirst-b
#SBATCH --partition=hpg1-compute

#export OMP_NUM_THREADS=4
 
# Load required modules; for example, if your program was
# compiled with Intel compiler, use the following 
module load bedtools
module load vcflib
module load vt 
# Run your program with correct path and command line options

cd /home/d.ence/projects/pinus_taeda_L/Fr1_project/aligning_Fr1_samples/aligning_to_custom_R_gene_V1_1_ref/filtering_calls/filtering_progeny_calls_on_missing_data 
cat diploid_samples_with_less_than_0.2_missing_data.fixed_samples.vcf | vcfallelicprimitives --keep-info --keep-geno | vt normalize -r ~/projects/ref_genomes/loblolly_pine/V1_1/ref_for_Fr1_probes/ptaeda.v1.01.masked.and_elite_RNAseq.probes_bed_scaffolds.fasta - > diploid_samples_with_less_than_0.2_missing_data.fixed_samples.deconvoluted.vcf
