//%attributes = {}
  // XSnota_ObtieneListaNotas ()
  // Por: Alberto Bachler K.: 11-03-15, 18:14:50
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_TEXT:C284($0)
C_TEXT:C284($1)

C_TEXT:C284($t_json;$t_llave)


If (False:C215)
	C_TEXT:C284(XSnota_ObtieneListaNotas ;$0)
	C_TEXT:C284(XSnota_ObtieneListaNotas ;$1)
End if 

$t_llave:=$1


READ ONLY:C145([xShell_RecordNotes:283])
QUERY:C277([xShell_RecordNotes:283];[xShell_RecordNotes:283]Llave:4=$t_llave)
ORDER BY:C49([xShell_RecordNotes:283];[xShell_RecordNotes:283]DTS:6;<)

ALL RECORDS:C47([xShell_RecordNotes:283])
$t_json:=Selection to JSON:C1234([xShell_RecordNotes:283];[xShell_RecordNotes:283]DTS:6;[xShell_RecordNotes:283]Usuario:5;[xShell_RecordNotes:283]Anotacion:8)
$0:=$t_json