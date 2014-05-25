package Acme::BeerSushi::CLI;
use strict;
use warnings;
use utf8;

use Acme::BeerSushi;
use Path::Tiny;

use Module::Load;
use String::CamelCase qw/camelize/;

sub run {
    my ($class, @argv) = @_;

    my $file = shift @argv;
    die "no files or subcommands are specified\n" unless $file;

    if (-f $file) {
        my $beer_sushi = Acme::BeerSushi->new;
        $beer_sushi->run(path($file)->slurp_utf8);
        return;
    }
    else {
        my $sub_command = $file;
        my $module = __PACKAGE__ . '::' . camelize($sub_command);
        load $module;
        $module->run(@argv);
    }
}

1;
