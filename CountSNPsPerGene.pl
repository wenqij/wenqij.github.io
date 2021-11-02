#!/usr/bin/perl
if ($#ARGV < 2) {
	print <<USAGE;
_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/
Usage :
perl CountSNPsPerGene.pl <TransgenerationalSamplesRenamed_dp10_q30_GT.GT.FORMAT> <genes.gff3> <SNPmatrixGeneCount.txt>

-> SNP count per gene for alpha diversity analysis.
       
_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/
USAGE
exit;
}
 else {
	
	$GTfile = $ARGV[0];
        $gffFile = $ARGV[1];
        $outfile = $ARGV[2];
	
        open (GTFILE,"<$GTfile");
        open (GFFFILE,"<$gffFile");
        open (OUTFILE,">$outfile");



        while($gtinfo = <GTFILE>)
         {
           chomp $gtinfo; 
           ($scaff,$pos,$cwp,$pp,$ep,$pr) = split /\t/, $gtinfo, 6;
            $scafpos = $scaff."_".$pos;
            $cwppos{$scafpos} = $cwp;
            $pppos{$scafpos} = $pp;
            $eppos{$scafpos} = $ep;
            $prpos{$scafpos} = $pr;
           #  print "$prpos{$scafpos}\n";
           #print "-$scafpos-\n";
            #print "-$renameOld2New{$oldName}-";
         }


	while($gffLine = <GFFFILE>)
    	 {
    	   chomp $gffLine;
           ($scaff,$soft,$feat,$start,$end,$dot,$strand,$dot2,$info) = split /\t/, $gffLine, 9; 
           ($geneID, $other)= split /\;/, $info, 2; $geneID =~ s/ID=//g;
            $cmpcnt=0; $ppcnt=0; $epcnt=0; $prcnt=0;
            if($feat eq "mRNA")   #if($feat eq "gene")if($feat eq "Intergeneic")
            {
             for($i=$start; $i<=$end;$i++)
               {
                $scaffpos = $scaff."_".$i;
                #print "$scaffpos\n";
                if(exists($cwppos{$scaffpos}))
                  {
                   $cmpcnt++ if($cwppos{$scaffpos} ne "0/0");
                  }
                if(exists($pppos{$scaffpos}))
                  {
                   $ppcnt++ if($pppos{$scaffpos} ne "0/0");
                  }
                if(exists($eppos{$scaffpos}))
                 {
                   $epcnt++ if($eppos{$scaffpos} ne "0/0");
                 } 
                if(exists($prpos{$scaffpos}))
                 {
                   $prcnt++ if($prpos{$scaffpos} ne "0/0");
                 }
               }
              $total = $cmpcnt+$ppcnt+$epcnt+$prcnt;
              if($total != 0)
                {
                   print OUTFILE "$geneID\t$cmpcnt\t$ppcnt\t$epcnt\t$prcnt\n"; #print OUTFILE "$scaff\t$geneID\t$cmpcnt\t$ppcnt\t$epcnt\t$prcnt\n";
                }
            }
    	 }
    	
    }   
