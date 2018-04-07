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
 
package Server;
use Gpu;
use Task;

# glob variables used for dynamic scoping
our $task = Task->new("   ", -1); # init using dummy task obj
our $gpu = Gpu->new(-1); # init using dummy gpu obj

# Init the gpus array with gpu num GPU Object. 
#  arr index represents the GPU index.
sub new {
	my $class = shift @_;
	my $gpu_num = shift @_;
	my @gpus = ();
	for my $i (0..$gpu_num - 1){
		$gpus[$i] = Gpu->new($i);
	}
	our @waitq;
	my $object = bless {"gpu_num"=>$gpu_num, "gpus"=>\@gpus, "waitq"=>\@waitq}, $class;
	return $object;
}
# Output the task information.
sub task_info {
	return "task(user: ".$task->name().", pid: ".$task->pid().", time: ".$task->time().")";
}
# Return the task attributes.
sub task_attr {
	return $task->name(), $task->pid(), $task->time();
}
# Return the GPU information.
sub gpu_info {
	return "gpu(id: ".$gpu->id().")";
}
# Assign the submitted task to a idle GPU in ascending order. 
#  If there is no empty GPU, it will be added in the waiting queue.
sub submit_task {
	my $self = shift @_;
	my $userName = shift @_;
	my $timeRequired = shift @_;
	my $foundIdleGpu = 0;
	local $task = Task->new($userName,$timeRequired);
	local $gpu;
	# search for idle GPU in ascending order
	for my $i (0..$self->{"gpu_num"} - 1){
		$gpu = $self->{"gpus"}[$i];
		if ( $gpu->{"state"} == 0){
			print $self->task_info($task)." => ".$self->gpu_info($gpu);
			print "\n";
			$gpu->assign_task($task);
			$foundIdleGpu = 1;
			last;
		}
	}
	# submit task to queue if no idle GPU found
	if ($foundIdleGpu == 0){
		#$temp = Task->new($userName,$timeRequired);
		print $self->task_info($task)." => waiting queue\n";
		push @{$self->{"waitq"}}, $task;

	}
}
# Check the waiting queue and submit the task if any GPU is idle.
sub deal_waitq {
	my $self = shift @_;
	local $task;
	local $gpu;
	if (scalar @{$self->{"waitq"}} > 0){
		$task = $self->{"waitq"}[0];
		splice @{$self->{"waitq"}}, 0, 1;
	}
	else{
		return 0;
	}
	for my $i (0..$self->{"gpu_num"} - 1){
		$gpu = $self->{"gpus"}[$i];
		# reset GPU and send waiting task to it
		if ($gpu->{"state"} == 0){
			$gpu->assign_task($task);
			print $self->task_info($task)." => ".$self->gpu_info($gpu)."\n";
			last;
		}
	}

}
# Kill the task with given pid and name.
#  If there is no corresponding task, output the failure message.
sub kill_task {
	my $self = shift @_;
	my $userName = shift @_;
	my $pidOfTask = shift @_;
	my $taskFound = 0;
	local $task;
	local $gpu; 
	# find the task to be killed in the GPUs
	for my $i (0..scalar @{$self->{"gpus"}} - 1){
		$task = $self->{"gpus"}[$i]->{"task"};
		$gpu = $self->{"gpus"}[$i];
		if (($task->{"name"} eq $userName) && ($task->{"pid"} == $pidOfTask)){
			$gpu->release();
			$taskFound = 1;
			last;
		}
	}
	# find the task to be killed in the waiting queue
	if ($taskFound == 0){
		for my $i (0..scalar @{$self->{"waitq"}} - 1){
			$task = $self->{"waitq"}[$i];
			if (($task->{"name"} eq $userName) && ($task->{"pid"} == $pidOfTask)){
				splice @{$self->{"waitq"}}, $i, 1; # remove the ith task in queue
				$taskFound = 1;
				last;
			}
		}
	}
	if ($taskFound == 0){
		print "user ".$userName." kill task(pid: $pidOfTask) fail\n";
	}
	else{
		print "user ".$userName." kill ".$self->task_info($task)."\n";
		$self->deal_waitq(); # check wait queue
	}

}
# Excute ALL the GPU one time.
sub execute_one_time {
	my $self = shift @_;
	local $gpu;
	print "execute_one_time..\n";
	for my $i (0..$self->{"gpu_num"} - 1){
		$gpu = $self->{"gpus"}[$i];
		if ($gpu->{"state"} == 0){
			next;
		}
		my $taskFinished = $gpu->execute_one_time();
		if ($taskFinished == 1){
			$gpu->release();
			print "task in ".$self->gpu_info($gpu)." finished\n";
			$self->deal_waitq();
		}
	}
}
# Print the current GPU message.
sub show {
	local $task;
	local $gpu;
	my $self = shift @_;
	print "==============Server Message================\n";
	print "gpu-id  state  user  pid  tot_time  cur_time\n";
	for my $i (0..$self->{"gpu_num"} - 1){
		$gpu = $self->{"gpus"}[$i];
		$task = $self->{"gpus"}[$i]->{"task"};
		print "  ".$gpu->{"id"};
		print "     ";
		if ($gpu->{"state"} == 0){
			print "idle";
			print "\n";
			next;
		}
		else{
			print "busy";
		}
		print "   ";
		print $task->{"name"};
		print "    ";
		if ($task->{"pid"} != -1){
			print $task->{"pid"};
		}
		else{
			print " ";
		}
		print "      ";
		if ( $task->{"time"} != -1){
			print $task->{"time"};
		}
		else{
			print " ";
		}
		print "         ";
		if (($gpu->{"time"} == 0) && $task->{"time"} == -1) {
			print " ";
		}
		else{
			print $gpu->{"time"};
		}
		print "\n";
	}
	for my $i (0..scalar @{$self->{"waitq"}} - 1){
		$task = $self->{"waitq"}[$i];
		print "   ";
		print "     ";
		print "wait";
		print "   ";
		print $task->{"name"};
		print "    ";
		print $task->{"pid"};
		print "      ";
		print $task->{"time"};
		print "\n";
	}
	print "============================================\n\n";
}

return 1;