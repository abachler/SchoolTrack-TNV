//%attributes = {}
  // DOCL_DocumentosAsociados()
  // Por: Alberto Bachler: 17/09/13, 13:38:59
  //  ---------------------------------------------
  // 
  //
  //  ---------------------------------------------

C_POINTER:C301($1)
C_TEXT:C284($2)

C_LONGINT:C283($l_numeroTabla)
C_POINTER:C301($y_tabla)
C_TEXT:C284($t_llaveDocumentos;$t_refRegistro;$t_refTabla;$t_claseDocumento)
C_BOOLEAN:C305($b_conMiniatura)

If (False:C215)
	C_POINTER:C301(DOCL_DocumentosAsociados ;$1)
	C_TEXT:C284(DOCL_DocumentosAsociados ;$3)
End if 

$y_tabla:=$1
$t_refRegistro:=$2


Case of 
	: (Count parameters:C259=4)
		$t_claseDocumento:=$3
		$b_conMiniatura:=$4
		
	: (Count parameters:C259=3)
		$t_claseDocumento:=$3
		
End case 

$l_numeroTabla:=Table:C252($y_tabla)
$t_refTabla:=String:C10($l_numeroTabla)

$t_llaveDocumentos:=$t_refTabla+"."+$t_refRegistro
READ ONLY:C145([DocumentLibrary:234])
QUERY:C277([DocumentLibrary:234];[DocumentLibrary:234]PrimaryKey:9=$t_llaveDocumentos;*)
If ($t_claseDocumento#"")
	QUERY:C277([DocumentLibrary:234]; & ;[DocumentLibrary:234]refClase:11=$t_claseDocumento;*)
End if 
If ($t_claseDocumento#"")
	QUERY:C277([DocumentLibrary:234]; & ;[DocumentLibrary:234]hasThumbnail:16=$b_conMiniatura;*)
End if 
QUERY:C277([DocumentLibrary:234])

ORDER BY:C49([DocumentLibrary:234];[DocumentLibrary:234]Order:17;>)

