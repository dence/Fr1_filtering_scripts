#module load vcftools

#get per individual missing data
vcftools --gzvcf ../freebayes/Fr1_megs.merged.freebayes.deconvoluted.fixed_names.vcf.gz --missing-indv
#identifiy individuals with more than 20% missing data
cat out.imiss | grep -v "F_MISS" | perl -ane 'chomp; my ($indv,$N_DATA, $N_FILTERED,$N_MISS,$F_MISS) = split(/\t/); if($F_MISS > 0.2){print "$indv\n"}' > megs.indvs_more_than_0.2_missing.txt

#filter those individuals, and apply filteres for min- and max-mean depth, bialleleic 
vcftools --gzvcf ../freebayes/Fr1_megs.merged.freebayes.deconvoluted.fixed_names.vcf.gz --min-alleles 2 --max-alleles 2 --min-meanDP 5 --max-meanDP 100 --remove-indv megs.indvs_more_than_0.2_missing.txt --recode --out Fr1_megs.merged.freebayes.deconvoluted.filtered_missing_indvs_minDP_5_maxDP_100_biallelic

FILTERED_VCF=Fr1_megs.merged.freebayes.deconvoluted.filtered_missing_indvs_minDP_5_maxDP_100_biallelic.recode.vcf 
DATA_DIR=../vcf_filtering_data/filter_megagam_calls_on_depth_allele_freq_missing_data/
#filter for chi2 1:1 allele segregation
#but first need to grab the header
cat $FILTERED_VCF | grep "#" > header
ls -l $FILTERED_VCF 
#run the filter script
FILTERED_DATA="Fr1_megs.merged.freebayes.deconvoluted.filtered_missing_indvs_allele_freqs_minDP_5_maxDP_100_only_biallel.filtered_segregation.data"
vcf_filter.py --vcf $FILTERED_VCF --filter_chi --chi_square_alpha 0.05 > $FILTERED_DATA

NEW_FILTERED_VCF="Fr1_megs.merged.freebayes.deconvoluted.filtered_missing_indvs_allele_freqs_minDP_5_maxDP_100_only_biallel.filtered_segregation.vcf"
cat header $FILTERED_DATA > $NEW_FILTERED_VCF 

NEW_FILTERED_GZVCF="Fr1_megs.merged.freebayes.deconvoluted.filtered_missing_indvs_allele_freqs_minDP_5_maxDP_100_only_biallel.filtered_segregation.vcf.gz"
bgzip -c $NEW_FILTERED_VCF > $NEW_FILTERED_GZVCF
tabix -p vcf $NEW_FILTERED_GZVCF
cp *.vcf.gz *.vcf.gz.tbi megs.indvs_more_than_0.2_missing.txt *vcf $DATA_DIR 
#clean up temp files
rm header $FILTERED_DATA *vcf.gz *vcf.gz.tbi *vcf out.imiss megs.indvs_more_than_0.2_missing.txt
