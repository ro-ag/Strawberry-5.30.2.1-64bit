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
#!/usr/bin/perl
#line 15

use 5.008;
use Config;
use Tk 804.000;
use lib Tk->findINC( 'demos/widget_lib' );
use Tk::widgets qw/ DialogBox ErrorDialog LabEntry ROText /;
use Tk::Config ();
use WidgetDemo;
use subs qw/
    build_about_dialog demos invoke lsearch
    see_code see_vars show_stat view_widget
/;
use vars qw/ $MW $FONT $BOLD_FONT $LARGE_FONT $MONOSPACE_FONT $WIDTRIB /;
use vars qw/ $CODE $CODE_RERUN $CODE_TEXT $VARS $VIEW $VIEW_TEXT /;
use vars qw/ $ALIGN $BRAKES $LIGHTS $OIL $SOBER $TRANS $WIPERS /;
use vars qw/ $COLOR $FONT_STYLE $POINT_SIZE $DEMO_FILE %DEMO_DESCRIPTION $XFT /;
use strict;

$XFT = $Tk::Config::xlib =~ /-lXft\b/;

$MW = Tk::MainWindow->new;
$MW->configure(-menu => my $menubar = $MW->Menu);

{
    package WidgetWrap;
    @WidgetWrap::ISA = qw/Tk::MainWindow/;

    # This magic conspires with widget's AUTOLOAD subroutine to make user
    # contributed demonstrations that don't use WidgetDemo embed properly.
    # The trick works because widget creates a superclass of Tk::MainWindow
    # which invokes WidgetDemo() implicitly. You loose if you bypass the
    # inheritance mechanism and call Tk::MainWindow directly.

    sub new {
	my ($name) = $::DEMO_FILE =~ m#([^/]+).pl$#;
	$::MW->WidgetDemo(-name => $name, -text => $::DEMO_DESCRIPTION{$name});
    }
}

@MainWindow::ISA = 'WidgetWrap';

$MW->title('Perl/Tk Widget Demonstration');
$MW->iconname('widget');

my $DEFAULT_FONT_FAMILY = $XFT ? "sans-serif" : "Helvetica";
{
    $FONT           = "$DEFAULT_FONT_FAMILY 12";
    $BOLD_FONT      = "$DEFAULT_FONT_FAMILY 12 bold";
    $LARGE_FONT     = "$DEFAULT_FONT_FAMILY 18";
    $MONOSPACE_FONT = "Courier 12";
    my $l = $MW->Label;
    my $default_font = $l->cget(-font);
    if ($default_font) {
	my %default_font = $MW->fontActual($default_font);
	$FONT           = $MW->fontCreate(%default_font, -family => $DEFAULT_FONT_FAMILY);
	$BOLD_FONT      = $MW->fontCreate(%default_font, -family => $DEFAULT_FONT_FAMILY, -weight => "bold");
	$LARGE_FONT     = $MW->fontCreate(%default_font, -family => $DEFAULT_FONT_FAMILY, -weight => "bold", -size => -18);
	$MONOSPACE_FONT = $MW->fontCreate(%default_font, -family => $XFT ? "monospace" : "Courier");
	$MW->optionAdd("*font", $FONT);
    }
    $l->destroy;
}

my $widget_lib = Tk->findINC('demos/widget_lib');
my $wd = "$widget_lib/WidgetDemo.pm";
$WIDTRIB = Tk->findINC('demos/widtrib');
unless (Tk::tainting) {
    $WIDTRIB = $ENV{WIDTRIB} if defined $ENV{WIDTRIB};
    $WIDTRIB = $ARGV[0] if defined $ARGV[0];
}

# The code below creates the main window, consisting of a menu bar
# and a text widget that explains how to use the program, plus lists
# all of the demos as hypertext items.

my $file = $menubar->cascade(qw/-label File -underline 0 -menuitems/ =>
    [
      [cascade    => '~View', -menuitems =>
        [
          [command  => '~widget', -command => [\&view_widget, __FILE__]],
          [command  => '~WidgetDemo', -command => [\&view_widget, $wd]],
        ], # end cascade menuitems
      ], # end view cascade
      '',
      [command    => '~Quit', -command => [\&exit], -accelerator => 'Ctrl-Q'],
    ]);

