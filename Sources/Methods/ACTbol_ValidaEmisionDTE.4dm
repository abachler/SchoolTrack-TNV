//%attributes = {}
  //ACTbol_ValidaEmisionDTE
C_TEXT:C284($1;$2)
C_TEXT:C284($t_accion;$t_parametro)
C_BOOLEAN:C305($b_continuar;$0)
C_TEXT:C284($t_direccion;$t_comuna;$t_ciudad;$t_rut;$t_nacionalidad)
C_LONGINT:C283($l_id;$l_emisorDTE)

$t_accion:=$1
If (Count parameters:C259>=2)
	$t_parametro:=$2
End if 

If (<>gCountryCode="cl")
	
	SET QUERY DESTINATION:C396(Into variable:K19:4;$l_emisorDTE)
	QUERY:C277([ACT_RazonesSociales:279];[ACT_RazonesSociales:279]emisor_electronico:30=True:C214)
	SET QUERY DESTINATION:C396(Into current selection:K19:1)
	
	If ($l_emisorDTE>0)
		Case of 
			: ($t_accion="avisos")
				USE SET:C118($t_parametro)
				
				While (Not:C34(End selection:C36([ACT_Avisos_de_Cobranza:124])))
					
					  //20150203 RCH Verifico según lo configurado por razon social
					READ ONLY:C145([ACT_Documentos_de_Cargo:174])
					READ ONLY:C145([ACT_Cargos:173])
					ARRAY LONGINT:C221($alACT_idsRS;0)
					C_LONGINT:C283($l_pos;$l_pos2;$l_indice)
					
					QUERY:C277([ACT_Documentos_de_Cargo:174];[ACT_Documentos_de_Cargo:174]No_ComprobanteInterno:15=[ACT_Avisos_de_Cobranza:124]ID_Aviso:1)
					KRL_RelateSelection (->[ACT_Cargos:173]ID_Documento_de_Cargo:3;->[ACT_Documentos_de_Cargo:174]ID_Documento:1;"")
					DISTINCT VALUES:C339([ACT_Cargos:173]ID_RazonSocial:57;$alACT_idsRS)
					$l_pos:=Find in array:C230($alACT_idsRS;0)
					$l_pos2:=Find in array:C230($alACT_idsRS;-1)
					If ($l_pos>0)
						If ($l_pos2=-1)
							APPEND TO ARRAY:C911($alACT_idsRS;-1)
						End if 
						AT_Delete ($l_pos;1;->$alACT_idsRS)
					End if 
					For ($l_indice;1;Size of array:C274($alACT_idsRS))
						
						ACTcfdi_OpcionesGenerales ("OnLoadConf";->$alACT_idsRS{$l_indice})
						ACTdte_OpcionesManeja ("LeeBlob";->$alACT_idsRS{$l_indice})
						If ((cs_emitirCFDI=1) & (at_proveedores{at_proveedores}="Colegium") & (r_verificarDirecciones=1))
							If ([ACT_Avisos_de_Cobranza:124]ID_Apoderado:3#0)
								$b_continuar:=ACTbol_ValidaEmisionDTE ("idApoderado";String:C10([ACT_Avisos_de_Cobranza:124]ID_Apoderado:3))
							Else 
								If ([ACT_Avisos_de_Cobranza:124]ID_Tercero:26#0)
									$b_continuar:=ACTbol_ValidaEmisionDTE ("idTercero";String:C10([ACT_Avisos_de_Cobranza:124]ID_Tercero:26))
								End if 
							End if 
							
						Else 
							$b_continuar:=True:C214
						End if 
						
					End for 
					
					If (Not:C34($b_continuar))
						ACTbol_ValidaEmisionDTE ("muestraMensaje")
						LAST RECORD:C200([ACT_Avisos_de_Cobranza:124])
					End if 
					NEXT RECORD:C51([ACT_Avisos_de_Cobranza:124])
				End while 
				
			: ($t_accion="pagos")
				
				USE SET:C118($t_parametro)
				
				While (Not:C34(End selection:C36([ACT_Pagos:172])))
					
					  //20150203 RCH Verifico según lo configurado por razon social
					  //READ ONLY([ACT_Documentos_de_Cargo])
					READ ONLY:C145([ACT_Transacciones:178])  //20150514 RCH Se corrige error en busqueda de cargos
					READ ONLY:C145([ACT_Cargos:173])
					ARRAY LONGINT:C221($alACT_idsRS;0)
					C_LONGINT:C283($l_pos;$l_pos2;$l_indice)
					
					QUERY:C277([ACT_Transacciones:178];[ACT_Transacciones:178]ID_Pago:4=[ACT_Pagos:172]ID:1)
					KRL_RelateSelection (->[ACT_Cargos:173]ID:1;->[ACT_Transacciones:178]ID_Item:3;"")
					DISTINCT VALUES:C339([ACT_Cargos:173]ID_RazonSocial:57;$alACT_idsRS)
					$l_pos:=Find in array:C230($alACT_idsRS;0)
					$l_pos2:=Find in array:C230($alACT_idsRS;-1)
					If ($l_pos>0)
						If ($l_pos2=-1)
							APPEND TO ARRAY:C911($alACT_idsRS;-1)
						Else 
							AT_Delete ($l_pos;1;->$alACT_idsRS)
						End if 
					End if 
					For ($l_indice;1;Size of array:C274($alACT_idsRS))
						ACTcfdi_OpcionesGenerales ("OnLoadConf";->$alACT_idsRS{$l_indice})
						ACTdte_OpcionesManeja ("LeeBlob";->$alACT_idsRS{$l_indice})
						If ((cs_emitirCFDI=1) & (at_proveedores{at_proveedores}="Colegium") & (r_verificarDirecciones=1))
							
							If ([ACT_Pagos:172]ID_Apoderado:3#0)
								$b_continuar:=ACTbol_ValidaEmisionDTE ("idApoderado";String:C10([ACT_Pagos:172]ID_Apoderado:3))
							Else 
								If ([ACT_Pagos:172]ID_Tercero:26#0)
									  //20150924 RCH
									  //$b_continuar:=ACTbol_ValidaEmisionDTE ("idTercero";String([ACT_Avisos_de_Cobranza]ID_Tercero))
									$b_continuar:=ACTbol_ValidaEmisionDTE ("idTercero";String:C10([ACT_Pagos:172]ID_Tercero:26))
								End if 
							End if 
						Else 
							$b_continuar:=True:C214
						End if 
					End for 
					
					If (Not:C34($b_continuar))
						ACTbol_ValidaEmisionDTE ("muestraMensaje")
						LAST RECORD:C200([ACT_Pagos:172])
					End if 
					NEXT RECORD:C51([ACT_Pagos:172])
				End while 
				
			: ($t_accion="idApoderado")
				$l_id:=Num:C11($t_parametro)
				$t_direccion:=KRL_GetTextFieldData (->[Personas:7]No:1;->$l_id;->[Personas:7]Direccion:14)
				$t_comuna:=KRL_GetTextFieldData (->[Personas:7]No:1;->$l_id;->[Personas:7]Comuna:16)
				$t_ciudad:=KRL_GetTextFieldData (->[Personas:7]No:1;->$l_id;->[Personas:7]Ciudad:17)
				$t_rut:=KRL_GetTextFieldData (->[Personas:7]No:1;->$l_id;->[Personas:7]RUT:6)
				$t_nacionalidad:=KRL_GetTextFieldData (->[Personas:7]No:1;->$l_id;->[Personas:7]Nacionalidad:7)  //20150122 RCH Cuando no es chileno no se puede validar que tenga rut
				If (($t_nacionalidad#"Chilena") & ($t_rut=""))
					$t_rut:="-"
				End if 
				If (($t_direccion#"") & ($t_comuna#"") & ($t_ciudad#"") & ($t_rut#""))
					$b_continuar:=True:C214
				End if 
				
			: ($t_accion="idTercero")
				$l_id:=Num:C11($t_parametro)
				$t_direccion:=KRL_GetTextFieldData (->[ACT_Terceros:138]Id:1;->$l_id;->[ACT_Terceros:138]Direccion:5)
				$t_comuna:=KRL_GetTextFieldData (->[ACT_Terceros:138]Id:1;->$l_id;->[ACT_Terceros:138]Comuna:6)
				$t_ciudad:=KRL_GetTextFieldData (->[ACT_Terceros:138]Id:1;->$l_id;->[ACT_Terceros:138]Ciudad:7)
				$t_rut:=KRL_GetTextFieldData (->[ACT_Terceros:138]Id:1;->$l_id;->[ACT_Terceros:138]RUT:4)
				$t_nacionalidad:=KRL_GetTextFieldData (->[ACT_Terceros:138]Id:1;->$l_id;->[ACT_Terceros:138]Nacionalidad:27)  //20150122 RCH Cuando no es chileno no se puede validar que tenga rut
				If (($t_nacionalidad#"Chilena") & ($t_rut=""))
					$t_rut:="-"
				End if 
				If (($t_direccion#"") & ($t_comuna#"") & ($t_ciudad#"") & ($t_rut#""))
					$b_continuar:=True:C214
				End if 
				
			: ($t_accion="muestraMensaje")
				CD_Dlog (0;__ ("Hay apoderados que no tienen dirección y/o comuna y/o ciudad ingresada. Antes de continuar complete esos datos."))
				
				
		End case 
	Else 
		$b_continuar:=True:C214  //si no hay emisores electrónicos, se coontinúa sin validar
	End if 
Else 
	$b_continuar:=True:C214
End if 



$0:=$b_continuar