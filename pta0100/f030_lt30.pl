print "del f080会社情報.csv\r\n";
while(<STDIN>){
	chop;
	print "type .\\A030会社\\$_ | perl f050a_gsyw.pl >> f080会社情報.csv\r\n";
}
