//%attributes = {}
C_TEXT:C284($response)
If ((appKey="") | (appSecret=""))
	$0:="Err: Either the appKey or appSecret are empty."
End if   //((appKey="") | (appSecret=""))


$url:="https://api.dropbox.com/1/oauth/request_token?"+prepareOauth 
$ignore:=HTTP Get:C1157($url;$response)

If (Position:C15("error";$response)>0)
	$0:="Err: Unable to get a request token"+<>cr+$response
Else   //Position("error";$response)=0
	
	  //<walk the response and pull the tokens out>
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
		End case 
		$position:=$position+$nextPositionOffset
	End while   // ($nextPositionOffset>0) // keep going until we're out of segments to walk
	  //</walk the response and pull the tokens out>
	
	If (($tokenSecret="") | ($tokenKey=""))
		$0:="Err:  Unable to get a request token"
	Else   //(($tokenSecret="") | ($tokenKey=""))
		$url:="https://www.dropbox.com/1/oauth/authorize?oauth_token="+$tokenKey
		
		If (Count parameters:C259>0)
			If (Count parameters:C259>1)  // called with a callback
				$url:=$url+"&oauth_callback="+$2
			End if   //count parameters >1
			
			If ($1)  // maybe launch the browser for the user
				OPEN URL:C673($url)
				$0:=""
			Else   //not($1)
				$0:=$url
			End if   //$1
		End if   //count parameters>0
	End if   //(($tokenSecret="") | ($tokenKey=""))
End if   //Position("error";$response)>0