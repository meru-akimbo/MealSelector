use strict;
use warnings;
use YAML;
use Math::Random::MT qw/rand/;
use Encode 'encode';

my $kind_of_meal = shift;

my $meal_yaml = YAML::LoadFile('./config.yaml');
my $meal = select_meal(+{
        meal_yaml    => $meal_yaml,
        kind_of_meal => $kind_of_meal
    });

print encode('utf8', $meal."\n");


sub select_meal {
    my $args = shift;
    my $meal_yaml    = $args->{meal_yaml};
    my $kind_of_meal = $args->{kind_of_meal};

    my $meal_list = _make_meal_list($meal_yaml->{$kind_of_meal});
    return $meal_list->[rand scalar @$meal_list];
}

sub _make_meal_list {
    my $meal_name = shift;
    my @meal_list = ();
    for my $meal (@$meal_name) {
        for (1..$meal->{weight}) { push @meal_list, $meal->{name} }
    }

    return \@meal_list;
}

