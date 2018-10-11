//%attributes = {}
  //ACTiecv_obtieneEstadoDesdeDTE 

  //obteniendo id asignado

C_LONGINT:C283($1;$l_id)
C_LONGINT:C283($l_idIECV_dte;$l_espera)
C_TEXT:C284($vt_glosa)
C_BOOLEAN:C305($0;$b_respuesta)

$l_id:=$1

KRL_FindAndLoadRecordByIndex (->[ACT_IECV:253]id:1;->$l_id;True:C214)
If (ok=1)
	
	If ((vlWS_folioDTE#0) | (vtWS_glosa#""))
		[ACT_IECV:253]estado:14:=[ACT_IECV:253]estado:14 ?+ 2
		[ACT_IECV:253]id_iecv_dtenet:4:=vlWS_folioDTE
		[ACT_IECV:253]glosa_procesamiento_dtenet:12:=vtWS_glosa
		If (vtWS_glosa="OK Procesamiento TXT@")
			[ACT_IECV:253]estado:14:=[ACT_IECV:253]estado:14 ?+ 3
		End if 
	Else 
		[ACT_IECV:253]glosa_procesamiento_dtenet:12:=vtWS_glosa
	End if 
	SAVE RECORD:C53([ACT_IECV:253])
	$b_respuesta:=True:C214
End if 
KRL_UnloadReadOnly (->[ACT_IECV:253])

$0:=$b_respuesta