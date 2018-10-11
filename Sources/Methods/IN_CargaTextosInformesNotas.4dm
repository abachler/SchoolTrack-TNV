//%attributes = {}
  //IN_CargaTextosInformesNotas

C_TEXT:C284(sName;tText)
C_LONGINT:C283($k)
C_LONGINT:C283(lID)



ARRAY TEXT:C222(atext1;0)
ARRAY TEXT:C222(atext2;0)
ARRAY TEXT:C222(atext3;0)
ARRAY TEXT:C222(atext4;0)
ARRAY TEXT:C222(atext5;0)
ARRAY TEXT:C222(atext21;0)
ARRAY TEXT:C222(atext22;0)
ARRAY TEXT:C222(atext23;0)
ARRAY TEXT:C222(atext24;0)
ARRAY TEXT:C222(atext25;0)
ARRAY INTEGER:C220(aInt1;0)

C_TEXT:C284($file)
C_TEXT:C284($t_nombreTabla)
C_LONGINT:C283($l_registros)

$file:=SYS_CarpetaAplicacion (CLG_Estructura)+"Config"+Folder separator:K24:12+"Langage.txt"

SET CHANNEL:C77(10;$file)
If (ok=1)
	READ WRITE:C146([xxSTR_TextosInformesNotas:56])
	
	RECEIVE VARIABLE:C81($t_nombreTabla)
	RECEIVE VARIABLE:C81($l_registros)
	For ($k;1;$l_registros)
		  //RECEIVE VARIABLE(lId)
		  //ABC191072 
		RECEIVE RECORD:C79([xxSTR_TextosInformesNotas:56])
		  //QUERY([xxSTR_TextosInformesNotas];[xxSTR_TextosInformesNotas]ID=lId)
		$l_recnum:=Find in field:C653([xxSTR_TextosInformesNotas:56]ID:1;[xxSTR_TextosInformesNotas:56]ID:1)
		If ($l_recnum<0)
			If (Records in selection:C76([xxSTR_TextosInformesNotas:56])=0)
				SAVE RECORD:C53([xxSTR_TextosInformesNotas:56])
				UNLOAD RECORD:C212([xxSTR_TextosInformesNotas:56])
			Else 
				For ($i;1;5)
					$pOriginal:=Get pointer:C304("aText"+String:C10($i))
					BLOB_Blob2Vars (Field:C253(Table:C252(->[xxSTR_TextosInformesNotas:56]);$i+7);0;->aInt1;$pOriginal)
				End for 
				  //DELETE RECORD([xxSTR_TextosInformesNotas])
				  //RECEIVE RECORD([xxSTR_TextosInformesNotas])
				For ($i;1;5)
					$pOriginal:=Get pointer:C304("aText"+String:C10($i))
					$pNew:=Get pointer:C304("aText2"+String:C10($i))
					BLOB_Blob2Vars (Field:C253(Table:C252(->[xxSTR_TextosInformesNotas:56]);$i+7);0;->aInt1;$pNew)
					For ($j;1;Size of array:C274($pOriginal->))
						$pNew->{$j}:=$pOriginal->{$j}
					End for 
					BLOB_Variables2Blob (Field:C253(Table:C252(->[xxSTR_TextosInformesNotas:56]);$i+7);0;->aInt1;$pNew)
				End for 
				SAVE RECORD:C53([xxSTR_TextosInformesNotas:56])
				UNLOAD RECORD:C212([xxSTR_TextosInformesNotas:56])
			End if 
		End if 
	End for 
	SET CHANNEL:C77(11)
	READ ONLY:C145([xxSTR_TextosInformesNotas:56])
Else 
	$r:=CD_Dlog (1;__ ("El archivo que contiene los lenguajes no pudo cargarse."))
End if 
