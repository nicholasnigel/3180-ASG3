use strict;
use warnings;

#this perl code is to demonstrate using parameter to see the parameter


sub getname {

    my $n = scalar(@_);

    print "Number of parameters passed are ". ${n}. "\n";
    my i = 0;
    foreach $name (@_) {
        my $namelist[i] = shift @_;
        i++;
    }
    foreach @names (@namelist) {
        print ${names} . "\n";
    }

}


# main function
getname('fred','zack','m-god');
