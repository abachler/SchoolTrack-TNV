//%attributes = {}
  // MAIL_VerifyAddress
  // MOD Ticket N° 215171 Patricio Aliaga 20180827
  // Centralizacion de verificacion en SMTP_VerifyEmailAddress
  // Declaracion de variables
C_TEXT:C284($0;$email)
C_BOOLEAN:C305($2;$alert)
If (Count parameters:C259=2)
	$alert:=$2
Else 
	$alert:=True:C214
End if 
$0:=SMTP_VerifyEmailAddress ($1;$alert)