my $help = $menubar->cascade(qw/-label Help -underline 0 -menuitems/ =>
    [
      [command    => '~About'],
    ]);

my $T = $MW->Scrolled('ROText',
    -scrollbars         => 'e',
    -wrap               => 'word',
    -width              => 70,
    -height             => 30,
    -font               => $FONT,
    -setgrid            => 1,
    -highlightthickness => 0,
    -padx               => 4,
    -pady               => 2,
    -takefocus          => 0,
)->grid(qw/-sticky nsew/);
$MW->gridRowconfigure(   0, -weight => 1); # allow expansion in both ...
$MW->gridColumnconfigure(0, -weight => 1); # ... X and Y dimensions

$MW->bind('<Control-q>' => \&exit);

my $STATUS_VAR;
my $status = $MW->Label(-textvariable => \$STATUS_VAR, qw/-anchor w/);
$status->grid(qw/-sticky ew/);

# Create a bunch of tags to use in the text widget, such as those for
# section titles and demo descriptions.  Also define the bindings for
# tags.

$T->tagConfigure(qw/title -font/, $LARGE_FONT);
$T->tagConfigure(qw/demo -lmargin1 1c -lmargin2 1c -foreground blue/);

if ($MW->depth  == 1) {
    $T->tagConfigure(qw/hot -background black -foreground white/);
    $T->tagConfigure(qw/visited -lmargin1 1c -lmargin2 1c -underline 1/);
} else {
    $T->tagConfigure(qw/hot -relief raised -borderwidth 1 -foreground red/);
    $T->tagConfigure(qw/visited -lmargin1 1c -lmargin2 1c -foreground/ =>
	    '#303080');
}
$T->tagConfigure('bold', -font => $BOLD_FONT);

$T->tagBind(qw/demo <ButtonRelease-1>/ => \&invoke);
my $last_line = '';
$T->tagBind(qw/demo <Enter>/ => [sub {
	my($text, $sv) = @_;
	my $e = $text->XEvent;
	my($x, $y) = ($e->x, $e->y);
	$last_line = $text->index("\@$x,$y linestart");
	$text->tagAdd('hot', $last_line, "$last_line lineend");
	$text->configure(qw/-cursor hand2/);
	show_stat $sv, $text, $text->index('current');
    }, \$STATUS_VAR]
);
$T->tagBind(qw/demo <Leave>/ => [sub {
	my($text, $sv) = @_;
	$text->tagRemove(qw/hot 1.0 end/);
	$text->configure(qw/-cursor xterm/);
	$$sv = '';
    }, \$STATUS_VAR]
);
$T->tagBind(qw/demo <Motion>/ => [sub {
	my($text, $sv) = @_;
	my $e = $text->XEvent;
	my($x, $y) = ($e->x, $e->y);
	my $new_line = $text->index("\@$x,$y linestart");
	if ($new_line ne $last_line) {
	    $text->tagRemove(qw/hot 1.0 end/);
	    $last_line = $new_line;
	    $text->tagAdd('hot', $last_line, "$last_line lineend");
	}
	show_stat $sv, $text, $text->index('current');
    }, \$STATUS_VAR]
);

# Create the text for the text widget.

$T->insert('end', "Perl/Tk Widget Demonstrations\n", 'title');
$T->insert('end',
"\nThis application provides a front end for several short scripts that demonstrate what you can do with Tk widgets.  Each of the numbered lines below describes a demonstration;  you can click on it to invoke the demonstration.  Once the demonstration window appears, you can click the ", '', 'See Code', 'bold', " button to see the Perl/Tk code that created the demonstration.  If you wish, you can edit the code and click the ", '', "Rerun Demo", 'bold', " button in the code window to reinvoke the demonstration with the modified code.\n"
);

demos 'Getting Started', (
    'hello'        => 'An introduction to Perl/Tk',
);

