//%attributes = {}
  // SMTP_VerifyEmailAddress
  // MOD Ticket N° 215171 Patricio Aliaga 20180827
C_TEXT:C284($mail;$0;$1)
C_BOOLEAN:C305($alert)
$mail:=$1
If ($mail#"")
	If (Count parameters:C259=2)
		$alert:=$2
	Else 
		$alert:=True:C214
	End if 
	$0:=""
	$mail:=ST_GetCleanString ($mail)
	Case of 
		: (Position:C15(" ";$mail)#0)
			$mail:=""
		: ((Position:C15(Char:C90(64);$mail)=0) | (Position:C15(".";$mail)=0))
			$mail:=""
		: ((Substring:C12(ST_GetWord ($mail;1;"@");1;1)=".") | (Substring:C12(ST_GetWord ($mail;1;"@");Length:C16(ST_GetWord ($mail;1;"@"));1)="."))
			  // Un nombre de correo no puede comenzar o terminar por "."
			$mail:=""
		: ((Position:C15("..";$mail)>=1))
			  // Un nombre de correo no puede terner mas de un punto "." de manera seguida
			$mail:=""
	End case 
	  //$pattern:="^[.a-zA-Z0-9_-]+@[.a-zA-Z0-9_-]+[.]+[a-zA-Z]{2,7}$"
	If ($mail#"")
		$pattern:="^[a-zA-Z0-9.!#$%&'*+\\/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$"
		$vb_correcto:=Match regex:C1019($pattern;$mail)
		If (Not:C34($vb_correcto))
			If ($alert)
				CD_Dlog (0;__ ("La dirección de correo electrónico no parece correcta."))
			End if 
			$mail:=""
		End if 
	Else 
		If ($alert)
			CD_Dlog (0;__ ("La dirección de correo electrónico ingresada no es válida."))
		End if 
	End if 
End if 
$0:=$mail