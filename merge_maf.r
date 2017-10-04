merge_maf = function(x, y, id="TAG"){
	x = copy(x)
	y = copy(y)
	x.tag2 = paste0(x$Tumor_Sample_Barcode, ":", x$TAG)
	y.tag2 = paste0(y$Tumor_Sample_Barcode, ":", y$TAG)

	x[, TAG2 := x.tag2]
	y[, TAG2 := y.tag2]
	x[, xy:='x']
	y[, xy:='y']
	intersect(colnames(x), colnames(y)) -> com.col
	x[, Variant_Classification := as.character(Variant_Classification)]
	y[, Variant_Classification := as.character(Variant_Classification)]
	rbind(x[, com.col, with=F], y[, com.col, with=F]) -> xy
	xy = dcast(xy, TAG2 + Tumor_Sample_Barcode + Hugo_Symbol + Variant_Classification ~ xy, value.var = 'vaf', 
	      fun.aggregate = mean)
	xy[, Variant_Classification := factor(Variant_Classification)]
}
