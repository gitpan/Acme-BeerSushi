use strict;
use warnings;
use utf8;
use Test::More;
use Test::Fatal qw/exception/;

use Acme::BeerSushi;

subtest new => sub {
    my $beer_sushi = Acme::BeerSushi->new;
    isa_ok $beer_sushi, 'Acme::BeerSushi';
    is  $beer_sushi->chars, '🍺🍣';
    is_deeply $beer_sushi->_chars, [qw/🍣  🍺/];
};

subtest 'new with options' => sub {
    my $beer_sushi = Acme::BeerSushi->new(chars => 'ab');
    isa_ok $beer_sushi, 'Acme::BeerSushi';
    is  $beer_sushi->chars, 'ab';
    is_deeply $beer_sushi->_chars, [qw/a b/];
};

subtest 'fail with three chars' => sub {
    my $exp = exception {
        Acme::BeerSushi->new(chars => 'abc');
    };
    like $exp, qr/must be two and different decoded characters/ms;
};

subtest 'fail with same two chars' => sub {
    my $exp = exception {
        Acme::BeerSushi->new(chars => 'aa');
    };
    like $exp, qr/must be two and different decoded characters/ms;
};

done_testing;
