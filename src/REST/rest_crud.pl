#!/usr/bin/env perl

use strict;
use warnings;

use Mojolicious::Lite;
use JSON;

use File::Basename qw(dirname);
use lib dirname $0;
use Student;

any '/' => {
    text => <<'EOT',
<pre>

PUT     GET     POST    DELETE
create  read    update  delete

Above requests accepted on following endpoint(s):
 1. /student

</pre>
EOT
};

get '/student' => sub {
    my $c = shift;

    my $s = Student->retrieve ( $c->param ('prn') );

    if ($s) {
        $c->render (
            text => encode_json ({
                prn    => $s->prn,
                fname  => $s->fname,
                lname  => $s->lname,
                dob    => $s->dob,
                branch => $s->branch,
            }) . "\n",
        );
    }
    else {
        $c->render (
            text => encode_json ({
                status => 'Unable to fetch data for given PRN.',
            }) . "\n",
        );
    }
};

put '/student' => sub {
    my $c = shift;

    my $s = Student->insert ({
        prn    => $c->param ('prn'),
        fname  => $c->param ('fname'),
        lname  => $c->param ('lname'),
        dob    => $c->param ('dob'),
        branch => $c->param ('branch'),
    });

    if ($s) {
        $c->render (
            text => encode_json ({
                status => 'Success.',
            }) . "\n",
        );
    }
    else {
        $c->render (
            text => encode_json ({
                status => 'Unable to insert given data.',
            }) . "\n",
        );
    }
};

app->start;

__END__

Usage from Terminal:

$ ./rest_crud.pl get '/student?prn=506'
