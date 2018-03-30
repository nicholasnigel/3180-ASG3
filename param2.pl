use strict;
use warnings;

sub printing {

    my $list = shift \@_;

    print $list->[1];
    print "\n";
}

printing (['james','jean']);