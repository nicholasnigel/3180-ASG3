use strict;
use warnings;

package Gpu;
use Task;

#``````````````````SUBROUTINE TO INITIALIZE NEW OBJECT GPU````````````````
sub new {       # sample usage Gpu -> new(1);
    my $class = shift @_;
    my $gpu_id = shift @_;  
    my $gpu_state = 0;  # initializing gpu state to 0 , showing that it is not used
    my $gpu_current_time = 0;   # initizlize the time gpu has executed its function to 0
    my $gpu_task = Task->new(" ", -1);  # c initializing a null task, just for the sake of storing it 

    my $object = bless {
        "gpu_id" => $gpu_id,
        "gpu_state" => $gpu_state,
        "gpu_current_time" => $gpu_current_time,
        "gpu_task" => $gpu_task
    }$class;   # bless the object, and return it

    return $object;
}


#````````````````````SUBROUTINE TO ASSIGN A NEW TASK TO THIS GPU, ITS TIME WILL BE SET TO 0 AND STATE TO BUSY````````````````
sub assign_task {
    my $self = shift @_;
    my $task = shift @_;
    
    $self->{"gpu_task"} = $task;    # setting the task to the assigned task to be mentioned
    $self->{"gpu_current_time"} = 0;    # setting current time to 0 ( a new task )
    $self->{"gpu_state"} = 1;   # Setting state to busy

}


#```````````````````````SUBROUTINE TO RELEASE THE TASK AND INITIALIZE AGAIN THE VARIABLES``````````````````````
sub release {
    my $self = shift @_;
    
    $self->{"gpu_task"} = Task->new(" ",-1);    # the gpu task becomes like the first time blessing object, uninitialized
    $self->{"gpu_current_time"} = 0;            # the current time should start again from 0  
    $self->{"gpu_state"} = 0;                   # the state is returned back to 0, which is idling(busy)


}


#```````````````````````SUBROUTINE TO ADVANCE THE CURRENT TIME BY 1, IF TASK IS FINISHED, THEN RELEASE`
sub execute_one_time {
    my $self = shift @_;

    $self->{"gpu_current_time"} += 1;

    if( $self->{"gpu_current_time"} == $self->{"task"}->{"total_time"} ){
        $self->release();    
    }#compare the gpu current time and the tasks' total required time


}



return 1;
