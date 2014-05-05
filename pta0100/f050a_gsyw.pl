use utf8;
use strict;
use warnings;

binmode STDIN,":utf8";
binmode STDOUT,":utf8";

# 一覧表形式
# 2013-08-05 修正
#
# "<"から">" を削除する
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

my $rt = "";	# 関数呼び出しからの戻り値取得
my $ra = "";
my $rb = "";


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

	#　特色
	if( />特色</ ){
		# 次行を強制読み込み
		$_ = <STDIN>;
		chop;
		$rt = &slice01( $_ );
		print "$rt,";
	}

	#　連結事業
	if( />連結事業</ ){
		# 次行を強制読み込み
		$_ = <STDIN>;
		chop;
		$rt = &slice01( $_ );
		print "$rt,";
	}

	#　本社所在地
	if( />本社所在地</ ){
		# 次行を強制読み込み
		$_ = <STDIN>;
		chop;
		$rt = &slice01( $_ );
		$rt =~ s/\[周辺地図\]//g;
		print "$rt,";
	}

	#　業種分類
	if( />業種分類</ ){
		# 次行を強制読み込み
		$_ = <STDIN>;
		chop;
		$rt = &slice01( $_ );
		print "$rt,";
	}

	#　代表者名
	if( />代表者名</ ){
		# 次行を強制読み込み
		$_ = <STDIN>;
		chop;
		$rt = &slice01( $_ );
		print "$rt,";
	}

	#　設立年月日
	if( />設立年月日</ ){
		# 次行を強制読み込み
		$_ = <STDIN>;
		chop;
		$rt = &slice01( $_ );
		print "$rt,";
	}

	#　上場年月日
	if( />上場年月日</ ){
		# 次行を強制読み込み
		$_ = <STDIN>;
		chop;
		$rt = &slice01( $_ );
		print "$rt,";
	}

	#　決算
	if( />決算</ ){
		# 次行を強制読み込み
		$_ = <STDIN>;
		chop;
		$rt = &slice01( $_ );
		print "$rt,";
	}

	#　単元株数
	if( />単元株数</ ){
		# 次行を強制読み込み
		$_ = <STDIN>;
		chop;
		$rt = &slice01( $_ );
		$rt =~ /([0-9,]+)(\D+)/;

		# なぜかカンマが抜けないので、以下のカンマ削除コードを挟む
		($ra,$rb ) = ( $1,$2 );
		$ra =~ s/,//g;
		print "$ra,$rb,";
	}

	#　従業員数（単独）
	if( />従業員数.+単独/ ){
		# 次行を強制読み込み
		$_ = <STDIN>;
		chop;
		$rt = &slice01( $_ );
		$rt =~ s/,//g;
		$rt =~ /([0-9]+)(\D+)/;
		print "$1,$2,";
	}	

	#　従業員数（連結）
	if( />従業員数.+連結/ ){
		# 次行を強制読み込み
		$_ = <STDIN>;
		chop;
		$rt = &slice01( $_ );
		$rt =~ s/,//g;
		$rt =~ /([0-9]+)(\D+)/;
		print "$1,$2,";
	}

	#　平均年齢
	if( />平均年齢</ ){
		# 次行を強制読み込み
		$_ = <STDIN>;
		chop;
		$rt = &slice01( $_ );
		$rt =~ /([.0-9]+)(\D+)/;
		print "$1,$2,";
	}

	#　平均年収
	if( />平均年収</ ){
		# 次行を強制読み込み
		$_ = <STDIN>;
		chop;
		$rt = &slice01( $_ );
		$rt =~ s/,//g;		#コンマカット
		$rt =~ /([0-9]+)(\D+)/;
		print "$1,$2";
	}
}
print "\r\n";
