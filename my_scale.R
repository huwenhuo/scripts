my_scale = function(xx){
	matrix_tmp = xx
	cn = colnames(xx)
	matrix_tmp = t(apply(tmp, 1, scale))
	matrix_tmp[matrix_tmp > 2] = 2
	matrix_tmp[matrix_tmp < -2] = -2
	colnames(matrix_tmp) = cn
	matrix_tmp
}
