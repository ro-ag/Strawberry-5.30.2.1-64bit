# This file was automatically generated.
package Prima::Config;
use vars qw(%Config);

my $bin = q(C:\Strawberry\perl\site\bin);

# Determine lib based on the location of this module
use File::Basename qw(dirname);
use File::Spec;
my $lib = File::Spec->catfile(dirname(__FILE__), '..');

%Config = (
	ifs                   => '\/',
	quote                 => '\"',
	platform              => 'win32',
	incpaths              => [ "$lib/Prima/CORE","$lib/Prima/CORE/generic","C:/Strawberry/c/lib/pkgconfig/../../include/libpng16" ],
	gencls                => "$bin/prima-gencls.bat",
	tmlink                => "$bin/prima-tmlink.bat",
	scriptext             => '.bat',
	genclsoptions         => '--tml --h --inc',
	cobjflag              => '-o ',
	coutexecflag          => '-o ',
	clinkprefix           => '',
	clibpathflag          => '-L',
	cdefs                 => [],
	libext                => '.a',
	libprefix             => 'lib',
	libname               => "$lib/auto/Prima/libPrima.a",
	dlname                => "$lib/auto/Prima/Prima.xs.dll",
	ldoutflag             => '-o ',
	ldlibflag             => '-l',
	ldlibpathflag         => '-L',
	ldpaths               => [],
	ldlibs                => ['jpeg','gif','gdi32','mpr','winspool','comdlg32','msimg32','ole32','uuid','png16','z','tiff','Xpm'],
	ldlibext              => '',
	inline                => 'inline',
	dl_load_flags         => 0,
	optimize              => '-s -O2 -Wall',
	openmp                => '-fopenmp',

	inc                   => "-I$lib/Prima/CORE -I$lib/Prima/CORE/generic -IC:/Strawberry/c/lib/pkgconfig/../../include/libpng16",
	define                => '',
	libs                  => "$lib/auto/Prima/libPrima.a",
);

1;
