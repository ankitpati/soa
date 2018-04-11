package AddNumbers;

use SOAP::Lite;

sub getSum {
    my $self = shift;

    my $sum = 0;
    $sum += $_ foreach @_;

    return SOAP::Data->name (Result => $sum)->type ('int');
}

1;
