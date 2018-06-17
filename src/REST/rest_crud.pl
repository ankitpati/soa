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
                # param 1: ARRAYref of subset
                # param 2: ARRAYref of superset

# helper subroutines

my @fields = map { $_->name } Student->columns;
my $pkey = Student->primary_column->name;

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

    my $s = Student->retrieve ( $c->param ($pkey) );

    if ($s) {
        my $response;
        $response->{$_} = $s->$_ foreach @fields;
        $c->render (text => encode_json ($response) . "\n");
    }
    else {
        $c->render (
            text => encode_json ({
                status => 'Given record does not exist.',
            }) . "\n",
        );
    }
};

del '/student' => sub {
    my $c = shift;

    my $s = Student->retrieve ( $c->param ($pkey) );

    if ($s) {
        $c->render (
            text => encode_json ({
                status => $s->delete == 1 ? 'Success.'
                                          : 'Unable to delete given record.',
            }) . "\n",
        );
    }
    else {
        $c->render (
            text => encode_json ({
                status => 'Given record does not exist.',
            }) . "\n",
        );
    }
};

put '/student' => sub {
    my $c = shift;

    my $params = $c->req->params->to_hash;
    my @got_fields = keys %$params;

    unless (
        is_subset (\@fields, \@got_fields) &&
        is_subset (\@got_fields, \@fields)
    ) {
        $c->render (
            text => encode_json ({ status => "@fields required.", }) . "\n",
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

post '/student' => sub {
    my $c = shift;

    my $params = $c->req->params->to_hash;
    my @got_fields = keys %$params;

    unless (is_subset \@got_fields, \@fields) {
        $c->render (
            text => encode_json ({
                status => "@fields accepted.",
            }) . "\n",
        );
        return;
    }

    my $s = Student->retrieve ($params->{$pkey});

    unless ($s) {
        $c->render (
            text => encode_json ({
                status => 'Unable to retrive required record.',
            }) . "\n",
        );
        return;
    }

    $s->$_ ($params->{$_}) foreach @got_fields;

    $c->render (
        text => encode_json ({
            status =>
                $s->update == 1 ? 'Success.' : 'Unable to update given record.',
        }) . "\n",
    );
};


app->start;

__END__

Usage from Terminal:

$ ./rest_crud.pl get '/student?prn=506'
