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

#printing (['james','jacqualine','jean']);
#my @names = ("jon", "lambert");
#printing2(@names);
my @names1 = ( "joel", "rita");
my @names2 = ( "amanda", "leo");
pushing(\@names1, \@names2);
print @names1;
print "\n";