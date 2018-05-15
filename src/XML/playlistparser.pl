#!/usr/bin/env perl

package AnkitPati::PlaylistParser;

use strict;
use warnings;

use XML::LibXML;

sub main {
    @ARGV == 1 or die "Usage:\n\t${\(split m|/|, $0)[-1]} <filename>\n";
    my $filename = shift @ARGV;

    my $dom = eval { XML::LibXML->load_xml (location => $filename) };
    die "Malformed XML file!\n" if $@;

    foreach my $movie ($dom->findnodes ('//movie')) {
        my $cast = join ', ', map { "$_->{name} as $_->{role}" }
                                $movie->findnodes ('./cast/person');
        $cast =~ s/, $//;

        print "\nTitle    : ", $movie->findvalue ('./title');
        print "\nDirector : ", $movie->findvalue ('./director');
        print "\nRelease  : ", $movie->findvalue ('./release-date');
        print "\nMPAA     : ", $movie->findvalue ('./mpaa-rating');
        print "\nTime     : ", $movie->findvalue ('./running-time');
        print "\nCast     : ", $cast;
        print "\n"
    }
}

main unless caller;

1;
