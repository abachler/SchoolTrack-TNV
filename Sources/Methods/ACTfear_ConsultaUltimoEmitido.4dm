//%attributes = {}
  //ACTfear_ConsultaUltimoEmitido 

C_REAL:C285($r_records)
C_TEXT:C284($t_mensaje)

If (USR_GetMethodAcces ("ACTfear_ObtenerCodigoAutElect"))
	
	$r_records:=BWR_SearchRecords 
	
	If ($r_records#-1)
		READ ONLY:C145([ACT_Boletas:181])
		
		QUERY SELECTION:C341([ACT_Boletas:181];[ACT_Boletas:181]documento_electronico:29=True:C214;*)
		QUERY SELECTION:C341([ACT_Boletas:181]; & ;[ACT_Boletas:181]Nula:15=False:C215)
		
		If (Records in selection:C76([ACT_Boletas:181])>0)
			CREATE SET:C116([ACT_Boletas:181];"setBoletas")
			
			ARRAY LONGINT:C221($alACT_idsRS;0)
			DISTINCT VALUES:C339([ACT_Boletas:181]ID_RazonSocial:25;$alACT_idsRS)
			
			If (Find in array:C230($alACT_idsRS;0)>0)
				$alACT_idsRS{Find in array:C230($alACT_idsRS;0)}:=-1
			End if 
			
			For ($l_indice;1;Size of array:C274($alACT_idsRS))
				
				ACTfear_OpcionesGenerales ("CargaConf";->$alACT_idsRS{$l_indice})
				
				If (vtACT_errorPHPExec="")
					If (vtACT_workstation=Current machine:C483)
						ARRAY TEXT:C222($atACT_ArrayUnico;0)
						USE SET:C118("setBoletas")
						QUERY SELECTION:C341([ACT_Boletas:181];[ACT_Boletas:181]ID_RazonSocial:25=$alACT_idsRS{$l_indice})
						While (Not:C34(End selection:C36([ACT_Boletas:181])))
							APPEND TO ARRAY:C911($atACT_ArrayUnico;String:C10([ACT_Boletas:181]AR_CodigoPtoVenta:47)+"_"+[ACT_Boletas:181]codigo_SII:33)
							NEXT RECORD:C51([ACT_Boletas:181])
						End while 
						AT_DistinctsArrayValues (->$atACT_ArrayUnico)
						For ($l_indiceUnico;1;Size of array:C274($atACT_ArrayUnico))
							$l_puntoVenta:=Num:C11(ST_GetWord ($atACT_ArrayUnico{$l_indiceUnico};1;"_"))
							$l_cbteTipo:=Num:C11(ST_GetWord ($atACT_ArrayUnico{$l_indiceUnico};2;"_"))
							$t_mensaje:=$t_mensaje+ACTfear_FECompUltimoAutorizado ($alACT_idsRS{$l_indice};$l_puntoVenta;$l_cbteTipo)+"\r"
						End for 
					Else   //20170802 RCH
						$t_mensaje:=__ ("El computador no corresponde a lo configurado en las Facturas Electrónicas.")
					End if 
				End if 
			End for 
			CD_Dlog (0;$t_mensaje)
			SET_ClearSets ("setBoletas")
			
		Else 
			CD_Dlog (0;"No hay documentos electrónicos no nulos en la selección de documentos.")
		End if 
		
		
		
	Else 
		CD_Dlog (0;"Debe tener seleccionado algún documento en el explorador.")
	End if 
	
End if 