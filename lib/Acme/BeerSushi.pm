package Acme::BeerSushi;
use 5.008001;
use strict;
use warnings;
use utf8;

our $VERSION = "0.01";

use Encode ();

use Mouse;
use Mouse::Util::TypeConstraints;

subtype 'Acme::BeerSushi::Chars',
  as    'Str',
  where { length($_) == 2 && substr($_, 0, 1) ne substr($_, 1, 1) },
  message { 'must be two and different decoded characters' };

has chars => (
    is      => 'ro',
    isa     => 'Acme::BeerSushi::Chars',
    default => sub { '🍺🍣' },
);

has _chars => (
    is => 'ro',
    isa => 'ArrayRef[Str]',
    default => sub {
        [sort split //, shift->chars];
    },
);

has _char_map => (
    is      => 'ro',
    isa     => 'HashRef[Str]',
    lazy    => 1,
    default => sub {
        my $self = shift;

        my ($zero, $one) = map { quotemeta $_ } @{ $self->_chars };
        my %map;
        for my $ascii_num (0..255) {
            my $bin_str = unpack('B8', pack 'C', $ascii_num);
            $bin_str =~ s/^0+//;
            $bin_str = '0' if $bin_str eq '';
            $bin_str =~ s/0/$zero/g;
            $bin_str =~ s/1/$one/g;

            $map{ chr($ascii_num) } = $bin_str;
        }
        \%map;
    },
);

has _rev_char_map => (
    is      => 'ro',
    isa     => 'HashRef[Str]',
    lazy    => 1,
    default => sub {
        +{ reverse %{ shift->_char_map } };
    },
);

no Mouse;

sub encode {
    my ($self, $str) = @_;

    my @encoded_lines;
    for my $line (split /\n/, $str) {
        push @encoded_lines, join(' ', map {
            $self->_char_map->{$_};
        } split //, Encode::encode_utf8($line));
    }
    join "\n", @encoded_lines;
}

sub decode {
    my ($self, $str) = @_;

    my @decoded_lines;
    for my $line (split /\n/, $str) {
        push @decoded_lines, Encode::decode_utf8(
            join '', map {
                $self->_rev_char_map->{$_};
            } split / /, $line
        );
    }
    join "\n", @decoded_lines;
}

sub run {
    my ($self, $beer_sushi_code) = @_;

    my $code = $self->decode($beer_sushi_code);
    eval $code;
    die $@ if $@;
}

1;
__END__

=encoding utf-8

=head1 NAME

Acme::BeerSushi - We love beer and sushi

=head1 SYNOPSIS

    use Acme::BeerSushi;
    my $beer_sushi = Acme::BeerSushi->new;

=head1 DESCRIPTION

ALL OF OUR PLEASURES ARE BELONGS TO BEER AND SUSHI.

=head1 LICENSE

Copyright (C) Songmu.

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=head1 AUTHOR

Songmu E<lt>y.songmu@gmail.comE<gt>

=cut

