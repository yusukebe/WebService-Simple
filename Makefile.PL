use strict;
use inc::Module::Install;

name('WebService-Simple');
all_from('lib/WebService/Simple.pm');

requires( 'Class::Accessor::Fast' );
requires( 'Class::Data::ConfigHash' );
requires( 'Class::Inspector' );
requires( 'Data::Dumper' );
requires( 'Digest::MD5' );
requires( 'JSON', '2.0' );
requires( 'LWP::UserAgent' );
requires( 'UNIVERSAL::require' );
requires( 'XML::Simple' );
requires( 'URI',1.36 );

recommends( 'XML::LibXML' );
recommends( 'XML::Parser::Lite::Tree' );
recommends( 'XML::Parser::Lite::Tree::XPath' );
recommends( 'XML::Feed' );

test_requires( 'Test::More', => 0.94 ); # subtest

tests 't/*.t';
author_tests 'xt/*.t';

auto_set_repository;

auto_include;
WriteAll;
