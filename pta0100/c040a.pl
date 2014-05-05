use utf8;
use strict;
use warnings;

binmode STDIN,":utf8";
binmode STDOUT,":utf8";

print "del c060基本情報.csv\r\n";

while(<STDIN>){
	chop;
	print "type .\\A010基本\\$_ | perl c050a_gsyw.pl >> c060基本情報.csv\n";
}
