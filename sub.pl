#using subroutine and using parameter

sub Hello{

	print "Hello, World!\n";
}

sub Average {
	#get total number of arguments passed.
		$n = scalar(@_);
		$sum = 0;

		foreach $item (@_){
			$sum += $item;
		}

		$average = $sum / $n;

		print "Average : ${average}\n";

}


Hello();
Average(40,20,30);