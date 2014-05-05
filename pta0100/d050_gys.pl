use utf8;
use strict;
use warnings;

binmode STDIN,":utf8";
binmode STDOUT,":utf8";

# 一覧表形式

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
	return $rt
}

my $kcd = 0 ;	# 銘柄cd
my $km = "";	# 市場
my $knm = "";	#　会社名

my $rt = "";	# 関数呼び出しからの戻り値取得

while(<STDIN>){
	chop;

	# 会社名を取得
	if ( /<h2 class=\"title\"><a href=[^<]+>(.+)<\/a><\/h2>/ ){
		$knm = $1;
		$_ = <STDIN>;	# 次の行を強制読み込み

		$_ =~ /<[^>]+>([0-9]+)（(.+)）<\/p>/;
		$kcd = $1;
		$km = $2;
	}

	# 決算期
	if( /<h3 class=\"title\">決算期<\/h3>/ ) {
		$_ = <STDIN>;
		$_ = <STDIN>;
		$_ = <STDIN>;
		chop;

		# 決算期を出力する前に、銘柄cd・会社名 を出力
		print "$kcd,$km,$knm,";		
		
		# 決算期を出力
		$rt = &slice01( $_ );
		if( $rt eq "---" ){
			print" , ,";
		} else {
			$rt =~ /([0-9]+)年([0-9]+)/;
			print "$1-$2,$rt,";
		}
	}

	# 決算発表日
	if( /<h3 class=\"title\">決算発表日<\/h3>/ ){
		$_ =<STDIN>; $_ = <STDIN>;
		$_ =<STDIN>;
		chop;
		$rt = &slice01( $_ );
		print "$rt,";

	}

	# 決算月数
	if( /<h3 class=\"title\">決算月数<\/h3>/ ){
		$_ =<STDIN>; $_ = <STDIN>;
		$_ =<STDIN>;
		chop;
		$rt = &slice01( $_ );
		print "$rt,";
	}
	
	# 売上高
	if( /<h3 class=\"title\">売上高<\/h3>/ ){
		$_ =<STDIN>; $_ = <STDIN>;
		$_ =<STDIN>;
		$_ =~ s/,//g;	#　カンマカット
		chop;
		$rt = &slice01( $_ );
		if( $rt eq "---" ){
			print " , ,";
		} else {
			$rt =~ /([0-9]+)(.+)/;
			print "$1,$2,";			
		}
	}

	# 営業利益
	if( /<h3 class=\"title\">営業利益<\/h3>/ ){
		$_ =<STDIN>; $_ = <STDIN>;
		$_ =<STDIN>;
		chop;
		$_ =~ s/,//g;	# カンマカット
		$rt = &slice01( $_ );
		if( $rt eq "---" ){
			print " , ,";
		} else {
			$rt =~ /([0-9]+)(.+)/;
			print "$1,$2,";
		}
	}

	# 経常利益
	if( /<h3 class=\"title\">経常利益<\/h3>/ ){
		$_ =<STDIN>; $_ = <STDIN>;
		$_ =<STDIN>;
		chop;
		$_ =~ s/,//g;	# カンマカット
		$rt = &slice01( $_ );	
		if( $rt eq "---" ){
			print " , ,";
		} else {
			$rt =~ /([0-9-]+)(.+)/;
			print "$1,$2,";
		}
	}	

	# 当期利益
	if( /<h3 class=\"title\">当期利益<\/h3>/ ){
		$_ =<STDIN>; $_ = <STDIN>;
		$_ =<STDIN>;
		chop;
		$_ =~ s/,//g;	# カンマカット
		$rt = &slice01( $_ );
		if( $rt eq "---" ){
			print " , ,";
		} else {
			$rt =~ /([0-9-]+)(.+)/;
			print "$1,$2,";
		}
	}	

	# EPS（一株あたり利益）
	if( /<h3 class=\"title\">EPS（一株あたり利益）<\/h3>/ ){
		$_ =<STDIN>; $_ = <STDIN>;
		$_ =<STDIN>;
		chop;
		$_ =~ s/,//g;	# カンマカット
		$rt = &slice01( $_ );
		if( $rt eq "---" ){
			print " , ,";
		} else {
			$rt =~ /([0-9-\.]+)(.+)/;
			print "$1,$2,";
		}
	}	
	
	# 調整一株あたり利益
	if( /<h3 class=\"title\">調整一株あたり利益<\/h3>/ ){
		$_ =<STDIN>; $_ = <STDIN>;
		$_ =<STDIN>;
		chop;
		$_ =~ s/,//g;	# カンマカット
		$rt = &slice01( $_ );
		print "$rt,";
	}	

	# BPS（一株あたり純資産）
	if( /<h3 class=\"title\">BPS（一株あたり純資産）<\/h3>/ ){
		$_ =<STDIN>; $_ = <STDIN>;
		$_ =<STDIN>;
		chop;
		$_ =~ s/,//g;	# カンマカット
		$rt = &slice01( $_ );
		if( $rt eq "---" ){
			print " , ,";
		} else {
			$rt =~ /([0-9\-\.]+)(.+)/;
			print "$1,$2,";
		}
	}	

	# 総資産
	if( /<h3 class=\"title\">総資産<\/h3>/ ){
		$_ =<STDIN>; $_ = <STDIN>;
		$_ =<STDIN>;
		chop;
		$_ =~ s/,//g;	# カンマカット
		$rt = &slice01( $_ );
		if( $rt eq "---" ){
			print " , ,";
		} else {
			$rt =~ /([0-9]+)(.+)/;
			print "$1,$2,";
		}
	}	

	# 自己資本
	if( /<h3 class=\"title\">自己資本<\/h3>/ ){
		$_ =<STDIN>; $_ = <STDIN>;
		$_ =<STDIN>;
		chop;
		$_ =~ s/,//g;	# カンマカット
		$rt = &slice01( $_ );
		if( $rt eq "---" ){
			print " , ,";
		} else {
			$rt =~ /([0-9]+)(.+)/;
			print "$1,$2,";
		}
	}	

	# 資本金
	if( /<h3 class=\"title\">資本金<\/h3>/ ){
		$_ =<STDIN>; $_ = <STDIN>;
		$_ =<STDIN>;
		chop;
		$_ =~ s/,//g;	#　カンマカット
		$rt = &slice01( $_ );
		if( $rt eq "---" ){
			print " , ,";
		} else {
			$rt =~ /([0-9]+)(.+)/;
			print "$1,$2,";
		}
	}	

	# 有利子負債
	if( /<h3 class=\"title\">有利子負債<\/h3>/ ){
		$_ =<STDIN>; $_ = <STDIN>;
		$_ =<STDIN>;
		chop;
		$_ =~ s/,//g;	#　カンマカット
		$rt = &slice01( $_ );
		if( $rt eq "---" ){
			print " , ,";
		} else {
			$rt =~ /([0-9]+)(.+)/;
			print "$1,$2,";
		}
	}

	# 自己資本比率
	if( /<h3 class=\"title\">自己資本比率<\/h3>/ ){
		$_ =<STDIN>; $_ = <STDIN>;
		$_ =<STDIN>;
		chop;
		$_ =~ s/,//g;	#　カンマカット
		$rt = &slice01( $_ );
		if( $rt eq "---" ){
			print " , ,";
		} else {
			$rt =~ /([0-9\.]+)(.+)/;
			print "$1,$2,";
		}
	}

	# 含み損益
	if( /<h3 class=\"title\">含み損益<\/h3>/ ){
		$_ =<STDIN>; $_ = <STDIN>;
		$_ =<STDIN>;
		chop;
		$_ =~ s/,//g;	#　カンマカット
		$rt = &slice01( $_ );
		print "$rt,";
	}

	# ROA（総資産利益率）
	if( /<h3 class=\"title\">ROA（総資産利益率）<\/h3>/ ){
		$_ =<STDIN>; $_ = <STDIN>;
		$_ =<STDIN>;
		chop;
		$_ =~ s/,//g;	#　カンマカット
		$rt = &slice01( $_ );
		if( $rt eq "---" ){
			print " , ,";
		} else {
			$rt =~ /([0-9\.-]+)(.+)/;
			print "$1,$2,";
		}
	}

	# ROE（自己資本利益率）
	if( /<h3 class=\"title\">ROE（自己資本利益率）<\/h3>/ ){
		$_ =<STDIN>; $_ = <STDIN>;
		$_ =<STDIN>;
		chop;
		$_ =~ s/,//g;	#　カンマカット
		$rt = &slice01( $_ );
		if( $rt eq "---" ){
			print " , ,";
		} else {
			$rt =~ /([0-9\.-]+)(.+)/;
			print "$1,$2,";
		}
	}

	# 総資産経常利益率
	if( /<h3 class=\"title\">総資産経常利益率<\/h3>/ ){
		$_ =<STDIN>; $_ = <STDIN>;
		$_ =<STDIN>;
		chop;
		$_ =~ s/,//g;	#　カンマカット
		$rt = &slice01( $_ );
		if( $rt eq "---" ){
			print " , ,";
		} else {
			$rt =~ /([0-9\.-]+)(.+)/;
			print "$1,$2";
		}

		# 最終項目の出力後に、改行出力
		print "\r\n";
	}
}
