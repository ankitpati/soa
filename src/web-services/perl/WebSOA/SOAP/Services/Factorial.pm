package Factorial;

sub getFactorial {
    my $self = shift;
    my $n = shift;

    my $factorial = 1;
    $factorial *= $_ foreach 1 .. $n;

    return $factorial;
}

1;
