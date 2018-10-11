//%attributes = {}
  //ACTbol_AsignaCatDocTributario

C_BLOB:C604($xBlob)
ARRAY LONGINT:C221(al_idsApoderados;0)
ARRAY LONGINT:C221($al_idsNoProcesados;0)
C_LONGINT:C283(vl_exId)
C_LONGINT:C283(vl_newId)
$xBlob:=$1
BLOB_Blob2Vars (->$xBlob;0;->al_idsApoderados;->vl_exId;->vl_newId)

For ($i;1;Size of array:C274(al_idsApoderados))
	$vl_idPersona:=al_idsApoderados{$i}
	$index:=Find in field:C653([Personas:7]No:1;$vl_idPersona)
	If ($index#-1)
		READ WRITE:C146([Personas:7])
		GOTO RECORD:C242([Personas:7];$index)
		If ([Personas:7]ACT_DocumentoTributario:45=vl_exId)
			If (Not:C34(Locked:C147([Personas:7])))
				[Personas:7]ACT_DocumentoTributario:45:=vl_newId
				SAVE RECORD:C53([Personas:7])
			Else 
				APPEND TO ARRAY:C911($al_idsNoProcesados;al_idsApoderados{$i})
			End if 
		End if 
	End if 
End for 
If (Size of array:C274($al_idsNoProcesados)>0)
	COPY ARRAY:C226($al_idsNoProcesados;al_idsApoderados)
	BLOB_Variables2Blob (->$xBlob;0;->al_idsApoderados;->vl_exId;->vl_newId)
	BM_CreateRequest ("AsignaIDDocTrib";"";"";$xBlob)
End if 
ARRAY LONGINT:C221(al_idsApoderados;0)

$0:=True:C214