demos 'Labels, buttons, checkbuttons, and radiobuttons', (
    'labels'       => 'Labels (text and images)',
    'unicodeout'   => 'Labels and Unicode text',
    'button'       => 'Buttons',
    'check'        => 'Checkbuttons (select any of a group)',
    'radio'        => 'Radiobuttons (select one of a group)',
    'puzzle'       => 'A 15-puzzle game made out of buttons',
    'icon'         => 'Iconic buttons that use bitmaps',
    'image1'       => 'Two labels displaying images',
    'image2'       => 'A simple user interface for viewing images',
    'labelframe'   => 'Labelled frames',
);

demos 'Listboxes', (
    'states'       => 'The 50 states',
    'colors'       => 'Change widget\'s color scheme',
    'sayings'      => 'A collection of famous and infamous sayings',
);

demos 'Entries and Spin-boxes', (
    'entry1'       => 'Entries without scrollbars',
    'entry2'       => 'Entries with scrollbars',
    'entry3'       => 'Validated entries and password fields',
    'spin'         => 'Spin-boxes',
    'form'         => 'Simple Rolodex-like form',
);

demos 'Text', (
    'texts'        => 'Basic editable text',
    'style'        => 'Text display styles',
    'bind'         => 'Hypertext (tag bindings)',
    'twind'        => 'A text widget with embedded windows',
    'search'       => 'A search tool built with a text widget',
);

demos 'Canvases', (
    'items'        => 'The canvas item types',
    'plot'         => 'A simple 2-D plot',
    'ctext'        => 'Text items in canvases',
    'arrows'       => 'An editor for arrowheads on canvas lines',
    'ruler'        => 'A ruler with adjustable tab stops',
    'floor'        => 'A building floor plan',
    'cscroll'      => 'A simple scrollable canvas',
    'transtile'    => 'Tiles and transparent images',
);

demos 'Scales', (
    'hscale'       => 'Horizontal scale',
    'vscale'       => 'Vertical scale',
);

demos 'Paned Windows', (
    'paned1'       => 'Horizontal paned window',
    'paned2'       => 'Vertical paned window',
);

demos 'Photos and Images', (
    'photo1'       => 'Transparent pixels',
    'photo2'       => 'Alpha channel compositing',
);

demos 'Menus', (
    'menus'        => 'Menus and cascades (sub-menus)',
    'menus2'       => 'As above, but using Perl/Tk -menuitems',
    'menbut'       => 'Menubuttons',
);

demos 'Common Dialogs', (
    'msgBox'       => 'Message boxes',
    'filebox'      => 'File selection dialog',
    'choosedir'    => 'Directory selection dialog',
    'clrpick'      => 'Color picker',
);

demos 'Tix Widgets', (
    'balloon'      => 'Popup help window when mouse lingers over widget',
    'browseentry'  => 'Entry with Listbox to select list values',
    'browseentry2' => 'Another BrowseEntry example',
    'dirtree'      => 'Display a directory tree',
    'form_mgr'     => 'The form geometry manager',
    'HList'        => 'A hierarchical listbox widget',
    'HList2'       => 'Multicolumn listbox with individual cell styles',
    'labframe'     => 'A Frame with embedded label',
);

demos 'Simulations', (
    'bounce'       => 'Balls bouncing in a cavity',
);

demos 'Sample Perl Mega-Widgets', (
    'mega'         => 'Introduction to writing pure Perl mega-widgets',
    'slide'        => 'Composite Tk::SlideSwitch - binary on/off switch',
    'trace2'       => 'Derived   Tk::TraceText - Text contents defined by a traced variable',
);

demos 'Miscellaneous', (
    'bitmaps'      => 'The built-in bitmaps',
    'dialog1'      => 'A dialog box with a local grab',
    'dialog2'      => 'A dialog box with a global grab',
    'trace1'       => 'Trace a variable\'s value',
    'progress'     => 'Various ProgressBar widgets',
    'keysyms'      => 'Show keyboard symbols',
    'virtevents1'  => 'Synthesizing events',
);

