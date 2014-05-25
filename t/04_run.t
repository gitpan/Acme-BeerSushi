use strict;
use warnings;
use utf8;
use Test::More;

use Capture::Tiny qw/capture_stdout/;
use Path::Tiny qw/path/;
use Acme::BeerSushi;
use Encode;

my $beer_sushi = Acme::BeerSushi->new;
my $stdout = capture_stdout {
    $beer_sushi->run(path('eg/sample.bs')->slurp_utf8);
};
$stdout = decode_utf8 $stdout;
like $stdout, qr/^Hello 🍣/;

done_testing;
