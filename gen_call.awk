#!/bin/awk -f

BEGIN{
 OFS ="\t"
 if(ARGC < 2)
  exit 1
 while(getline < ARGV[1])
  param[$1] = $2
 qual_hom = param["qhom"]
 coverage_hom = param["chom"]
 qual_het = param["qhet"]
 coverage_het = param["chet"]
 missing = param["m"]
 het = param["h"]
 maf = param["f"]

 print "#gen_call.awk parameters: qual = "qual_hom, qual_het, "coverage = "coverage_hom, coverage_het, "missing = "missing, "het = "het, "maf = "maf
 ARGV[1] = ARGV[2]
 ARGC = ARGC - 1

 header = 0
}

/^#CHROM/ && !header {
  printf "chr\tpos\treference_allele\talternative_allele\tsamtools_quality_score"
  for ( i = 10; i <= NF; i++){
   printf "\t"$i
  }
  printf "\n"
  header = 1
 }


!/^#/{
 if(!(length($4) == 1 && length($5) == 1 && $6 >= 40))
  next
 if($4 == "N")
  next
 delete(h)
 for ( i = 10; i <= NF; i++){
  split($i, a, ":")
  if(a[1] == "1/1")
   g=2
  else if(a[1] == "0/1")
   g=1
  else if(a[1] == "0/0")
   g=0
  else
   g="NA"
  if((g == 0 || g == 2) && a[3] >= coverage_hom && a[5] >= qual_hom)
   h[i] = g
  else if(g == 1 && a[3] >= coverage_het && a[5] >= qual_het)
   h[i] = g
  else
   h[i] = "NA"
 }
 delete(hist)
 for(i in h)
  hist[h[i]]++
 n = 0 + hist["NA"] 
 A = 0 + hist[0] 
 H = 0 + hist[1] 
 B = 0 + hist[2] 
 if(A + B + H == 0)
  next

 if(B > A)
  m = (2*A + H) / 2 / (A+B+H)
 else
  m = (2*B + H) / 2 / (A+B+H)
 
 all = A + B + H + n
 if(n <= missing * all && H <= het * (A+B+H) && m >= maf){
  printf $1"\t"$2"\t"$4"\t"$5"\t"$6
  for ( i = 10; i <= NF; i++)
   printf "\t"h[i]
  printf "\n"
 }
}
