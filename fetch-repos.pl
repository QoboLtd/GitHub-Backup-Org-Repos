#!/usr/bin/perl -w

use strict;
use Net::GitHub;
use Git::Repository;
use Data::Dumper;

my $debug = 0;
# User belonging to the organization
my $git_username = 'some_username';
my $git_password = 'some_password';

my $github = Net::GitHub->new( 'version' => 3, 'login' => $git_username, 'pass' => $git_password );
my @orgs = $github->org->orgs;
foreach my $org (@orgs) {
	print 'Fetching repos for ' . $org->{'login'} . "\n" if $debug;
	my @repos = $github->repos->list_org($org->{'login'});
	foreach my $repo (@repos) {
		my $clone_url = $repo->{'clone_url'};
		my $dest_dir = $clone_url; 
		$dest_dir =~ s#^.*/##;
		$dest_dir =~ s#\.git$##;

		$clone_url =~ s#^https://#https://${git_username}:${git_password}@#i;
		if (-e $dest_dir) {
			print "Pulling [$clone_url] into [$dest_dir]\n" if $debug;
			my $r = Git::Repository->new('work_tree' => $dest_dir);
			$r->run('pull');
		}
		else {
			print "Cloning repo [$clone_url]\n" if $debug;
			Git::Repository->run('clone' => $clone_url);
		}
	}
}
