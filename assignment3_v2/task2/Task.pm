use strict;
use warnings;

package Task;
our $pid = 0 ;       # the first pid ever should be 0

#``````````````SUBROUTINE FOR BLESSING A NEW OBJECT ````````````````````````
sub new {   # calling new = Task->new(name,time)
    my $class = shift @_;   
    my $name = shift @_;    
    my $total_time = shift @_;

    my $object = bless {
        "name" => $name,
        "total_time" => $total_time,
        "pid" => $pid,
    }, $class;

    return $object;
}

#```````````````SUBROUTINE TO GET OBJECT NAME ```````````````````
sub getName {       # sample use: $task->getName();
    my $self = shift @_;
    
    my $name_return = $self->{"name"};

    return $name_return;
}

#`````````````````SUBROUTINE TO GET THE TASK'S TOTAL TIME ``````````````
sub getTotalTime { 
    my $self = shift @_;

    my $total_time = $self->{"total_time"};

    return $total_time;
}

#`````````````````SUBROUTINE TO GET TASK'S ID```````````````````
sub getPID {
    my $self = shift @_;
    my $pid = $self->{"pid"};

    return $pid;
}


return 1;