#!/usr/bin/perl
if ($#ARGV < 1) {
	print <<USAGE;
_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/
Usage :
perl GFFtoIntergeneic.pl <genes.gff3> <Intergeneic.gff3>
       
_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/
USAGE
exit;
}
 else {
	
	$gffFile = $ARGV[0];
        $outfile = $ARGV[1];
	
        open (GFFFILE,"<$gffFile");
        open (OUTFILE,">$outfile");
        
        @gffLine = <GFFFILE>;
        $len = @gffLine;
     print $len;
        for($i=0; $i < $len; $i++)
          {
            chomp $gffLine[$i];
            ($scaff,$soft,$feat,$start,$end,$dot,$strand,$dot2,$info) = split /\t/, $gffLine[$i], 9;
           
 
            chomp $gffLine[$i+1];
            ($scaff1,$soft1,$feat1,$start1,$end1,$dot1,$strand1,$dot21,$info1) = split /\t/, $gffLine[$i+1], 9;
                    
        
            if($scaff eq $scaff1)
              {
               $Intergeneid = "DAPHNIA"."$i";
               $IntStart = $end + 1;
               $IntEnd = $start1 - 1;
               print OUTFILE "$scaff\t$soft\tIntergeneic\t$IntStart\t$IntEnd\t$dot\t+\t$dot2\tID=$Intergeneid\n";
              }
          }
    	
     }   
