r_bowtie2 = function(targets, sel, cwd="", submit = F, need.wait=F){
	source("~/program/configure.R")
	if(cwd=='') {cwd = getwd()}
	targets[, bt.jobname := paste0("bt2.", targets$ID)]
	targets[, bt.err := paste0(bt.jobname, ".err")]
	targets[, bt.std := paste0(bt.jobname, ".std")]
	targets[, bt.cmd := paste(bsub, "-J", bt.jobname, '-cwd', cwd, "-e", bt.err, "-o", bt.std, "-We 1:59")]
	targets[, bt.cmd := paste(bt.cmd, '-R "rusage[mem=30]"', '-R "rusage[iounits=0]"', '-n 10')]
	if(need.wait == T){
		targets[, bt.cmd := paste(bt.cmd, '-w "post_done(', wait, ')"')]
	}
	targets[, bt.cmd := paste(bt.cmd, '"', bowtie2, '--local -p 7 -x', genome, '-1', fastq1, '-2', fastq2)]
	targets[, bt.cmd := paste(bt.cmd, '|', samtools, 'view -@ 1 -bS - |', samtools, 'sort -@ 3 -m 20 -n - ', bamsorted, '"')]
	if(submit){
		if(sel==0){sel = 1:nrow(targets)}
		for(i in sel){
			print("submitting: ")
			print(targets[i, macs2.cmd])
			system(targets[i, bt.cmd])
		}
	}
	targets
}

# targets:
# ID, fastq1, fastq2, bamfile, bamsortedfile, bamsortedrmdupfile, genome, path, 
