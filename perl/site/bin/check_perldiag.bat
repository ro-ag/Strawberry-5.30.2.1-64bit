@rem = '--*-Perl-*--
@echo off
if "%OS%" == "Windows_NT" goto WinNT
perl -x -S "%0" %1 %2 %3 %4 %5 %6 %7 %8 %9
goto endofperl
:WinNT
perl -x -S %0 %*
if NOT "%COMSPEC%" == "%SystemRoot%\system32\cmd.exe" goto endofperl
if %errorlevel% == 9009 echo You do not have Perl in your PATH.
if errorlevel 1 goto script_failed_so_exit_with_non_zero_val 2>nul
goto endofperl
@rem ';
#!/usr/bin/perl -w
#line 15

package check_perldiag;

# ABSTRACT: check a localized version of L<perldiag> for consistency

use strict;
use warnings;

use Pod::Find  ();
use Pod::POM   ();

my $localized_perldiag = $ARGV[0];

die "No perldiag specified" unless $localized_perldiag;

my $localized_pod_filename = Pod::Find::pod_where({-inc => 1}, $localized_perldiag);
my $default_pod_filename = Pod::Find::pod_where({-inc => 1}, 'perldiag');

my $parser = Pod::POM->new();
my $pom_local = $parser->parse_file($localized_pod_filename);
if (!$pom_local) {
	die "Could not parse localized perldiag: " . $parser->error();
}

my $pom_default = $parser->parse_file($default_pod_filename);
if (!$pom_default) {
	die "Could not parse default perldiag: " . $parser->error();
}

my (@local_errors, @default_errors);
foreach my $item ($pom_local->head1->[1]->over->[0]->item) {
	push @local_errors, $item->title;
}

foreach my $item ($pom_default->head1->[1]->over->[0]->item) {
	push @default_errors, $item->title;
}

if ($#local_errors != $#default_errors) {
	print "Unequal number of errors: localized - $#local_errors, default - $#default_errors.\n";
}

for (my $i = 0; $i <= $#local_errors; $i++) {
	if ($local_errors[$i] ne $default_errors[$i]) {
		print 'Got: "' . $local_errors[$i] . '", expected: "' . $default_errors[$i] . '".' . "\n";
	}
}

__END__

=head1 NAME

check_perldiag - check a localized version of perldiag for consistency

=head1 SYNOPSIS

From the command line:

	check_perldiag POD2::FR::perldiag

=head1 DESCRIPTION

This script compares a translated version of L<perldiag> with the default L<perldiag> installed with perl. It compares each error message in the two files and tells you if they do not match. A warning is issued if the two files contain a different number of error messages defined.

__END__
:endofperl
