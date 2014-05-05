use encoding 'utf-8';
use strict;
use warnings;

binmode STDIN,":utf8";
binmode STDOUT,":utf8";
binmode STDERR,":utf8";

# 日付の「年」・「月」を変換出力
sub dt010{
	my $dt = $_[0];
	my $m;
	my $d;
	
	$dt =~ /([0-9]+)年([0-9]+)月/;
	$m = $1;
	$d = "0".$2;
	$d =~ /([0-9]{2})$/;
	$dt = $m."-".$1;
}

# 出力部
sub cut_put010{

	my $nm = $_[0];
	my $r = $_[1];
	my $dt;

	$r =~ /<\/tr><tr><td>([0-9]+年[0-9]+月)(<\/td><td>[0-9,]+){5}<\/td><td>([0-9]+)<\/td>/;
	$dt = &dt010($1);	#日付だけ出力形式を変換する
	print "$nm,$dt,$3\r\n";

}

my $rt;
my $mn;

while(<STDIN>){
	chop;

	# 銘柄コードの取り出し
	if( /^(<dt>[0-9]{4}<\/dt>)/ ){
		$& =~ /([0-9]{4})/;
		$mn = $1;		
	}	

	# 株価部分の取り出し
	if ( /^(<\/tr><tr><td>)/ ){
		$rt = $_;
		$rt =~ s/,//g;
		while( $rt =~ /^(<\/tr><tr><td>[0-9]+年[0-9]+月(<\/td><td>[0-9]+){6}<\/td>)/ ){
			&cut_put010( $mn,$& );
			$rt = $';
		}
	}
}
