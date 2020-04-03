package Color::RGB::Util;

our $DATE = '2019-08-20'; # DATE
our $VERSION = '0.599'; # VERSION

use 5.010001;
use strict;
use warnings;

#use List::Util qw(min);

require Exporter;
our @ISA = qw(Exporter);
our @EXPORT_OK = qw(
                       assign_rgb_color
                       assign_rgb_dark_color
                       assign_rgb_light_color
                       int2rgb
                       mix_2_rgb_colors
                       mix_rgb_colors
                       rand_rgb_color
                       rand_rgb_colors
                       reverse_rgb_color
                       rgb2grayscale
                       rgb2hsv
                       rgb2hsl
                       rgb2int
                       rgb2sepia
                       rgb_diff
                       rgb_distance
                       rgb_is_dark
                       rgb_is_light
                       rgb_luminance
                       tint_rgb_color
               );

my $re_rgb = qr/\A#?([0-9A-Fa-f]{2})([0-9A-Fa-f]{2})([0-9A-Fa-f]{2})\z/;

sub _min {
    $_[0] < $_[1] ? $_[0] : $_[1];
}

sub assign_rgb_color {
    require Digest::SHA;

    my ($str) = @_;

    my $sha1 = Digest::SHA::sha1_hex($str);
    substr($sha1, 0, 2) .
    substr($sha1, 18, 2) .
    substr($sha1, 38, 2);
}

sub assign_rgb_dark_color {
    my $str = shift;

    my $rgb = assign_rgb_color($str);
    rgb_is_dark($rgb) ? $rgb : mix_2_rgb_colors($rgb, '000000');
}

sub assign_rgb_light_color {
    my $str = shift;

    my $rgb = assign_rgb_color($str);
    rgb_is_light($rgb) ? $rgb : mix_2_rgb_colors($rgb, 'ffffff');
}

sub int2rgb {
    my $int = shift;

    return sprintf("%02x%02x%02x",
                   ($int & 0xff0000) >> 16,
                   ($int & 0x00ff00) >>  8,
                   ($int & 0x0000ff),
               );
}

sub mix_2_rgb_colors {
    my ($rgb1, $rgb2, $pct) = @_;

    $pct //= 0.5;

    my ($r1, $g1, $b1) =
        $rgb1 =~ $re_rgb or die "Invalid rgb1 color, must be in 'ffffff' form";
    my ($r2, $g2, $b2) =
        $rgb2 =~ $re_rgb or die "Invalid rgb2 color, must be in 'ffffff' form";
    for ($r1, $g1, $b1, $r2, $g2, $b2) { $_ = hex $_ }

    return sprintf("%02x%02x%02x",
                   $r1 + $pct*($r2-$r1),
                   $g1 + $pct*($g2-$g1),
                   $b1 + $pct*($b2-$b1),
               );
}

