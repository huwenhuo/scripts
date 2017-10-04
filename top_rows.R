top_rows = function(xx, topsd, topn){

	xx.sd = apply(xx, 1, sd)
	if(missing(topn) & missing(topsd)){ print("topn or topsd not assigned"); return}
	top = 0
	if(!missing(topn)){ top = names(xx.sd[1:topn])}
	if(!missing(topsd)){ top = names(xx.sd[xx.sd > topsd])}

	cat("total rows selected: ", length(top), "\n")

	xx[row.names(xx) %in% top, ]
}