$T->insert('end', "\n", '', "User Contributed Demonstrations\n", 'title');
opendir(C, $WIDTRIB) or warn "Cannot open $WIDTRIB: $!";
my(@dirent) = grep /^.+\.pl$/, sort(readdir C);
closedir C;
unshift @dirent, 'TEMPLATE.pl';	# I want it first
my $i = 0;
while ($_ = shift @dirent) {
    next if /TEMPLATE\.pl/ and $i != 0;
    unless (open(C, "$WIDTRIB/$_")) {
	warn "Cannot open $_: $!" unless /TEMPLATE\.pl/;
	next;
    }
    my($name) = /^(.*)\.pl$/;
    $_ = <C>;
    my($title) = /^#\s*(.*)$/;
    $title =~ s{\r}{}g; # strip DOS newlines
    $DEMO_DESCRIPTION{$name} = $title;
    close C;
    $T->insert('end', ++$i . ". $title\n", ['demo', "demo-$name"]);
}

build_about_dialog $help;
$T->focus;

MainLoop;

sub AUTOLOAD {

    # This routine handles the loading of most demo methods.

    my($demo) = @_;

    $T->Busy;
    {
	$DEMO_FILE = "$WIDTRIB/${demo}.pl" if -f "$WIDTRIB/${demo}.pl";
	$DEMO_FILE = "$widget_lib/${demo}.pl" if -f "$widget_lib/${demo}.pl";
	do $DEMO_FILE;
	warn $@ if $@;
    }
    $T->Unbusy;
    goto &$::AUTOLOAD if defined &$::AUTOLOAD;

} # end AUTOLOAD

sub build_about_dialog {

    my $help = shift;

    my $dialog = $MW->DialogBox(
        -title          => "Perl/Tk, based on Tcl/Tk ${Tk::version}.x",
        -default_button => 'OK',
        -buttons        => ['OK'],
    );
    my $df = $dialog->add( 'Labelframe', -text => '  2006 - Oct - 31  ' );
    $df->pack( qw/ -fill both -expand 1 / );
    my( $change ) = $Tk::CHANGE =~ /Change:\s+(.*)/;
    my( $tk_date ) = scalar localtime( ( stat $Tk::library )[9] );
    my( $tk ) = "$Tk::VERSION ($change), $tk_date";

    foreach my $item (
         [ 'Perl',    "$], $Config{cf_time}" ],
         [ 'Tk',                         $tk ],
         [ 'Platform',         $Tk::platform ],
         [ 'Library',           $Tk::library ],
        ) {
        my $l = $item->[0] . ':';
        my $le = $df->LabEntry(
            -font         => $FONT,
            -label        => ' ' x (13 - length $l) . $l,
            -labelPack    => [qw/-side left -anchor w/],
            -labelFont    => 'Courier 12 bold',
            -relief       => 'flat',
            -takefocus    => 0,
            -textvariable => $item->[1],
            -width        => 45,
        );
        $le->pack(qw/ -fill x -expand 1/);
	$le->Subwidget( 'entry' )->bindtags( [ ] );
    }

    $help->cget(-menu)->entryconfigure('About',
        -command => [$dialog => 'Show'],
    );

} # end build_about_dialog

sub demos {

    # Generate one demo section.

    my ($title, @demos) = @_;

    $T->insert('end', "\n", '', "$title\n", 'title');

    for (my $n = 0; $n <= $#demos; $n += 2) {
	$T->insert('end', $n / 2 + 1 . '. ' . $demos[$n + 1] . ".\n",
		   ['demo', 'demo-' . $demos[$n]]);
    }

} # end demos

sub invoke {

    # This procedure is called when the user clicks on a demo description.

    my($text) = @_;

    my $index = $text->index('current');
    my @tags = $T->tagNames($index);
    my $i = lsearch('demo\-.*', @tags);
    return if $i < 0;
    my($demo) = $tags[$i] =~ /demo-(.*)/;
    $T->tagAdd('visited', "$index linestart", "$index lineend");
    {
	no strict 'refs';
	$SIG{__WARN__} = sub {
	    print @_ unless $_[0] =~ /Subroutine \S+ redefined at/;
	};
	&$demo($demo);
    }

} # end invoke

