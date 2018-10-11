//%attributes = {}
  //ACTac_CreaDTSPDF

C_BOOLEAN:C305($b_done;$0)
C_LONGINT:C283($l_idAC)
C_TEXT:C284($t_dts;$t_parametro)

$t_parametro:=$1

ST_Deconcatenate (";";$t_parametro;->$l_idAC;->$t_dts)
If ($l_idAC>0)
	KRL_FindAndLoadRecordByIndex (->[ACT_Avisos_de_Cobranza:124]ID_Aviso:1;->$l_idAC;True:C214)
	If (ok=1)
		If ([ACT_Avisos_de_Cobranza:124]DTS_GeneracionPDF:31="")
			[ACT_Avisos_de_Cobranza:124]DTS_GeneracionPDF:31:=$t_dts
			SAVE RECORD:C53([ACT_Avisos_de_Cobranza:124])
		End if 
		$b_done:=True:C214
	Else 
		If (Records in selection:C76([ACT_Avisos_de_Cobranza:124])=1)
			$b_done:=False:C215
		Else 
			$b_done:=True:C214
		End if 
	End if 
	KRL_UnloadReadOnly (->[ACT_Avisos_de_Cobranza:124])
Else 
	$b_done:=True:C214
End if 

$0:=$b_done