=begin comment
/*
 * CSCI3180 Principles of Programming Languages
 *
 * --- Declaration ---
 *
 * I declare that the assignment here submitted is original except for source
 * material explicitly acknowledged. I also acknowledge that I am aware of
 * University policy and regulations on honesty in academic work, and of the
 * disciplinary guidelines and procedures applicable to breaches of such policy
 * and regulations, as contained in the website
 * http://www.cuhk.edu.hk/policy/academichonesty/
 *
 * Assignment 3
 * Name : KARYONO JO Saswiko
 * Student ID : 1155074594
 * Email Addr : karyono6@cse.cuhk.edu.hk
 */
use strict;
use warnings;
=cut

use strict;
use warnings;

package Gpu;
use Task;

# New an object and initial state is idle.
sub new {
	my $class = shift @_;
	my $id = shift @_; # The ID of this GPU in the server.
	my $task = Task->new("   ",-1); # initialize using dummy task
	my $state = 0; # The state of GPU, it has two value, 1 and 0. 1 means busy and 0 means idle.
	my $time = 0; # Current execution time of the task
	my $object = bless {"id"=>$id, "task"=>$task, "state"=>$state, "time"=>$time}, $class;
	return $object;
}
# Assign a new task to this GPU. 
#  Its state will become busy and time is set to zero.
sub assign_task {
	my $self = shift @_;
	my $taskToBeAssigned = shift @_;
	$self->{"task"} = $taskToBeAssigned;
	$self->{"state"} = 1;
	$self->{"time"} = 0;
}
# Release the task and re-initialize the variable.
sub release {
	my $self = shift @_;
	$self->{"task"} = Task->new("   ",-1); # release task
	$self->{"task"}->{"pid"} = -1; # dummy pid
	$self->{"state"} = 0;
	$self->{"time"} = 0;
}
# Execute the task one time. 
#  When the task is finished, it will be released.
sub execute_one_time {
	my $self = shift @_;

	$self->{"time"}++; # GPU time (cur_time)++
	if ($self->{"task"}->{"time"} == $self->{"time"} ){
		$self->release();
		return 1; # to indicate whether task has finished
	}
	else{
		return 0;
	}
}

sub id{
	my $self = shift @_;
	return $self->{"id"};
}

return 1;
=begin comment
my $test = Gpu->new(0);
$test->{"task"} = Task->new('liz',6);
print $test->{"task"}->{"name"};
print $test->{"task"}->{"time"};
=cut

