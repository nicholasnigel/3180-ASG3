use strict;
use warnings;

package Task;
our $pid = 0 ;       # the first pid ever should be 0

#``````````````SUBROUTINE FOR BLESSING A NEW OBJECT ````````````````````````
sub new {   # calling new = Task->new(name,time)
    my $class = shift @_;   
    my $name = shift @_;    
    my $time = shift @_;

    my $object = bless {
        "name" => $name,
        "time" => $time,
        "pid" => $pid,
    }, $class;

    return $object;
}


return 1;