# wenqij.github.io
sudo apt install vcftools

vcftools --vcf Ellen_temporal_parasite_filetred_variants.recode.vcf --extract-FORMAT-info GT --out Ellen_temporal_parasite_filetred_variants.recode_GT  ## Extract SNPs in genotype format

perl CountSNPsPerGene.pl Ellen_temporal_parasite_filetred_variants.recode_GT.GT.FORMAT dmagset7finloc9b.puban.gff SNPmatrixGeneCountWithScaff.txt  ## Map SNPs on Genes

sudo apt install datamash

datamash transpose < SNPmatrixGeneCountWithScaff.txt > SNPmatrixGeneCountWithScaffTransposed.txt  ## Transpose the countmatrix for Population wise Alpha Diversity

Rscript AlphaDiversity.r SNPmatrixGeneCountWithScaffTransposed.txt AlphaDiversity_result.txt  ## run AlphaDiversity.r

perl GFFtoIntergeneic.pl dmagset7finloc9b.puban.gff dmagset7finloc9b.intergenic.gff  ## call intergenic regions from gff file.

perl CountSNPsPerGene2.pl Ellen_temporal_parasite_filetred_variants.recode_GT.GT.FORMAT dmagset7finloc9b.intergenic.gff SNPmatrixInterGenicCount.txt  ## Count SNPs into matrix

datamash transpose  < SNPmatrixInterGenicCount.txt > SNPmatrixInterGenicCountTransposed.txt   Transpose the countmatrix for Population wise Beta Diversity

Rscript BetaDiversity.r SNPmatrixInterGenicCountTransposed.txt Beta-diversity.txt  ## run BetaDiversity.r
