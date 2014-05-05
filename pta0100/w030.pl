use utf8;
use strict;
use warnings;

binmode STDIN,":utf8";
binmode STDOUT,":utf8";

print "del w050株価情報.csv\r\n";
while(<STDIN>){
	chop;
	print "type .\\V010値動き\\$_ | perl w060.pl >> w050株価情報.csv\r\n";
}
