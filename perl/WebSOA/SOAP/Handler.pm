package WebSOA::SOAP::Handler;

use strict;
use warnings;

use File::Basename qw(dirname);
use SOAP::Transport::HTTP;

my $server = SOAP::Transport::HTTP::Apache
                               ->dispatch_to (dirname (__FILE__) . '/Services');

sub handler {
    $server->handler (@_);
}

1;
