//%attributes = {}
  // ST_SonTextosIdenticos()
  // Por: Alberto Bachler K.: 16-01-15, 13:11:13
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_BOOLEAN:C305($0)
C_TEXT:C284($1;$2)

C_TEXT:C284($t_texto1;$t_texto2)

If (False:C215)
	C_BOOLEAN:C305(ST_SonTextosIdenticos ;$0)
	C_TEXT:C284(ST_SonTextosIdenticos ;$1)
	C_TEXT:C284(ST_SonTextosIdenticos ;$2)
End if 

$t_texto1:=$1
$t_texto2:=$2

Case of 
	: ($t_texto1#$t_texto2)
		
	: (Length:C16(Replace string:C233($t_texto1;$t_texto2;"";1;*))=0)
		$0:=True:C214
End case 
