#!perl -lan
## ========== ========== ========== ========== ##
## size-conv.pl
## Convert units to make seaweedfs shell results more readable.
## ========== ========== ========== ========== ##
## USAGE: 
##   $  | ./size-conv.pl
## EXAMPLE:
##   $ printf 'volume.list -v 4\n' | weed shell | perl -lan size-conv.pl
## NOTES: 
## * Expectes to be given input via STDIN.
## ========== ========== ========== ========== ##
## AUTHOR: Ctrl-S
## LICENSE: BSD0
## CREATED: 2023-07-21
## MODIFIED: 2023-07-21
## ========== ========== ========== ========== ##

sub conv_bytes {
  ## Convert size in bytes into human-readable format.
  ## Argument, number of bytes.
  $sizenum = $_[0];
  ## Unabmbiguous proper kilobytes; not stupid SI crap.
  @units=("B","KiB","MiB","GiB","TiB","PiB");
  ## Throw away units until number is no more than 1024:
  while ($sizenum > 1024) {
    $sizenum/=1024;
    shift @units;
  }
  ## Use first remaining unit:
  return sprintf("%.2f%s", $sizenum, $units[0]);
}

foreach my $line ( <STDIN> ) { ## Explicitly loop over stdin.
  ## Replace each occurance of each pattern using conversion function:
  ## Perl regex /e suffix makes the replacement section execute code
  ##  $var_modified_inplace =~ s/PATTERN/REPLACEMENT_EXPRESSION/e;
  $line =~ s/(size:)(\d+)/$1 . conv_bytes($2)/e;
  $line =~ s/(deleted_bytes:)(\d+)/$1 . conv_bytes($2)/e;
  printf $line # Send to stdout without extra newline
}
printf "\n" # Trailing newline on exit.
