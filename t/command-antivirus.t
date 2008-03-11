package TestVirusScan::CommandAntivirus;
use strict;
use warnings;

use lib qw( t/lib );
use base qw( TestVirusPlugin );

use Test::More;
use Test::Exception;
use File::Temp ();

use Email::VirusScan::Engine::CommandAntivirus;

sub under_test { 'Email::VirusScan::Engine::CommandAntivirus' };
sub required_arguments {
	{ command => 'csav' }
}

sub testable_live
{
	my ($self) = @_;

	# Only testable live if the command exists and can be run.
	return (system( $self->engine->{command} . " >/dev/null 2>&1") == 0);
}

sub constructor_failures : Test(2)
{
	my ($self) = @_;

	dies_ok { $self->under_test->new() } 'Constructor dies with no arguments';
	like( $@, qr/Must supply a 'command' config value/, ' ... error as expected');
}

__PACKAGE__->runtests() unless caller();
1;