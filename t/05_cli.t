use strict;
use warnings;
use utf8;
use Test::More;

use Capture::Tiny qw/capture_stdout/;
use Path::Tiny qw/path/;
use Acme::BeerSushi::CLI;
use Encode;

my $stdout = capture_stdout {
    Acme::BeerSushi::CLI->run('eg/sample.bs');
};
$stdout = decode_utf8 $stdout;
like $stdout, qr/^Hello 🍣/;

done_testing;
