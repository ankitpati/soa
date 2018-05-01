package Factors;

use SOAP::Lite;

sub getFactors {
    my $self = shift;
    my $n = shift;

    my @factors;
    foreach (1 .. $n/2) {
        push @factors, $_ unless $n % $_;
    }

    return SOAP::Data->name (factors => @factors);
}

1;
