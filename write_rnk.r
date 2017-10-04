write_rnk = function(data = xx, filename="", pvalue.cutoff=1){
	tmp = data;
	tmp[tmp$symbol != '' & !is.na(tmp$log2FoldChange) & !is.na(tmp$pvalue) & tmp$pvalue < pvalue.cutoff, ] -> tmp;
	tmp$gsea = sign(tmp$log2FoldChange) * (- log10(tmp$pvalue))
	tmp = tmp[order(tmp$pvalue),]
	#strsplit(as.character(tmp[,1]), "///") -> tt;
	#lapply(tt, length) -> tt.len;
	#unlist(tt.len) -> tt.len;
	#Map(function(x,y){rep(x,each=y)}, tmp[,2], tt.len) -> xx;
	#unlist(xx) -> xx;
	#data.frame(tt = unlist(tt), xx) -> tmp2;
	duplicated(tmp[,"symbol"]) -> dup;
	tmp2 = tmp[!dup,];
	if(is.infinite(tmp2$gsea[1])){
		top = tmp2$gsea[is.infinite(tmp2$gsea)]
		mm = max(abs(tmp2$gsea[!is.infinite(tmp2$gsea)])) +1
		top_seq = seq(from = mm, by = 1, length.out = length(top))
		top_seq = top_seq * sign(tmp$log2FoldChange[length(top):1])
		tmp2$gsea[is.infinite(tmp2$gsea)] = top_seq
	}
	write.table(tmp2[,c("symbol", "gsea")], file=filename, quote=F, sep="\t", row.names=F, col.names=F);
}

