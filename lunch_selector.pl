use strict;
use warnings;
use YAML;
use Math::Random::MT qw/rand/;
use Encode 'encode';

my $lunch_yaml = YAML::LoadFile('./config.yaml');
print encode('utf8', select_lunch($lunch_yaml));

sub select_lunch {
    my $lunch_yaml = shift;
    my $lunch_list = _make_shop_list($lunch_yaml);
    return $lunch_list->[rand scalar @$lunch_list];
}

sub _make_shop_list {
    my $lunch_name = shift;
    my @lunch_list = ();
    for my $lunch (@$lunch_name) {
        for (1..$lunch->{weight}) { push @lunch_list, $lunch->{name} }
    }

    return \@lunch_list;
}

