//%attributes = {}
C_TEXT:C284(what)
Repeat 
	$what:=Request:C163("Yes, Master?";what)
	If (ok=1)
		what:=$what
		EXECUTE FORMULA:C63($what)
	End if   //ok=1
Until (ok=0)