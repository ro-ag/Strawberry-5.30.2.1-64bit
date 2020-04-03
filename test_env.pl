use strict;
use warnings;
use Win32::Shortcut;
use Path::Tiny;
use Data::Dumper;

print ":::Perl version $]:::\n";

my $dir  = path($0)->parent;
my $user = $ENV{USERPROFILE};
my $Link= Win32::Shortcut->new();

my $site = '/perl/site/bin';
my $bin  = '/perl/bin';
my $PadrePath = "$dir/$site";
my $PerlPathLong  =  Win32::GetFullPathName( "$dir/$bin/wperl.exe");
my $PerlPathShort =  Win32::GetShortPathName($PerlPathLong);

$Link->{'Path' }       = $PerlPathLong;
$Link->{'Arguments'}   =  Win32::GetFullPathName("$PadrePath/padre.bat");
$Link->{'ShortPath' }  = $PerlPathShort;
$Link->{'IconLocation'}  = Win32::GetFullPathName("$PadrePath/padre.exe");

$Link->{'IconNumber'} = 0 ;
$Link->{'ShowCmd'} = 1 ;
$Link->{'File' } = 'Padre.lnk';
$Link->{'WorkingDirectory' } = '%USERPROFILE%';
$Link->{'Description' } = '';
$Link->{'Hotkey' }=  0;

print "Save ShortCut :".Win32::GetFullPathName("$user/Desktop/Padre Perl's IDE.lnk"); 
$Link->Save( "$user/Desktop/Padre Perl's IDE.lnk" );
$Link->Close;
