//%attributes = {}
ALERT:C41(dropbox.about )
If (Not:C34(dropbox.available ))
	ALERT:C41("Dropbox is not currently available.")
Else   //available
	If (dropbox.init ("put your app key here";"put your app secret here")#"")
		ALERT:C41("Error initializing dropbox.")
	Else   // init worked
		ALERT:C41("URL:  "+dropbox.requestToken )
	End if   // dropbox.init...
End if   // not(dropbox.available)