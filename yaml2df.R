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
		df[,i] = as.character(df[,i])
		if(all(is.numeric(df[,i]))){
			df[,i] = as.numeric(df[,i])
		}
	}
	df[df == 'NULL'] = NA
	df[df == 'null'] = NA
	df
}

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

