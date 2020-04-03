@rem = '--*-Perl-*--
@set "ErrorLevel="
@if "%OS%" == "Windows_NT" @goto WinNT
@perl -x -S "%0" %1 %2 %3 %4 %5 %6 %7 %8 %9
@set ErrorLevel=%ErrorLevel%
@goto endofperl
:WinNT
@perl -x -S %0 %*
@set ErrorLevel=%ErrorLevel%
@if NOT "%COMSPEC%" == "%SystemRoot%\system32\cmd.exe" @goto endofperl
@if %ErrorLevel% == 9009 @echo You do not have Perl in your PATH.
@goto endofperl
@rem ';
#!C:\Strawberry\perl\bin\perl.exe 
#line 16
use strict;
use warnings;

use Getopt::Long qw(GetOptions);
use SQL::Beautify;


my %opt;

usage() if not @ARGV;
GetOptions(\%opt,
	'spaces=i',
	'help',
) or usage();
usage() if $opt{help};
usage() if not @ARGV;

my $sql = SQL::Beautify->new(%opt);

foreach my $file (@ARGV) {
	my $original_sql = read_file($file);
	$sql->query($original_sql);
	my $nice_sql = $sql->beautify;
	print $nice_sql;
}


sub read_file {
	my $file = shift;
	open my $fh, '<', $file or die;
	local $/ = undef;
	my $content = <$fh>;
	close $fh;
	return $content;
}

sub usage {
	print <<"END_USAGE";
v$SQL::Beautify::VERSION
Usage: $0 [options] FILEs

      --spaces 4      - number of indentation spaces (defaults to 4)
      
      --help          - this help
END_USAGE
	exit;
}

__END__
:endofperl
@set "ErrorLevel=" & @goto _undefined_label_ 2>NUL || @"%COMSPEC%" /d/c @exit %ErrorLevel%
