//%attributes = {}
C_LONGINT:C283($0)
$days:=Current date:C33-!1970-01-01!
$0:=$days*24*60*60  // 24 hours in a day * 60 minutes in an hour * 60 seconds in a minute
$time:=String:C10(Current date:C33;Date RFC 1123:K1:11;Current time:C178)  //;Current time)  // returns, for example Fri, 10 Sep 2010 13:07:20 GMT
$timeOffset:=Length:C16($time)-11  // the length of HH:MM:SS GMT
$hour:=Num:C11(Substring:C12($time;$timeOffset;2))
$minute:=Num:C11(Substring:C12($time;$timeOffset+3;2))
$second:=Num:C11(Substring:C12($time;$timeOffset+6;2))

$0:=$0+($hour*3600)+($minute*60)+$second