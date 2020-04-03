package Alien::OpenSSL::Install::Files;
use strict;
use warnings;
require Alien::OpenSSL;
sub Inline { shift; Alien::OpenSSL->Inline(@_) }
1;

=begin Pod::Coverage

  Inline

=cut
