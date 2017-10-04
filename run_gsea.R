run_gsea = function(rnkfile, cmdfile=NULL, gmtfile=NULL, cwd=NULL, nperm=NULL, mem=NULL){

	if(missing(rnkfile)){
		print("rnkfile must provided\n")
		return
	}else{
		if(!all(file.exists(rnkfile))){
			print("rnkfile is not all available\n")
			return
		}
	}

	if(missing(cwd)){ cwd = getwd(); outdir = file.path(cwd, "/gsea") }
	if(missing(cmdfile)){ 
		tmp = sub(".rnk$", "_gsea.sh", rnkfile);
		if( tmp == rnkfile ) {
			cmdfile = paste0(rnkfile, "_gsea.sh")
		}else{
			cmdfile = tmp

		}
	}

	if(missing(gmtfile)){
		target = c("c1.all.v5.0.symbols.gmt" ,
			 "c2.cgp.v5.0.symbols.gmt" ,
			 "c2.cp.biocarta.v5.0.symbols.gmt" ,
			 "c2.cp.kegg.v5.0.symbols.gmt" ,
			 "c2.cp.reactome.v5.0.symbols.gmt" ,
			 "c2.cp.v5.0.symbols.gmt" ,
			 "c3.mir.v5.0.symbols.gmt" ,
			 "c3.tft.v5.0.symbols.gmt" ,
			 "c4.cgn.v5.0.symbols.gmt" ,
			 "c4.cm.v5.0.symbols.gmt" ,
			 "c5.bp.v5.0.symbols.gmt" ,
			 "c5.cc.v5.0.symbols.gmt" ,
			 "c5.mf.v5.0.symbols.gmt" ,
			 "c6.all.v5.0.symbols.gmt" ,
			 "c7.all.v5.0.symbols.gmt" ,
			 "h.all.v5.0.symbols.gmt"
			   )
	}else{
		target = gmtfile
	}
	if(!all(file.exists(target)) ){ ## if gmt file is not at current working dir
		xx = !file.exists(target)
		target[xx] = paste0("~/program/", target[xx]) # look into this dir
	}
	if(!all(file.exists(target))){ # if still cannot find gmt file
		cat("gmt file can not find\n")
		cat(target[!file.exists(target)], sep="\t")
		cat("\n")
		return
	}
	targetname = basename(target)

	if(missing(nperm)) { nperm = 1000}

	if(missing(mem)) { mem = 5}

	java="/home/huw/program/jdk7/bin/java"
	xmx = paste0(" -Xmx", mem, "g")
	cmd0 = paste0(java,  xmx, " -cp /home/huw/program/gsea2-2.2.0.jar xtools.gsea.GseaPreranked")
	cmd0 = paste0(cmd0, " -collapse false -mode Max_probe -norm meandiv -nperm ", nperm, " -scoring_scheme classic")
	cmd0 = paste0(cmd0, " -include_only_symbols true -make_sets true -plot_top_x 20 -rnd_seed timestamp ")
	cmd0 = paste0(cmd0, " -set_max 500 -set_min 15 -zip_report false -gui false")
	cmd0 = paste0(cmd0, " -out ",  outdir, " ")

	for(i in 1:length(target)){
		targeti = target[i]
		cmd1 = paste0(cmd0, " -gmx ", targeti)

		targetnamei = targetname[i]
		for(j in 1:length(rnkfile)){
			rnkfilei = rnkfile[j]
			cmd = paste0(cmd1, " -rnk ", rnkfilei)
			label = basename(rnkfilei)
			cmd = paste0(cmd, " -rpt_label gsea.", label, ".", targetnamei)
			cat("## now dealing with ", rnkfilei, "\t\t", targeti, "\n", file=cmdfile, append=T)
			cat(cmd, "\n", file=cmdfile, append=T)
			#system(cmd)
		}
	}
}
