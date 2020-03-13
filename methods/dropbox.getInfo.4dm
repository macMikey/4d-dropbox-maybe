//%attributes = {}
If (Not:C34(verifyInit ))
	$0:="Err:  Bad Initialization"
Else   // verifyInit
	$url:="https://api.dropbox.com/1/account/info?"+prepareOauth 
	$ignore:=HTTP Get:C1157($url;$response)
	$0:=responseOrError ($response;"Unable to get user info")
End if   //(Not(verifyInit ))