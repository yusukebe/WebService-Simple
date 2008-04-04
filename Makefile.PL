use strict;
use warnings;
use ExtUtils::MakeMaker;

WriteMakefile(
    NAME                => 'WebService::Simple',
    AUTHOR              => 'Yusuke Wada <yusuke@kamawada.com>',
    VERSION_FROM        => 'lib/WebService/Simple.pm',
    ABSTRACT_FROM       => 'lib/WebService/Simple.pm',
    PL_FILES            => {},
    PREREQ_PM => {
        'Test::More'          => 0,
        'Test::Perl::Critic'  => 0,
        'Test::Pod::Coverage' => 0,
        'Test::Pod'           => 0,
        'URI::Escape'         => 0,
        'LWP::UserAgent'      => 0,
        'XML::Simple'         => 0,
        'HTTP::Response'      => 0,
      },
    dist                => { COMPRESS => 'gzip -9f', SUFFIX => 'gz', },
    clean               => { FILES => 'WebService-Simple-*' },
);
