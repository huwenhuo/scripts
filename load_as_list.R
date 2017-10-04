
load_as_list = function(x){
	x <- scan(x, what="", sep="\n");
	y <- strsplit(x, "[[:space:]]+");
	names(y) <- sapply(y, `[[`, 1);
	y <- lapply(y, `[`, -1);
	y <- lapply(y, `[`, -1);
	return(y);
}
