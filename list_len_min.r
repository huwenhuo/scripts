
list.len.min = function(l1, l2){
        oo = c();
        for(i in 1:length(l1)){
                oo = c(oo, min(length(l1[[i]]), length(l2[[i]])));
        }
        return(oo)
}
list.intersect.len = function(l1, l2){
