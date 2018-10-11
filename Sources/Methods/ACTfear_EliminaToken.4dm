//%attributes = {}
  //ACTfear_EliminaToken
  //Script para ser usado para limpiar las credenciales que puedan estar vigentes. Por ejemplo si hay un error de tocken o verificación de hash se puede usar esto.
C_LONGINT:C283($l_recs;$l_indice)
C_TEXT:C284($t_ws;$t_nomPref)
ARRAY LONGINT:C221($alACT_idRS;0)

$l_recs:=BWR_SearchRecords 

If ($l_recs>0)
	READ ONLY:C145([ACT_RazonesSociales:279])
	KRL_RelateSelection (->[ACT_RazonesSociales:279]id:1;->[ACT_Boletas:181]ID_RazonSocial:25;"")
	SELECTION TO ARRAY:C260([ACT_RazonesSociales:279]id:1;$alACT_idRS)
	
	For ($l_indice;1;Size of array:C274($alACT_idRS))
		ACTfear_OpcionesGenerales ("CargaConf";->$alACT_idRS{$l_indice})
		$t_ws:="wsfe"
		$t_nomPref:=ACTfear_OpcionesGenerales ("ObtieneNombrePreferencia";->$alACT_idRS{$l_indice};->$t_ws)
		READ WRITE:C146([xShell_Prefs:46])
		
		QUERY:C277([xShell_Prefs:46];[xShell_Prefs:46]User:9=0;*)
		QUERY:C277([xShell_Prefs:46]; & [xShell_Prefs:46]Reference:1=$t_nomPref)
		If (Records in selection:C76([xShell_Prefs:46])=1)
			If (Not:C34(Locked:C147([xShell_Prefs:46])))
				DELETE RECORD:C58([xShell_Prefs:46])
				CD_Dlog (0;"El fue ejecutado con éxito.")
			Else 
				CD_Dlog (0;"El script no pudo ser ejecutado debido a que el registro está en uso.")
			End if 
		Else 
			CD_Dlog (0;"El script no pudo ser ejecutado debido a que no se encontró el registro.")
		End if 
		KRL_UnloadReadOnly (->[xShell_Prefs:46])
	End for 
End if 