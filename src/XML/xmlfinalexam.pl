#!/usr/bin/env perl

package AnkitPati::XMLFinalExam;

use strict;
use warnings;

use File::Basename qw(dirname);

use XML::LibXML;

sub answer1 {
    print <<'EOM';

Question 1
List all the authors of a book with maximum number of authors.

Answer 1
EOM

    my $dom = shift;

    my @books = $dom->findnodes ('//book');

    my $book_max_authors = shift @books;
    foreach my $book (@books) {
        my @authors_max = $book_max_authors->findnodes ('./author');
        my @authors = $book->findnodes ('./author');

        $book_max_authors = $book if @authors > @authors_max;
    }

    foreach my $author ($book_max_authors->findnodes ('./author')) {
        print $author->to_literal, "\n";
    }
}

sub answer2 {
    print <<'EOM';

Question 2
Display the price of a given book title.

Answer 2
EOM

    my $dom = shift;
    my $given = shift;

    print $dom->findvalue ("//book/title[text() = '$given']/../price"), "\n";
}

sub answer3 {
    print <<'EOM';

Question 3
List all the books below a given price.

Answer 3
EOM

    my $dom = shift;
    my $given = shift;

    print $_->to_literal, "\n"
        foreach $dom->findnodes ("//book/price[text() < '$given']/../title");
}

sub answer4 {
    print <<'EOM';

Question 4
Get all the book titles of a given category.

Answer 4
EOM

    my $dom = shift;
    my $given = shift;

    print $_->to_literal, "\n"
        foreach $dom->findnodes ("//book[\@category = '$given']/title");
}

sub main {
    my $filename = dirname ($0) . '/xml/books.xml';

    my $dom = eval { XML::LibXML->load_xml (location => $filename) };
    die "Malformed XML file!\n" if $@;

    answer1 $dom;
    answer2 $dom, 'XQuery Kick Start';
    answer3 $dom, 35.50;
    answer4 $dom, 'children';
}

main unless caller;

1;
