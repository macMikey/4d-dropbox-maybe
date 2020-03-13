//%attributes = {}
$0:=False:C215
C_TEXT:C284($response)
$URL:="https://api.dropbox.com/1"
$ignore:=HTTP Get:C1157($url;$response)
If (Position:C15(("{"+Char:C90(Double quote:K15:41)+"error"+Char:C90(Double quote:K15:41));$response)>0)  //yes, we want an error.  The full text of the response should be  {"error": "Not Found"}
	$0:=True:C214
End if   // ((Substring("{"+Char(Double quote)+"error"+Char(Double quote));$response)>0)