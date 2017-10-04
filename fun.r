list.len.max = function(l1, l2){
        oo = c();
        for(i in 1:length(l1)){
                oo = c(oo, max(length(l1[[i]]), length(l2[[i]])));
        }
        return(oo)
}
list.intersect = function(l1, l2){
        oo = list();
        for(i in 1:length(l1)){
                oo[[i]] = intersect(l1[[i]], l2[[i]]);
        }
        return(oo)
}
list.len.min = function(l1, l2){
        oo = c();
        for(i in 1:length(l1)){
                oo = c(oo, min(length(l1[[i]]), length(l2[[i]])));
        }
        return(oo)
}
list.intersect.len = function(l1, l2){
        oo = c();
        for(i in 1:length(l1)){
                oo = c(oo, length(intersect(l1[[i]], l2[[i]])));
        }
        return(oo)
}

list.setdiff.len = function(l1, l2){
        oo = c();
        for(i in 1:length(l1)){
                oo = c(oo, length(intersect(l1[[i]], l2[[i]])));
        }
        return(oo)
}

list.setdiff = function(l1, l2){
        oo = list();
        for(i in 1:length(l1)){
		nn = names(l1)[i];
		paste0(nn, "_sub") -> nn
                oo[[nn]] = intersect(l1[[i]], l2[[i]]);
        }
        return(oo)
}

## write to rnk file for gsea
## xx is dataframe(genesymbol, log2FoldChange, pvalue )

write_rnk = function(data = xx, filename=""){
	tmp = data;
	tmp[tmp$symbol != '' & !is.na(tmp$log2FoldChange) & !is.na(tmp$pvalue) & tmp$pvalue < 0.1, ] -> tmp;
	tmp$gsea = sign(tmp$log2FoldChange) * (- log10(tmp$pvalue))
	tmp = tmp[order(tmp$pvalue),]
	#strsplit(as.character(tmp[,1]), "///") -> tt;
	#lapply(tt, length) -> tt.len;
	#unlist(tt.len) -> tt.len;
	#Map(function(x,y){rep(x,each=y)}, tmp[,2], tt.len) -> xx;
	#unlist(xx) -> xx;
	#data.frame(tt = unlist(tt), xx) -> tmp2;
	duplicated(tmp[,"symbol"]) -> dup;
	tmp2 = tmp[!dup,];
	if(is.infinite(tmp2$gsea[1])){
		top = tmp2$gsea[is.infinite(tmp2$gsea)]
		mm = max(abs(tmp2$gsea[!is.infinite(tmp2$gsea)])) +1
		top_seq = seq(from = mm, by = 1, length.out = length(top))
		top_seq = top_seq * sign(tmp$log2FoldChange[length(top):1])
		tmp2$gsea[is.infinite(tmp2$gsea)] = top_seq
	}
	write.table(tmp2[,c("symbol", "gsea")], file=filename, quote=F, sep="\t", row.names=F, col.names=F);
}

bed_to_granges <- function(file){
   df <- read.table(file,
                    header=F,
                    stringsAsFactors=F)
 
   if(length(df) > 6){
      df <- df[,-c(7:length(df))]
   }
 
   if(length(df)<3){
      stop("File has less than 3 columns")
   }
 
   header <- c('chr','start','end','id','score','strand')
   names(df) <- header[1:length(names(df))]
 
   if('strand' %in% colnames(df)){
      df$strand <- gsub(pattern="[^+-]+", replacement = '*', x = df$strand)
   }
 
   library("GenomicRanges")
 
   if(length(df)==3){
      gr <- with(df, GRanges(chr, IRanges(start, end)))
   } else if (length(df)==4){
      gr <- with(df, GRanges(chr, IRanges(start, end), id=id))
   } else if (length(df)==5){
      gr <- with(df, GRanges(chr, IRanges(start, end), id=id, score=score))
   } else if (length(df)==6){
      gr <- with(df, GRanges(chr, IRanges(start, end), id=id, score=score, strand=strand))
   }
   return(gr)
}

### load gmt file as a list
load_as_list = function(x){

	x <- scan(x, what="", sep="\n");
	y <- strsplit(x, "[[:space:]]+");
	names(y) <- sapply(y, `[[`, 1);
	y <- lapply(y, `[`, -1);
	y <- lapply(y, `[`, -1);
	return(y);
}

generate_breaks = function(x){
        rnge = range(x)
        t1 = seq(from = -1, to = 1, length.out = 8)
        t2 = seq(from = -2, to = -1, length.out = 8)
        t3 = seq(from = 1, to = 2, length.out = 8)
        t4 = seq(from = -10, to = -2, length.out = 4)
        t5 = seq(from = 2, to = 10, length.out = 4)
        tt = unique(c(t1, t2, t3, t4, t5, rnge))
        tt = tt[order(tt)] 
        tt[tt >= floor(min(rnge)) & tt <= ceiling(max(rnge))]     
}

generate_z_score = function(x) {
	sweep(x, 1, apply(x, 1, median, na.rm=T))
}
