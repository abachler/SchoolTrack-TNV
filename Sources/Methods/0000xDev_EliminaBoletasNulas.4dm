//%attributes = {}
  //0000xDev_EliminaBoletasNulas

C_LONGINT:C283($found;$r;$del)
If (Table:C252(yBWR_CurrentTable)=Table:C252(->[ACT_Boletas:181]))
	ARRAY LONGINT:C221($al_idsBol;0)
	READ WRITE:C146([ACT_Boletas:181])
	$found:=BWR_SearchRecords 
	If ($found#-1)
		QUERY SELECTION:C341([ACT_Boletas:181];[ACT_Boletas:181]ID_Estado:20=4)
		If (Records in selection:C76([ACT_Boletas:181])>0)
			  //$r:=CD_Dlog (0;__ ("La eliminación de Documentos Tributarios nulos no toma en cuenta el motivo de la anulación y es irreversible.\r¿Desea continuar?");"";__ ("Si");__ ("No"))
			$r:=CD_Dlog (0;__ ("La eliminación de Documentos Tributarios nulos no toma en cuenta el motivo de la anulación y es irreversible.\r¿Desea continuar?")+"\r\r"+"Se eliminará(n) "+String:C10(Records in selection:C76([ACT_Boletas:181]))+" Documento(s) Tributario(s).";"";__ ("Si");__ ("No"))
			If ($r=1)
				SELECTION TO ARRAY:C260([ACT_Boletas:181]ID:1;$al_idsBol)
				$del:=KRL_DeleteSelection (->[ACT_Boletas:181];True:C214;__ ("Eliminando Documentos Tributarios nulos..."))
				If ($del=0)
					CD_Dlog (0;__ ("La selección  no pudo ser eliminada."))
				Else 
					LOG_RegisterEvt ("Eliminación de documentos tributarios número: "+AT_array2text (->$al_idsBol;"-";"############")+".")
				End if 
				POST KEY:C465(-96)
			End if 
		Else 
			CD_Dlog (0;__ ("No hay Documentos Tributarios nulos entre los seleccionados."))
		End if 
		KRL_UnloadReadOnly (->[ACT_Boletas:181])
	Else 
		CD_Dlog (0;__ ("Primero debe seleccionar los Documentos Tributarios nulos que desea eliminar."))
	End if 
Else 
	CD_Dlog (0;__ ("Este comando sólo puede ser ejecutado desde la lengueta Documentos Tributarios."))
End if 