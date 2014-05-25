#!/usr/bin/env perl
use strict;
use warnings;
use utf8;

use Path::Tiny qw/path/;
use Acme::BeerSushi;

my $beer_sushi = Acme::BeerSushi->new;
$beer_sushi->run(path('eg/sample.bs')->slurp_utf8);
