package Acme::BeerSushi::CLI::Encode;
use strict;
use warnings;
use utf8;

use Acme::BeerSushi;
use Path::Tiny;
use Getopt::Long 2.39;
use Encode;

sub run {
    my ($class, @argv) = @_;

    my $parser = Getopt::Long::Parser->new(
        config => [qw/posix_default no_ignore_case/],
    );
    $parser->getoptionsfromarray(\@argv, \my %opt, qw/
        file=s
        chars=s
    /);
    my $file = delete $opt{file};
    die "no valid file is specified\n" if !defined $file || !-f $file;
    $opt{chars} = decode_utf8 $opt{chars} if $opt{chars};

    my $beer_sushi = Acme::BeerSushi->new(%opt);
    print encode_utf8($beer_sushi->encode(path($file)->slurp_utf8)) . "\n";
}

1;
