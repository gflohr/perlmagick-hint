#! /usr/bin/env perl

use strict;

use Config;
use Cwd qw(abs_path);
use File::Spec;

sub check_path;

my $has_self;
{
	no strict 'vars';
	$has_self = defined $self;
}

check_path if !$has_self;

my $magick = $ENV{MAGICKCORE_CONFIG} || 'MagickCore-config';

my $cflags = `$magick --cflags` || die "error executing '$magick --cflags': $!";
chomp $cflags;
my $ldflags = `$magick --ldflags` || die "error executing '$magick --ldflags': $!";
chomp $ldflags;
my $libs = `$magick --libs` || die "error executing '$magick --libsq': $!";
chomp $libs;

my $corepath = File::Spec->catdir($Config{archlib}, 'CORE');
$libs .= " -L$corepath";

my %self;
$self{INC} = '';
$self{CCFLAGS} = "$Config{ccflags} $cflags";
$self{LDFLAGS} = "$ldflags $Config{ldflags}";
$self{LDDLFLAGS} = "$ldflags $Config{lddlflags}";
$self{LIBS} = "$libs -L$corepath";

if ($has_self) {
	no strict 'vars';
	foreach my $key (keys %self) {
		$self->{$key} = $self{$key};
		$self->{ARGS}->{$key} = $self{$key};
	}
	print "Getting ImageMagick configuration from hints directory.\n";
} else {
	print "Patch configuration:\n";
	foreach my $key (sort keys %self) {
		print "\t$key = $self{$key}\n";
	}
}

sub check_path {
	my $file = __FILE__;
	if (!File::Spec->file_name_is_absolute($file)) {
		$file = File::Spec->rel2abs($file);
	}
	my (undef, $directories, $filename) = File::Spec->splitpath($file);
	my @directories = File::Spec->splitdir($directories);
	pop @directories if !length $directories[-1];

	# Determine hintfile name.
	my $hint = "${^O}_$Config{osvers}";
	$hint =~ s/\./_/g;
	$hint =~ s/_$//;
	die "cannot determine hint file name" unless $hint;

	my $hint_file;
	while (1) {
		my $wanted = "$hint.pl";
		if ($wanted eq $filename) {
			$hint_file = $wanted;
			last;
		}
		last if $hint !~ s/_[^_]+$//;
	}

	if (!defined $hint_file || $directories[-1] ne 'hints') {
		die <<"EOF";
Error: Create a directory 'hints' in an unpacked ImageMagick distribution and
store this file as 'hints/$hint.pl'! Then run 'perl Makefile.PL && make &&
make install'!
EOF
	}
}
