# convert this simple yaml file to data frame
##ID:
##        K21H3K27me3
##        K21IgGK2
##        K22H3K27me3
##        K22IgGK2
##        RT41H3K27me3
##        RT41IgGRT4
##        RT42H3K27me3
##        RT42IgGRT4
##        RT41ATAC
##        RT42ATAC
##        K21ATACK2
##        K22ATACK2
##cell:
##        K2
##        K2
##        K2
##        K2
##        RT4
##        RT4
##        RT4
##        RT4
##        RT4
##        RT4
##        K2
##        K2
##rep:
##        1
##        1
##        2
##        2
##        1
##        1
##        2
##        2
##        1
##        2
##        1
##        2
##chip:
##        H3K27me3
##        IgG
##        H3K27me3
##        IgG
##        H3K27me3
##        IgG
##        H3K27me3
##        IgG
##        ATAC
##        ATAC
##        ATAC
##        ATAC
##oldbam:
##        chipseq_kdm6a/ChIPSeqData/RT4_K2_1_H3K27me3/Chr1745_RT4_K2_1_si_H3K27me3_159_160531_TS21_A12_GTTTCG_AHMK5TBCXX_L002_001.R1_trimmed.hg19.sorted.RmDup.bam
##        chipseq_kdm6a/ChIPSeqData/RT4_K2_1_IgG/Chr1745_RT4_K2_1_si_IgG_177_160531_TS20_A12_GTGGCC_AHMK5TBCXX_L002_001.R1_trimmed.hg19.sorted.RmDup.bam
##        chipseq_kdm6a/ChIPSeqData/RT4_K2_2_H3K27me3/Chr1746_RT4_K2_2_si_H3K27me3_159_160531_TS21_A12_GTTTCG_AHMKFLBCXX_L001_001.R1_trimmed.hg19.sorted.RmDup.bam
##        chipseq_kdm6a/ChIPSeqData/RT4_K2_2_IgG/Chr1746_RT4_K2_2_si_IgG_177_160531_TS22_A12_CGTACG_AHMK5TBCXX_L002_001.R1_trimmed.hg19.sorted.RmDup.bam
##        chipseq_kdm6a/ChIPSeqData/RT4_Parental_1_H3K27me3/Chr1743_RT4_Parental_1_si_H3K27me3_159_160531_TS8_A12_ACTTGA_AHMK5TBCXX_L002_001.R1_trimmed.hg19.sorted.RmDup.bam
##        chipseq_kdm6a/ChIPSeqData/RT4_Parental_1_IgG/Chr1743_RT4_Parental_1_si_IgG_177_160531_TS15_A12_ATGTCA_AHMK5TBCXX_L002_001.R1_trimmed.hg19.sorted.RmDup.bam
##        chipseq_kdm6a/ChIPSeqData/RT4_Parental_2_H3K27me3/Chr1744_RT4_Parental_2_si_H3K27me3_159_160531_TS9_A12_GATCAG_AHMK5TBCXX_L002_001.R1_trimmed.hg19.sorted.RmDup.bam
##        chipseq_kdm6a/ChIPSeqData/RT4_Parental_2_IgG/Chr1744_RT4_Parental_2_si_IgG_177_160531_TS15_A12_ATGTCA_AHMKFLBCXX_L001_001.R1_trimmed.hg19.sorted.RmDup.bam
##        ATAC_seq/WT1/Chr2304_WT1_AT_A11_TGCTGGGT_TGCTGGGT_BHG255BCXY_L002_001.R1_val.hg19.sorted.RmDup.bam
##        ATAC_seq/WT2/Chr2305_WT2_AT_A11_GAGGGGTT_GAGGGGTT_BHG255BCXY_L002_001.R1_val.hg19.sorted.RmDup.bam
##        ATAC_seq/KO1/Chr2306_KO1_AT_A11_AGGTTGGG_AGGTTGGG_BHG255BCXY_L002_001.R1_val.hg19.sorted.RmDup.bam
##        ATAC_seq/KO2/Chr2307_KO2_AT_A11_CCGTTTGT_CCGTTTGT_BHG255BCXY_L002_001.R1_val.hg19.sorted.RmDup.bam
##fastq1: 
##        NULL
##        NULL
##        NULL
##        NULL
##        NULL
##        NULL
##        ./WT1/Chr2304_WT1_AT_A11_TGCTGGGT_TGCTGGGT_BHG255BCXY_L002_001.R1.fastq.gz
##        ./WT2/Chr2305_WT2_AT_A11_GAGGGGTT_GAGGGGTT_BHG255BCXY_L002_001.R1.fastq.gz
##        ./KO1/Chr2306_KO1_AT_A11_AGGTTGGG_AGGTTGGG_BHG255BCXY_L002_001.R1.fastq.gz
##        ./KO2/Chr2307_KO2_AT_A11_CCGTTTGT_CCGTTTGT_BHG255BCXY_L002_001.R1.fastq.gz
##fastq2:
##        NULL
##        NULL
##        NULL
##        NULL
##        NULL
##        NULL
##        NULL
##        NULL
##        ./WT1/Chr2304_WT1_AT_A11_TGCTGGGT_TGCTGGGT_BHG255BCXY_L002_001.R2.fastq.gz
##        ./WT2/Chr2305_WT2_AT_A11_GAGGGGTT_GAGGGGTT_BHG255BCXY_L002_001.R2.fastq.gz
##        ./KO1/Chr2306_KO1_AT_A11_AGGTTGGG_AGGTTGGG_BHG255BCXY_L002_001.R2.fastq.gz
##        ./KO2/Chr2307_KO2_AT_A11_CCGTTTGT_CCGTTTGT_BHG255BCXY_L002_001.R2.fastq.gz


yaml2df = function(targetfile){
	d = yaml.load_file(targetfile)
	d = lapply(d, function(x){unlist(strsplit(x, " "))})
	unlist(lapply(d, length)) -> x.len
	ll = max(x.len == x.len[1])
	df = data.frame(d[1][1:ll], stringsAsFactors = F)
	for(i in 2:length(d)){
		cbind(df, data.frame(d[i][1:ll])) -> df
	}
	for(i in 1:ncol(df)){
		if(all(is.numeric(df[,i]))){
			df[,i] = as.numeric(df[,i])
		}
	}
	df[df == 'NULL'] = NA
	df[df == 'null'] = NA
	df
}
