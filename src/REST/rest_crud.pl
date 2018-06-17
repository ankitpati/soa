#!/usr/bin/env perl

use strict;
use warnings;

use Mojolicious::Lite;
use JSON;

use File::Basename qw(dirname);
use lib dirname $0;
use Student;

# helper subroutines
sub is_subset { my %h; undef @h{@{$_[0]}}; delete @h{@{$_[1]}}; !keys %h }
# helper subroutines

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

    my @expected_fields = qw( prn fname lname dob branch );
    my $params = $c->req->params->to_hash;
    my @got_fields = keys %$params;

    unless (
        is_subset (\@expected_fields, \@got_fields) &&
        is_subset (\@got_fields, \@expected_fields)
    ) {
        $c->render (
            text => encode_json ({
                status => 'prn, fname, lname, dob, branch required.',
            }) . "\n",
        );
        return;
    }

    my $s = Student->insert ($params);

    $c->render (
        text => encode_json ({
            status => $s ? 'Success.' : 'Unable to insert given data.',
        }) . "\n",
    );
};

app->start;

__END__

Usage from Terminal:

$ ./rest_crud.pl get '/student?prn=506'
