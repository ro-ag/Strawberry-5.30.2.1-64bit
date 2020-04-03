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
#!perl
#line 15
use strict;
use warnings;

die <<USAGE unless @ARGV;
Prima::VB form file viewer

format: $0 file.fm
USAGE

use Prima qw(Application VB::VBLoader);
my $ret = Prima::VBLoad( $ARGV[0] );
die "$@\n" unless $ret;
$ret-> execute;

__END__
:endofperl
