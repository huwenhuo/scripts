post_deseq2_results = function(x, name=NULL, padj = 0.01, log2FC = 1){
	x$symbol = sub(".*_", "", row.names(x))
	x[order(x$pvalue),] -> x

	x.sig = x[!is.na(x$padj) & x$padj < padj & !is.na(x$log2FoldChange) & abs(x$log2FoldChange) < log2FC,] 

	source("~/program/fun/write_rnk.r")
	write_rnk(data = x, filename=paste0(name, ".rnk"), pvalue.cutoff=1)
	write.table(x, file = paste0(name, ".csv"), sep="\t", quote=F)
	return(list(x, x.sig))
}

