use strict;
use warnings;
use utf8;
use Test::More;

use Acme::BeerSushi;

my $beer_sushi = Acme::BeerSushi->new;

is $beer_sushi->encode("\x00"), '🍣';
is $beer_sushi->encode("\x01"), '🍺';
is $beer_sushi->encode("\x02\x03
\x04"), '🍺🍣 🍺🍺
🍺🍣🍣';
is $beer_sushi->encode('?'), '🍺' x 6;

done_testing;
