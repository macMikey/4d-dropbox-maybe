//%attributes = {}
If (Not:C34(verifyInit ))
	$0:="Err: Bad Initialization"
Else   //verified
	$url:="https://api.dropbox.com/1/oauth/access_token?"+prepareOauth 
	$ignore:=HTTP Get:C1157($url;$response)
	If (Position:C15("error";$response)>0)
		$0:="Err: Unable to get access token"+cr+$response
	Else   // not failure
		
		  //<walk the response and pull the tokens and uid out>
		$position:=Position:C15("&";$response)
		$lastSegment:=False:C215  //not at the end of the response, yet.
		While (Not:C34($lastSegment))  // keep going until we're out of segments to walk
			$nextPositionOffset:=Position:C15("&";$response;$position+1)  // find the next "&", that terminates the segment/begins the next segment.
			If ($nextPositionOffset=0)  // i.e. only one segment
				$nextPositionOffset:=Length:C16($response)
				$lastSegment:=True:C214  // don't do another pass, we're at the end.
			End if   //$nextPositionOffset=0
			
			$segment:=Substring:C12($response;$position+1;$nextPositionOffset-1)
			Case of 
				: (Substring:C12($segment;1;19)="oauth_token_secret=")
					$tokenSecret:=Substring:C12($segment;20)
				: (Substring:C12($segment;1;12)="oauth_token=")
					$tokenKey:=Substring:C12($segment;13)
				: (Substring:C12($segment;1;4)="uid=")
					$uid:=Substring:C12($segment;5)
			End case 
			$position:=$position+$nextPositionOffset
		End while   // ($nextPositionOffset>0) // keep going until we're out of segments to walk
		  //</walk the response and pull the tokens and uid out>
		
		If (($tokenSecret="") | ($tokenKey=""))
			$0:="Err:  Unable to get a request token"
		Else   //(($tokenSecret="") | ($tokenKey=""))
			$0:=$tokenKey+cr+tokenSecret+cr+$uid
		End if   // (($tokenSecret="") | ($tokenKey=""))
	End if   //(Position("error";$response)>0)
End if   // (Not(verifyInit ))