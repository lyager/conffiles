#!/usr/bin/perl
use strict;
use warnings;
use Text::Wrap;

# Initialization
$Text::Wrap::columns=78;


# Parsing variables
my $svn_rev;
my $commit_msg;
my $svn_author;
my $header_done = 0;
my @files;

# Other, more static, arguments
my $in_author;
my $entry_count = 0;
if (scalar(@ARGV) != 1) {
    print STDERR "Need name of author to look for.\n";
    exit 1;
}

$in_author = shift(@ARGV);


while(<STDIN>) {
    if (/^---/) {
	# Process all data
	if ( $svn_rev && $svn_author eq $in_author && $commit_msg ) {
	    # Only print logs by me
	    my $entry = "* [$svn_rev]: $commit_msg\n";
	    print wrap("\t", "\t  ", $entry);
	    foreach my $file (@files) {
		print "\t    $file\n";
	    }
	}
	# clear variables for next message
	$svn_rev = "";
	$svn_author = "";
	$commit_msg = "";
	$header_done = 0;
	@files = ();
	$entry_count++;
	next;
    }
    if (/^r(\d+) \| ([^\s]+) \|/) {
	if ($svn_rev eq "" && $svn_author eq "") {
	    $svn_rev = $1;
	    $svn_author = $2;
	}
	next;
    }
    if (/^   [M|A] (.+)$/) {
	push(@files, $1);
	next;
    }
    if (/^$/) { # Empty line indicates header done
	$header_done = 1;
	next;
    }
    if ($header_done) {	# Rest is commit message
	chomp($_);
	$commit_msg .= $_;
    }
}

# Display helper if nothing was processed
if ($entry_count == 0) {
    print "\nNo entries was processed, did you feed the information from 'git-svn log' correctly?\n\n";
    exit 1;
}

exit 0;
