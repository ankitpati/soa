#!/usr/bin/env perl

use strict;
use warnings;

use SOAP::Transport::HTTP;

SOAP::Transport::HTTP::CGI->dispatch_to('AnkitPatiSOAPServer')->handle;

package AnkitPatiSOAPServer;

sub add {
    my $self = shift;

    my $sum = 0;
    $sum += $_ foreach @_;

    return $sum;
}

sub factorial {
    my $self = shift;
    my $n = shift;

    my $factorial = 1;
    $factorial *= $_ foreach 1 .. $n;

    return $factorial;
}

sub factors {
    my $self = shift;
    my $n = shift;

    my @factors;
    foreach (1 .. $n) {
        push @factors, $_ unless $n % $_;
    }

    return @factors;
}

1;
