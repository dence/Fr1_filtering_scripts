FILTERED_MEGS_FILE="Fr1_megs.merged.freebayes.deconvoluted.filtered_missing_indvs_allele_freqs_minDP_5_maxDP_100_only_biallel.filtered_segregation.vcf.gz"
DATA_DIR="../vcf_filtering_data/filter_megagam_calls_on_depth_allele_freq_missing_data/"

MEGS_POS_FILE="filtered_megs_pos.txt"
#Get the positions from the FILTERED_MEGS_FILE
cp $DATA_DIR$FILTERED_MEGS_FILE .
gunzip $FILTERED_MEGS_FILE
cat *vcf | grep -v "#" | cut -f1,2 > $MEGS_POS_FILE 

#use vcftools to filter just those positions from the susceptible progeny
SUSCEPTIBLE_VCF="../vcf_filtering_data/breaking_into_groups/Fr1_susceptible_samples.fixed_sample_names.deconvoluted.vcf"
#using cyvcf2, so need to grab the header
cat ../vcf_filtering_data/breaking_into_groups/Fr1_susceptible_samples.fixed_sample_names.deconvoluted.vcf | grep "#" > header 
ls -l $SUSCEPTIBLE_VCF
ls -l $DATA_DIR$FILTERED_MEGS_FILE
vcf_exact_intersect.py --source $SUSCEPTIBLE_VCF --positions $DATA_DIR$FILTERED_MEGS_FILE 2> exact_filter_out 1> Fr1_susceptible.meg_hets.data
FILTERED_SUSC_VCF="Fr1_susceptible.meg_hets.vcf"
cat header Fr1_susceptible.meg_hets.data > $FILTERED_SUSC_VCF
FILTERED_SUSC_GZVCF="Fr1_susceptible.meg_hets.vcf.gz"
(grep ^"#" $FILTERED_SUSC_VCF; grep -v ^"#" $FILTERED_SUSC_VCF | sort -k1,1 -k2,2n) | bgzip > $FILTERED_SUSC_GZVCF 
tabix -p vcf $FILTERED_SUSC_GZVCF 

TMP_RARE_MEG_HETS="tmp.meg_hets.susc.max_AF_10.recode.vcf"
#vcftools --gzvcf $FILTERED_SUSC_GZVCF --recode --max-maf 0.00 --out tmp.meg_hets.susc.maxAF_0
#vcftools --gzvcf $FILTERED_SUSC_GZVCF --recode --max-maf 0.01 --out tmp.meg_hets.susc.maxAF_1
#vcftools --gzvcf $FILTERED_SUSC_GZVCF --recode --max-maf 0.05 --out tmp.meg_hets.susc.maxAF_5
vcftools --gzvcf $FILTERED_SUSC_GZVCF --recode --max-maf 0.10 --out tmp.meg_hets.susc.max_AF_10

RARE_MEG_HETS="meg_hets.susc.maxAF_10.recode.vcf"
RARE_MEG_HETS_DATA="tmp.meg_hets.susc.maxAF_10.recode.data"
vcf_exact_intersect.py --source $TMP_RARE_MEG_HETS --positions $FILTERED_SUSC_VCF > $RARE_MEG_HETS_DATA
cat header $RARE_MEG_HETS_DATA > $RARE_MEG_HETS

RARE_MEG_HETS_GZVCF="meg_hets.susc.maxAF_10.recode.vcf.gz"
(grep ^"#" $RARE_MEG_HETS; grep -v ^"#" $RARE_MEG_HETS | sort -k1,1 -k2,2n) | bgzip > $RARE_MEG_HETS_GZVCF 
tabix -p vcf $RARE_MEG_HETS_GZVCF
#cp exact_filter_out *vcf *vcf.gz *tbi ../vcf_filtering_data/intersecting_megagam_calls_with_susceptible_calls
#rm *vcf *vcf.gz *vcf.gz.tbi header *data filtered_megs_pos.txt 
