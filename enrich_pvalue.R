enrich_pvalue = function(N, A, B, k)
{
    m <- A + k
    n <- B + k
    i <- k:min(m,n)

    as.numeric( sum(chooseZ(m,i)*chooseZ(N-m,n-i))/chooseZ(N,n) )
}
#https://stackoverflow.com/questions/18340123/calculate-venn-diagram-hypergeometric-p-value-using-r
