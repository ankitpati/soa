package AddTwoNumbers;

use SOAP::Lite;

sub getSum {
    my $self = shift;
    my ($num1, $num2) = (shift, shift);
    return SOAP::Data->name (Result => $num1 + $num2)->type ('int');
}

1;
