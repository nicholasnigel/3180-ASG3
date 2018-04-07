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

package Task;

our $pid = -1; # initialize pid so that first task has pid of 0

# Instantiate an object with its name, time, and return the object. 
#  The pid is counted from zero and plus one for each new task. 
#  The first task has pid 0.
sub new {
	my $class = shift @_;
	my $name = shift @_; # The name of user who submits this task.
	my $time = shift @_; # Total execution time of the task.
	# time acts as a boolean that determines whether the task is a dummy
	if ($time!= -1){
		$pid++; # increase pid by 1 
	}
	my $object = bless {"name"=>$name, "time"=>$time, "pid"=>$pid}, $class;
	return $object;
}

# below are get methods for a Task object's attributes

sub name{
	my $self = shift @_;
	return $self->{"name"};
}

sub time{
	my $self = shift @_;
	return $self->{"time"};
}

sub pid{
	my $self = shift @_;
	return $self->{"pid"};
}

return 1;