sub lsearch {

    # Search the list using the supplied regular expression and return its
    # ordinal, or -1 if not found.

    my($regexp, @list) = @_;
    my($i);

    for ($i=0; $i<=$#list; $i++) {
        return $i if $list[$i] =~ /$regexp/;
    }
    return -1;

} # end lsearch

sub see_code {

    # This procedure creates a toplevel window that displays the code for
    # a demonstration and allows it to be edited and reinvoked.

    my($demo) = @_;

    my $file;
    $file = ( $demo =~ /\.pl$/ ) ? $demo : "${demo}.pl";
    if (not Exists $CODE) {
	$CODE = $MW->Toplevel;
	my $code_buttons = $CODE->Frame;
	$code_buttons->pack(qw/-side bottom -fill x/);
	my $code_buttons_dismiss = $code_buttons->Button(
            -text    => 'Dismiss',
            -command => [$CODE => 'withdraw'],
	);
	$CODE_RERUN = $code_buttons->Button(-text => 'Rerun Demo');
	$CODE_TEXT = $CODE->Scrolled('Text', qw/ -height 40 -scrollbars oe -font /, $MONOSPACE_FONT);
	$code_buttons_dismiss->pack(qw/-side left -expand 1/);
	$CODE_RERUN->pack(qw/-side left -expand 1/);
	$CODE_TEXT->pack(qw/-side left -expand 1 -fill both/);
    } else {
	$CODE->deiconify;
	$CODE->raise;
    }
    $CODE_RERUN->configure(-command => sub {
	eval $CODE_TEXT->get(qw/1.0 end/);
	{
	    no strict 'refs';
	    &$demo($demo);
	}
    });
    $CODE->iconname($file);
    $file = "$WIDTRIB/$file" if -f "$WIDTRIB/$file";
    $file = "$widget_lib/$file" if -f "$widget_lib/$file";
    $CODE->title("Demo code: $file");
    $CODE_TEXT->delete(qw/1.0 end/);
    open(CODE, "<$file") or warn "Cannot open demo file $file: $!";
    {
	local $/ = undef;
	$CODE_TEXT->insert('1.0', <CODE>);
    }
    close CODE;
    $CODE_TEXT->markSet(qw/insert 1.0/);
    $CODE_TEXT->focus;

} # end see_code

sub see_vars {

    # Create a top-level window that displays a bunch of global variable values
    # and keeps the display up-to-date even when the variables change value.
    # $args is a pointer to a list of list of 2:
    #
    #   ["variable description", \$VAR]
    #
    # The old trick of passing a string to serve as the description and a soft
    # reference to the variable no longer works with lexicals and use strict.

    my($parent, $args) = @_;

    $VARS->destroy if Exists($VARS);
    $VARS = $parent->Toplevel;
    $VARS->geometry('+300+300');
    $VARS->title('Variable Values');
    $VARS->iconname('Variables');

    my $title = $VARS->Label(
        -text   => 'Variable Values:',
        -width  => 20,
        -anchor => 'center',
        -font   => $LARGE_FONT,
    );
    $title->pack(qw/-side top -fill x/);
    my($label, $var);
    foreach my $i (@$args) {
	($label, $var) = @$i;
	my $wf = $VARS->Frame->pack(qw/-anchor w/);
	$wf->Label(-text => "$label: ")->pack(qw/-side left/);
	$wf->Label(-textvariable => $var)->pack(qw/-side left/);
    }
    $VARS->Button(-text => 'OK', -command => [$VARS => 'destroy'])->
        pack(qw/-side bottom -pady 2/);

} # end see_vars

sub show_stat {

    # Display name of current demonstration.  $sv is a reference to the
    # status Label -textvariable, $text is the Text widget reference and
    # $index is the demonstration index in the Text widget.

    my($sv, $text, $index) = @_;

    my @tags = $text->tagNames($index);
    my $i = lsearch('demo\-.*', @tags);
    return if $i < 0;
    my($demo) = $tags[$i] =~ /demo-(.*)/;
    $$sv = "Click Button-1 to run the \"$demo\" demonstration.";

} # end show_stat

