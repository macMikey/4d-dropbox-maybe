//%attributes = {}
$time:=String:C10(theSeconds )
$once:=Generate digest:C1147($time;0)  //md5 digest
TEXT TO BLOB:C554($once;$onceAsBlob)  //blob only temporary, created so we can encode $once
$once:=BASE64 ENCODE:C895($onceAsBlob)

$0:="oauth_consumer_key="+appKey+"&"
If (tokenKey#"")
	$0:=$0+"oauth_token="+tokenKey+"&"
End if 
$0:=$0+"oauth_signature_method=PLAINTEXT&"
$0:=$0+"oauth_signature="+dropbox.rfcURLEncode (appSecret+"&"+tokenSecret)+"&"  // yes, even if the token secret is empty
$0:=$0+"oauth_timestamp="+$time+"&"
$0:=$0+"oauth_nonce="+$once+"&"
$0:=$0+"oauth_version=1.0"