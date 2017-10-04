remove_null_row = function(xx){
	tf = apply(!is.na(as.matrix(xx)), 1, all)
	xx[tf, ]
}
