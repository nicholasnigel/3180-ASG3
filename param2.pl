use strict;
use warnings;

sub printing {

    my $list = shift \@_;
        
    print $list->[0]. "\n";
    
    my $n = scalar(@{$list});
    print $n. "\n";
    
    #shift $list;
    foreach (@{$list}){
        print $_. "\n";
    }

    #print $list->[0]. "\n";

}

sub printing2 {
    my $list =  \@_;
    my $list_num = scalar(@{$list});

    my $i = 0;
    while( $i < $list_num) {
        print $list->[$i]. " ";
        $i++;
    }
    print "\n";

    foreach my $i (@{$list}) {
        print $i. " ";
    }
    print"\n";
    
}

sub pushing {
my $names1 = shift @_;
my $names2 = shift @_;
splice @{$names1} , 1, 1;
}

sub splicing {
    my $names1 = shift @_;
    #print scalar(@{$names1});
    my $total = 0;
    #print "\n";
    foreach my $name (@{$names1}) {
        $total += $name;
    }
    print "${total} \n";
    my @result =splice @{$names1} , 2, 4;
    
    #print @result;
    print "\n";
}

#printing (['james','jacqualine','jean']);
#my @names = ("jon", "lambert");
#printing2(@names);
my @names1 = (0,1,2,3,4,5,6,7,8,9,10,11);
my @names2 = ( "amanda", "leo");

my @division = @names1[1..5];
#print @division;
#print "\n";

splicing(\@names1);
#print @names1;
my @bonjour = splice @names1;
print @bonjour;
print "\n";
print "\n";
