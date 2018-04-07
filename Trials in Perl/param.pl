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

sub changeName {
my $names = shift @_;
$names->[0] = "altima";

}

sub deletion {
    my $list = shift @_;
    my $num_to_delete = shift @_;
    my $num = scalar(@{$list});

    my $i = 0;
    while( $i < $num) {
        if($list->[$i] == $num_to_delete) {
            splice @{$list}, $i, 1;
        }
        $i++;
    }
}

# main function
#getname('fred','zack','m-god');
#print "next one is \n";
#getname('joseph','mikey');
 my @numbers1 = (1,2,3,4,5,6,7,8,9);

deletion(\@numbers1, 5);
print "@numbers1 \n";
print $numbers1[4];
