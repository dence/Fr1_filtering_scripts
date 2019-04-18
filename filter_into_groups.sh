PROG_VCF_FILE="../freebayes/Fr1_progeny.merged.freebayes.deconvoluted.fixed_sample_names.vcf.gz"

gatk SelectVariants --allow-nonoverlapping-command-line-samples --variant $PROG_VCF_FILE --sample-name ./10_5_by_4_6664_samples.txt.args --output 10_5_by_4_6664_samples.fixed_sample_names.deconvoluted.vcf
gatk SelectVariants --allow-nonoverlapping-command-line-samples --variant $PROG_VCF_FILE --sample-name 20-1010_sample.txt.args --output 20-1010_samples.fixed_sample_names.deconvoluted.vcf
gatk SelectVariants --allow-nonoverlapping-command-line-samples --variant $PROG_VCF_FILE --sample-name CL_and_PD_samples.txt.args --output CL_and_PD_samples.fixed_sample_names.vcf
gatk SelectVariants --allow-nonoverlapping-command-line-samples --variant $PROG_VCF_FILE --exclude-sample-name  non_Fr1_progeny_samples.args --output Fr1_progeny_samples.fixed_sample_names.deconvoluted.vcf
gatk SelectVariants --allow-nonoverlapping-command-line-samples --variant $PROG_VCF_FILE --sample-name resistant_samples.not_excluded.txt.args --output Fr1_resistant_samples.fixed_sample_names.deconvoluted.vcf
gatk SelectVariants --allow-nonoverlapping-command-line-samples --variant $PROG_VCF_FILE --sample-name susceptible_samples.not_excluded.txt.args --output Fr1_susceptible_samples.fixed_sample_names.deconvoluted.vcf
cp *vcf ../vcf_filtering_data/breaking_into_groups/
rm *vcf *vcf.idx
