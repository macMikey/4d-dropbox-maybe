//%attributes = {}
If (Not:C34(dropbox.init ))
	$0:="Err: Bad Initialization"
Else   // init
	If (Not:C34(rootIsProper ($1)))
		$0:="Err: Invalid root param"
	Else   // root is proper
		$path:=dropbox.rfcURLEncode ($2;True:C214)
		If (Length:C16($3)<3)
			$0:="Err:  String to search for must be at least 3 chars long."
		Else   // length($3)>=3
			$str:=dropbox.rfcURLEncode ($3;True:C214)
			$url:="https://api.dropbox.com/1/search/"+pRoot+"/"+pPath+"?query="+$str+"&"
			
			$includeDeleted:="false"
			If (Count parameters:C259>=3)
				If ($3)
					$includeDeleted:="true"
				End if   //$3
				$includeDeleted:="include_deleted="+$includeDeleted
				$url:=$url+$includeDeleted
				
				If (Count parameters:C259>=4)
					$fileLimit:="&file_limit=" & String:C10($4)
					$url:=$url+$fileLimit
				End if   //count parameters >=4
				
				$url:=$url+"&"+prepareOauth 
				$ignore:=HTTP Get:C1157($url;$response)
				
				$0:=responseOrError ($response;"Unable to find files")
			End if   //length($3)<3
		End if   //count parameters>=3
	End if   // (not(rootIsProper($1))
End if   //(not(dropbox.init))