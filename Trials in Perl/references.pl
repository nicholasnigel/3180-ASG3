my $x = 5;
my @y = ("hello", 1);
my %z = ("name"=>"Christina", "gender" => female);


my $xRef = \$x;
my $yref = \@y;
my $zRef = \%z;


print $xRef;
print $yRef;
print $zRef;

print $$xref;
print $yref->[0];
print $zRef->{"name"};

print $$xRef;
print @$yRef;
print %$zRef;