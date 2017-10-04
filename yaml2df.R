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
