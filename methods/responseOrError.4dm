//%attributes = {}
If (Position:C15("error";$1)>0)
	$0:="Err:  "+$2+cr+$1  // e.g. Err:  Unable to get file metadata <CR> ...
Else   //not (position("error";$1)>0)
	$0:=$1
End if   //position("error";$1)>0
