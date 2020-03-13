//%attributes = {"shared":true}
$startAt:=1
$0:=$1  // default return untouched
$position:=Position:C15("%";$1)
While ($position>0)  // found a percent sign, investigate it to see if it's part of a percent-encoding (which it should be, but just check it, anyway)
	$maybeHex:=Substring:C12($1;$position;3)  // the percent and next two chars.
	$char1:=$1[[($position+1)]]  // first char after percent
	$char2:=$1[[($position+2)]]  // second char after percent
	If ((isHex ($char1)) & (isHex ($char2)))  // both are hex chars
		$char1HexPosition:=Position:C15(Uppercase:C13($char1);hex)
		$char2HexPosition:=Position:C15(Uppercase:C13($char2);hex)
		$ascii:=($char1HexPosition*16)+$char2HexPosition  // hex is base 16
		$char:=Char:C90($ascii)
		$startAt:=$position+1  // skip past this spot on future passes through the loop, ESPECIALLY if we were decoding a %25 (percent sign)
		$0:=Substring:C12($1;1;($position-1))+$char+Substring:C12($1;($position+3))  // replace the percent-encoded character.  DO NOT USE REPLACE STRING because it's possible that you could incorrectly process the conversion.  For example...
		  // if you have %25 in the string (which is the percent-encoding of the percent sign), and you use REPLACE STRING to replace every instance of the percent sign, and somewhere else in the string you have %25AB, after %25 is converted...
		  // to %, you will have %AB, which will then be incorrectly converted, later, when we walk down the string and get to that point.  You COULD use REPLACE STRING one time, but sooner or later, some n00b is going to see that and say...
		  // OH, I can optimize this code by changing this and that and replacing every instance one time, and...#FALE
	End if   //(isHex($char1) & (isHex($char2))  
	$position:=Position:C15("%";$1;$startAt)
End while   //($position>0)