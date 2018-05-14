#!/usr/bin/env perl

use strict;
use warnings;

use SOAP::Lite;

my $client = new SOAP::Lite (
    proxy => 'http://localhost/soapserver.cgi',
    uri   => 'urn:AnkitPatiSOAPServer',
);

print "Addition\n", $client->add(43, 5, 50, 55)->result, "\n\n";

print "Factorial\n", $client->factorial(5)->result, "\n\n";

my $values = $client->factors (1849);
my @factors = ($values->result, $values->paramsout);
print "Factors\n@factors\n";
