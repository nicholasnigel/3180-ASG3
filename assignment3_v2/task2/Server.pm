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
 * Name : Nigel Nicholas
 * Student ID : 1155088791
 * Email Addr : nigel7@cse.cuhk.edu.hk
 */

=cut

use strict;
use warnings;
 #you are required to use dynamic scoping here

package Server;
use Gpu;
use Task;

our $task;	#for the purpose of dynamic scoping
our $gpu;	#for the purpose of dynamic
#``````````````````````````````````INITIALIZATION OF THE SERVER CLASS OBJECT````````````````````````
sub new {
	my $class = shift @_;
	my $gpu_num = shift @_;		#recieves the gpu_num

	my @gpus = ();			#the list of gpus

	for (my $i = 0 ; $i < $gpu_num ; $i++) {
		$gpus[$i] = Gpu->new($i);		#initialize the GPUs with their corresponding ids, starting from 0 to gpu_num-1
	}
	my @waitq = ();		#initially, waitq should be empty

	my $object = bless {
		"gpu_number" => $gpu_num,
		"gpus" => \@gpus,
		"waitq" => \@waitq
	}, $class;

	return $object;
}


#`````````````````````````FOR PRINITNG PURPOSE````````````````````
sub task_info {
	return "task(user: ".$task->name().", pid: ".$task->pid().", time: ".$task->time().")";
}

#````````````````````````RETURN TASKS' ATTRIBUTE````````````````````````
sub task_attr {
	return $task->name(), $task->pid(), $task->time();
}

#````````````````````````PRINTING FOR THE GPU``````````````````````````
sub gpu_info {
	return "gpu(id: ".$gpu->id().")";
}


#`````````````````````````ASSIGN THE SUBMITTED TASK TO AN IDLE GPU IN ASCENDING ORDER. IF NO EMPTY, ADD TO WAIT QUEUE`````````````
sub submit_task {	# usage =  $server->submit_task("lin", 6);
	my $self = shift @_;
	my $user = shift @_;
	my $total_time = shift @_;

	local $task = Task->new($user,$total_time);
	local $gpu;

	foreach $gpu (@{$self->{"gpus"}} ) {
		if ( $gpu->{"gpu_state"} == 0 )	{

			print task_info() . " => ". gpu_info;
			print "\n";
			$gpu->assign_task($task);
			return 1;		# if a gpu is already found, just return a value (1) to show successful
		}	# if available (idling) , then assign a task
		
	}
	print task_info(). " => waiting queue\n";	# when it reaches this part, that means that no idle gpu is found
	push @{$self->{"waitq"}}, $task;  					# push the task into the waitqueue

}


#`````````````````````CHECKING WAITING QUEUE AND SUBMIT TASK IF ANY GPU IS IDLE```````````````````````
sub deal_waitq {
	my $self = shift @_;
	local $task;
	local $gpu;

	my $num_in_waitq = scalar( @{$self->{"waitq"}}  );
	if($num_in_waitq >= 1 ) {	#if there is something in the queue	
		foreach $gpu ( @{$self->{"gpus"}} ) {
			if ($gpu->{"gpu_state"} == 0 ) {
				$task = $self->{"waitq"}->[0];
				print task_info(). " => ". gpu_info();
				$gpu->assign_task( $task );		# if there is an idle gpu, then assign the first task in wait q to that gpu
				splice @{$self->{"waitq"}} , 0 ,1;	# delete that task from the waiting queue
				print "\n";
			}
		}	# check the gpu if there are any space to run this task
	}


}


#`````````````````````````KILL THE TASK WITH GIVEN PID AND NAME, IF NO CORRESPONDING TASK, OUTPUT FAILURE MESSAGE````````````````
sub kill_task {
	my $self = shift @_;
	my $username = shift @_;
	my $pid = shift @_;

	local $task;
	local $gpu;

	# check within the list of gpus of the server
	foreach $gpu ( @{$self->{"gpus"}}  ) {
		$task = $gpu->{"gpu_task"};

		if( ($task->{"name"} eq $username)  && $task->{"pid"} == $pid  ) {
			$gpu->release();	#if they have same name and pid, then release that gpu
			print "user $username kill ". task_info();
			print "\n";
			$self->deal_waitq();
			return 1; 		# showing that it successfully deleted
		}
	}

	for (my $i=0; $i < scalar(@{$self->{"waitq"}}) ; $i++ ) {	# if not found in the gpu run , look for it in the waitingq
		$task = $self->{"waitq"}[$i];
		if( ($task->{"name"} eq $username) && ($task->{"pid"} == $pid)  ) {
			splice @{$self->{"waitq"}}, $i, 1;		# if the task has the same name and pid, 
			print "user $username kill ". task_info();
			print "\n";
			return 1;
		}
	}

	print "user ".$username." kill task(pid: $pid) fail\n";		#if it reaches here, then the task is not found

}



#`````````````````````````` EXECUTE ALL THE GPU ONE UNIT TIME. THE TASK	IS FINISHED ONCE REACHING THE SET EXECUTION TIME````````
sub execute_one_time {
	my $self = shift @_;
	local $gpu;
	print "execute_one_time..\n";
	foreach $gpu ( @{$self->{"gpus"}} ) {
		if ( $gpu->{"gpu_state"} == 0 ) {	# if state is 0, go to the next gpu
			next;
		}
		else {
			$gpu->execute_one_time();		# for each gpu in the list of gpus, execute one time for each
			$self->deal_waitq();		#after execute one time, then deal the waitq, in case whether something is finished.
		}
	}

}


#````````````````````````PRINT THE CURRENT GPU MESSAGE``````````````````````````````
sub show {	# subroutine that prints out the usage of the gpus
	my $self = shift @_;
	local $task; 
	local $gpu;

	print "==============Server Message================\n";	

	print "gpu-id  state  user  pid  tot_time  cur_time\n";

	# for each gpu, print the line with same format
	foreach $gpu ( @{$self->{"gpus"}} ) {
		$task = $gpu->{"gpu_task"};
		#"  0     busy   lin    0      6         1" This should be the format that we are following
		print "  ". $gpu->{"gpu_id"};
		print "     ";
		if( $gpu->{"gpu_state"} == 0 ) {
			print "idle";
		}
		elsif( $gpu->{"gpu_state"} == 1 ) {
			print "busy";
		}

		if( $task->{"total_time"} == -1 ) {	# if it's the dummy target, print blank for the rest
			print "\n";
		}
		else {			# else, it means that it is a legit task, therefore print all the things
			print "   ";
			print $task->{"name"};
			print "    ";
			print $task->{"pid"};
			print "      ";
			print $task->{"total_time"};
			print "         ";
			print $gpu->{"gpu_current_time"};
			print "\n";
		}
	}
	my $queue_num = scalar ( @{$self->{"waitq"}});
	if($queue_num > 0) {

	foreach $task( @{$self->{"waitq"}} ) {	# check also for the list in waitq
		my ($name, $pid, $total_time) = task_attr();
		print "        "; 	# the spacing first
		print "wait";
		print "   ";
		print $name;
		print "    ";
		print $pid;
		print "      ";
		print $total_time;
		print "\n";


	}		# after printing the gpus, then check if there are tasks in waitq
}
	print "============================================\n\n"#by the end print the border
}


return 1;