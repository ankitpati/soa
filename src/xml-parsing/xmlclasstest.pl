#!/usr/bin/env perl

package AnkitPati::XMLClassTest;

use strict;
use warnings;

use XML::Parser;
use XML::Parser::EasyTree;
use XML::Generator;

$XML::Parser::EasyTree::Noempty = 1;

sub answer1 {
    print <<'EOM';

Question 1
Display all the foodnames available for breakfast.

Answer 1
EOM

    my $tree = shift;

    my @foods = @{$tree->[0]{content}};

    foreach my $food (@foods) {
        print "$food->{content}[0]{content}[0]{content}\n";
    }
}

sub answer2 {
    print <<'EOM';

Question 2
Display the description of a foodname given.

Answer 2
EOM

    my $tree = shift;
    my $given = shift;

    my @foods = @{$tree->[0]{content}};

    foreach my $food (@foods) {
        print "$food->{content}[2]{content}[0]{content}\n"
            if $food->{content}[0]{content}[0]{content} eq $given;
    }
}

sub answer3 {
    print <<'EOM';

Question 3
Display all the foodnames and their respective price in a table.

Answer 3
EOM

    my $tree = shift;

    my @foods = @{$tree->[0]{content}};

    foreach my $food (@foods) {
        print "$food->{content}[0]{content}[0]{content}\n\t";
        print "$food->{content}[1]{content}[0]{content}\n";
    }
}

sub answer4 {
    print <<'EOM';

Question 4
Display all the foodnames below a given price.

Answer 4
EOM

    my $tree = shift;
    my $given = shift;

    my @foods = @{$tree->[0]{content}};

    foreach my $food (@foods) {
        print "$food->{content}[0]{content}[0]{content}\n"
            if ($food->{content}[1]{content}[0]{content} =~ s/\$//r) < $given;
    }
}

sub answer5 {
    print <<'EOM';

Question 5
Display foodnames and description in a sorted table based on calorific value.

Answer 5
EOM

    my $tree = shift;
    my $given = shift;

    my @foods = @{$tree->[0]{content}};

    @foods = sort {
        ($a->{content}[1]{content}[0]{content} =~ s/\$//r) <=>
        ($b->{content}[1]{content}[0]{content} =~ s/\$//r)
    } @foods;

    foreach my $food (@foods) {
        print "$food->{content}[0]{content}[0]{content}\n\t";
        print "$food->{content}[2]{content}[0]{content}\n";
    }
}

sub main {
    my $prsr = new XML::Parser (Style => 'EasyTree');

    my $tree;
    eval {
        $tree = $prsr->parsefile ('xml/menu.xml');
    };
    die "Malformed XML file!\n" if $@;

    answer1 $tree;
    answer2 $tree, 'French Toast';
    answer3 $tree;
    answer4 $tree, 6;
    answer5 $tree;
}

main unless caller;

1;
