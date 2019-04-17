module load bedtools
bedtools intersect -header -wa -a ../breaking_progeny_calls_into_groups/Fr1_susceptible_samples.with_less_than_0.2_missing_data.fixed_sample_names.deconvoluted.vcf -b ../filter_megagam_calls_on_depth_allele_freq_missing_data/Fr1_megs.merged.freebayes.deconvoluted.filtered_missing_indvs_allele_freqs_minDP_5_maxDP_100.no_recode.vcf > Fr1_susceptible_samples.with_less_than_0.2_missing_data.megagam_cands_5X_100X.fixed_sample_names.vcf
bedtools intersect -header -wa -a ../breaking_progeny_calls_into_groups/Fr1_susceptible_samples.with_less_than_0.2_missing_data.fixed_sample_names.deconvoluted.vcf -b ../filter_megagam_calls_on_depth_allele_freq_missing_data/Fr1_megs.merged.freebayes.deconvoluted.filtered_missing_indvs_allele_freqs_minDP_10_maxDP_50.no_recode.vcf > Fr1_susceptible_samples.with_less_than_0.2_missing_data.megagam_cands_10X_50X.fixed_sample_names.vcf
bedtools intersect -header -wa -a ../breaking_progeny_calls_into_groups/Fr1_susceptible_samples.with_less_than_0.2_missing_data.fixed_sample_names.deconvoluted.vcf -b ../filter_megagam_calls_on_depth_allele_freq_missing_data/Fr1_megs.merged.freebayes.deconvoluted.filtered_missing_indvs_allele_freqs_minDP_5_maxDP_50.no_recode.vcf > Fr1_susceptible_samples.with_less_than_0.2_missing_data.megagam_cands_5X_50X.fixed_sample_names.vcf


module load vcftools
vcftools --recode --vcf ./Fr1_susceptible_samples.with_less_than_0.2_missing_data.megagam_cands_5X_100X.fixed_sample_names.vcf --max-maf 0.00 --out Fr1_susceptible_samples.with_less_than_0.2_missing_data.megagam_cands_5X_100X.MAF_MAX_0.00.fixed_sample_names

vcftools --recode --vcf ./Fr1_susceptible_samples.with_less_than_0.2_missing_data.megagam_cands_5X_100X.fixed_sample_names.vcf --max-maf 0.01 --out Fr1_susceptible_samples.with_less_than_0.2_missing_data.megagam_cands_5X_100X.MAF_MAX_0.01.fixed_sample_names

vcftools --recode --vcf ./Fr1_susceptible_samples.with_less_than_0.2_missing_data.megagam_cands_5X_100X.fixed_sample_names.vcf --max-maf 0.05 --out Fr1_susceptible_samples.with_less_than_0.2_missing_data.megagam_cands_5X_100X.MAF_MAX_0.05.fixed_sample_names

vcftools --recode --vcf ./Fr1_susceptible_samples.with_less_than_0.2_missing_data.megagam_cands_5X_100X.fixed_sample_names.vcf --max-maf 0.10 --out Fr1_susceptible_samples.with_less_than_0.2_missing_data.megagam_cands_5X_100X.MAF_MAX_0.10.fixed_sample_names


bedtools intersect -header -wa -a Fr1_susceptible_samples.with_less_than_0.2_missing_data.megagam_cands_5X_100X.MAF_MAX_0.00.fixed_sample_names.recode.vcf -b ../breaking_progeny_calls_into_groups/Fr1_susceptible_samples.with_less_than_0.2_missing_data.fixed_sample_names.deconvoluted.vcf &> Fr1_susceptible_samples.with_less_than_0.2_missing_data.megagam_cands_5X_100X.MAF_MAX_0.00.fixed_sample_names.no_recode.vcf 
bedtools intersect -header -wa -a Fr1_susceptible_samples.with_less_than_0.2_missing_data.megagam_cands_5X_100X.MAF_MAX_0.01.fixed_sample_names.recode.vcf -b ../breaking_progeny_calls_into_groups/Fr1_susceptible_samples.with_less_than_0.2_missing_data.fixed_sample_names.deconvoluted.vcf &> Fr1_susceptible_samples.with_less_than_0.2_missing_data.megagam_cands_5X_100X.MAF_MAX_0.01.fixed_sample_names.no_recode.vcf 
bedtools intersect -header -wa -a Fr1_susceptible_samples.with_less_than_0.2_missing_data.megagam_cands_5X_100X.MAF_MAX_0.05.fixed_sample_names.recode.vcf -b ../breaking_progeny_calls_into_groups/Fr1_susceptible_samples.with_less_than_0.2_missing_data.fixed_sample_names.deconvoluted.vcf &> Fr1_susceptible_samples.with_less_than_0.2_missing_data.megagam_cands_5X_100X.MAF_MAX_0.05.fixed_sample_names.no_recode.vcf 
bedtools intersect -header -wa -a Fr1_susceptible_samples.with_less_than_0.2_missing_data.megagam_cands_5X_100X.MAF_MAX_0.10.fixed_sample_names.recode.vcf -b ../breaking_progeny_calls_into_groups/Fr1_susceptible_samples.with_less_than_0.2_missing_data.fixed_sample_names.deconvoluted.vcf &> Fr1_susceptible_samples.with_less_than_0.2_missing_data.megagam_cands_5X_100X.MAF_MAX_0.10.fixed_sample_names.no_recode.vcf 

