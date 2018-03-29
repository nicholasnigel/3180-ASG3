use strict;
use warnings;

#this perl code is to demonstrate using parameter to see the parameter


sub getname {

    my $n = scalar(@_);

    print "Number of parameters passed are ". ${n}. "\n";
    my $i = 0;
    my @namelist = (' ');
    foreach my $item (@_) {
         $namelist[$i] = $item;
        $i++;
    }
    foreach my $names (@namelist) {
        print ${names} . "\n";
    }
    print "first person in the name list is ". ${namelist[0]} . "\n";
}


# main function
getname('fred','zack','m-god');
print "next one is \n";
getname('joseph','mikey');
