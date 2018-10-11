//%attributes = {}
  // MPAmtx_OpcionesCalculo()
  // Por: Alberto Bachler K.: 12-06-15, 11:00:44
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_LONGINT:C283($l_recNumMatriz)
C_POINTER:C301($y_matrizRecNum)
C_LONGINT:C283(hl_PaginasOpciones)


START TRANSACTION:C239
vb_CalculoResultadoFinal:=False:C215
vb_CalculoEjes:=False:C215
vb_CalculoDimensiones:=False:C215
vb_RecalcularCalificaciones:=False:C215
$y_matrizRecNum:=OBJECT Get pointer:C1124(Object named:K67:5;"matrizRecNum")
$l_recNumMatriz:=$y_matrizRecNum->{$y_matrizRecNum->}

If ($l_recNumMatriz>No current record:K29:2)
	KRL_GotoRecord (->[MPA_AsignaturasMatrices:189];$l_recNumMatriz)
	
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


