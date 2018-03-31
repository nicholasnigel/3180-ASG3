use strict;
use warnings;

sub printing {

    my $list = shift \@_;
        
    print $list->[0]. "\n";
    
    my $n = scalar(@{$list});
    print $n. "\n";
    
    shift $list;
    print $list->[0]. "\n";

}

printing (['james','jacqualine','jean']);