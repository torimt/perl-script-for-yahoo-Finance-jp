use utf8;
use strict;
use warnings;

binmode STDIN,":utf8";
binmode STDOUT,":utf8";

my $cd; 	# 銘柄コード

while(<STDIN>){
	chop;
	$cd = $_;
	print "wget -O .\\v010値動き\\$cd.html \"http://info.finance.yahoo.co.jp/history/?code=$cd.T&sy=2013&sm=4&ey=2014&em=4&tm=m\"\r\n";
}