sub view_widget {

    # Expose a file's innards to the world too, but only for viewing.

    my($widget) = @_;

    if (not Exists $VIEW) {
	$VIEW = $MW->Toplevel;
	$VIEW->iconname('widget');
	my $view_buttons = $VIEW->Frame;
	$view_buttons->pack(qw/-side bottom -fill x/);
	my $view_buttons_dismiss = $view_buttons->Button(
            -text    => 'Dismiss',
            -command => [$VIEW => 'withdraw'],
	);
	$view_buttons_dismiss->pack(qw/-side left -expand 1/);
	$VIEW_TEXT = $VIEW->Scrolled('Text', qw/ -height 40 -scrollbars oe /);
	$VIEW_TEXT->pack(qw/-side left -expand 1 -fill both/);
    } else {
	$VIEW->deiconify;
	$VIEW->raise;
    }
    $VIEW->title("Demo code: $widget");
    $VIEW_TEXT->configure(qw/-state normal/);
    $VIEW_TEXT->delete(qw/1.0 end/);
    open(VIEW, "<$widget") or warn "Cannot open demo file $widget: $!";
    {
	local $/ = undef;
	$VIEW_TEXT->insert('1.0', <VIEW>);
    }
    close VIEW;
    $VIEW_TEXT->markSet(qw/insert 1.0/);
    $VIEW_TEXT->configure(qw/-state disabled/);

} # end view_widget

=head1 NAME

widget - Demonstration of Perl/Tk widgets

=head1 SYNOPSYS

  widget [ directory ]

=head1 DESCRIPTION

This script demonstrates the various widgets provided by Tk, along with
many of the features of the Tk toolkit.  This file only contains code to
generate the main window for the application, which invokes individual
demonstrations.  The code for the actual demonstrations is contained in
separate ".pl" files in the "widget_lib" directory, which are autoloaded
by this script as needed.

widget looks in the directory specified on the command line to load user
contributed demonstrations.  If no directory name is specified when widget is
invoked and the environment variable WIDTRIB is defined then demonstrations
are loaded from the WIDTRIB directory. If WIDTRIB is undefined then widget
defaults to the released user contributed directory, "widtrib".

=head2 History

 #
 # Stephen O. Lidie, LUCC, 96/03/11.  lusol@Lehigh.EDU
 # Stephen O. Lidie, LUCC, 97/01/01.  lusol@Lehigh.EDU
 # Stephen O. Lidie, LUCC, 97/02/11.  lusol@Lehigh.EDU
 # Stephen O. Lidie, LUCC, 97/06/07.  lusol@Lehigh.EDU
 #     Update for Tk402.00x.  Total revamp:  WidgetDemo, Scrolled, released
 #     composites, -menuitems, qw//, etcetera.  Perl 5.004 required.
 # Stephen O. Lidie, LUCC, 98/03/10.  lusol@Lehigh.EDU
 #     Update for Tk8.
 # Stephen O. Lidie, LUCC, 98/06/26.  Stephen.O.Lidie@Lehigh.EDU
 #     Add Common Dialogs for Tk800.007.
 # Stephen.O.Lidie@Lehigh.EDU, 1999/11/29, Lehigh University.
 #     Demo some "dash patch" changes.
 # Stephen.O.Lidie@Lehigh.EDU, 2000/01/11, Lehigh University.
 #     Update menubar to Tk 8, fix color palette Menubutton demo.
 # Stephen.O.Lidie@Lehigh.EDU, 2000/07/06, Lehigh University.
 #     Remove inswt() from widget and styles.pl to show the proper Perl/Tk
 #     idiom for inserting Text tags.  Various and sundry cleanups.
 # sol0@lehigh.edu, 2003/07/29, Lehigh University Computing Center.
 #     Update for Tk 8.4.4.

=head1 AUTHOR

Steve Lidie <sol0@Lehigh.EDU>

=cut

__END__
:endofperl
