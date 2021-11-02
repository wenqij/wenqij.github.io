#SNP alpha-diversity
#usage: Rscript alpha-diversity.r filename #filesname is the file containing the SNP matrix.
d.chao<-function(A,lev,q)
{
  tot<-sum(A)
  eA<-A/tot
  eA<-eA[eA>0]
  if(is.vector(A)){
    cA<-A
    N<-1
  }else{
    cA<-colSums(A)
    N<-nrow(A)
  }
  ecA<-cA/tot
  ecA<-ecA[ecA>0]
  if(lev=='alpha'){
    if(q!=1){
      Da<-(1/N)*(sum(eA^q))^(1/(1-q))
      D.value<-Da
    }else{
      Da<-exp(-sum(eA*log(eA))-log(N))
      D.value<-Da
    }
  }
  if(lev=='beta'){
    D.value<-d.chao(A,lev='gamma',q)/d.chao(A,lev='alpha',q)
  }
  if(lev=='gamma'){
    if(q!=1){
      Dg<-(sum(ecA^q))^(1/(1-q))
      D.value<-Dg
    }else{
      Dg<-exp(-sum(ecA*log(ecA)))
      D.value<-Dg
    }
  }
  D.value
}
# Calculating
args=commandArgs(T)
getwd()
setwd("/rds/projects/o/orsinil-popgenomics/Vignesh/DNAseq/Transgenerational/snpcountFiles/transpose")
da=read.table("scaffold_10_SNPmatrixGeneCount.txt", header=T,sep="\t",stringsAsFactors=F)
ID=as.vector(da[,1])
dat=da[,2:ncol(da)]
dat=as.matrix(dat)
Alpha=matrix(0,nrow(dat),5)
for(n in 1:nrow(dat)){
  24
  otu=dat[n,]
  otu=otu[otu>0]
  otu=otu[!is.na(otu)]
  for(q in 0:4){
    Alpha[n,q+1]<-d.chao(otu,"alpha",q)
  }
}
Alpha=cbind(ID,Alpha)
colnames(Alpha)=c("ID","q=0","q=1","q=2","q=3","q=4")
write.table(Alpha,"scaffold_10_Alpha-diversity.txt",row.names=F,col.names=T,quote=F,sep="\t")
