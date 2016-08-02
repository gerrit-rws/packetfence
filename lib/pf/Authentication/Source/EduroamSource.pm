package pf::Authentication::Source::EduroamSource;

=head1 NAME

pf::Authentication::Source::EduroamSource

=head1 DESCRIPTION

=cut

use pf::Authentication::constants;
use pf::constants qw($TRUE $FALSE);
use pf::log;

use Moose;
extends 'pf::Authentication::Source';

has '+type'                 => (default => 'Eduroam');
has '+class'                => (isa => 'Str', is => 'ro', default => 'external');
has '+unique'               => (isa => 'Bool', is => 'ro', default => $TRUE);
has 'tlrs1_server_address'  => (isa => 'Str', is => 'rw');
has 'tlrs2_server_address'  => (isa => 'Str', is => 'rw');
has 'tlrs_radius_secret'    => (isa => 'Str', is => 'rw');
has 'auth_listening_port'   => (isa => 'Maybe[Int]', is => 'rw', default => '11812');
has 'acct_listening_port'   => (isa => 'Maybe[Int]', is => 'rw', default => '11813');


=head2 available_rule_classes

Eduroam source only allow 'authentication' rules

=cut

sub available_rule_classes {
    return [ grep { $_ ne $Rules::ADMIN } @Rules::CLASSES ];
}

=head2 available_actions

Eduroam source only allow 'authentication' actions

=cut

sub available_actions {
    my @actions = map( { @$_ } $Actions::ACTIONS{$Rules::AUTH});
    return \@actions;
}


=head1 AUTHOR

Inverse inc. <info@inverse.ca>

=head1 COPYRIGHT

Copyright (C) 2005-2016 Inverse inc.

=head1 LICENSE

This program is free software; you can redistribute it and/or
modify it under the terms of the GNU General Public License
as published by the Free Software Foundation; either version 2
of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program; if not, write to the Free Software
Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301,
USA.

=cut

__PACKAGE__->meta->make_immutable;
1;

# vim: set shiftwidth=4:
# vim: set expandtab:
# vim: set backspace=indent,eol,start:
