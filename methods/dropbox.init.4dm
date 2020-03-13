//%attributes = {"shared":true}
unreservedChars:="abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789-_.~"
hex:="0123456789ABCDEF"
cr:=Char:C90(Carriage return:K15:38)


appKey:=""
appSecret:=""
tokenKey:=""
tokenSecret:=""

$0:="Err: No app info passed."  // default
Case of   // <make sure appKey and appSecret are passed and are not blank>
	: (Count parameters:C259<2)
		  // error, use the message
	: ($1="") | ($2="")
		  // error, use the message
	Else   // appKey and appSecret passed and not blank
		  // don't wipe $0, because until we examine the rest of the parameters, we don't know if there is an error or not.
		appKey:=$1
		appSecret:=$2
		
		Case of   // <at least appKey and appSecret passed>
			: (Count parameters:C259=2)  // only appKey and appSecret being passed is fine b/c we might not know the tokenKey and tokenSecret, yet.
				$0:=""
			: (Count parameters:C259=3)  // tokenKey also passed, but that isn't ok without the tokenSecret
				$0:="Err: Improper number of parameters passed.  You must pass either two or four."
			: ((($3="") & ($4="")) | (($3<>"") & ($4<>"")))  // tokenKey and tokenSecret are either both empty or both not empty.  Blank is ok, it's the same as not passing them.
				$0:=""
				tokenKey:=$3
				tokenSecret:=$4
			Else   // one is empty and one is not.
				$0:="Err: the tokenKey and tokenSecret must either both be empty or not empty."
		End case   // </at least 2 params passed, could be more>
End case   // </check if parameters 1 and 2 passed and are not blank>