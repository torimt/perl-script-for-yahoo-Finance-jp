use utf8;
use strict;
use warnings;

binmode STDIN,":utf8";
binmode STDOUT,":utf8";

# 一覧表形式
# 2013-08-05 修正
#

sub slice01 {

	my $hn = $_[0];
	my @lt01;
	my $g01;
	my $rt = "";

	@lt01 = split( /<[^>]+>/, $hn );
	foreach $g01 ( @lt01 ){
		if ( $g01 ne '&nbsp;' ){
			$rt = $rt . $g01;
		}
	}
	return $rt;
}

#
# 一部例外、EPS 等の 分割出力
#
sub slice05_prt {

	my $hn = $_[0];

	# 文字列が ( スタートなら、(連)|（単)　が先頭に有る
	if( $hn =~ /^\(/ ) {
		$hn =~ /^(\(.+\))[ ]*([0-9\.-]+)(.+)/;
		if( $2 eq '---' ){
			# 値が '---' ならnull値
			print "$1,,$3,";
		} else {
			print "$1,$2,$3,";
		}
	} else {
		# 文字列先頭に、（連）（単）が含まれていない。
		my $one;
		my $two;
		if( $hn =~ /(.+)(倍.+)/ ){
			$one = $1;
			$two = $2;
		} else {
			$hn =~ /(.+)(（.+)/;
			$one = $1;
			$two = $2;
		}
		if( $one eq '---' ){
			print ",,$two,";
		} else {
			print ",$one,$two,";
		}
	}
}

my $buf = "";	# 読み込むファイルの前行を保存する。
my $rt = "";	# 関数呼び出しからの戻り値取得

while(<STDIN>){
	chop;
	s/,//g;	# 先に、カンマをカット

	# 会社名のマッチング：
	if( /<th class="symbol"><h1>(.+)<\/h1><\/th>/ ){
		print $1.",";
	}

	# 証券コード
	if( /<dt>([0-9]{4})<\/dt>/ ) {
		print $1.",";

		# 証券コードの次の行は、「市場」が表れる。
		$_ = <STDIN>;	# 次の１行強制読み込み
		chop;
		$rt = &slice01( $_ );
		print "$rt,";
	}

	#　業種
	if( /<dd class="category yjSb"><a .+>(.+)<\/a><\/dd>/ ){
		print $1.",";
	}

	#　前日終値
	if( /<dt class="title">前日終値/ ){
		$rt = &slice01( $buf );
		$rt =~ /([0-9]+)(.+)/;
		print "$1,$2,";
	}

	# 時価総額
	if( /<dt class="title">時価総額/ ){
		$rt = &slice01( $buf );
		$rt =~ /([0-9]+)(.+)/;
		print "$1,$2,";
	}

	# 発行済株式数
	if( /<dt class="title">発行済株式数/ ){
		$rt = &slice01( $buf );
		$rt =~ /([0-9]+)(.+)/;
		print "$1,$2,";
	}
	
	# 配当利回り
	if( /<dt class="title">配当利回り/ ) {
		$rt = &slice01( $buf );
		$rt =~ /(.+)(%.+)/;
		if( $1 eq '---' ){
			print ",$2,";
		} else {
			print "$1,$2,";
		}
	}

	#	1株配当		
	if ( /<dt class="title">1株配当/ ){
		$rt = &slice01( $buf );
		$rt =~ /([0-9\.\-]+)(.+)/;
		if( $1 eq '---' ){
			print ",$2,";
		} else {
			print "$1,$2,";
		}
	}
	
	# PER
	if ( /<dt class="title">PER/ ){
		$rt = &slice01( $buf );
		&slice05_prt( $rt );
	}

	# PBR
	if ( /<dt class="title">PBR/ ){
		$rt = &slice01( $buf );
		&slice05_prt( $rt );
	}

	# EPS
	if ( /<dt class="title">.+EPS/ ){
		$rt = &slice01( $buf );
		&slice05_prt( $rt );
	}

	# BPS
	if ( /<dt class="title">.+BPS/ ){
		$rt = &slice01( $buf );
		&slice05_prt( $rt );
	}

	# 単元株数
	if( /<dt class="title">単元株数/ ){
		$rt = &slice01( $buf );
		$rt =~ /(.+)株/;
		if( $1 eq '---' ){
			print ",";
		} else {
			print "$1,";
		}
	}

	# 年初来高値
	if( /<dt class="title">年初来高値/ ){
		$rt = &slice01( $buf );
		$rt =~ /([0-9]+)(.+)/;
		print "$1,$2,";
	}


	# 年初来安値
	if( /<dt class="title">年初来安値/ ){
		$rt = &slice01( $buf );
		$rt =~ /([0-9]+)(.+)/;
		print "$1,$2";
	}

	# １行前データを保存
	$buf = $_;
}
print "\r\n";
