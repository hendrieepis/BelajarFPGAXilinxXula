use File::Find;

binmode(STDOUT); # so the linefeed is not expanded into a linefeed + carriage return

@directories_to_search = ( '50', "100", "200", "3S1000", "XSA_LIB");
find(\&wanted, @directories_to_search);

sub wanted {
  $\ = "\x0a"; # separate file names with linefeeds since this is what tar wants
  my $f = $File::Find::name;;
  $f =~ s/\\/\//g;  
  /.*\.vhd$/ && print $f;
  /.*\.ucf$/ && print $f;
  /.*\.npl$/ && print $f;
  /.*\.bit$/ && print $f;
  /.*\.svf$/ && print $f;
  /.*\.xls$/ && print $f;
  return 0;
}

