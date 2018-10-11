//%attributes = {}
  //ACTiecv_enviaLibro
TRACE:C157
C_LONGINT:C283($1;$l_id;$l_proc)
C_LONGINT:C283($l_idIECV_dte;$l_espera)
C_TEXT:C284($vt_glosa)
C_BOOLEAN:C305($0;$b_respuestaObtenida)

$l_id:=$1

$l_proc:=IT_UThermometer (1;0;"Recibiendo id...")

KRL_FindAndLoadRecordByIndex (->[ACT_IECV:253]id:1;->$l_id;True:C214)
If (ok=1)
	$l_espera:=0
	
	$vl_Result:=WSact_GeneraLibrosContables ($vt_rut;$vt_file;"compra")
	
	While ((Not:C34([ACT_IECV:253]estado:14 ?? 2)) & ($l_espera<=15))
		$ok:=WSact_getFolioDTE ([ACT_IECV:253]id:1;->$l_idIECV_dte;->$vt_glosa;Choose:C955([ACT_IECV:253]tipo_operacion:5;"";"IEC";"IEV";"BOLETA";"GUIAS"))
		If (($l_idIECV_dte#0) | ($vt_glosa#""))
			[ACT_IECV:253]estado:14:=[ACT_IECV:253]estado:14 ?+ 2
			[ACT_IECV:253]id_iecv_dtenet:4:=$l_idIECV_dte
			[ACT_IECV:253]glosa_procesamiento_dtenet:12:=$vt_glosa
			If ($vt_glosa="OK Procesamiento TXT@")
				[ACT_IECV:253]estado:14:=[ACT_IECV:253]estado:14 ?+ 3
			End if 
			SAVE RECORD:C53([ACT_IECV:253])
			$b_respuestaObtenida:=True:C214
		End if 
		DELAY PROCESS:C323(Current process:C322;60)
		$l_espera:=$l_espera+1
	End while 
End if 
KRL_UnloadReadOnly (->[ACT_IECV:253])

IT_UThermometer (-2;$l_proc)

$0:=$b_respuestaObtenida