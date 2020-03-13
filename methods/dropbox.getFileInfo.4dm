//%attributes = {}
If (Not:C34(verifyInit ))
	$0:="Err:  Bad Initialization"
Else   // verifyInit
	If (Not:C34(rootIsProper ($1)))
		$0:="Err: Invalid root param"
	Else   // proper
		$path:=dropbox.rfcURLEncode ($2;True:C214)
		$url:="https://api.dropbox.com/1/metadata/"+$1+"/"+$2+"?"
		$list:=""  // default to showing a list of files if a directory
		If (Count parameters:C259>=3)
			If (Not:C34($3))  // don't include list of files
				$list:="&list=false"
			End if   //not($3)
			
			If (Count parameters:C259=4)
				If (($4<0) | ($4>25000))
					$0:="Err: Invalid limit"
				Else   // 0<=$4<=25000
					$limit:="&file_limit="+String:C10($4)
				End if   //(($4<0) | ($4>25000))
			End if   // (Count parameters=4)
		End if   //(count parameters>=3)
		
		If ($0="")  // no error with $4
			$url:=$url+$limit+$list
			$ignore:=HTTP Get:C1157($url;$response)
			
			$0:=responseOrError ($response;"Unable to get file metadata")
		End if   //($0="")
	End if   //not(rootIsProper($1))
End if   //(not(verifyinit))