//%attributes = {"shared":true}
C_TEXT:C284($0)
C_BOOLEAN:C305($2)  // whether or not what's being passed in is a path or not
$isAPath:=False:C215  // default

If (Count parameters:C259>1)
	$isAPath:=$2
End if   //(count parameters>1)

For ($i;1;Length:C16($1))  // walk and evaluate
	If ((Position:C15($1[[$i]];unreservedChars)>0) | (($1[[$i]]="/") & $isAPath))  // either the char doesn't need to be convereted, or it's a directory separator (so we won't convert it)
		$0:=$0+$1[[$i]]
	Else   // either a character that has to be percent-encoded, OR a slash that isn't in a path (therefore has to be percent-encoded)
		$ascii:=Character code:C91($1[[$i]])
		$firstPosition:=hex[[$ascii\16]]  // first hex digit of char value
		$secondPosition:=hex[[$ascii%16]]  // second hext digit of char value
		$0:=$0+"%"+$firstPosition+$secondPosition  // for example, %20 for space
	End if   // ((Position($1[[$i]];unreservedChars)>0) | (($1[[$i]]="/") & $isAPath))
End for   // $i;1;length($1)