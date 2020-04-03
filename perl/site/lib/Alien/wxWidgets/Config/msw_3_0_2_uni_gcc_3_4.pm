package Alien::wxWidgets::Config::msw_3_0_2_uni_gcc_3_4;

use strict;

our %VALUES;

{
    no strict 'vars';
    %VALUES = %{
$VAR1 = {
          '_libraries' => {
                            'adv' => {
                                       'dll' => 'wxmsw30u_adv_gcc_custom.dll',
                                       'lib' => 'libwxmsw30u_adv.a',
                                       'link' => '-lwxmsw30u_adv'
                                     },
                            'aui' => {
                                       'dll' => 'wxmsw30u_aui_gcc_custom.dll',
                                       'lib' => 'libwxmsw30u_aui.a',
                                       'link' => '-lwxmsw30u_aui'
                                     },
                            'base' => {
                                        'dll' => 'wxbase30u_gcc_custom.dll',
                                        'lib' => 'libwxbase30u.a',
                                        'link' => '-lwxbase30u'
                                      },
                            'core' => {
                                        'dll' => 'wxmsw30u_core_gcc_custom.dll',
                                        'lib' => 'libwxmsw30u_core.a',
                                        'link' => '-lwxmsw30u_core'
                                      },
                            'gl' => {
                                      'dll' => 'wxmsw30u_gl_gcc_custom.dll',
                                      'lib' => 'libwxmsw30u_gl.a',
                                      'link' => '-lwxmsw30u_gl'
                                    },
                            'html' => {
                                        'dll' => 'wxmsw30u_html_gcc_custom.dll',
                                        'lib' => 'libwxmsw30u_html.a',
                                        'link' => '-lwxmsw30u_html'
                                      },
                            'media' => {
                                         'dll' => 'wxmsw30u_media_gcc_custom.dll',
                                         'lib' => 'libwxmsw30u_media.a',
                                         'link' => '-lwxmsw30u_media'
                                       },
                            'net' => {
                                       'dll' => 'wxbase30u_net_gcc_custom.dll',
                                       'lib' => 'libwxbase30u_net.a',
                                       'link' => '-lwxbase30u_net'
                                     },
                            'propgrid' => {
                                            'dll' => 'wxmsw30u_propgrid_gcc_custom.dll',
                                            'lib' => 'libwxmsw30u_propgrid.a',
                                            'link' => '-lwxmsw30u_propgrid'
                                          },
                            'ribbon' => {
                                          'dll' => 'wxmsw30u_ribbon_gcc_custom.dll',
                                          'lib' => 'libwxmsw30u_ribbon.a',
                                          'link' => '-lwxmsw30u_ribbon'
                                        },
                            'richtext' => {
                                            'dll' => 'wxmsw30u_richtext_gcc_custom.dll',
                                            'lib' => 'libwxmsw30u_richtext.a',
                                            'link' => '-lwxmsw30u_richtext'
                                          },
                            'stc' => {
                                       'dll' => 'wxmsw30u_stc_gcc_custom.dll',
                                       'lib' => 'libwxmsw30u_stc.a',
                                       'link' => '-lwxmsw30u_stc'
                                     },
                            'webview' => {
                                           'dll' => 'wxmsw30u_webview_gcc_custom.dll',
                                           'lib' => 'libwxmsw30u_webview.a',
                                           'link' => '-lwxmsw30u_webview'
                                         },
                            'xml' => {
                                       'dll' => 'wxbase30u_xml_gcc_custom.dll',
                                       'lib' => 'libwxbase30u_xml.a',
                                       'link' => '-lwxbase30u_xml'
                                     },
                            'xrc' => {
                                       'dll' => 'wxmsw30u_xrc_gcc_custom.dll',
                                       'lib' => 'libwxmsw30u_xrc.a',
                                       'link' => '-lwxmsw30u_xrc'
                                     }
                          },
          'alien_base' => 'msw_3_0_2_uni_gcc_3_4',
          'alien_package' => 'Alien::wxWidgets::Config::msw_3_0_2_uni_gcc_3_4',
          'c_flags' => ' -m64  -O2 -mthreads -m64 -Os ',
          'compiler' => 'g++',
          'config' => {
                        'build' => 'multi',
                        'compiler_kind' => 'gcc',
                        'compiler_version' => '3.4',
                        'debug' => 0,
                        'mslu' => 0,
                        'toolkit' => 'msw',
                        'unicode' => 1
                      },
          'defines' => '-DHAVE_W32API_H -D__WXMSW__ -DNDEBUG -D_UNICODE -DWXUSINGDLL -DNOPCH -DNO_GCC_PRAGMA ',
          'include_path' => '-IC:\\Strawberry\\perl\\site\\lib\\Alien\\wxWidgets\\msw_3_0_2_uni_gcc_3_4\\lib -IC:\\Strawberry\\perl\\site\\lib\\Alien\\wxWidgets\\msw_3_0_2_uni_gcc_3_4\\include -IC:\\Strawberry\\perl\\site\\lib\\Alien\\wxWidgets\\msw_3_0_2_uni_gcc_3_4\\include ',
          'link_flags' => ' -s -m64 ',
          'link_libraries' => '-LC:\\Strawberry\\perl\\site\\lib\\Alien\\wxWidgets\\msw_3_0_2_uni_gcc_3_4\\lib -lwxmsw30u_core -lwxbase30u ',
          'linker' => 'g++',
          'prefix' => 'C:\\Strawberry\\perl\\site\\lib\\Alien\\wxWidgets\\msw_3_0_2_uni_gcc_3_4',
          'shared_library_path' => 'C:\\Strawberry\\perl\\site\\lib\\Alien\\wxWidgets\\msw_3_0_2_uni_gcc_3_4\\lib',
          'version' => '3.000002',
          'wx_base_directory' => 'C:\\Strawberry\\perl\\site\\lib\\Alien\\wxWidgets\\msw_3_0_2_uni_gcc_3_4'
        };
    };
}

my $key = substr __PACKAGE__, 1 + rindex __PACKAGE__, ':';

my ($portablebase);
my $wxwidgetspath = __PACKAGE__ . '.pm';
$wxwidgetspath =~ s/::/\//g;

for (@INC) {
    if( -f qq($_/$wxwidgetspath ) ) {
        $portablebase = qq($_/Alien/wxWidgets/$key);
        last;
    }
}

if( $portablebase ) {
    $portablebase =~ s{/}{\\}g;
    my $portablelibpath = qq($portablebase\\lib);
    my $portableincpath = qq($portablebase\\include);

    $VALUES{include_path} = qq{-I$portablelibpath -I$portableincpath};
    $VALUES{link_libraries} =~ s{-L\S+\s}{-L$portablelibpath };
    $VALUES{shared_library_path} = $portablelibpath;
    $VALUES{wx_base_directory} = $portablebase;
    $VALUES{prefix} = $portablebase;
}

sub values { %VALUES, key => $key }

sub config {
   +{ %{$VALUES{config}},
      package       => __PACKAGE__,
      key           => $key,
      version       => $VALUES{version},
      }
}

1;
