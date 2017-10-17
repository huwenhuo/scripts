r_rmdup = function(targets, sel, cwd="", submit = F, need.wait=F){
	source("~/program/configure.R")
	if(cwd=='') {cwd = getwd()}
	targets[, rmdup.jobname := paste0("rmdup.", targets$ID)]
	targets[, rmdup.err := paste0(rmdup.jobname, ".err")]
	targets[, rmdup.std := paste0(rmdup.jobname, ".std")]
	targets[, rmdup.cmd := paste(bsub, "-J", rmdup.jobname, '-cwd', cwd, "-e", rmdup.err, "-o", rmdup.std, "-We 1:59")]
	targets[, rmdup.cmd := paste(rmdup.cmd, '-R "rusage[mem=10]"', '-R "rusage[iounits=0]"', '-n 3')]
	if(need.wait != ''){
		targets[, rmdup.cmd := paste(rmdup.cmd, '-w "post_done(', wait, ')"')]
	}
	targets[, rmdup.cmd := paste(rmdup.cmd, '"', java, '-Xmx15g -jar', picard, 'MarkDuplicates REMOVE_DUPLICATES=true CREATE_INDEX=TRUE METRICS_FILE=dup.txt  AS=true INPUT=')]
	targets[, rmdup.cmd := paste(rmdup.cmd, bamsortedfile, 'OUTPUT=', bamsortedrmdupfile, '"')]
	if(submit){
		if(sel==0){sel = 1:nrow(targets)}
		for(i in sel){
			print("submitting: ")
			print(targets[i, macs2.cmd])
			system(targets[i, rmdup.cmd])
		}
	}
	targets
}

# targets:
# ID, fastq1, fastq2, bamfile, bamsortedfile, bamsortedrmdupfile, genome, path, 
