use encoding 'utf-8';
use strict;
use warnings;

binmode STDIN,":utf8";
binmode STDOUT,":utf8";
binmode STDERR,":utf8";

my $cd; #証券コード

while(<STDIN>){
	chop;
	$cd = $_;
	print "wget -O .\\A030会社\\$cd.html http://stocks.finance.yahoo.co.jp/stocks/profile/?code=$cd\r\n";
}