sub mix_rgb_colors {

    my (@weights, @r, @g, @b);

    while (@_ >= 2) {
        my ($rgb, $weight) = splice @_, 0, 2;
        my ($r, $g, $b) = $rgb =~ $re_rgb
            or die "Invalid rgb color '$rgb', must be in 'ffffff' form";
        push @r, hex $r;
        push @g, hex $g;
        push @b, hex $b;
        push @weights, $weight;
    }
    my $tot_r = 0; for (0..$#r) { $tot_r += $r[$_]*$weights[$_] }
    my $tot_g = 0; for (0..$#g) { $tot_g += $g[$_]*$weights[$_] }
    my $tot_b = 0; for (0..$#b) { $tot_b += $b[$_]*$weights[$_] }
    my $tot_weight = 0; $tot_weight += $_ for @weights;
    die "Zero/negative total weight" unless $tot_weight > 0;

    return sprintf("%02x%02x%02x",
                   $tot_r / $tot_weight,
                   $tot_g / $tot_weight,
                   $tot_b / $tot_weight,
               );
}

sub rand_rgb_color {
    my ($rgb1, $rgb2) = @_;

    $rgb1 //= '000000';
    my ($r1, $g1, $b1) =
        $rgb1 =~ $re_rgb or die "Invalid rgb1 color, must be in 'ffffff' form";
    $rgb2 //= 'ffffff';
    my ($r2, $g2, $b2) =
        $rgb2 =~ $re_rgb or die "Invalid rgb2 color, must be in 'ffffff' form";
    for ($r1, $g1, $b1, $r2, $g2, $b2) { $_ = hex $_ }

    return sprintf("%02x%02x%02x",
                   $r1 + rand()*($r2-$r1+1),
                   $g1 + rand()*($g2-$g1+1),
                   $b1 + rand()*($b2-$b1+1),
               );
}

sub rand_rgb_colors {
    my $opts = ref $_[0] eq 'HASH' ? shift : {};
    my $num = shift // 1;
    my $light_color  = exists($opts->{light_color}) ? $opts->{light_color} : 1;
    my $max_attempts = $opts->{max_attempts} // 1000;
    my $avoid_colors = $opts->{avoid_colors};

    my @res;
    while (@res < $num) {
        my $num_attempts = 0;
        my $rgb;
        while (1) {
            $rgb = rand_rgb_color();
            my $reject = 0;
          REJECT: {
                if ($light_color) {
                    do { $reject++; last } if rgb_is_dark($rgb);
                } elsif (defined $light_color) {
                    do { $reject++; last } if rgb_is_light($rgb);
                }
                if ($avoid_colors && ref $avoid_colors eq 'ARRAY') {
                    do { $reject++; last } if grep { $rgb eq $_ } @$avoid_colors;
                }
                if ($avoid_colors && ref $avoid_colors eq 'HASH') {
                    do { $reject++; last } if $avoid_colors->{$rgb}
                }
            } # REJECT
            last if !$reject;
            last if ++$num_attempts >= $max_attempts;
        }
        push @res, $rgb;
    }
    @res;
}

sub reverse_rgb_color {
    my ($rgb) = @_;

    my ($r, $g, $b) =
        $rgb =~ $re_rgb or die "Invalid rgb color, must be in 'ffffff' form";
    for ($r, $g, $b) { $_ = hex $_ }

    return sprintf("%02x%02x%02x", 255-$r, 255-$g, 255-$b);
}

sub rgb2grayscale {
    my ($rgb) = @_;

    my ($r, $g, $b) =
        $rgb =~ $re_rgb or die "Invalid rgb color, must be in 'ffffff' form";
    for ($r, $g, $b) { $_ = hex $_ }

    # basically we just average the R, G, B
    my $avg = int(($r + $g + $b)/3);
    return sprintf("%02x%02x%02x", $avg, $avg, $avg);
}

sub rgb2int {
    my $rgb = shift;

    # just to check
    $rgb =~ $re_rgb or die "Invalid rgb color, must be in 'ffffff' form";

    hex($rgb);
}

sub rgb2sepia {
    my ($rgb) = @_;

    my ($r, $g, $b) =
        $rgb =~ $re_rgb or die "Invalid rgb color, must be in 'ffffff' form";
    for ($r, $g, $b) { $_ = hex $_ }

    # reference: http://www.techrepublic.com/blog/howdoi/how-do-i-convert-images-to-grayscale-and-sepia-tone-using-c/120
    my $or = ($r*0.393) + ($g*0.769) + ($b*0.189);
    my $og = ($r*0.349) + ($g*0.686) + ($b*0.168);
    my $ob = ($r*0.272) + ($g*0.534) + ($b*0.131);
    for ($or, $og, $ob) { $_ = 255 if $_ > 255 }
    return sprintf("%02x%02x%02x", $or, $og, $ob);
}

sub rgb_diff {
    my ($rgb1, $rgb2, $algo) = @_;

    $algo //= 'euclidean';

    my ($r1, $g1, $b1) =
        $rgb1 =~ $re_rgb or die "Invalid rgb1 color, must be in 'ffffff' form";
    my ($r2, $g2, $b2) =
        $rgb2 =~ $re_rgb or die "Invalid rgb2 color, must be in 'ffffff' form";
    for ($r1, $g1, $b1, $r2, $g2, $b2) { $_ = hex $_ }

    my $dr2 = ($r1-$r2)**2;
    my $dg2 = ($g1-$g2)**2;
    my $db2 = ($b1-$b2)**2;

    if ($algo eq 'approx1' || $algo eq 'approx2') {
        my $rm = ($r1 + $r2)/2;
        if ($algo eq 'approx1') {
            return (2*$dr2 + 4*$dg2 + 3*$db2 + $rm*($dr2 - $db2)/256 )**0.5;
        } else { # approx2
            if ($rm < 128) {
                return (3*$dr2 + 4*$dg2 + 2*$db2)**0.5;
            } else {
                return (2*$dr2 + 4*$dg2 + 3*$db2)**0.5;
            }
        }
    } elsif ($algo eq 'hsv_euclidean' || $algo eq 'hsv_hue1') {
        my $hsv1 = rgb2hsv($rgb1);
        my ($h1, $s1, $v1) = split / /, $hsv1;
        my $hsv2 = rgb2hsv($rgb2);
        my ($h2, $s2, $v2) = split / /, $hsv2;

        my $dh2 = ( _min(abs($h2-$h1), 360-abs($h2-$h1))/180 )**2;
        my $ds2 = ( $s2-$s1 )**2;
        my $dv2 = ( ($v2-$v1)/255.0 )**2;

        if ($algo eq 'hsv_hue1') {
            return (5*$dh2 + $ds2 + $dv2)**0.5;
        } else { # hsv_euclidean
            return ($dh2 + $ds2 + $dv2)**0.5;
        }
    } else { # euclidean
        return ($dr2 + $dg2 + $db2)**0.5;
    }
}

sub rgb_distance {
    my ($rgb1, $rgb2) = @_;

    my ($r1, $g1, $b1) =
        $rgb1 =~ $re_rgb or die "Invalid rgb1 color, must be in 'ffffff' form";
    my ($r2, $g2, $b2) =
        $rgb2 =~ $re_rgb or die "Invalid rgb2 color, must be in 'ffffff' form";
    for ($r1, $g1, $b1, $r2, $g2, $b2) { $_ = hex $_ }

    (($r1-$r2)**2 + ($g1-$g2)**2 + ($b1-$b2)**2)**0.5;
}

sub rgb_is_dark {
    my ($rgb) = @_;
    rgb_distance($rgb, "000000") < rgb_distance($rgb, "ffffff") ? 1:0;
}

sub rgb_is_light {
    my ($rgb) = @_;
    rgb_distance($rgb, "000000") > rgb_distance($rgb, "ffffff") ? 1:0;
}

sub _rgb_luminance {
    my ($r, $g, $b) = @_;
    0.2126*$r/255 + 0.7152*$g/255 + 0.0722*$b/255;
}

sub rgb_luminance {
    my ($rgb) = @_;

    my ($r, $g, $b) =
        $rgb =~ $re_rgb or die "Invalid rgb color, must be in 'ffffff' form";
    for ($r, $g, $b) { $_ = hex $_ }

    return _rgb_luminance($r, $g, $b);
}

sub tint_rgb_color {
    my ($rgb1, $rgb2, $pct) = @_;

    $pct //= 0.5;

    my ($r1, $g1, $b1) =
        $rgb1 =~ $re_rgb or die "Invalid rgb1 color, must be in 'ffffff' form";
    my ($r2, $g2, $b2) =
        $rgb2 =~ $re_rgb or die "Invalid rgb2 color, must be in 'ffffff' form";
    for ($r1, $g1, $b1, $r2, $g2, $b2) { $_ = hex $_ }

    my $lum = _rgb_luminance($r1, $g1, $b1);

    return sprintf("%02x%02x%02x",
                   $r1 + $pct*($r2-$r1)*$lum,
                   $g1 + $pct*($g2-$g1)*$lum,
                   $b1 + $pct*($b2-$b1)*$lum,
               );
}

sub rgb2hsl {
    my ($rgb) = @_;

    my ($r, $g, $b) =
        $rgb =~ $re_rgb or die "Invalid rgb color, must be in 'ffffff' form";
    for ($r, $g, $b) { $_ = hex($_)/255 }

    my $max = $r;
    my $maxc = 'r';
    my $min = $r;

    if ($g > $max) {
        $max = $g;
        $maxc = 'g';
    }
    if ($b > $max) {
        $max = $b;
        $maxc = 'b';
    }

    if ($g < $min) {
        $min = $g;
    }
    if ($b < $min) {
        $min = $b;
    }

    my ($h, $s, $l);
    if ($max == $min) {
        $h = 0;
    } elsif ($maxc eq 'r') {
        $h = 60 * (($g - $b) / ($max - $min)) % 360;
    } elsif ($maxc eq 'g') {
        $h = (60 * (($b - $r) / ($max - $min)) + 120);
    } elsif ($maxc eq 'b') {
        $h = (60 * (($r - $g) / ($max - $min)) + 240);
    }

    $l = ($max + $min) / 2;

    if ($max == $min) {
        $s = 0;
    } elsif($l <= .5) {
        $s = ($max - $min) / ($max + $min);
    } else {
        $s = ($max - $min) / (2 - ($max + $min));
    }

    return sprintf("%.3g %.3g %.3g", $h, $s, $l);
}

sub rgb2hsv {
    my ($rgb) = @_;

    my ($r, $g, $b) =
        $rgb =~ $re_rgb or die "Invalid rgb color, must be in 'ffffff' form";
    for ($r, $g, $b) { $_ = hex($_)/255 }

    my $max = $r;
    my $maxc = 'r';
    my $min = $r;

    if ($g > $max) {
        $max = $g;
        $maxc = 'g';
    }
    if($b > $max) {
        $max = $b;
        $maxc = 'b';
    }

    if($g < $min) {
        $min = $g;
    }
    if($b < $min) {
        $min = $b;
    }

    my ($h, $s, $v);

    if ($max == $min) {
        $h = 0;
    } elsif ($maxc eq 'r') {
        $h = 60 * (($g - $b) / ($max - $min)) % 360;
    } elsif ($maxc eq 'g') {
        $h = (60 * (($b - $r) / ($max - $min)) + 120);
    } elsif ($maxc eq 'b') {
        $h = (60 * (($r - $g) / ($max - $min)) + 240);
    }

    $v = $max;
    if($max == 0) {
        $s = 0;
    } else {
        $s = 1 - ($min / $max);
    }

    return sprintf("%.3g %.3g %.3g", $h, $s, $v);
}

1;
# ABSTRACT: Utilities related to RGB colors

__END__

=pod

=encoding UTF-8

=head1 NAME

Color::RGB::Util - Utilities related to RGB colors

=head1 VERSION

This document describes version 0.599 of Color::RGB::Util (from Perl distribution Color-RGB-Util), released on 2019-08-20.

=head1 SYNOPSIS

 use Color::RGB::Util qw(
     assign_rgb_color
     assign_rgb_dark_color
     assign_rgb_light_color
     int2rgb
     mix_2_rgb_colors
     mix_rgb_colors
     rand_rgb_color
     rand_rgb_colors
     reverse_rgb_color
     rgb2grayscale
     rgb2int
     rgb2sepia
     rgb_diff
     rgb_distance
     rgb_is_dark
     rgb_is_light
     rgb_luminance
     tint_rgb_color
 );

 say assign_rgb_color("foo");                    # 0b5d33
 say assign_rgb_dark_color("foo");               # 0b5d33
 say assign_rgb_light_color("foo");              # 85ae99

 say int2rgb(0xffffff);                          # ffffff

 say mix_2_rgb_colors('#ff0000', '#ffffff');     # pink (red + white)
 say mix_2_rgb_colors('ff0000', 'ffffff', 0.75); # pink with a whiter shade

 say mix_rgb_colors('ff0000', 1, 'ffffff', 1);   # pink (red + white 1 : 1)
 say mix_rgb_colors('ff0000', 1, 'ffffff', 3);   # pink with a whiter shade (red + white 1 : 3)
 say mix_rgb_colors('ff0000', 1, 'ffffff', 1, '0000ff', 0.5);   # bluish pink

 say rand_rgb_color();
 say rand_rgb_color('000000', '333333');         # limit range

 say rand_rgb_colors(
       {light_color => 1, avoid_colors=>[qw/ffffff ffcc00 ff00cc/],
       3);                                       # ("e9f3d7", "e0bbcc", "63f88c")

 say reverse_rgb_color('0033CC');                # => ffcc33

 say rgb2grayscale('0033CC');                    # => 555555

 say rgb2int("ffffff");                          # 16777215 (which is 0xffffff)

 say rgb2sepia('0033CC');                        # => 4d4535

 say rgb_distance('000000', '000000')            # => 0
 say rgb_distance('01f000', '04f400')            # => 5
 say rgb_distance('ffff00', 'ffffff')            # => 255

 say rgb_diff('000000', '000000');               # => 0
 say rgb_diff('01f000', '04f400');               # => 5
 say rgb_diff('ffff00', 'ffffff');               # => 255
 say rgb_diff('000000', '000000', 'approx1');    # => 0
 say rgb_diff('01f000', '04f400', 'approx1');    # => 9.06
 say rgb_diff('ffff00', 'ffffff', 'approx1');    # => 360.98

 say rgb_is_dark('404040');                      # => 1
 say rgb_is_dark('a0a0a0');                      # => 0
 say rgb_is_light('404040');                     # => 0
 say rgb_is_light('a0a0a0');                     # => 1

 say rgb_luminance('d090aa');                    # => ffcc33

 say tint_rgb_color('#ff8800', '#0033cc');       # => b36e3c

=head1 DESCRIPTION

=head1 FUNCTIONS

None are exported by default, but they are exportable.

=head2 assign_rgb_color

Usage:

 my $rgb = assign_rgb_color($str);

Map a string to an RGB color. This is done by producing SHA-1 digest (160bit, 20
bytes) of the string, then taking the first, 10th, and last byte to become the
RGB color.

=head2 assign_rgb_dark_color

Like L</assign_rgb_color> except that it will make sure the assigned color is
dark.

=head2 assign_rgb_light_color

Like L</assign_rgb_color> except that it will make sure the assigned color is
light.

=head2 int2rgb

Usage:

 my $rgb = int2rgb(0xffffff); # => ffffff

Convert integer to RGB string.

=head2 mix_2_rgb_colors

Usage:

 my $mixed_rgb = mix_2_rgb_colors($rgb1, $rgb2, $pct);

Mix 2 RGB colors. C<$pct> is a number between 0 and 1, by default 0.5 (halfway),
the closer to 1 the closer the resulting color to C<$rgb2>.

=head2 mix_rgb_colors

Usage:

 my $mixed_rgb = mix_rgb_colors($color1, $weight1, $color2, $weight2, ...);

Mix several RGB colors.

=head2 rand_rgb_color

Usage:

 my $rgb = rand_rgb_color([ $low_limit [ , $high_limit ] ]);

Generate a random RGB color. You can specify the limit. Otherwise, they default
to the full range (000000 to ffffff).

=head2 rand_rgb_colors

Usage:

 my @rgbs = rand_rgb_colors([ \%opts ], $num=1);

Produce C<$num> random RGB colors, with some options. Will make reasonable
attempt to make the colors different from one another.

Known options:

=over

=item * light_color

Boolean, default true. By default, this function will create light RGB colors,
assuming the background color is dark, which is often the case in terminal. If
this option is set to false, will create dark colors instead, If this option is
set to undef, will create both dark and light colors.

=item * avoid_colors

Arrayref or hashref. List of colors to be avoided. You can put, for example,
colors that you've already assigned/picked for your palette and don't want to
use again.

=item * max_attempts

Uint, default 1000. Number of attempts to try generating the next random color
if the generated color is rejected because it is light/dark, or because it's in
C<avoid_colors>.

When the number of attempts has been exceeded, the generated color is used
anyway.

=back

=head2 reverse_rgb_color

Usage:

 my $reversed = reverse_rgb_color($rgb);

Reverse C<$rgb>.

=head2 rgb2grayscale

Usage:

 my $rgb_gs = rgb2grayscale($rgb);

Convert C<$rgb> to grayscale RGB value.

=head2 rgb2hsl

Usage:

 my $hsl = rgb2hsl($rgb); # example: "0 1 0.5"

Convert RGB (0-255) to HSL. The result is a space-separated H, S, L values.

=head2 rgb2hsv

Usage:

 my $hsv = rgb2hsv($rgb); # example: "0 1 255"

Convert RGB (0-255) to HSV. The result is a space-separated H, S, V values.

=head2 rgb2int

Usage:

 my $int = rgb2int("ffffff"); # => 16777216, which is 0xffffff

Convert RGB string to integer.

=head2 rgb2sepia

Usage:

 my $rgb_sepia = rgb2sepia($rgb);

Convert C<$rgb> to sepia tone RGB value.

=head2 rgb_diff

Usage:

 my $dist = rgb_diff($rgb1, $rgb2[ , $algo ])

Calculate difference between two RGB colors, using one of several algorithms.

=over

=item * euclidean

The default. It calculates the distance as:

 ( (R1-R2)**2 + (G1-G2)**2 + (B1-B2)**2 )**0.5

which is the same as what L</"rgb_distance">() would produce.

=item * approx1

This algorithm uses the following formula:

 ( 2*(R1-R2)**2 + 4*(G1-G2)**2 + 3*(B1-B2)**2 + Rm*((R1-R2)**2 - (B1-B2)**2)/256 )**0.5

where, Rm or "R mean" is (R1+R2)/2.

=item * approx2

Like C<approx1>, but uses this formula:

 ( 2*(R1-R2)**2 + 4*(G1-G2)**2 + 3*(B1-B2)**2 )**0.5  # if Rm < 128
 ( 3*(R1-R2)**2 + 4*(G1-G2)**2 + 2*(B1-B2)**2 )**0.5  # otherwise

=item * hsv_euclidean

Convert the RGB values to HSV, then calculate the HSV distance. Please see
source code for details.

=item * hsv_hue1

Like C<hsv_euclidean> but puts more emphasis on hue difference. This algorithm
is used, for example, by L<Color::ANSI::Util> when mapping RGB 24bit color to
the "closest" the ANSI 256-color or 16-color. This algorithm tends to choose the
hued colors instead of favoring to fallback on white/gray, which is more
preferred.

=back

For more details about color difference, refer to
L<https://en.wikipedia.org/wiki/Color_difference>.

=head2 rgb_distance

Usage:

 my $dist = rgb_distance($rgb1, $rgb2)

Calculate the euclidean RGB distance, using this formula:

 ( (R1-R2)**2 + (G1-G2)**2 + (B1-B2)**2 )**0.5

For example, the distance between "000000" and "ffffff" is ~441.67, while the
distance between "ffff00" and "ffffff" is 255.

=head2 rgb_is_dark

Usage:

 my $is_dark = rgb_is_dark($rgb)

Return true if C<$rgb> is a "dark" color, which is determined by checking if the
RGB distance to "000000" is smaller than to "ffffff".

=head2 rgb_is_light

Usage:

 my $is_light = rgb_is_light($rgb)

Return true if C<$rgb> is a "light" color, which is determined by checking if
the RGB distance to "000000" is larger than to "ffffff".

=head2 rgb_luminance

Usage:

 my $luminance = rgb_luminance($rgb);

Calculate standard/objective luminance from RGB value using this formula:

 (0.2126*R) + (0.7152*G) + (0.0722*B)

where R, G, and B range from 0 to 1. Return a number from 0 to 1.

=head2 tint_rgb_color

Usage:

 my $new_rgb = tint_rgb_color($rgb, $tint_rgb, $pct)

Tint C<$rgb> with C<$tint_rgb>. $pct is by default 0.5. It is similar to mixing,
but the less luminance the color is the less it is tinted with the tint color.
This has the effect of black color still being black instead of becoming tinted.

=head1 HOMEPAGE

Please visit the project's homepage at L<https://metacpan.org/release/Color-RGB-Util>.

=head1 SOURCE

Source repository is at L<https://github.com/perlancar/perl-Color-RGB-Util>.

=head1 BUGS

Please report any bugs or feature requests on the bugtracker website L<https://rt.cpan.org/Public/Dist/Display.html?Name=Color-RGB-Util>

When submitting a bug or request, please include a test-file or a
patch to an existing test-file that illustrates the bug or desired
feature.

=head1 SEE ALSO

L<Color::ANSI::Util>

=head1 AUTHOR

perlancar <perlancar@cpan.org>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2019, 2018, 2015, 2014, 2013 by perlancar@cpan.org.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut
