#module load vcftools

#get per individual missing data
vcftools --vcf ../freebayes/Fr1_megs.merged.freebayes.deconvoluted.vcf --missing-indv
#identifiy individuals with more than 20% missing data
cat out.imiss | grep -v "F_MISS" | perl -ane 'chomp; my ($indv,$N_DATA, $N_FILTERED,$N_MISS,$F_MISS) = split(/\t/); if($F_MISS > 0.2){print "$indv\n"}' > megs.indvs_more_than_0.2_missing.txt

#filter those individuals, and apply filteres for min- and max-mean depth, 
vcftools --vcf ../freebayes/Fr1_megs.merged.freebayes.deconvoluted.vcf --min-meanDP 5 --max-meanDP 100 --remove-indv megs.indvs_more_than_0.2_missing.txt --recode-INFO-all --out Fr1_megs.merged.freebayes.deconvoluted.filtered_missing_indvs_minDP_5_maxDP_100

#filter for chi2 1:1 allele segregation
