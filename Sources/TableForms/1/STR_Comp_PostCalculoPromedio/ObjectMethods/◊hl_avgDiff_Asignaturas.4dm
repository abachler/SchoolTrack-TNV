C_LONGINT:C283(<>hl_avgDiff_Alumnos;$recNumAsignatura)
C_TEXT:C284($nombreAsignatura)

Case of 
	: (Form event:C388=On Selection Change:K2:29)
		EV2_CambiosPostRecalculo ("SelectAsignatura")
		
	: (Form event:C388=On Double Clicked:K2:5)
		KRL_ReloadAsReadOnly (->[Asignaturas:18])
		$explorerProcessPos:=Find in array:C230(<>alXS_ModuleRef;1)
		If ($explorerProcessPos>0)
			GET LIST ITEM:C378(<>hl_avgDiff_Asignaturas;*;$recNumAsignatura;$nombreAsignatura)
			<>vl_IPMsg_OpenRecNum:=$recNumAsignatura
			<>vl_IPMsg_Tab2Select:=18
			<>vt_IPMsg_Message:="OpenRecord"
			BRING TO FRONT:C326(<>alXS_ModuleProcessID{$explorerProcessPos})
			POST OUTSIDE CALL:C329(<>alXS_ModuleProcessID{$explorerProcessPos})
		End if 
End case 