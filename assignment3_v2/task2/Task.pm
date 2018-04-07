use strict;
use warnings;

package Task;
our $pid = -1 ;       # the first pid ever should be 0

#``````````````SUBROUTINE FOR BLESSING A NEW OBJECT ````````````````````````
sub new {   # calling new = Task->new(name,time)
    my $class = shift @_;   
    my $name = shift @_;    
    my $total_time = shift @_;

    if( $total_time != -1) {
        # if when creating time is negative one, dont change the pid = -1
        $pid++;
    }
    
    my $object = bless {
        "name" => $name,
        "total_time" => $total_time,
        "pid" => $pid,
    }, $class;      # blessing object with the corresponding name, total_time, and PID



    return $object;
}

#```````````````SUBROUTINE TO GET OBJECT NAME ```````````````````
sub name {       # sample use: $task->getName();
    my $self = shift @_;
    
    my $name_return = $self->{"name"};

    return $name_return;    
}

#`````````````````SUBROUTINE TO GET THE TASK'S TOTAL TIME ``````````````
sub time { 
    my $self = shift @_;

    my $total_time = $self->{"total_time"};

    return $total_time;
}

#`````````````````SUBROUTINE TO GET TASK'S ID```````````````````
sub pid {
    my $self = shift @_;
    my $pid = $self->{"pid"};

    return $pid;
}


return 1;