#
# Update the file references in the .npl and .prj files of a Xilinx ISE project
# to reflect the new locations of VHDL files that have been moved to new directories.
#

use Getopt::Long;
use File::Find;

sub wanted {
    my $f = $File::Find::name;
    $f =~ s/\\/\//g;
    /.*\.npl$/ && push( @files, $f );
    /.*\.prj$/ && push( @files, $f );
    return 0;
}

GetOptions(
    "help"        => \$help,
    "dir=s"       => \@directories_to_search,
    "subsitute=s" => \@substitutions,
);

print "Unknown options:\n" if $ARGV[0];
foreach (@ARGV) {
    print "$_\n";
}

if ( $ARGV[0] || $help ) {
    print "perl $0 [-help] [-dir <directory>] [-s <string substitute_string>]\n";
    die;
}

find( \&wanted, @directories_to_search );
foreach $f (@files) {
    open( FP, $f ) || die $!;
    @file_contents = <FP>;
    close(FP);
    $file_contents = join( "", @file_contents );

    #print STDOUT "\n\n$f:\n---------------\n$file_contents\n--------------\n";
    foreach $s (@substitutions) {
        ( $search_term, $substitution ) = split( /\s+/, $s );
        $file_contents =~ s/$search_term/$substitution/ig;
    }

    #print STDOUT "$file_contents\n-------------\n";
    open( FP, ">$f" ) || die $!;
    print FP $file_contents;
    close(FP);
}

