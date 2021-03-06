package pf::services::manager::radsniff;

=head1 NAME

pf::services::manager::radsniff management module.

=cut

=head1 DESCRIPTION

pf::services::manager::radsniff

=cut

use strict;
use warnings;
use pf::file_paths qw($install_dir);
use pf::util;
use pf::config qw($management_network);
use Moo;
use pf::cluster;

extends 'pf::services::manager';

has '+name' => ( default => sub {'radsniff'} );
has '+optional' => ( default => sub {1} );

has '+launcher' => (
    default => sub {
        if($cluster_enabled){
          my $cluster_management_ip = pf::cluster::management_cluster_ip();
          my $management_ip = pf::cluster::current_server()->{management_ip};
          "sudo %1\$s -d $install_dir/raddb/ -D $install_dir/raddb/ -q -P $install_dir/var/run/radsniff.pid -W10 -O $install_dir/var/run/collectd-unixsock -f '(host $management_ip and udp port 1812 or 1813)' -i $management_network->{Tint}";
        }
        else {
          "sudo %1\$s -d $install_dir/raddb/ -D $install_dir/raddb/ -q -P $install_dir/var/run/radsniff.pid -W10 -O $install_dir/var/run/collectd-unixsock -i $management_network->{Tint}";
        }
    }
);

has startDependsOnServices => ( is => 'ro', default => sub { [qw(collectd)] } );

1;
