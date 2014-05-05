use encoding 'utf-8';
use strict;
use warnings;

binmode STDIN,":utf8";
binmode STDOUT,":utf8";
binmode STDERR,":utf8";

# 業績ファイルの取得

my $cd; #証券コード

while(<STDIN>){
	chop;
	$cd = $_;
	print "wget -O .\\A020業績\\$cd.html http://m.finance.yahoo.co.jp/stock/settlement/consolidate?code=$cd\r\n";
}
