r_bigwig = function(targets, sel=0, cwd="", submit = F, gsize=2451960000, qvalue = 0.001, need.wait=F){
	targets[, bigwig := paste0(path, "/", ID, ".sorted.rmdup.bw")]
	source("~/program/configure.R")
	if(cwd=='') {cwd = getwd()}
	targets[, bw.jobname := paste0("bw2.", targets$ID)]
	targets[, bw.err := paste0(bw.jobname, ".err")]
	targets[, bw.std := paste0(bw.jobname, ".std")]
	targets[, bw.cmd := paste(bsub, "-J", bw.jobname, '-cwd', cwd, "-e", bw.err, "-o", bw.std, "-We 1:59")]
	targets[, bw.cmd := paste(bw.cmd, '-R "rusage[mem=10]"', '-R "rusage[iounits=0]"', '-n 10')]
	if(need.wait == T){
		targets[, bw.cmd := paste(bw.cmd, '-w "post_done(', wait, ')"')]
	}
	targets[, bw.cmd := paste(bw.cmd, '"/home/huw/anaconda3/bin/bamCoverage -b', bamsortedrmdupfile)]
	targets[, bw.cmd := paste(bw.cmd, ' --extendReads 200 --ignoreForNormalization chrX --normalizeTo1x', gsize, '--binSize 10 -o')]
	targets[, bw.cmd := paste(bw.cmd, bigwig, '"')]
	if(submit){
		if(sel==0){sel = 1:nrow(targets)}
		for(i in sel){
			print("submitting: ")
			print(targets[i, bw.cmd])
			system(targets[i, bw.cmd])
		}
	}
	targets
}

# targets:
# ID, fastq1, fastq2, bamfile, bamsortedfile, bamsortedrmdupfile, genome, path, 
