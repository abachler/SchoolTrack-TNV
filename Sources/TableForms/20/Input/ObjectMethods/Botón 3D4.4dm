START TRANSACTION:C239
vb_CalculoResultadoFinal:=False:C215
vb_CalculoEjes:=False:C215
vb_CalculoDimensiones:=False:C215
vb_RecalcularCalificaciones:=False:C215


If (Selected list items:C379(hl_configuraciones)>0)
	GET LIST ITEM:C378(hl_configuraciones;Selected list items:C379(hl_configuraciones);$recNum;$nombreMatriz)
	KRL_GotoRecord (->[MPA_AsignaturasMatrices:189];$recNum)
	
	C_LONGINT:C283(hl_PaginasOpciones)
	WDW_OpenFormWindow (->[MPA_AsignaturasMatrices:189];"OpcionesCalculos";-1;8;__ ("Opciones de cálculo para la Evaluación de Aprendizajes"))
	KRL_ModifyRecord (->[MPA_AsignaturasMatrices:189];"OpcionesCalculos")
	CLOSE WINDOW:C154
	If (OK=1)
		VALIDATE TRANSACTION:C240
		If (vb_CalculoResultadoFinal | vb_CalculoEjes | vb_CalculoDimensiones)
			MPA_Recalculos_Matriz ([MPA_AsignaturasMatrices:189]ID_Matriz:1;vb_CalculoResultadoFinal;vb_CalculoEjes;vb_CalculoDimensiones;True:C214)
		End if 
	Else 
		CANCEL TRANSACTION:C241
	End if 
	
Else 
	BEEP:C151
End if 
