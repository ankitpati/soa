#!/usr/bin/env perl

package AnkitPati::XMLClassTest;

use strict;
use warnings;

use File::Basename qw(dirname);

use XML::LibXML;

sub answer1 {
    print <<'EOM';

Question 1
Display all the foodnames available for breakfast.

Answer 1
EOM

    my $dom = shift;

    print $_->to_literal, "\n" foreach $dom->findnodes ('//food/name');
}

sub answer2 {
    print <<'EOM';

Question 2
Display the description of a foodname given.

Answer 2
EOM

    my $dom = shift;
    my $given = shift;

    my @foods = $dom->findnodes
                        ("//food/name[text() = '$given']/../description");

    print $_->to_literal, "\n" foreach @foods;
}

sub answer3 {
    print <<'EOM';

Question 3
Display all the foodnames and their respective price in a table.

Answer 3
EOM

    my $dom = shift;

    print $_->findvalue ('name'), "\n\t", $_->findvalue ('price'), "\n"
        foreach $dom->findnodes ('//food');
}

sub answer4 {
    print <<'EOM';

Question 4
Display all the foodnames below a given price.

Answer 4
EOM

    my $dom = shift;
    my $given = shift;

    my @foods = $dom->findnodes
                        ("//food/price[text() = '$given']/../description");

    print $_->to_literal, "\n" foreach @foods;

    foreach my $food ($dom->findnodes ('//food')) {
        print $food->findvalue ('name'), "\n"
              if ($food->findvalue ('price') =~ s/[^\d.]//gr) < $given;
    }
}

sub answer5 {
    print <<'EOM';

Question 5
Display foodnames and description in a sorted table based on calorific value.

Answer 5
EOM

    my $dom = shift;
    my $given = shift;

    my @foods = $dom->findnodes ('//food');

    @foods = sort { $a->findvalue ('calories') <=> $b->findvalue ('calories') }
             @foods;

    print $_->findvalue ('name'), "\n\t", $_->findvalue ('description'), "\n"
        foreach @foods;
}

sub main {
    my $filename = dirname ($0) . '/xml/menu.xml';

    my $dom = eval { XML::LibXML->load_xml (location => $filename) };
    die "Malformed XML file!\n" if $@;

    answer1 $dom;
    answer2 $dom, 'French Toast';
    answer3 $dom;
    answer4 $dom, 6;
    answer5 $dom;
}

main unless caller;

1;
