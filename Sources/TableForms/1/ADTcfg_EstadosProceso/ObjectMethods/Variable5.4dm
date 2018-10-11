C_TEXT:C284($textEstado)
C_LONGINT:C283($refEstado)

$item:=Selected list items:C379(hl_Estados)
GET LIST ITEM:C378(hl_Estados;$item;$ref;$text;$sublist;$expanded)
$estadoTerm:=Num:C11(PREF_fGet (0;"estadoTerminalADT";"0"))
If ($ref=$estadoTerm)
	If ($ref<=-100)
		CD_Dlog (0;__ ("Se dispone a eliminar la situación final terminal. Una vez eliminada deberá seleccionar otro estado a situación final terminal."))
	Else 
		CD_Dlog (0;__ ("Se dispone a eliminar el estado terminal. Una vez eliminado deberá seleccionar otro estado o situación final terminal."))
	End if 
	vMsg:="El estado terminal no ha sido establecido."
	PREF_Set (0;"estadoTerminalADT";"0")
End if 
$estado:=List item parent:C633(hl_Estados;$ref)
READ ONLY:C145([ADT_Candidatos:49])
If ($ref<=-100)
	QUERY:C277([ADT_Candidatos:49];[ADT_Candidatos:49]ID_SitFinal:51=$ref)
Else 
	QUERY:C277([ADT_Candidatos:49];[ADT_Candidatos:49]ID_Estado:49=$ref)
End if 
CREATE SET:C116([ADT_Candidatos:49];"deleteCand")
$delete:=False:C215
If (Records in selection:C76([ADT_Candidatos:49])=0)
	$delete:=True:C214
Else 
	If ($ref<=-100)
		SELECT LIST ITEMS BY REFERENCE:C630(Self:C308->;$estado)
		GET LIST ITEM:C378(Self:C308->;*;$refEstado;$textEstado;$sublistEstado)
		$sitFinales:=Count list items:C380($sublistEstado)
		If ($sitFinales=1)
			$r:=CD_Dlog (0;__ ("Hay ")+String:C10(Records in selection:C76([ADT_Candidatos:49]))+__ (" candidato(s) con esta situación final. Si elimina la situación final, dichos candidatos pasarán a tener el estado al que pertenece la situación final.\r¿Desea proseguir?");__ ("");__ ("Si");__ ("No"))
		Else 
			$r:=CD_Dlog (0;__ ("Hay ")+String:C10(Records in selection:C76([ADT_Candidatos:49]))+__ (" candidato(s) con esta situación final. Si elimina la situación final, dichos candidatos pasarán a tener una situación final indeterminada.\r¿Desea proseguir?");__ ("");__ ("Si");__ ("No"))
		End if 
	Else 
		$r:=CD_Dlog (0;__ ("Hay ")+String:C10(Records in selection:C76([ADT_Candidatos:49]))+__ (" candidato(s) con este estado. Si elimina el estado dichos candidatos pasarán a tener un estado indeterminado.\r¿Desea proseguir?");__ ("");__ ("Si");__ ("No"))
	End if 
	If ($r=1)
		$delete:=True:C214
		READ WRITE:C146([ADT_Candidatos:49])
		USE SET:C118("deleteCand")
		$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;__ ("Cambiando estado a candidatos..."))
		While (Not:C34(End selection:C36([ADT_Candidatos:49])))
			CREATE RECORD:C68([xxADT_LogCambioEstado:162])
			[xxADT_LogCambioEstado:162]DTS:2:=DTS_MakeFromDateTime 
			[xxADT_LogCambioEstado:162]ID_Candidato:1:=[ADT_Candidatos:49]Candidato_numero:1
			[xxADT_LogCambioEstado:162]ID_Estado_Viejo:3:=[ADT_Candidatos:49]ID_Estado:49
			[xxADT_LogCambioEstado:162]ID_SitFinal_Viejo:6:=[ADT_Candidatos:49]ID_SitFinal:51
			If ($ref<=-100)
				[xxADT_LogCambioEstado:162]ID_Estado_Nuevo:4:=[ADT_Candidatos:49]ID_Estado:49
				If ($sitFinales=1)
					[xxADT_LogCambioEstado:162]ID_SitFinal_Nuevo:7:=[ADT_Candidatos:49]ID_Estado:49
					[ADT_Candidatos:49]ID_SitFinal:51:=[ADT_Candidatos:49]ID_Estado:49
					[ADT_Candidatos:49]Situación_final:16:=[ADT_Candidatos:49]Estado:52
				Else 
					[xxADT_LogCambioEstado:162]ID_SitFinal_Nuevo:7:=0
					[ADT_Candidatos:49]ID_SitFinal:51:=0
					[ADT_Candidatos:49]Situación_final:16:="Indeterminado"
				End if 
			Else 
				[xxADT_LogCambioEstado:162]ID_Estado_Nuevo:4:=0
				[xxADT_LogCambioEstado:162]ID_SitFinal_Nuevo:7:=[ADT_Candidatos:49]ID_SitFinal:51
				[ADT_Candidatos:49]ID_Estado:49:=0
				[ADT_Candidatos:49]ID_SitFinal:51:=0
				[ADT_Candidatos:49]Estado:52:="Indeterminado"
				[ADT_Candidatos:49]Situación_final:16:="Indeterminado"
			End if 
			[xxADT_LogCambioEstado:162]ID_Usuario:5:=USR_GetUserID 
			SAVE RECORD:C53([xxADT_LogCambioEstado:162])
			SAVE RECORD:C53([ADT_Candidatos:49])
			NEXT RECORD:C51([ADT_Candidatos:49])
			$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;Selected record number:C246([ADT_Candidatos:49])/Records in selection:C76([ADT_Candidatos:49]))
		End while 
		$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
		KRL_UnloadReadOnly (->[ADT_Candidatos:49])
	End if 
End if 
If ($delete)
	DELETE FROM LIST:C624(hl_Estados;$ref;*)
	If ($ref<=-100)
		SELECT LIST ITEMS BY REFERENCE:C630(hl_Estados;$estado)
		GET LIST ITEM:C378(hl_Estados;*;$estado;$text;$sublist)
		If (Count list items:C380($sublist)=0)
			SET LIST ITEM:C385(hl_Estados;$estado;$text;$estado;0;False:C215)
		End if 
	End if 
	_O_REDRAW LIST:C382(hl_Estados)
	_O_DISABLE BUTTON:C193(bDelEstado)
End if 
CLEAR SET:C117("deleteCand")