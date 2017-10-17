r_macs2 = function(targets, sel=0, cwd="", submit = F, g='hs', qvalue = 0.001, need.wait=F){
	source("~/program/configure.R")
	if(cwd=='') {cwd = getwd()}
	targets[, macs2.jobname := paste0("macs22.", targets$ID)]
	targets[, macs2.err := paste0(macs2.jobname, ".err")]
	targets[, macs2.std := paste0(macs2.jobname, ".std")]
	targets[, macs2.cmd := paste(bsub, "-J", macs2.jobname, '-cwd', cwd, "-e", macs2.err, "-o", macs2.std, "-We 1:59")]
	targets[, macs2.cmd := paste(macs2.cmd, '-R "rusage[mem=30]"', '-R "rusage[iounits=0]"', '-n 10')]
	if(need.wait == T){
		targets[, macs2.cmd := paste(macs2.cmd, '-w "post_done(', wait, ')"')]
	}
	targets[, macs2.cmd := paste(macs2.cmd, '"', macs2, 'callpeak -t', bamsortedrmdupfile, '-f BAM -g', g, '-n', paste0(path, '/macs2_', ID), '-B -q ', qvalue, '"')]
	if(submit){
		if(sel==0){sel = 1:nrow(targets)}
		for(i in sel){
			print("submitting: ")
			print(targets[i, macs2.cmd])
			system(targets[i, macs2.cmd])
		}
	}
	targets
}

# targets:
# ID, fastq1, fastq2, bamfile, bamsortedfile, bamsortedrmdupfile, genome, path, 
