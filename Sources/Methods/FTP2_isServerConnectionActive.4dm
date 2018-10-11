//%attributes = {}
  // Método: FTP2_isServerConnectionActive
  //
  //
  // creado por Alberto Bachler Klein
  // el 12/08/18, 10:32:27
  // ––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––
C_BOOLEAN:C305($0)
C_LONGINT:C283($1)

C_LONGINT:C283($l_connectionID;$l_error)


If (False:C215)
	C_BOOLEAN:C305(FTP2_isServerConnectionActive ;$0)
	C_LONGINT:C283(FTP2_isServerConnectionActive ;$1)
End if 

$l_connectionID:=$1


$l_error:=FTP_VerifyID ($l_connectionID)
$0:=(($l_error=0) | ($l_connectionID>0))


