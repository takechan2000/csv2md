#!/usr/bin/perl

use Getopt::Long qw(:config posix_default no_ignore_case gnu_compat);

my(@formats);
GetOptions(
    "f=s" => \@format
    );

my $format = $format[0];

my $filename = $ARGV[0];
open(IN, "./$filename") or die("> error : $!");

my $startline = 1;

while(<>) {
    $line = $_;
    $line =~ s/\n//;
    $line =~ s/\r//;

    $done = "";
    $rest = $line;
    $rest =~ s/""/--DUMMYQUOTE--/g;
    while ($rest){
	if ($rest =~ /^([^"]*)"([^"]+)"(.*)$/) {
	    $head = $1;
	    $escape = $2;
	    $rest = $3;
	    $head =~ s/,/|/g; 
	    $done .= $head . $escape;
      } else {
	  $rest =~ s/,/|/g; 
	  $done .= $rest;
	  $rest = "";
      }
    }
    $line = $done;

    $line =~ s/^/|/; 
    $line =~ s/"//g;
    $line =~ s/--DUMMYQUOTE--/"/g;
    $line =~ s/\[/\\[/g;
    $line =~ s/\]/\\]/g;
    $line = $line . "|\n";
    print $line;
    if ($startline == 1) {
	$count = 0;
	$count++ while( $line =~ m/\|/g);
	if ($count > 0){
	    print "|";
	    while (--$count) {
		if ($format ne ""){
		    $fc = substr($format, 0, 1);
		    if ($fc eq "l"){
			print ":----|";
		    } elsif ($fc eq "c"){
			print ":---:|";
		    } elsif ($fc eq "r"){
			print "----:|";
		    } else {
			print ":----";
		    };
		    $format = substr($format, 1);
		} else {
		    print ":---|"
		}
	    };
	    print "\n";
	    $startline = 0;
	}
    }
}

