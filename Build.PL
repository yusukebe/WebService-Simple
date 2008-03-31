use strict;
use warnings;
use Module::Build;

my $builder = Module::Build->new(
    module_name         => 'WebService::Simple',
    license             => 'perl',
    dist_author         => 'Yusuke Wada <yusuke@kamawada.com>',
    dist_version_from   => 'lib/WebService/Simple.pm',
    requires => {
        'Test::More' => 0,
    },
    add_to_cleanup      => [ 'WebService-Simple-*' ],
);

$builder->create_build_script();
