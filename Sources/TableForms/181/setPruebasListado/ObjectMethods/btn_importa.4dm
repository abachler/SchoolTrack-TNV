  //lee archivo
C_TEXT:C284($t_ruta)
C_LONGINT:C283($l_resp)
If (Is compiled mode:C492)
	$l_resp:=CD_Dlog (0;"A continuación debe seleccionar el archivo con el set de prueba DTE recibido para el colegio."+"\r\r"+"Luego deberá seleccionar el archivo base con los casos DTE (Primero se debe realizar el set básico si es que hay)"+"\r\r"+"¿Desea continuar?";"";"Si";"No")
	If ($l_resp=1)
		$t_ruta:=xfGetFileName ("Seleccione el set de prueba")
	End if 
Else 
	C_TEXT:C284(<>tACT_rutaSet)
	If (<>tACT_rutaSet="")
		<>tACT_rutaSet:=xfGetFileName ("Seleccione el set de prueba")
	End if 
	$t_ruta:=<>tACT_rutaSet
End if 

ARRAY TEXT:C222($atACT_casos;0)
ARRAY LONGINT:C221($l_idsTercerosOrg;0)
ARRAY LONGINT:C221($l_idsTercerosNew;0)

$vb_continuar:=True:C214
$b_mensajeCompletaInfoTer:=False:C215
If ($t_ruta#"")
	
	ACTdte_setPruebasOpcionesGen ("InitVars")
	
	ARRAY TEXT:C222(atACT_archivo;0)
	C_TEXT:C284($t_numeroDeCaso)
	
	  //Primero se elije que certificar
	ARRAY TEXT:C222(atACT_setDisponibles;0)
	ARRAY TEXT:C222(atACT_setDisponiblesApp;0)
	
	APPEND TO ARRAY:C911(atACT_setDisponibles;"SET BÁSICO - NUMERO DE ATENCION:")
	APPEND TO ARRAY:C911(atACT_setDisponibles;"SET FACTURA EXENTA - NUMERO DE ATENCION:")
	
	USE CHARACTER SET:C205("Windows-1252";1)
	
	$delimiter:=ACTabc_DetectDelimiter ($t_ruta)
	$ref:=Open document:C264($t_ruta;"";Read mode:K24:5)
	RECEIVE PACKET:C104($ref;$text;$delimiter)
	While ($text#"")
		APPEND TO ARRAY:C911(atACT_archivo;$text)
		
		
		
		$t_linea:=ST_GetWord ($text;1;"\t")
		For ($i;1;Size of array:C274(atACT_setDisponibles))
			$pos:=Position:C15(atACT_setDisponibles{$i};$t_linea)
			If ($pos>0)
				APPEND TO ARRAY:C911(atACT_setDisponiblesApp;atACT_setDisponibles{$i})
			End if 
		End for 
		
		RECEIVE PACKET:C104($ref;$text;$delimiter)
		$l_contador:=1
		While ((Length:C16($text)=0) & ($l_contador<=10))
			RECEIVE PACKET:C104($ref;$text;$delimiter)
			$l_contador:=$l_contador+1
		End while 
	End while 
	CLOSE DOCUMENT:C267($ref)
	
	USE CHARACTER SET:C205(*;1)
	
	
	
	  //For ($l_indice;1;Size of array(atACT_setDisponiblesApp))
	
	$vt_numCaso:=""
	$b_setAfecto:=False:C215
	$b_setExento:=False:C215
	$t_textoAfecto:=""
	$t_textoExento:=""
	$t_textoAProcesar:=""
	  //busco numero de caso
	For ($l_indiceLineas;1;Size of array:C274(atACT_archivo))
		$t_linea:=atACT_archivo{$l_indiceLineas}
		If (Position:C15("SET BÁSICO - NUMERO DE ATENCION:";$t_linea)>0)
			$b_setAfecto:=True:C214
			$t_textoAfecto:="SET BÁSICO - NUMERO DE ATENCION:"
		End if 
		If (Position:C15("SET FACTURA EXENTA - NUMERO DE ATENCION:";$t_linea)>0)
			$b_setExento:=True:C214
			$t_textoExento:="SET FACTURA EXENTA - NUMERO DE ATENCION:"
		End if 
	End for 
	
	$b_continuar:=True:C214
	Case of 
		: (($b_setAfecto) & ($b_setExento))
			$l_resp:=CD_Dlog (0;"El set leído tiene set básico y set exento. ¿Cuál set desea procesar ahora?"+"\r\r"+"Recuerde que debe tener aprobado el SET BÁSICO ANTES de procesar el SET DE FACTURA EXENTA.";"";"SET BÁSICO";"SET EXENTO";"Cancelar")
			If ($l_resp=3)
				$b_continuar:=False:C215
			Else 
				If ($l_resp=1)
					$b_setAfecto:=True:C214
					$b_setExento:=False:C215
					$t_textoAProcesar:=$t_textoAfecto
				Else 
					$b_setAfecto:=False:C215
					$b_setExento:=True:C214
					$t_textoAProcesar:=$t_textoExento
				End if 
			End if 
		: ($b_setExento)
			$b_setAfecto:=False:C215
			$b_setExento:=True:C214
			$t_textoAProcesar:=$t_textoExento
		: ($b_setAfecto)
			$b_setAfecto:=True:C214
			$b_setExento:=False:C215
			$t_textoAProcesar:=$t_textoAfecto
	End case 
	
	If ($b_continuar)
		$t_RutaDocumento:=xfGetFileName ("Seleccione el set "+Choose:C955($b_setAfecto;"SET AFECTO";"SET EXENTO")+".")
		If ($t_RutaDocumento#"")
			
			  //busco numero de caso
			For ($l_indiceLineas;1;Size of array:C274(atACT_archivo))
				$t_linea:=atACT_archivo{$l_indiceLineas}
				$pos:=Position:C15($t_textoAProcesar;$t_linea)
				If ($pos>0)
					$vt_numCaso:=String:C10(Num:C11(Replace string:C233($t_linea;$t_textoAProcesar;"")))
					$l_indiceLineas:=Size of array:C274(atACT_archivo)
				End if 
			End for 
			
			  //importar casos
			
			C_LONGINT:C283($i;$j;$l_numeroTabla;$l_numeroTablas;$l_registros)
			C_POINTER:C301($y_Tabla)
			C_TEXT:C284($t_RutaDocumento;$t_nombreTabla)
			C_TEXT:C284($t_casos)
			
			SET CHANNEL:C77(10;$t_RutaDocumento)
			
			If (ok=1)
				RECEIVE VARIABLE:C81($l_numeroTablas)
				For ($j;1;$l_numeroTablas)
					RECEIVE VARIABLE:C81($l_numeroTabla)
					RECEIVE VARIABLE:C81($t_nombreTabla)
					RECEIVE VARIABLE:C81($l_registros)
					RECEIVE VARIABLE:C81($t_casos)
					
					If ($t_casos#"")
						AT_Text2Array (->$atACT_casos;$t_casos)
					End if 
					
					$y_Tabla:=Table:C252($l_numeroTabla)
					
					If ($t_nombreTabla=Table name:C256($l_numeroTabla))
						$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;__ ("Importando registros en el archivo ")+$t_nombreTabla)
						For ($i;1;$l_registros)
							$b_importar:=True:C214
							RECEIVE RECORD:C79($y_Tabla->)
							
							Case of 
								: (Table:C252($y_Tabla)=Table:C252(->[ACT_Terceros:138]))
									$l_idTercero:=[ACT_Terceros:138]Id:1
									$t_rut:=[ACT_Terceros:138]RUT:4
									APPEND TO ARRAY:C911($l_idsTercerosOrg;$l_idTercero)
									
									If (Find in field:C653([ACT_Terceros:138]RUT:4;$t_rut)>=0)
										KRL_FindAndLoadRecordByIndex (->[ACT_Terceros:138]RUT:4;->$t_rut)
										$l_idTercero:=[ACT_Terceros:138]Id:1
										$b_importar:=False:C215
										If (([ACT_Terceros:138]Nombre_Completo:9="") | ([ACT_Terceros:138]Direccion:5="") | ([ACT_Terceros:138]Comuna:6=""))
											$b_mensajeCompletaInfoTer:=True:C214
										End if 
									Else 
										While (Find in field:C653([ACT_Terceros:138]Id:1;$l_idTercero)>=0)
											$l_idTercero:=SQ_SeqNumber (->[ACT_Terceros:138]Id:1)
										End while 
										[ACT_Terceros:138]Id:1:=$l_idTercero
									End if 
									
									APPEND TO ARRAY:C911($l_idsTercerosNew;$l_idTercero)
							End case 
							If ($b_importar)
								SAVE RECORD:C53($y_Tabla->)
							End if 
							$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$i/$l_registros)
						End for 
						$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
					Else 
						ALERT:C41("Los datos exportados no corresponden al archivo que debe recibirlos")
						$j:=$l_numeroTablas
					End if 
				End for 
			End if 
			
			
			
			  //actualizar valores
			ARRAY TEXT:C222($atACT_CasosRefLinea;0)
			ARRAY REAL:C219($arACT_CasosCantidad;0)
			ARRAY REAL:C219($arACT_CasosValores;0)
			ARRAY REAL:C219($arACT_CasosDescuentos;0)
			
			For ($l_indiceCasos;1;Size of array:C274($atACT_casos))
				
				  //Cambio valores
				$vt_pref:=$atACT_casos{$l_indiceCasos}
				$vt_casoOrg:=ST_GetWord ($atACT_casos{$l_indiceCasos};4;"_")
				
				ACTdte_setPruebasOpcionesGen ("DesarmaBlob";->$vt_pref)
				vt_numeroAtencion:=Replace string:C233(vt_numeroAtencion;$vt_casoOrg;$vt_numCaso)
				vt_descripcionAtencion:=Replace string:C233(vt_descripcionAtencion;$vt_casoOrg;$vt_numCaso)
				vt_variableCaso:=Replace string:C233(vt_variableCaso;$vt_casoOrg;$vt_numCaso)
				vt_referencia:=Replace string:C233(vt_referencia;$vt_casoOrg;$vt_numCaso)
				vlACT_idBoleta:=0
				$l_existe:=Find in array:C230($l_idsTercerosOrg;vlACT_terceroID)
				If ($l_existe>0)
					vlACT_terceroID:=$l_idsTercerosNew{$l_existe}
				Else 
					
				End if 
				
				ARRAY TEXT:C222($atACT_Text;0)
				ACTdte_setPruebasOpcionesGen ("CargaReferencias";->$atACT_Text)
				ARRAY TEXT:C222($atACT_Caso2;0)
				For ($j;1;Size of array:C274($atACT_Text))
					APPEND TO ARRAY:C911($atACT_Caso2;ST_GetWord ($atACT_Text{$j};6;"_"))
				End for 
				
				
				COPY ARRAY:C226($atACT_Caso2;atACT_Caso2)
				If (vt_referencia="")
					atACT_Caso2:=0
				Else 
					atACT_Caso2:=Find in array:C230(atACT_Caso2;vt_referencia)
				End if 
				
				  //actualiza valores de lineas
				  //atACT_item;->abACT_afecto;->arACT_cantidad;->arACT_valorUnitario;->arACT_descuento;->arACT_total;->atACT_unidadMedida)
				For ($l_indiceLineas;1;Size of array:C274(atACT_archivo))
					$t_linea:=atACT_archivo{$l_indiceLineas}
					If (Position:C15(vt_variableCaso;$t_linea)>0)
						$l_numCaso:=Num:C11(Substring:C12(vt_variableCaso;Position:C15("-";vt_variableCaso)+1;Length:C16(vt_variableCaso)))
						If ($b_setExento)
							Case of 
								: ($l_numCaso=1)
									$t_linea:=atACT_archivo{$l_indiceLineas+4}
									$l_linea:=1
									arACT_cantidad{$l_linea}:=Num:C11(ST_GetWord ($t_linea;2;"\t"))
									arACT_valorUnitario{$l_linea}:=Num:C11(ST_GetWord ($t_linea;6;"\t"))
									ACTdte_setPruebasOpcionesGen ("CalculalineasYTotales";->$l_linea)
									
									APPEND TO ARRAY:C911($atACT_CasosRefLinea;vt_variableCaso+"_"+String:C10($l_linea))
									APPEND TO ARRAY:C911($arACT_CasosCantidad;arACT_cantidad{$l_linea})
									APPEND TO ARRAY:C911($arACT_CasosValores;arACT_valorUnitario{$l_linea})
									
								: ($l_numCaso=2)
									$t_linea:=atACT_archivo{$l_indiceLineas+6}
									$l_linea:=1
									arACT_valorUnitario{$l_linea}:=Num:C11(ST_GetWord ($t_linea;2;"\t"))
									
									$t_ref:=vt_numeroAtencion+"-1"+"_"+String:C10($l_linea)
									$l_pos:=Find in array:C230($atACT_CasosRefLinea;$t_ref)
									If ($l_pos>0)
										arACT_cantidad{$l_linea}:=$arACT_CasosCantidad{$l_pos}
									End if 
									
									ACTdte_setPruebasOpcionesGen ("CalculalineasYTotales";->$l_linea)
									
								: ($l_numCaso=3)
									$t_linea:=atACT_archivo{$l_indiceLineas+4}
									$l_linea:=1
									arACT_cantidad{$l_linea}:=Num:C11(ST_GetWord ($t_linea;2;"\t"))
									arACT_valorUnitario{$l_linea}:=Num:C11(ST_GetWord ($t_linea;4;"\t"))
									ACTdte_setPruebasOpcionesGen ("Calculalineas";->$l_linea)
									
									APPEND TO ARRAY:C911($atACT_CasosRefLinea;vt_variableCaso+"_"+String:C10($l_linea))
									APPEND TO ARRAY:C911($arACT_CasosCantidad;arACT_cantidad{$l_linea})
									APPEND TO ARRAY:C911($arACT_CasosValores;arACT_valorUnitario{$l_linea})
									
									$t_linea:=atACT_archivo{$l_indiceLineas+5}
									$l_linea:=2
									arACT_cantidad{$l_linea}:=Num:C11(ST_GetWord ($t_linea;2;"\t"))
									arACT_valorUnitario{$l_linea}:=Num:C11(ST_GetWord ($t_linea;4;"\t"))
									ACTdte_setPruebasOpcionesGen ("CalculalineasYTotales";->$l_linea)
									
									APPEND TO ARRAY:C911($atACT_CasosRefLinea;vt_variableCaso+"_"+String:C10($l_linea))
									APPEND TO ARRAY:C911($arACT_CasosCantidad;arACT_cantidad{$l_linea})
									APPEND TO ARRAY:C911($arACT_CasosValores;arACT_valorUnitario{$l_linea})
									
								: ($l_numCaso=4)
									  //nada
									
								: ($l_numCaso=5)
									  //nada
									
								: ($l_numCaso=6)
									$t_linea:=atACT_archivo{$l_indiceLineas+4}
									$l_linea:=1
									arACT_cantidad{$l_linea}:=Num:C11(ST_GetWord ($t_linea;2;"\t"))
									arACT_valorUnitario{$l_linea}:=Num:C11(ST_GetWord ($t_linea;4;"\t"))
									ACTdte_setPruebasOpcionesGen ("Calculalineas";->$l_linea)
									APPEND TO ARRAY:C911($atACT_CasosRefLinea;vt_variableCaso+"_"+String:C10($l_linea))
									APPEND TO ARRAY:C911($arACT_CasosCantidad;arACT_cantidad{$l_linea})
									APPEND TO ARRAY:C911($arACT_CasosValores;arACT_valorUnitario{$l_linea})
									
									$t_linea:=atACT_archivo{$l_indiceLineas+5}
									$l_linea:=2
									arACT_cantidad{$l_linea}:=Num:C11(ST_GetWord ($t_linea;2;"\t"))
									arACT_valorUnitario{$l_linea}:=Num:C11(ST_GetWord ($t_linea;4;"\t"))
									ACTdte_setPruebasOpcionesGen ("CalculalineasYTotales";->$l_linea)
									APPEND TO ARRAY:C911($atACT_CasosRefLinea;vt_variableCaso+"_"+String:C10($l_linea))
									APPEND TO ARRAY:C911($arACT_CasosCantidad;arACT_cantidad{$l_linea})
									APPEND TO ARRAY:C911($arACT_CasosValores;arACT_valorUnitario{$l_linea})
									
								: ($l_numCaso=7)
									$t_linea:=atACT_archivo{$l_indiceLineas+6}
									$l_linea:=1
									arACT_valorUnitario{$l_linea}:=Num:C11(ST_GetWord ($t_linea;2;"\t"))
									$t_ref:=vt_numeroAtencion+"-6"+"_"+String:C10($l_linea)
									$l_pos:=Find in array:C230($atACT_CasosRefLinea;$t_ref)
									If ($l_pos>0)
										arACT_cantidad{$l_linea}:=$arACT_CasosCantidad{$l_pos}
									End if 
									ACTdte_setPruebasOpcionesGen ("CalculalineasYTotales";->$l_linea)
									
								: ($l_numCaso=8)
									$t_linea:=atACT_archivo{$l_indiceLineas+6}
									$l_linea:=1
									arACT_valorUnitario{$l_linea}:=Num:C11(ST_GetWord ($t_linea;2;"\t"))
									$t_ref:=vt_numeroAtencion+"-6"+"_"+String:C10($l_linea)
									$l_pos:=Find in array:C230($atACT_CasosRefLinea;$t_ref)
									If ($l_pos>0)
										arACT_cantidad{$l_linea}:=$arACT_CasosCantidad{$l_pos}
									End if 
									ACTdte_setPruebasOpcionesGen ("CalculalineasYTotales";->$l_linea)
									
							End case 
						Else 
							Case of 
								: ($l_numCaso=1)
									$t_linea:=atACT_archivo{$l_indiceLineas+4}
									$l_linea:=1
									arACT_cantidad{$l_linea}:=Num:C11(ST_GetWord ($t_linea;3;"\t"))
									arACT_valorUnitario{$l_linea}:=Num:C11(ST_GetWord ($t_linea;5;"\t"))
									ACTdte_setPruebasOpcionesGen ("Calculalineas";->$l_linea)
									APPEND TO ARRAY:C911($atACT_CasosRefLinea;vt_variableCaso+"_"+String:C10($l_linea))
									APPEND TO ARRAY:C911($arACT_CasosCantidad;arACT_cantidad{$l_linea})
									APPEND TO ARRAY:C911($arACT_CasosValores;arACT_valorUnitario{$l_linea})
									APPEND TO ARRAY:C911($arACT_CasosDescuentos;arACT_descuento{$l_linea})
									
									$t_linea:=atACT_archivo{$l_indiceLineas+5}
									$l_linea:=2
									arACT_cantidad{$l_linea}:=Num:C11(ST_GetWord ($t_linea;3;"\t"))
									arACT_valorUnitario{$l_linea}:=Num:C11(ST_GetWord ($t_linea;5;"\t"))
									ACTdte_setPruebasOpcionesGen ("CalculalineasYTotales";->$l_linea)
									APPEND TO ARRAY:C911($atACT_CasosRefLinea;vt_variableCaso+"_"+String:C10($l_linea))
									APPEND TO ARRAY:C911($arACT_CasosCantidad;arACT_cantidad{$l_linea})
									APPEND TO ARRAY:C911($arACT_CasosValores;arACT_valorUnitario{$l_linea})
									APPEND TO ARRAY:C911($arACT_CasosDescuentos;arACT_descuento{$l_linea})
									
								: ($l_numCaso=2)
									$t_linea:=atACT_archivo{$l_indiceLineas+4}
									$l_linea:=1
									arACT_cantidad{$l_linea}:=Num:C11(ST_GetWord ($t_linea;3;"\t"))
									arACT_valorUnitario{$l_linea}:=Num:C11(ST_GetWord ($t_linea;5;"\t"))
									arACT_descuento{$l_linea}:=Num:C11(ST_GetWord ($t_linea;8;"\t"))
									ACTdte_setPruebasOpcionesGen ("Calculalineas";->$l_linea)
									APPEND TO ARRAY:C911($atACT_CasosRefLinea;vt_variableCaso+"_"+String:C10($l_linea))
									APPEND TO ARRAY:C911($arACT_CasosCantidad;arACT_cantidad{$l_linea})
									APPEND TO ARRAY:C911($arACT_CasosValores;arACT_valorUnitario{$l_linea})
									APPEND TO ARRAY:C911($arACT_CasosDescuentos;arACT_descuento{$l_linea})
									
									$t_linea:=atACT_archivo{$l_indiceLineas+5}
									$l_linea:=2
									arACT_cantidad{$l_linea}:=Num:C11(ST_GetWord ($t_linea;3;"\t"))
									arACT_valorUnitario{$l_linea}:=Num:C11(ST_GetWord ($t_linea;5;"\t"))
									arACT_descuento{$l_linea}:=Num:C11(ST_GetWord ($t_linea;8;"\t"))
									ACTdte_setPruebasOpcionesGen ("CalculalineasYTotales";->$l_linea)
									APPEND TO ARRAY:C911($atACT_CasosRefLinea;vt_variableCaso+"_"+String:C10($l_linea))
									APPEND TO ARRAY:C911($arACT_CasosCantidad;arACT_cantidad{$l_linea})
									APPEND TO ARRAY:C911($arACT_CasosValores;arACT_valorUnitario{$l_linea})
									APPEND TO ARRAY:C911($arACT_CasosDescuentos;arACT_descuento{$l_linea})
									
								: ($l_numCaso=3)
									$t_linea:=atACT_archivo{$l_indiceLineas+4}
									$l_linea:=1
									arACT_cantidad{$l_linea}:=Num:C11(ST_GetWord ($t_linea;2;"\t"))
									arACT_valorUnitario{$l_linea}:=Num:C11(ST_GetWord ($t_linea;4;"\t"))
									arACT_descuento{$l_linea}:=0
									ACTdte_setPruebasOpcionesGen ("Calculalineas";->$l_linea)
									APPEND TO ARRAY:C911($atACT_CasosRefLinea;vt_variableCaso+"_"+String:C10($l_linea))
									APPEND TO ARRAY:C911($arACT_CasosCantidad;arACT_cantidad{$l_linea})
									APPEND TO ARRAY:C911($arACT_CasosValores;arACT_valorUnitario{$l_linea})
									APPEND TO ARRAY:C911($arACT_CasosDescuentos;arACT_descuento{$l_linea})
									
									$t_linea:=atACT_archivo{$l_indiceLineas+5}
									$l_linea:=2
									arACT_cantidad{$l_linea}:=Num:C11(ST_GetWord ($t_linea;3;"\t"))
									arACT_valorUnitario{$l_linea}:=Num:C11(ST_GetWord ($t_linea;5;"\t"))
									arACT_descuento{$l_linea}:=0
									ACTdte_setPruebasOpcionesGen ("CalculalineasYTotales";->$l_linea)
									APPEND TO ARRAY:C911($atACT_CasosRefLinea;vt_variableCaso+"_"+String:C10($l_linea))
									APPEND TO ARRAY:C911($arACT_CasosCantidad;arACT_cantidad{$l_linea})
									APPEND TO ARRAY:C911($arACT_CasosValores;arACT_valorUnitario{$l_linea})
									APPEND TO ARRAY:C911($arACT_CasosDescuentos;arACT_descuento{$l_linea})
									
									$t_linea:=atACT_archivo{$l_indiceLineas+6}
									$l_linea:=3
									arACT_cantidad{$l_linea}:=Num:C11(ST_GetWord ($t_linea;2;"\t"))
									arACT_valorUnitario{$l_linea}:=Num:C11(ST_GetWord ($t_linea;4;"\t"))
									arACT_descuento{$l_linea}:=0
									ACTdte_setPruebasOpcionesGen ("CalculalineasYTotales";->$l_linea)
									APPEND TO ARRAY:C911($atACT_CasosRefLinea;vt_variableCaso+"_"+String:C10($l_linea))
									APPEND TO ARRAY:C911($arACT_CasosCantidad;arACT_cantidad{$l_linea})
									APPEND TO ARRAY:C911($arACT_CasosValores;arACT_valorUnitario{$l_linea})
									APPEND TO ARRAY:C911($arACT_CasosDescuentos;arACT_descuento{$l_linea})
									
								: ($l_numCaso=4)
									$t_linea:=atACT_archivo{$l_indiceLineas+4}
									$l_linea:=1
									arACT_cantidad{$l_linea}:=Num:C11(ST_GetWord ($t_linea;3;"\t"))
									arACT_valorUnitario{$l_linea}:=Num:C11(ST_GetWord ($t_linea;5;"\t"))
									arACT_descuento{$l_linea}:=0
									ACTdte_setPruebasOpcionesGen ("Calculalineas";->$l_linea)
									APPEND TO ARRAY:C911($atACT_CasosRefLinea;vt_variableCaso+"_"+String:C10($l_linea))
									APPEND TO ARRAY:C911($arACT_CasosCantidad;arACT_cantidad{$l_linea})
									APPEND TO ARRAY:C911($arACT_CasosValores;arACT_valorUnitario{$l_linea})
									APPEND TO ARRAY:C911($arACT_CasosDescuentos;arACT_descuento{$l_linea})
									
									$t_linea:=atACT_archivo{$l_indiceLineas+5}
									$l_linea:=2
									arACT_cantidad{$l_linea}:=Num:C11(ST_GetWord ($t_linea;3;"\t"))
									arACT_valorUnitario{$l_linea}:=Num:C11(ST_GetWord ($t_linea;5;"\t"))
									arACT_descuento{$l_linea}:=0
									ACTdte_setPruebasOpcionesGen ("Calculalineas";->$l_linea)
									APPEND TO ARRAY:C911($atACT_CasosRefLinea;vt_variableCaso+"_"+String:C10($l_linea))
									APPEND TO ARRAY:C911($arACT_CasosCantidad;arACT_cantidad{$l_linea})
									APPEND TO ARRAY:C911($arACT_CasosValores;arACT_valorUnitario{$l_linea})
									APPEND TO ARRAY:C911($arACT_CasosDescuentos;arACT_descuento{$l_linea})
									
									$t_linea:=atACT_archivo{$l_indiceLineas+6}
									$l_linea:=3
									arACT_cantidad{$l_linea}:=Num:C11(ST_GetWord ($t_linea;2;"\t"))
									arACT_valorUnitario{$l_linea}:=Num:C11(ST_GetWord ($t_linea;4;"\t"))
									arACT_descuento{$l_linea}:=0
									ACTdte_setPruebasOpcionesGen ("Calculalineas";->$l_linea)
									APPEND TO ARRAY:C911($atACT_CasosRefLinea;vt_variableCaso+"_"+String:C10($l_linea))
									APPEND TO ARRAY:C911($arACT_CasosCantidad;arACT_cantidad{$l_linea})
									APPEND TO ARRAY:C911($arACT_CasosValores;arACT_valorUnitario{$l_linea})
									APPEND TO ARRAY:C911($arACT_CasosDescuentos;arACT_descuento{$l_linea})
									
									$t_linea:=atACT_archivo{$l_indiceLineas+7}
									If (Position:C15("AFECTOS";$t_linea)>0)
										vrACTdte_DescuentoAfecto:=Num:C11($t_linea)
										If (Position:C15("DESCUENTO";$t_linea)>0)
											vrACTdte_DescuentoAfecto:=vrACTdte_DescuentoAfecto*-1
										End if 
									Else 
										vrACTdte_DescuentoExento:=Num:C11($t_linea)
										If (Position:C15("DESCUENTO";$t_linea)>0)
											vrACTdte_DescuentoExento:=vrACTdte_DescuentoExento*-1
										End if 
									End if 
									
									ACTdte_setPruebasOpcionesGen ("CalculalineasYTotales";->$l_linea)
									
								: ($l_numCaso=5)
									  //nada
									
								: ($l_numCaso=6)
									$t_linea:=atACT_archivo{$l_indiceLineas+6}
									$l_linea:=1
									arACT_cantidad{$l_linea}:=Num:C11(ST_GetWord ($t_linea;3;"\t"))
									$t_ref:=vt_numeroAtencion+"-2"+"_"+String:C10($l_linea)
									$l_pos:=Find in array:C230($atACT_CasosRefLinea;$t_ref)
									If ($l_pos>0)
										arACT_valorUnitario{$l_linea}:=$arACT_CasosValores{$l_pos}
										arACT_descuento{$l_linea}:=$arACT_CasosDescuentos{$l_pos}
									End if 
									ACTdte_setPruebasOpcionesGen ("Calculalineas";->$l_linea)
									
									$t_linea:=atACT_archivo{$l_indiceLineas+7}
									$l_linea:=2
									arACT_cantidad{$l_linea}:=Num:C11(ST_GetWord ($t_linea;3;"\t"))
									$t_ref:=vt_numeroAtencion+"-2"+"_"+String:C10($l_linea)
									$l_pos:=Find in array:C230($atACT_CasosRefLinea;$t_ref)
									If ($l_pos>0)
										arACT_valorUnitario{$l_linea}:=$arACT_CasosValores{$l_pos}
										arACT_descuento{$l_linea}:=$arACT_CasosDescuentos{$l_pos}
									End if 
									ACTdte_setPruebasOpcionesGen ("CalculalineasYTotales";->$l_linea)
									
								: ($l_numCaso=7)
									$t_linea:=atACT_archivo{$l_indiceLineas+6}
									$l_linea:=1
									
									$t_ref:=vt_numeroAtencion+"-3"+"_"+String:C10($l_linea)
									$l_pos:=Find in array:C230($atACT_CasosRefLinea;$t_ref)
									If ($l_pos>0)
										arACT_cantidad{$l_linea}:=$arACT_CasosCantidad{$l_pos}
										arACT_valorUnitario{$l_linea}:=$arACT_CasosValores{$l_pos}
										arACT_descuento{$l_linea}:=$arACT_CasosDescuentos{$l_pos}
									End if 
									ACTdte_setPruebasOpcionesGen ("Calculalineas";->$l_linea)
									
									$t_linea:=atACT_archivo{$l_indiceLineas+7}
									$l_linea:=2
									
									$t_ref:=vt_numeroAtencion+"-3"+"_"+String:C10($l_linea)
									$l_pos:=Find in array:C230($atACT_CasosRefLinea;$t_ref)
									If ($l_pos>0)
										arACT_cantidad{$l_linea}:=$arACT_CasosCantidad{$l_pos}
										arACT_valorUnitario{$l_linea}:=$arACT_CasosValores{$l_pos}
										arACT_descuento{$l_linea}:=$arACT_CasosDescuentos{$l_pos}
									End if 
									ACTdte_setPruebasOpcionesGen ("Calculalineas";->$l_linea)
									
									$t_linea:=atACT_archivo{$l_indiceLineas+8}
									$l_linea:=3
									
									$t_ref:=vt_numeroAtencion+"-3"+"_"+String:C10($l_linea)
									$l_pos:=Find in array:C230($atACT_CasosRefLinea;$t_ref)
									If ($l_pos>0)
										arACT_cantidad{$l_linea}:=$arACT_CasosCantidad{$l_pos}
										arACT_valorUnitario{$l_linea}:=$arACT_CasosValores{$l_pos}
										arACT_descuento{$l_linea}:=$arACT_CasosDescuentos{$l_pos}
									End if 
									
									ACTdte_setPruebasOpcionesGen ("CalculalineasYTotales";->$l_linea)
									
								: ($l_numCaso=8)
									  //nada
									
							End case 
						End if 
						$l_indiceLineas:=Size of array:C274(atACT_archivo)
					End if 
				End for 
				
				$vt_retorno:=ACTdte_setPruebasOpcionesGen ("GuardaCaso")
				If ($vt_retorno="0")
					$l_indiceLineas:=Size of array:C274(atACT_archivo)
					$vb_continuar:=False:C215
				End if 
				
			End for 
			
			
			
			
			SET CHANNEL:C77(11)
			
			
			  //Se procesa de a uno a la vez
			  //$l_indice:=Size of array(atACT_setDisponiblesApp)
			  //
			  //End for 
			
			  //borro casos importados
			READ WRITE:C146([xShell_Prefs:46])
			QUERY WITH ARRAY:C644([xShell_Prefs:46]Reference:1;$atACT_casos)
			KRL_DeleteSelection (->[xShell_Prefs:46])
			KRL_UnloadReadOnly (->[xShell_Prefs:46])
			
			  //actualizar referencias... puede que la referencia no quede correcta
			
			
			If ($vb_continuar)
				ACTdte_setPruebasOpcionesGen ("CargaListado")
				If ($b_mensajeCompletaInfoTer)
					CD_Dlog (0;"Debe revisar que los terceros tengan ingresados los apellidos, nombres, dirección y comuna. Script ejecutado.")
				Else 
					CD_Dlog (0;"Script ejecutado.")
				End if 
			Else 
				CD_Dlog (0;"Script no ejecutado.")
			End if 
			
			
		End if 
		
		
		
	End if 
	
End if 