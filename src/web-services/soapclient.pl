#!/usr/bin/env perl

use strict;
use warnings;

use SOAP::Lite;

my $client = new SOAP::Lite ( proxy => 'http://localhost/soap/' );

$client->uri ('urn:AddNumbers');
print "Addition\n", $client->getSum (43, 5, 50, 55)->result, "\n\n";

$client->uri ('urn:Factorial');
print "Factorial\n", $client->getFactorial (5)->result, "\n\n";
