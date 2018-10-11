//%attributes = {}
  //ACTfear_ObtenerCodigoAutElect
C_LONGINT:C283($l_resp)
READ ONLY:C145([ACT_Boletas:181])

If (USR_GetMethodAcces ("ACTfear_ObtenerCodigoAutElect"))
	
	QUERY:C277([ACT_Boletas:181];[ACT_Boletas:181]documento_electronico:29=True:C214;*)
	QUERY:C277([ACT_Boletas:181]; & ;[ACT_Boletas:181]AR_CAEcodigo:48="";*)
	QUERY:C277([ACT_Boletas:181]; & ;[ACT_Boletas:181]Nula:15=False:C215)
	
	  //If (Not(Is compiled mode))
	  //QUERY([ACT_Boletas];[ACT_Boletas]ID=20)
	  //End if 
	
	If (Records in selection:C76([ACT_Boletas:181])>0)
		$l_resp:=CD_Dlog (0;"Se obtendrá el Código de Autorización Electrónico para "+String:C10(Records in selection:C76([ACT_Boletas:181]))+" documento(s)."+"\r\r"+"¿Desea continuar?";"";"Si";"No")
		If ($l_resp=1)
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
						
						$l_idRS:=$alACT_idsRS{$l_indice}
						USE SET:C118("setBoletas")
						QUERY SELECTION:C341([ACT_Boletas:181];[ACT_Boletas:181]ID_RazonSocial:25=$l_idRS;*)
						If ($l_idRS=-1)
							QUERY SELECTION:C341([ACT_Boletas:181]; | ;[ACT_Boletas:181]ID_RazonSocial:25=0;*)
							  //Else //20161103 RCH
							  //QUERY([ACT_Boletas])
						End if 
						QUERY SELECTION:C341([ACT_Boletas:181])
						
						ORDER BY:C49([ACT_Boletas:181];[ACT_Boletas:181]Numero:11;>)
						
						SELECTION TO ARRAY:C260([ACT_Boletas:181]ID:1;$alACT_idsBoletas)
						
						$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;__ ("Obteniendo códigos de autorización electrónico..."))
						For ($l_indiceBoletas;1;Size of array:C274($alACT_idsBoletas))
							$b_hecho:=ACTfear_ObtieneCAE ($alACT_idsBoletas{$l_indiceBoletas})
							If (Not:C34($b_hecho))
								$l_indiceBoletas:=Size of array:C274($alACT_idsBoletas)
							End if 
							$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$l_indiceBoletas/Size of array:C274($alACT_idsBoletas))
						End for 
						$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
					Else 
						CD_Dlog (0;"El nombre de la máquina no coincide con la estación de trabajo configurada para la emisión de las facturas electrónicas. La estación configurada es: "+ST_Qte (vtACT_workstation)+".")
					End if 
				Else 
					CD_Dlog (0;"Error en la configuración de los documentos electrónicos. Error: "+vtACT_errorPHPExec)
				End if 
			End for 
			
		End if 
		SET_ClearSets ("setBoletas")
		
	End if 
	
End if 