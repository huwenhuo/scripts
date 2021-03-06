my_pheatmap = function (xx, topn, topsd, pdffile, annoRow=NULL, annoCol=NULL, isScaled = F, breaks, ...){## top SD genes
	xx.sd = apply(xx, 1, sd)
	xx.sd = xx.sd[order(xx.sd, decreasing=T)]

	if(missing(topn) & missing(topsd)){cat("topn or topsd not assigned, using whole dataset");}
	top = ''
	flag = 0
	if(!missing(topn)){ 
		top = names(xx.sd[1:topn])
		flag = 1
		cat("using topn ", topn, ", selected rows:", length(top), "\n")
	}else if(!missing(topsd)){ 
		top = names(xx.sd[xx.sd > topsd])
		flag = 2
		cat("using top sd ", topsd, ", selected rows:", length(top), "\n")
	}

	if(flag > 0 & length(top) <1){ 
		cat("total rows selected: ", length(top), "\n")
		cat("no rows selected based on top sd or top n \n") 
	}else{
		xx = xx[row.names(xx) %in% top, ]
	}

	matrix_tmp = xx
	if(!isScaled){
		cn = colnames(xx)
		matrix_tmp = t(apply(tmp, 1, scale))
		matrix_tmp[matrix_tmp > 2] = 2
		matrix_tmp[matrix_tmp < -2] = -2
		colnames(matrix_tmp) = cn
	}

	if(missing(breaks)){
		breaks = c( seq(from = -2, to = 2, length.out = 30))
	}

	tf = apply(!is.na(as.matrix(matrix_tmp)), 1, all)
	matrix_tmp = matrix_tmp[tf, ]

	pdf(pdffile)
	hp = pheatmap(matrix_tmp, color=greenred(length(breaks)+1), scale='none', clustering_method = 'complete', 
		      cluster_rows = TRUE, cluster_cols = TRUE, show_colnames = T, fontsize_row = 9, show_rownames = F,
		      annotation_col = annoCol, annotation_row = annoRow)
	dev.off()
}
