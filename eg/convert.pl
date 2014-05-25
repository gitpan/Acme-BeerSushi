#!/usr/bin/env perl
use strict;
use warnings;
use utf8;
binmode STDOUT, ':encoding(utf-8)';

use Path::Tiny qw/path/;
use Acme::BeerSushi;

my $file = shift || 'eg/sample.pl';

my $beer_sushi = Acme::BeerSushi->new;

print $beer_sushi->encode(path($file)->slurp_utf8). "\n";
