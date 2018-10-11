//%attributes = {}
  //RINSCwa_VerificaCargoDctoEmiti

C_TEXT:C284($t_setCargos)
C_OBJECT:C1216($ob_objetoConCargos)
C_LONGINT:C283($l_indice;$l_indice2)
C_DATE:C307($d_fecha;$d_fechaGen)
C_LONGINT:C283(vlACT_NumVerificacion)

READ ONLY:C145([Alumnos:2])
READ ONLY:C145([ACT_CuentasCorrientes:175])
READ ONLY:C145([ACT_Cargos:173])
READ ONLY:C145([ACT_Documentos_de_Cargo:174])

ARRAY TEXT:C222($atACT_CargosUUIDAl;0)
ARRAY LONGINT:C221($alACT_CargosIDACT;0)
ARRAY TEXT:C222($atACT_Montos;0)

vlACT_NumVerificacion:=vlACT_NumVerificacion+1

If (vlACT_NumVerificacion<10)
	<>tRINSC_debug:=<>tRINSC_debug+"Iteración de verificación de descuentos "+String:C10(vlACT_NumVerificacion)+"\r"
	
	$t_setCargos:=$1
	$ob_objetoConCargos:=$2
	$d_fecha:=$3
	
	OB GET ARRAY:C1229($ob_objetoConCargos;"uuidal";$atACT_CargosUUIDAl)
	OB GET ARRAY:C1229($ob_objetoConCargos;"idcargo";$alACT_CargosIDACT)
	OB GET ARRAY:C1229($ob_objetoConCargos;"montos";$atACT_Montos)
	
	  //Separo cargos y descuento
	ARRAY TEXT:C222($atACT_CargosUUIDAl_Dcto;0)
	ARRAY LONGINT:C221($alACT_CargosIDACT_Dcto;0)
	ARRAY TEXT:C222($atACT_Montos_Dcto;0)
	ARRAY LONGINT:C221($alACT_idCta_Dcto;0)
	
	ARRAY TEXT:C222($atACT_CargosUUIDAl_Cargo;0)
	ARRAY LONGINT:C221($alACT_CargosIDACT_Cargo;0)
	ARRAY TEXT:C222($atACT_Montos_Cargo;0)
	ARRAY LONGINT:C221($alACT_idCta_Cargo;0)
	
	For ($l_indice;1;Size of array:C274($atACT_CargosUUIDAl))
		KRL_FindAndLoadRecordByIndex (->[Alumnos:2]auto_uuid:72;->$atACT_CargosUUIDAl{$l_indice})
		KRL_FindAndLoadRecordByIndex (->[ACT_CuentasCorrientes:175]ID_Alumno:3;->[Alumnos:2]numero:1)
		If (Num:C11($atACT_Montos{$l_indice})<0)
			APPEND TO ARRAY:C911($atACT_CargosUUIDAl_Dcto;$atACT_CargosUUIDAl{$l_indice})
			APPEND TO ARRAY:C911($alACT_CargosIDACT_Dcto;$alACT_CargosIDACT{$l_indice})
			APPEND TO ARRAY:C911($atACT_Montos_Dcto;$atACT_Montos{$l_indice})
			APPEND TO ARRAY:C911($alACT_idCta_Dcto;[ACT_CuentasCorrientes:175]ID:1)
		Else 
			APPEND TO ARRAY:C911($atACT_CargosUUIDAl_Cargo;$atACT_CargosUUIDAl{$l_indice})
			APPEND TO ARRAY:C911($alACT_CargosIDACT_Cargo;$alACT_CargosIDACT{$l_indice})
			APPEND TO ARRAY:C911($atACT_Montos_Cargo;$atACT_Montos{$l_indice})
			APPEND TO ARRAY:C911($alACT_idCta_Cargo;[ACT_CuentasCorrientes:175]ID:1)
		End if 
	End for 
	<>tRINSC_debug:=<>tRINSC_debug+"Cargos separados en los arreglos\r"
	
	  //trabajo sobre cuentas unicas
	ARRAY TEXT:C222($atACT_CargosUUIDAl_Dcto_Unicos;0)
	COPY ARRAY:C226($atACT_CargosUUIDAl_Dcto;$atACT_CargosUUIDAl_Dcto_Unicos)
	AT_DistinctsArrayValues (->$atACT_CargosUUIDAl_Dcto_Unicos)
	
	If (Size of array:C274($atACT_CargosUUIDAl_Dcto_Unicos)>0)
		For ($l_indice;1;Size of array:C274($atACT_CargosUUIDAl_Dcto_Unicos))
			  //busco valores unicos de descuentos y cargos
			ARRAY LONGINT:C221($alACT_CargosIDDctos_Unicos;0)
			ARRAY REAL:C219($arACT_MontosDctos_Unicos;0)
			ARRAY LONGINT:C221($alACT_idCtaDctos_Unicos;0)
			
			ARRAY LONGINT:C221($alACT_CargosIDCargos_Unicos;0)
			ARRAY REAL:C219($arACT_MontosCargos_Unicos;0)
			
			ARRAY LONGINT:C221($DA_Return;0)
			$atACT_CargosUUIDAl_Dcto{0}:=$atACT_CargosUUIDAl_Dcto_Unicos{$l_indice}
			AT_SearchArray (->$atACT_CargosUUIDAl_Dcto;"=";->$DA_Return)
			For ($l_indice2;1;Size of array:C274($DA_Return))
				APPEND TO ARRAY:C911($alACT_CargosIDDctos_Unicos;$alACT_CargosIDACT_Dcto{$DA_Return{$l_indice2}})
				APPEND TO ARRAY:C911($arACT_MontosDctos_Unicos;Num:C11($atACT_Montos_Dcto{$DA_Return{$l_indice2}}))
				APPEND TO ARRAY:C911($alACT_idCtaDctos_Unicos;$alACT_idCta_Dcto{$DA_Return{$l_indice2}})
			End for 
			AT_DistinctsArrayValues (->$alACT_idCtaDctos_Unicos)
			
			ARRAY LONGINT:C221($alACT_CargosIDCargos_Unicos;0)
			ARRAY REAL:C219($arACT_MontosCargos_Unicos;0)
			ARRAY LONGINT:C221($DA_Return;0)
			$atACT_CargosUUIDAl_Cargo{0}:=$atACT_CargosUUIDAl_Dcto_Unicos{$l_indice}
			AT_SearchArray (->$atACT_CargosUUIDAl_Cargo;"=";->$DA_Return)
			For ($l_indice2;1;Size of array:C274($DA_Return))
				APPEND TO ARRAY:C911($alACT_CargosIDCargos_Unicos;$alACT_CargosIDACT_Cargo{$DA_Return{$l_indice2}})
				APPEND TO ARRAY:C911($arACT_MontosCargos_Unicos;Num:C11($atACT_Montos_Cargo{$DA_Return{$l_indice2}}))
			End for 
			
			  //verifico si montos de descuentos son menores o iguales a montos de cargos del mes
			USE SET:C118($t_setCargos)
			QUERY SELECTION WITH ARRAY:C1050([ACT_Cargos:173]Ref_Item:16;$alACT_CargosIDDctos_Unicos)
			QUERY SELECTION WITH ARRAY:C1050([ACT_Cargos:173]ID_CuentaCorriente:2;$alACT_idCtaDctos_Unicos)
			
			ARRAY DATE:C224($adACT_FechasDctos;0)
			ARRAY DATE:C224($adACT_FechasConProblemas;0)
			ARRAY LONGINT:C221($alACT_refIntesmDctos;0)
			SELECTION TO ARRAY:C260([ACT_Cargos:173]Ref_Item:16;$alACT_refIntesmDctos;[ACT_Cargos:173]Fecha_de_generacion:4;$adACT_FechasDctos)
			
			SORT ARRAY:C229($adACT_FechasDctos;$alACT_refIntesmDctos;>)
			C_REAL:C285($r_montoDctos;$r_montoCargosMes;$r_diferencia;$r_descuentosCargos)
			<>tRINSC_debug:=<>tRINSC_debug+"Fechas a verificar "+AT_array2text (->$adACT_FechasDctos;"; ")+"\r"
			For ($l_indice2;1;Size of array:C274($adACT_FechasDctos))
				USE SET:C118($t_setCargos)
				QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]Fecha_de_generacion:4=$adACT_FechasDctos{$l_indice2})
				QUERY SELECTION WITH ARRAY:C1050([ACT_Cargos:173]ID_CuentaCorriente:2;$alACT_idCtaDctos_Unicos)
				
				CREATE SET:C116([ACT_Cargos:173];"$setMes")
				
				For ($l_indiceEA;1;2)  //20171207 RCH No se consideraba si los descuentos eran afectos o exentos
					USE SET:C118("$setMes")
					QUERY SELECTION WITH ARRAY:C1050([ACT_Cargos:173]Ref_Item:16;$alACT_CargosIDDctos_Unicos)
					If ($l_indiceEA=1)
						QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]TasaIVA:21=0)
					Else 
						QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]TasaIVA:21>0)
					End if 
					If (Records in selection:C76([ACT_Cargos:173])>0)
						$r_montoDctos:=ACTcar_CalculaMontos ("redondeadoFromCurrentRecordsMPago";->[ACT_Cargos:173]Monto_Neto:5;->[ACT_Cargos:173]Monto_Neto:5;$d_fecha)
						
						USE SET:C118("$setMes")
						QUERY SELECTION WITH ARRAY:C1050([ACT_Cargos:173]Ref_Item:16;$alACT_CargosIDCargos_Unicos)
						
						If ($l_indiceEA=1)
							QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]TasaIVA:21=0)
						Else 
							QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]TasaIVA:21>0)
						End if 
						
						$r_montoCargosMes:=ACTcar_CalculaMontos ("redondeadoFromCurrentRecordsMPago";->[ACT_Cargos:173]Monto_Neto:5;->[ACT_Cargos:173]Monto_Neto:5;$d_fecha)
						
						  //resto posibles descuentos asociados calculados en lineas separadas
						ARRAY LONGINT:C221($al_idsCargos;0)
						SELECTION TO ARRAY:C260([ACT_Cargos:173]ID:1;$al_idsCargos)
						QUERY WITH ARRAY:C644([ACT_Cargos:173]ID_CargoRelacionado:47;$al_idsCargos)
						If (Records in selection:C76([ACT_Cargos:173])>0)
							$r_descuentosCargos:=Abs:C99(ACTcar_CalculaMontos ("redondeadoFromCurrentRecordsMPago";->[ACT_Cargos:173]Monto_Neto:5;->[ACT_Cargos:173]Monto_Neto:5;$d_fecha))
							$r_montoCargosMes:=$r_montoCargosMes-$r_descuentosCargos
						End if 
						
						If (Abs:C99($r_montoDctos)>Abs:C99($r_montoCargosMes))
							APPEND TO ARRAY:C911($adACT_FechasConProblemas;$adACT_FechasDctos{$l_indice2})
							<>tRINSC_debug:=<>tRINSC_debug+"Fecha con problemas "+String:C10($adACT_FechasDctos{$l_indice2})+". Monto descuentos: "+String:C10($r_montoDctos)+". Monto cargos: "+String:C10($r_montoCargosMes)+". Montos descuentos asociados: "+String:C10($r_descuentosCargos)+"\r"
						End if 
					End if 
				End for 
			End for 
			
			  //CORRIJO PROBLEMAS EN LOS MESES
			If (Size of array:C274($adACT_FechasConProblemas)>0)
				For ($l_indice2;1;Size of array:C274($adACT_FechasConProblemas))
					USE SET:C118($t_setCargos)
					QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]Fecha_de_generacion:4=$adACT_FechasConProblemas{$l_indice2})
					QUERY SELECTION WITH ARRAY:C1050([ACT_Cargos:173]ID_CuentaCorriente:2;$alACT_idCtaDctos_Unicos)
					CREATE SET:C116([ACT_Cargos:173];"$setMes")
					
					QUERY SELECTION WITH ARRAY:C1050([ACT_Cargos:173]Ref_Item:16;$alACT_CargosIDDctos_Unicos)
					CREATE SET:C116([ACT_Cargos:173];"$setDctosMes")
					
					For ($l_indiceEA;1;2)
						USE SET:C118("$setDctosMes")
						
						If ($l_indiceEA=1)
							QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]TasaIVA:21=0)
						Else 
							QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]TasaIVA:21>0)
						End if 
						If (Records in selection:C76([ACT_Cargos:173])>0)
							
							$r_montoDctos:=ACTcar_CalculaMontos ("redondeadoFromCurrentRecordsMPago";->[ACT_Cargos:173]Monto_Neto:5;->[ACT_Cargos:173]Monto_Neto:5;$d_fecha)
							ARRAY LONGINT:C221($alACT_RefItemDctos;0)
							SELECTION TO ARRAY:C260([ACT_Cargos:173]Ref_Item:16;$alACT_RefItemDctos)
							
							USE SET:C118("$setMes")
							QUERY SELECTION WITH ARRAY:C1050([ACT_Cargos:173]Ref_Item:16;$alACT_CargosIDCargos_Unicos)
							
							If ($l_indiceEA=1)
								QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]TasaIVA:21=0)
							Else 
								QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]TasaIVA:21>0)
							End if 
							
							$r_montoCargosMes:=ACTcar_CalculaMontos ("redondeadoFromCurrentRecordsMPago";->[ACT_Cargos:173]Monto_Neto:5;->[ACT_Cargos:173]Monto_Neto:5;$d_fecha)
							
							ARRAY LONGINT:C221($alACT_RefItemCargos;0)
							SELECTION TO ARRAY:C260([ACT_Cargos:173]Ref_Item:16;$alACT_RefItemCargos)
							
							  //resto posibles descuentos asociados calculados en lineas separadas
							ARRAY LONGINT:C221($al_idsCargos;0)
							SELECTION TO ARRAY:C260([ACT_Cargos:173]ID:1;$al_idsCargos)
							QUERY WITH ARRAY:C644([ACT_Cargos:173]ID_CargoRelacionado:47;$al_idsCargos)
							If (Records in selection:C76([ACT_Cargos:173])>0)
								$r_descuentosCargos:=Abs:C99(ACTcar_CalculaMontos ("redondeadoFromCurrentRecordsMPago";->[ACT_Cargos:173]Monto_Neto:5;->[ACT_Cargos:173]Monto_Neto:5;$d_fecha))
								$r_montoCargosMes:=$r_montoCargosMes-$r_descuentosCargos
							End if 
							
							If ((Abs:C99($r_montoDctos)>Abs:C99($r_montoCargosMes)) & (Size of array:C274($alACT_RefItemCargos)>0))
								
								$r_diferencia:=Abs:C99($r_montoDctos)-Abs:C99($r_montoCargosMes)
								  //cambio monto de cargos al maximo del mes
								READ WRITE:C146([ACT_Cargos:173])
								USE SET:C118("$setDctosMes")
								QUERY SELECTION BY FORMULA:C207([ACT_Cargos:173];Abs:C99([ACT_Cargos:173]Monto_Neto:5)>Abs:C99($r_diferencia))
								[ACT_Cargos:173]Monto_Neto:5:=[ACT_Cargos:173]Monto_Neto:5+$r_diferencia
								[ACT_Cargos:173]Monto_Moneda:9:=[ACT_Cargos:173]Monto_Neto:5
								[ACT_Cargos:173]Monto_Bruto:24:=[ACT_Cargos:173]Monto_Moneda:9
								<>tRINSC_debug:=<>tRINSC_debug+"Disminución de monto de descuento. Cambió de "+String:C10(Old:C35([ACT_Cargos:173]Monto_Neto:5))+" a "+String:C10([ACT_Cargos:173]Monto_Neto:5)+"\r"
								SAVE RECORD:C53([ACT_Cargos:173])
								$l_rec:=Record number:C243([ACT_Cargos:173])  //para duplicar
								
								  //genero cargo para periodo siguiente
								USE SET:C118($t_setCargos)
								QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]Ref_Item:16=$alACT_RefItemCargos{1};*)
								QUERY SELECTION:C341([ACT_Cargos:173]; & ;[ACT_Cargos:173]Fecha_de_generacion:4>$adACT_FechasConProblemas{$l_indice2})
								ORDER BY:C49([ACT_Cargos:173];[ACT_Cargos:173]Fecha_de_generacion:4;>)
								$d_fechaGen:=[ACT_Cargos:173]Fecha_de_generacion:4
								
								If ($d_fechaGen#!00-00-00!)
									KRL_GotoRecord (->[ACT_Cargos:173];$l_rec)
									QUERY:C277([ACT_Documentos_de_Cargo:174];[ACT_Documentos_de_Cargo:174]ID_Documento:1=[ACT_Cargos:173]ID_Documento_de_Cargo:3)
									DUPLICATE RECORD:C225([ACT_Documentos_de_Cargo:174])
									[ACT_Documentos_de_Cargo:174]FechaGeneracion:7:=$d_fechaGen
									[ACT_Documentos_de_Cargo:174]Año:14:=Year of:C25($d_fechaGen)
									[ACT_Documentos_de_Cargo:174]Mes:13:=Month of:C24($d_fechaGen)
									[ACT_Documentos_de_Cargo:174]ID_Documento:1:=0
									SAVE RECORD:C53([ACT_Documentos_de_Cargo:174])
									$l_idDctoCargo:=[ACT_Documentos_de_Cargo:174]ID_Documento:1
									
									KRL_GotoRecord (->[ACT_Cargos:173];$l_rec)
									DUPLICATE RECORD:C225([ACT_Cargos:173])
									[ACT_Cargos:173]Fecha_de_generacion:4:=$d_fechaGen
									[ACT_Cargos:173]Año:14:=Year of:C25($d_fechaGen)
									[ACT_Cargos:173]Mes:13:=Month of:C24($d_fechaGen)
									[ACT_Cargos:173]Monto_Neto:5:=Abs:C99($r_diferencia)*-1
									[ACT_Cargos:173]Monto_Moneda:9:=[ACT_Cargos:173]Monto_Neto:5
									[ACT_Cargos:173]Monto_Bruto:24:=[ACT_Cargos:173]Monto_Moneda:9
									[ACT_Cargos:173]ID_Documento_de_Cargo:3:=$l_idDctoCargo
									<>tRINSC_debug:=<>tRINSC_debug+"Descuento generado por un monto de "+String:C10([ACT_Cargos:173]Monto_Neto:5)+" para la fecha "+String:C10($d_fechaGen)+"\r"
									SAVE RECORD:C53([ACT_Cargos:173])
									ADD TO SET:C119([ACT_Cargos:173];$t_setCargos)
									
									READ ONLY:C145([ACT_Documentos_de_Cargo:174])
									KRL_GotoRecord (->[ACT_Cargos:173];$l_rec)
									QUERY:C277([ACT_Documentos_de_Cargo:174];[ACT_Documentos_de_Cargo:174]ID_Documento:1=[ACT_Cargos:173]ID_Documento_de_Cargo:3)
									ACTcc_CalculaDocumentoCargo (Record number:C243([ACT_Documentos_de_Cargo:174]))
									
									QUERY:C277([ACT_Documentos_de_Cargo:174];[ACT_Documentos_de_Cargo:174]ID_Documento:1=$l_idDctoCargo)
									ACTcc_CalculaDocumentoCargo (Record number:C243([ACT_Documentos_de_Cargo:174]))
								Else 
									<>tRINSC_debug:=<>tRINSC_debug+"Error: Fecha vacía: "+String:C10($d_fechaGen)+"\r"
								End if 
							Else 
								<>tRINSC_debug:=<>tRINSC_debug+"Error: Monto descuento: "+String:C10($r_montoDctos)+". Monto cargos: "+String:C10($r_montoCargosMes)+". Tamaño del arreglo: "+String:C10(Size of array:C274($alACT_RefItemCargos))+"\r"
							End if 
						End if 
					End for 
				End for 
				
				  //Vuelvo a verificar
				<>tRINSC_debug:=<>tRINSC_debug+"Llamado método verificación de montos\r"
				RINSCwa_VerificaCargoDctoEmiti ($t_setCargos;$ob_objetoConCargos;$d_fecha)
			End if 
		End for 
		
		
	End if 
	
	
	
End if 