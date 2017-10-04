consensus_cluster = function(xx, optK, pdffile, maxK, reps, isScaled=F){
	if(!isScaled){
		cn = colnames(xx)
		xx= t(apply(xx, 1, scale))
	}
	colnames(xx) = cn
	title=tempdir()

	tf = apply(!is.na(as.matrix(matrix_tmp)), 1, all)
	matrix_tmp = matrix_tmp[tf, ]

	if(missing(maxK)){maxK = 5}
	if(missing(reps)){reps = 1000}
	if(missing(pdffile)){cat("missing pdf file name\n"); return ;}

	pdf(pdffile)
	results = ConsensusClusterPlus(matrix_tmp, maxK=5,reps=1000,pItem=0.8,pFeature=1, 
				       title=title,clusterAlg="hc",distance="pearson",seed=1262118388.71279)
	dev.off()

	##https://www.biostars.org/p/198789/
	if(missing(optK)){
		Kvec = 2:Kmax
		x1 = 0.1; x2 = 0.9 # threshold defining the intermediate sub-interval
		PAC = rep(NA,length(Kvec)) 
		names(PAC) = paste("K=",Kvec,sep="") # from 2 to maxK
		for(i in Kvec){
			M = results[[i]]$consensusMatrix
			Fn = ecdf(M[lower.tri(M)])
			PAC[i-1] = Fn(x2) - Fn(x1)
		}
		# The optimal K
		optK = Kvec[which.min(PAC)]
		cat("optK is ", optK, "\n");
	}

	optClass = results[[optK]]$consensusClass
	optClass

}
