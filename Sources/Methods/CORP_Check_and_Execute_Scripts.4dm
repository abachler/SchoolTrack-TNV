//%attributes = {}
  //CORP_Check_and_Execute_Scripts
  //Revisa la frecuencia para ejecutar los script activos obtenidos desde la intranet

ARRAY LONGINT:C221($al_rec_num_script;0)
C_BOOLEAN:C305($vb_ejecutar)
C_LONGINT:C283($err;$p)
C_DATE:C307($vd_fecha)
ARRAY TEXT:C222($at_mes_dia;0)
READ ONLY:C145([CORP_Scripts:197])
QUERY:C277([CORP_Scripts:197];[CORP_Scripts:197]Activo:5=True:C214)
ORDER BY:C49([CORP_Scripts:197];[CORP_Scripts:197]Orden_de_Ejecucion:7;>)
LONGINT ARRAY FROM SELECTION:C647([CORP_Scripts:197];$al_rec_num_script;"")


$p:=IT_UThermometer (1;0;"Revisando y Ejecutando Scripts Corp.")

For ($i;1;Size of array:C274($al_rec_num_script))
	READ WRITE:C146([CORP_Scripts:197])
	GOTO RECORD:C242([CORP_Scripts:197];$al_rec_num_script{$i})
	
	If ([CORP_Scripts:197]DTS_GeneracionArchivo:4="")
		$vb_ejecutar:=True:C214
	Else 
		$vd_fecha:=DTS_GetDate ([CORP_Scripts:197]DTS_GeneracionArchivo:4)
		OB_GET ([CORP_Scripts:197]ExecutionDays:8;->$at_mes_dia;"arrayDays")
		$fia:=Find in array:C230($at_mes_dia;String:C10(Month of:C24(Current date:C33(*));"00")+"-"+String:C10(Day of:C23(Current date:C33(*))))
		If ($fia>0)
			$vb_ejecutar:=True:C214
		Else 
			$vb_ejecutar:=False:C215
		End if 
		
	End if 
	
	If ($vb_ejecutar)
		$t_error:=EXE_Execute ([CORP_Scripts:197]Script:2)
		If ($t_error="")
			[CORP_Scripts:197]DTS_GeneracionArchivo:4:=DTS_MakeFromDateTime 
			SAVE RECORD:C53([CORP_Scripts:197])
			LOG_RegisterEvt ("CORP script: ID("+String:C10([CORP_Scripts:197]ID_Script:1)+"), ejecutado exitosamente")
		Else 
			LOG_RegisterEvt ("CORP script: ID("+String:C10([CORP_Scripts:197]ID_Script:1)+"), con errores de ejecución:\r "+$t_error+"\r\r por favor deshabilitar el script hasta corregir el error")
		End if 
	End if 
	
	KRL_UnloadReadOnly (->[CORP_Scripts:197])
	
End for 
IT_UThermometer (-2;$p)
