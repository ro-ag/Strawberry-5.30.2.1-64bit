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

our $DATE = '2018-12-02'; # DATE
our $VERSION = '0.501'; # VERSION

use 5.010;
use strict;
use warnings;

use Text::ANSITable;

binmode(STDOUT, ":encoding(utf8)");

my $t = Text::ANSITable->new;
my $all_ct = $t->list_color_themes(1);

my $chosen_ct = $ARGV[0] // $t->{color_theme}{name};

$t->columns(['Name', 'Summary']);
for my $name (sort keys %$all_ct) {
    my $ct = $all_ct->{$name};
    my $selected = $chosen_ct eq $name;

    $t->add_row([$name . ($selected ? " (*)" : ""), $ct->{summary}],
                {fgcolor=>($selected && $t->use_color ? 'aaaa00' : undef)});
}

say "Tip: you can run me with color theme name as argument to try it out.";
print $t->draw;

$t = Text::ANSITable->new;
$t->color_theme($chosen_ct);
my $ct = $t->color_theme;
$t->columns(['num','percent%','date','bool?','text']);
$t->add_row([1, 0.4, time(), 1, 'hello']);
$t->add_row([-3.3, 1, time(), 0, 'world']);
$t->add_row_separator;
$t->add_row([$_, $_/10, 1367451584+$_*10000, int(rand()*2), "x$_"])
    for 1..5;

say "Demo table";
print $t->draw;

# ABSTRACT: List available color themes for Text::ANSITable
# PODNAME: ansitable-list-color-themes

__END__

=pod

=encoding UTF-8

=head1 NAME

ansitable-list-color-themes - List available color themes for Text::ANSITable

=head1 VERSION

This document describes version 0.501 of ansitable-list-color-themes (from Perl distribution Text-ANSITable), released on 2018-12-02.

=head1 SYNOPSIS

 % ansitable-list-color-themes

Sample output:

 Tip: you can run me with color theme name as argument to try it out.
 .--------------------------------------------------------------------------------------------.
 | Name                                   Summary                                             |
 |                                                                                            |
 | Default::default_gradation             Default (for terminal with black background)        |
 | Default::default_gradation_whitebg     Default (for terminal with white background)        |
 | Default::default_nogradation           Default (for terminal with black background)        |
 | Default::default_nogradation_whitebg   Default (for terminal with white background)        |
 | Default::no_color (*)                  Special theme that means no color                   |
 | Demo::demo_random                      Show random color according to detected color depth |
 | Demo::demo_random_16                   Show random 16 color                                |
 | Demo::demo_random_24bit                Show random 24bit color                             |
 | Demo::demo_random_256                  Show random 256 color                               |
 | Demo::demo_random_8                    Show random 8 color                                 |
 | Demo::demo_random_border_color         Demoes coderef in item color                        |
 | Duotone::duotone_cyan1                 Duotone cyan 1                                      |
 | Duotone::duotone_green1                Duotone green 1                                     |
 | Duotone::duotone_random                Random duotone on every run                         |
 | Extra::grayscale                       Grayscale                                           |
 | Extra::reverse                         Reverse                                             |
 | Extra::sepia                           Sepia tone                                          |
 | Monotone::monotone_blue                Monotone blue                                       |
 | Monotone::monotone_cyan                Monotone cyan                                       |
 | Monotone::monotone_green               Monotone green                                      |
 | Monotone::monotone_purple              Monotone purple                                     |
 | Monotone::monotone_red                 Monotone red                                        |
 | Monotone::monotone_yellow              Monotone yellow                                     |
 | Tint::tint_black                       Black-tinted (50%)                                  |
 | Tint::tint_blue                        Blue-tinted (50%)                                   |
 | Tint::tint_cyan                        Cyan-tinted (50%)                                   |
 | Tint::tint_green                       Green-tinted (50%)                                  |
 | Tint::tint_magenta                     Magenta-tinted (50%)                                |
 | Tint::tint_orange                      Orange-tinted (50%)                                 |
 | Tint::tint_red                         Red-tinted (50%)                                    |
 | Tint::tint_yellow                      Yellow-tinted (50%)                                 |
 `--------------------------------------------------------------------------------------------'
 Demo table
 .-------------------------------------------------------.
 |  num   percent%          date           bool?   text  |
 |                                                       |
 |    1     40,00%   2018-12-02 19:55:13     Y     hello |
 | -3.3    100,00%   2018-12-02 19:55:13     N     world |
 +-------------------------------------------------------+
 |    1     10,00%   2013-05-02 09:26:24     Y     x1    |
 |    2     20,00%   2013-05-02 12:13:04     N     x2    |
 |    3     30,00%   2013-05-02 14:59:44     Y     x3    |
 |    4     40,00%   2013-05-02 17:46:24     N     x4    |
 |    5     50,00%   2013-05-02 20:33:04     N     x5    |
 `-------------------------------------------------------'

=head1 HOMEPAGE

Please visit the project's homepage at L<https://metacpan.org/release/Text-ANSITable>.

=head1 SOURCE

Source repository is at L<https://github.com/perlancar/perl-Text-ANSITable>.

=head1 BUGS

Please report any bugs or feature requests on the bugtracker website L<https://rt.cpan.org/Public/Dist/Display.html?Name=Text-ANSITable>

When submitting a bug or request, please include a test-file or a
patch to an existing test-file that illustrates the bug or desired
feature.

=head1 AUTHOR

perlancar <perlancar@cpan.org>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2018, 2017, 2016, 2015, 2014, 2013 by perlancar@cpan.org.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut

__END__
:endofperl
