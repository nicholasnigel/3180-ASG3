use strict;
use warnings;
 #you are required to use dynamic scoping here

package Server;
use Gpu;
use Task;

#``````````````````````````````````INITIALIZATION OF THE SERVER CLASS OBJECT````````````````````````
sub new {
	my $class = shift @_;
	my $gpu_num = shift @_;		#recieves the gpu_num

	my @gpus = ();			#the list of gpus

	for (my $i = 0 ; $i < $gpu_num ; $i++) {
		$gpus[$i] = Gpu->mew($i);		#initialize the GPUs with their corresponding ids, starting from 0 to gpu_num-1
	}
	my @waitq = ();		#initially, waitq should be empty

	my $object = bless {
		"gpu_number" => $gpu_num.
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

	local $task_to_assign = Task->new($user,$total_time);
	local $gpu;

	foreach $gpu ($self->{"gpus"}) {
		if ( $gpu->{"gpu_state"} == 0 )	{
			print $self->task_info($task_to_assign)." => ".$self->gpu_info($gpu);
			print "\n";
			$gpu->assign_task($task_to_assign);
		}	# if available (idling) , then assign a task
		return 1;		# if a gpu is already found, just return a value (1) to show successful
	}
	print $self->task_info($task_to_assign). " => waiting queue\n";	# when it reaches this part, that means that no idle gpu is found
	push @{$self->{"waitq"}}, $task_to_assign;  					# push the task into the waitqueue

}


#`````````````````````CHECKING WAITING QUEUE AND SUBMIT TASK IF ANY GPU IS IDLE```````````````````````
sub deal_waitq {
	my $self = shift @_;
	local $task;
	local $gpu;

	my $num_in_waitq = scalar( @{$self->{"waitq"}}  );
	if($num_in_waitq >= 1 ) {	#if there is something in the queue	
		foreach $gpu ($self->{"gpus"} ) {
			if ($gpu->{"gpu_state"} == 0 ) {
				$task = $self->{"waitq"}->[0];
				print $self->task_info($task). " => ". $self->gpu_info($gpu);
				$gpu->assign_task( $task );		# if there is an idle gpu, then assign the first task in wait q to that gpu
				splice @{$self->{"waitq"}} , 0 ,1;	# delete that task from the waiting queue
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
		$task = $gpu->{"tasks"};
		if( ($task->{"name"} eq $username)  && $task->{"pid"} == $pid  ) {
			$gpu->release();	#if they have same name and pid, then release that gpu
			print "user $username kill "$task->task_info();
			print "\n";
			return 1; 		# showing that it successfully deleted
		}
	}

	for (my $i=0; $i < scalar(@{$self->{"waitq"}})-1 ; $i++ ) {
		$task = $self->{"waitq"}[i];
		if( ($task->{"name"} eq $username) && $task->{"pid"} == $pid  ) {
			splice @{$self->{"waitq"}}, $i, 1;		# if the task has the same name and pid, 
			print "user $username kill "$task->task_info();
			print "\n";
			return 1;
		}
	}

	print "user ".$username." kill task(pid: $pid) fail\n";		#if it reaches here, then the task is not found

}



#`````````````````````````` EXECUTE ALL THE GPU ONE UNIT TIME. THE TASK	IS FINISHED ONCE REACHING THE SET EXECUTION TIME````````
sub execute_one_time {


}
sub show {

}


return 1;