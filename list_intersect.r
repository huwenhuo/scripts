
list.intersect = function(l1, l2){
        oo = list();
        for(i in 1:length(l1)){
                oo[[i]] = intersect(l1[[i]], l2[[i]]);
        }
        return(oo)
}
