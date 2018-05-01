#!/usr/bin/env perl

package AnkitPati::XMLParse;

use strict;
use warnings;

use XML::Parser;
use XML::Parser::EasyTree;
use XML::Generator;

$XML::Parser::EasyTree::Noempty = 1;

sub unravel {
    my $elem = shift;
    my $level = shift // 0;

    if ('ARRAY' eq ref $elem) {
        unravel ($_, $level + 1) foreach @$elem;
        print "\n\n";
        return;
    }

    if ($elem->{type} eq 't') { # print text elements directly
        print '    'x($level-1), $elem->{content};
        print "\n";
        return;
    }

    print '    'x($level-1), "Name: $elem->{name}\n";

    if (%{$elem->{attrib}}) {
        print '    'x($level-1), "Attributes:\n";
        print '    'x($level-1), "    $_: $elem->{attrib}{$_}\n"
            foreach sort keys %{$elem->{attrib}};
    }

    print '    'x($level-1), "Content:\n";
    unravel ($elem->{content}, $level);
}

sub main {
    @ARGV == 1 or die "Usage:\n\t${\(split m|/|, $0)[-1]} <filename>\n";
    my $filename = shift @ARGV;

    my $prsr = new XML::Parser (Style => 'EasyTree');

    my $tree;
    eval {
        $tree = $prsr->parsefile ($filename);
    };
    die "Malformed XML file!\n" if $@;

    unravel $tree;
}

main unless caller;

1;
