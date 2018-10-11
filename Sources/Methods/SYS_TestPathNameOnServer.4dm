//%attributes = {"executedOnServer":true}
  // SYS_TestPathNameOnServer
  // Por: Alberto Bachler Klein: 16-10-15, 19:53:47
  //  ---------------------------------------------
  // 
  //
  //  ---------------------------------------------

C_LONGINT:C283($0)
C_TEXT:C284($1)

C_TEXT:C284($t_raiz)
C_TEXT:C284($t_rutaDocumento)
C_TEXT:C284($t_rutaEstructura)
C_TEXT:C284($t_volumen)
C_TEXT:C284($t_volumenDB)
ARRAY TEXT:C222($at_volumenes;0)
ARRAY TEXT:C222($at_elementosRuta;0)

If (False:C215)
	C_LONGINT:C283(SYS_TestPathNameOnServer ;$0)
	C_TEXT:C284(SYS_TestPathNameOnServer ;$1)
End if 

$0:=-43
$t_rutaDocumento:=$1

If (Length:C16($t_rutaDocumento)>0)
	$t_rutaEstructura:=Get 4D folder:C485(Database folder:K5:14)
	Case of 
		: (SYS_IsMacintosh )
			$t_volumenDB:=ST_GetWord ($t_rutaEstructura;1;":")+Folder separator:K24:12
		: (SYS_IsWindows )
			$t_volumenDB:=Substring:C12($t_rutaEstructura;1;1)+":\\"
	End case 
	VOLUME LIST:C471($at_volumenes)
	
	  //TRACE
	$t_rutaDocumento:=Replace string:C233($t_rutaDocumento;":\\";"/")
	$t_rutaDocumento:=Replace string:C233($t_rutaDocumento;"\\";"/")
	$t_rutaDocumento:=Replace string:C233($t_rutaDocumento;":";"/")
	If (Position:C15("/";$t_rutaDocumento)=1)
		$t_rutaDocumento:=Substring:C12($t_rutaDocumento;2)
	End if 
	AT_Text2Array (->$at_elementosRuta;$t_rutaDocumento;"/")
	
	$t_volumen:=$at_elementosRuta{1}
	If (SYS_IsWindows )
		$t_volumen:=$at_elementosRuta{1}+":\\"
	End if 
	
	If (Find in array:C230($at_volumenes;$t_volumen)<0)
		$t_volumen:=""
	Else 
		$t_volumen:=$at_elementosRuta{1}+Choose:C955(SYS_IsWindows ;":";"")
		DELETE FROM ARRAY:C228($at_elementosRuta;1)
	End if 
	
	If ($t_volumen#"")
		$t_rutaDocumento:=$t_volumen
	Else 
		$t_rutaEstructura:=Get 4D folder:C485(Database folder:K5:14)
		$t_rutaDocumento:=Substring:C12($t_rutaEstructura;1;Length:C16($t_rutaEstructura)-1)
	End if 
	For ($i;1;Size of array:C274($at_elementosRuta))
		$t_rutaDocumento:=$t_rutaDocumento+Folder separator:K24:12+$at_elementosRuta{$i}
	End for 
End if 

$t_rutaDocumento:=Replace string:C233($t_rutaDocumento;Folder separator:K24:12+Folder separator:K24:12;Folder separator:K24:12)
$0:=Test path name:C476($t_rutaDocumento)
