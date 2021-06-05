fst.hudson <- function(X, idx.p1, idx.p2){
    prestep.fst.one.marker <- function(alleles,idx.p1,idx.p2){
        
        #Pop 1
        G = alleles[idx.p1]
        no.AA=length(which(G==0))
        no.AB=length(which(G==1))
        no.BB=length(which(G==2))
        n1=(no.AA+no.AB+no.BB)*2
        p.A=(no.AA*2 + no.AB)/n1
        #p.B=(no.BB*2 + no.AB)/n1
        #p1 = min(p.A,p.B,na.rm = T)
        p1 = p.A
        
        #Pop 2
        G = alleles[idx.p2]
        no.AA=length(which(G==0))
        no.AB=length(which(G==1))
        no.BB=length(which(G==2))
        n2=(no.AA+no.AB+no.BB)*2
        p.A=(no.AA*2 + no.AB)/n2
        #p.B=(no.BB*2 + no.AB)/n2
        #p2 = min(p.A,p.B,na.rm = T)
        p2 = p.A
        
        
        N = (p1 - p2)^2 - p1*(1-p1)/(n1-1) - p2*(1-p2)/(n2-1)
        D = p1*(1-p2) + p2*(1-p1)
        
        return(c(N,D))
    }
set.fst = apply(X,2,prestep.fst.one.marker,idx.p1=idx.p1, idx.p2=idx.p2)

# Bhatia, et al 2013, "This is the basis of our recommendation that FST be estimated as a ratio of averages."

fst = mean(set.fst[1,],na.rm=T) / mean(set.fst[2,],na.rm=T)
#fst = mean(set.fst[1,]/set.fst[2,],na.rm = T)

return(fst)
}
