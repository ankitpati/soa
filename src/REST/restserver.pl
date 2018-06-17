#!/usr/bin/env perl

use strict;
use warnings;

use Mojolicious::Lite;

any '/' => {
    text => <<'EOT',
<pre>

GET and POST requests accepted at the following end-points:
 1. /add
    Parameters:
        double num1, num2;
    Eg. /add?num1=43&num2=5

 2. /factorial
        unsigned num;
    Eg. /factorial?num=5

 3. /factors
        unsigned num;
    Eg. /factors?num=1849

</pre>
EOT
};

any '/add' => sub {
    my $c = shift;

    my $num1 = $c->param ('num1');
    my $num2 = $c->param ('num2');

    $c->render (text => ($num1 + $num2) . "\n");
};

any '/factorial' => sub {
    my $c = shift;

    my $num = $c->param ('num');

    my $factorial = 1;
    $factorial *= $_ foreach 1 .. $num;

    $c->render (text => "$factorial\n");
};

any '/factors' => sub {
    my $c = shift;

    my $num = $c->param ('num');

    my @factors;
    foreach (1 .. $num) {
        push @factors, $_ unless $num % $_;
    }

    $c->render (text => "@factors\n");
};

app->start;

__END__

Usage from Terminal:

$ ./restserver.pl get '/add?num1=43&num2=5'
$ ./restserver.pl get '/factorial?num=5'
$ ./restserver.pl get '/factors?num=1849'
