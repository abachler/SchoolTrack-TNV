//%attributes = {}
  //ACTpgs_DescuentosXTramo
C_TEXT:C284($t_accion;$1)
C_POINTER:C301(${2})
C_POINTER:C301($y_puntero1;$y_puntero2;$y_puntero3;$y_puntero4)
C_OBJECT:C1216($ob_retorno;$0)

$t_accion:=$1
If (Count parameters:C259>=2)
	$y_puntero1:=$2
End if 
If (Count parameters:C259>=3)
	$y_puntero2:=$3
End if 
If (Count parameters:C259>=4)
	$y_puntero3:=$4
End if 
If (Count parameters:C259>=5)
	$y_puntero4:=$5
End if 

Case of 
	: ($t_accion="ObtienePunteros2ObjetosConfiguracion")
		  //ACTpgs_DescuentosXTramo ("ObtienePunteros2ObjetosConfiguracion")
		$y_puntero1->:=OBJECT Get pointer:C1124(Object named:K67:5;"calcularDescuento")
		$y_puntero2->:=OBJECT Get pointer:C1124(Object named:K67:5;"rb_CalcularitemsAfectos")
		$y_puntero3->:=OBJECT Get pointer:C1124(Object named:K67:5;"rb_CalcularTodos")
		$y_puntero4->:=OBJECT Get pointer:C1124(Object named:K67:5;"GeneraCargosSeparadosXCuenta")
		
	: ($t_accion="GuardaConf")
		ACTcfg_GuardaBlob ("ACT_DescuentosPorTramo")
		
	: ($t_accion="DesarmaObjeto")
		cb_SepararCargosXPct:=OB Get:C1224($y_puntero1->;"divide_cargos")
		cb_SepararACsXPct:=OB Get:C1224($y_puntero1->;"divide_avisosC")
		cb_SepararDTsXPct:=OB Get:C1224($y_puntero1->;"divide_documentosT")
		
	: ($t_accion="ArmaObjetoAlGuardar")
		C_POINTER:C301($y_calcularDescuento;$y_calculaSoloAfectos;$y_calculaTodos;$y_generaCargosPorCuenta)
		ACTpgs_DescuentosXTramo ("ObtienePunteros2ObjetosConfiguracion";->$y_puntero1;->$y_puntero2;->$y_puntero3;->$y_puntero4)
		$ob_retorno:=ACTpgs_DescuentosXTramo ("ArmaObjeto";$y_puntero1;$y_puntero2;$y_puntero3;$y_puntero4)
		
	: ($t_accion="ArmaObjeto")
		C_LONGINT:C283($l_calcularDescuento;$l_CalcularitemsAfectos;$l_CalcularTodos;$l_GeneraCargosSeparadosXCuenta)
		C_OBJECT:C1216($ob_opciones;$ob_arreglos)
		
		$l_CalcularTodos:=1
		$l_GeneraCargosSeparadosXCuenta:=1
		
		If (Is nil pointer:C315($y_puntero1))
			$y_puntero1:=->$l_calcularDescuento
		End if 
		If (Is nil pointer:C315($y_puntero2))
			$y_puntero2:=->$l_CalcularitemsAfectos
		End if 
		If (Is nil pointer:C315($y_puntero3))
			$y_puntero3:=->$l_CalcularTodos
		End if 
		If (Is nil pointer:C315($y_puntero4))
			$y_puntero4:=->$l_GeneraCargosSeparadosXCuenta
		End if 
		
		OB SET:C1220($ob_opciones;"generar_descuentos";$y_puntero1->)
		OB SET:C1220($ob_opciones;"calcular_solo_afectos";$y_puntero2->)
		OB SET:C1220($ob_opciones;"calcular_todos";$y_puntero3->)
		OB SET:C1220($ob_opciones;"generar_descuentos_separados";$y_puntero4->)
		
		  //OB SET ARRAY($ob_arreglos;"id";alACT_DXTid)
		OB SET ARRAY:C1227($ob_arreglos;"desde";alACT_DXTdesde)
		OB SET ARRAY:C1227($ob_arreglos;"hasta";alACT_DXThasta)
		OB SET ARRAY:C1227($ob_arreglos;"tipo_monto";abACT_DXTesMontoFijo)
		OB SET ARRAY:C1227($ob_arreglos;"valor";arACT_DXTvalor)
		
		OB SET:C1220($ob_retorno;"opciones";$ob_opciones)
		OB SET:C1220($ob_retorno;"arreglos";$ob_arreglos)
		
	: ($t_accion="DeclaraVars")
		  //ARRAY LONGINT(alACT_DXTid;0)
		ARRAY LONGINT:C221(alACT_DXTdesde;0)
		ARRAY LONGINT:C221(alACT_DXThasta;0)
		ARRAY BOOLEAN:C223(abACT_DXTesMontoFijo;0)
		ARRAY REAL:C219(arACT_DXTvalor;0)
		
	: ($t_accion="LeeConf")
		$ob_retorno:=ACTcfg_LeeBlob ("ACT_DescuentosPorTramo")
		C_OBJECT:C1216($ob_opciones;$ob_arreglos)
		$ob_opciones:=OB Get:C1224($ob_retorno;"opciones")
		$ob_arreglos:=OB Get:C1224($ob_retorno;"arreglos")
		
		If (Not:C34(Is nil pointer:C315($y_puntero1)))
			$y_puntero1->:=OB Get:C1224($ob_opciones;"generar_descuentos";Is longint:K8:6)
		End if 
		If (Not:C34(Is nil pointer:C315($y_puntero2)))
			$y_puntero2->:=OB Get:C1224($ob_opciones;"calcular_solo_afectos";Is longint:K8:6)
		End if 
		If (Not:C34(Is nil pointer:C315($y_puntero3)))
			$y_puntero3->:=OB Get:C1224($ob_opciones;"calcular_todos";Is longint:K8:6)
		End if 
		If (Not:C34(Is nil pointer:C315($y_puntero4)))
			$y_puntero4->:=OB Get:C1224($ob_opciones;"generar_descuentos_separados";Is longint:K8:6)
		End if 
		
		If (Not:C34(Is nil pointer:C315($y_puntero1)))
			  //OB GET ARRAY($ob_arreglos;"id";alACT_DXTid)
			OB GET ARRAY:C1229($ob_arreglos;"desde";alACT_DXTdesde)
			OB GET ARRAY:C1229($ob_arreglos;"hasta";alACT_DXThasta)
			OB GET ARRAY:C1229($ob_arreglos;"tipo_monto";abACT_DXTesMontoFijo)
			OB GET ARRAY:C1229($ob_arreglos;"valor";arACT_DXTvalor)
		End if 
		
	: ($t_accion="LeeArreglos")
		AT_Initialize ($y_puntero2;$y_puntero3)
		If (Not:C34(OB Is empty:C1297($y_puntero1->)))
			C_OBJECT:C1216($ob_objeto)
			$ob_objeto:=OB Get:C1224($y_puntero1->;"Porcentajes")
			OB GET ARRAY:C1229($ob_objeto;"ids";$y_puntero2->)
			OB GET ARRAY:C1229($ob_objeto;"pct";$y_puntero3->)
		End if 
		
	: ($t_accion="ArmaObjeto")
		C_OBJECT:C1216($ob_objeto)
		OB SET ARRAY:C1227($ob_objeto;"ids";$y_puntero2->)
		OB SET ARRAY:C1227($ob_objeto;"pct";$y_puntero3->)
		OB SET:C1220($y_puntero1->;"Porcentajes";$ob_objeto)
		
	: ($t_accion="InsertaTramo")
		If (Size of array:C274(alACT_DXTdesde)<28)  //solo se permiten 28 tramos… 1 para cada día
			If (Find in array:C230(alACT_DXTdesde;27)=-1)
				LISTBOX INSERT ROWS:C913(*;"lb_tramosDctos";MAXLONG:K35:2;1)
				  //alACT_DXTid{Size of array(alACT_DXTid)}:=Size of array(alACT_DXTid)
				Case of 
					: (Size of array:C274(alACT_DXTdesde)=1)
						alACT_DXTdesde{Size of array:C274(alACT_DXTdesde)}:=1
						alACT_DXThasta{Size of array:C274(alACT_DXThasta)}:=31
					Else 
						alACT_DXThasta{Size of array:C274(alACT_DXThasta)-1}:=alACT_DXTdesde{Size of array:C274(alACT_DXTdesde)-1}
						
						alACT_DXTdesde{Size of array:C274(alACT_DXTdesde)}:=alACT_DXThasta{Size of array:C274(alACT_DXThasta)-1}+1
						alACT_DXThasta{Size of array:C274(alACT_DXThasta)}:=31
				End case 
				LOG_RegisterEvt ("Cambio en configuración de descuentos por tramo: Nueva línea desde: "+String:C10(alACT_DXTdesde{Size of array:C274(alACT_DXTdesde)})+", hasta: "+String:C10(alACT_DXThasta{Size of array:C274(alACT_DXThasta)})+".")
			Else 
				CD_Dlog (0;"No es posible insertar rangos is existe uno que comience el día 27.")
			End if 
		End if 
		
	: ($t_accion="ValidaIngreso")
		  //ACTpgs_DescuentosXTramo("ValidaIngreso")
		  //ACTcfgit_OpcionesGenerales ("ValidaIngreso")
		C_TEXT:C284($t_var)
		C_LONGINT:C283($l_tabla;$l_campo)
		RESOLVE POINTER:C394($y_puntero1;$t_var;$l_tabla;$l_campo)
		
		$b_error:=False:C215
		Case of 
			: ($t_var="alACT_DXThasta")
				Case of 
					: (Size of array:C274(alACT_DXThasta)=1)
						alACT_DXTdesde{Size of array:C274(alACT_DXTdesde)}:=1
						alACT_DXThasta{Size of array:C274(alACT_DXThasta)}:=31
						
						LOG_RegisterEvt ("Cambio en configuración de descuentos por tramo: Nueva línea desde: "+String:C10(alACT_DXTdesde{Size of array:C274(alACT_DXTdesde)})+", hasta: "+String:C10(alACT_DXThasta{Size of array:C274(alACT_DXThasta)})+".")
						
					: (Size of array:C274(alACT_DXThasta)=lb_tramosDctos)
						alACT_DXThasta{Size of array:C274(alACT_DXThasta)}:=31
						
					: (alACT_DXThasta{lb_tramosDctos}<alACT_DXTdesde{lb_tramosDctos})
						alACT_DXThasta{lb_tramosDctos}:=alACT_DXThasta{0}
						BEEP:C151
						$b_error:=True:C214
						
					: (alACT_DXThasta{lb_tramosDctos}>=27)
						alACT_DXThasta{lb_tramosDctos}:=alACT_DXThasta{0}
						$b_error:=True:C214
						
					Else 
						  //LOG_RegisterEvt ("Cambio en configuración de descuentos por tramo: Línea "+String(lb_tramosDctos)+" desde: "+String(alACT_DXTdesde{lb_tramosDctos})+", hasta: "+String(alACT_DXThasta{lb_tramosDctos})+".")
						
						C_OBJECT:C1216($ob_datos)  //guardamos datos por si hay error y tenemos que cancelar.
						OB SET:C1220($ob_datos;"id";lb_tramosDctos)
						OB SET:C1220($ob_datos;"desde_siguiente";alACT_DXTdesde{lb_tramosDctos+1})
						OB SET:C1220($ob_datos;"valor_original";alACT_DXThasta{0})
						OB SET:C1220($ob_datos;"hasta_siguiente";alACT_DXThasta{lb_tramosDctos+1})
						
						alACT_DXTdesde{lb_tramosDctos+1}:=alACT_DXThasta{lb_tramosDctos}+1
						If (alACT_DXTdesde{lb_tramosDctos+1}>alACT_DXThasta{lb_tramosDctos+1})
							alACT_DXThasta{0}:=alACT_DXThasta{lb_tramosDctos+1}
							alACT_DXThasta{lb_tramosDctos+1}:=alACT_DXTdesde{lb_tramosDctos+1}+1
							lb_tramosDctos:=lb_tramosDctos+1
							$ob_respuesta:=ACTpgs_DescuentosXTramo ("ValidaIngreso";->alACT_DXThasta)
							lb_tramosDctos:=OB Get:C1224($ob_datos;"id")
							alACT_DXThasta{0}:=OB Get:C1224($ob_datos;"valor_original")
							If (OB Get:C1224($ob_respuesta;"error")=True:C214)
								BEEP:C151
								$b_error:=True:C214
								alACT_DXThasta{lb_tramosDctos}:=alACT_DXThasta{0}
								alACT_DXTdesde{lb_tramosDctos+1}:=OB Get:C1224($ob_datos;"desde_siguiente")
								alACT_DXThasta{lb_tramosDctos+1}:=OB Get:C1224($ob_datos;"hasta_siguiente")
							Else 
								LOG_RegisterEvt ("Cambio en configuración de descuentos por tramo: Línea "+String:C10(lb_tramosDctos)+" desde: "+String:C10(alACT_DXTdesde{lb_tramosDctos})+", hasta: "+String:C10(alACT_DXThasta{lb_tramosDctos})+".")
							End if 
						Else 
							LOG_RegisterEvt ("Cambio en configuración de descuentos por tramo: Línea "+String:C10(lb_tramosDctos+1)+" desde: "+String:C10(alACT_DXTdesde{lb_tramosDctos+1})+", hasta: "+String:C10(alACT_DXThasta{lb_tramosDctos+1})+".")
						End if 
				End case 
				OB SET:C1220($ob_retorno;"error";$b_error)
				
			: ($t_var="abACT_DXTesMontoFijo")
				LOG_RegisterEvt ("Cambio en configuración de descuentos por tramo: Línea "+String:C10(lb_tramosDctos)+", desde: "+String:C10(alACT_DXTdesde{lb_tramosDctos})+", hasta: "+String:C10(alACT_DXThasta{lb_tramosDctos})+". Tipo cambió de: "+String:C10(abACT_DXTesMontoFijo{0};"Fijo;Porcentaje")+" a: "+String:C10(abACT_DXTesMontoFijo{lb_tramosDctos};"Fijo;Porcentaje")+".")
				
			: ($t_var="arACT_DXTvalor")
				arACT_DXTvalor{lb_tramosDctos}:=Round:C94(arACT_DXTvalor{lb_tramosDctos};4)
				LOG_RegisterEvt ("Cambio en configuración de descuentos por tramo: Línea "+String:C10(lb_tramosDctos)+", desde: "+String:C10(alACT_DXTdesde{lb_tramosDctos})+", hasta: "+String:C10(alACT_DXThasta{lb_tramosDctos})+". Valor cambió de: "+String:C10(arACT_DXTvalor{0})+" a: "+String:C10(arACT_DXTvalor{lb_tramosDctos})+".")
				
		End case 
		
		If (Not:C34(abACT_DXTesMontoFijo{lb_tramosDctos}))
			If ((arACT_DXTvalor{lb_tramosDctos}<-100) | (arACT_DXTvalor{lb_tramosDctos}>100))
				arACT_DXTvalor{lb_tramosDctos}:=0
			End if 
		End if 
		
	: ($t_accion="EliminaTramoLB")
		
		  //Primero modifico valores y luego elimino linea
		If (Size of array:C274(alACT_DXTdesde)>0)
			Case of 
				: (lb_tramosDctos=Size of array:C274(alACT_DXTdesde))
					If (Size of array:C274(alACT_DXThasta)>1)
						alACT_DXThasta{lb_tramosDctos-1}:=31
						LOG_RegisterEvt ("Cambio en configuración de descuentos por eliminación de tramo: Eliminación de línea "+String:C10(lb_tramosDctos-1)+": "+String:C10(alACT_DXTdesde{lb_tramosDctos-1})+", hasta: "+String:C10(alACT_DXThasta{lb_tramosDctos-1})+".")
					End if 
				: (lb_tramosDctos=1)
					alACT_DXTdesde{lb_tramosDctos+1}:=1
					LOG_RegisterEvt ("Cambio en configuración de descuentos por eliminación de tramo: Eliminación de línea "+String:C10(lb_tramosDctos+1)+": "+String:C10(alACT_DXTdesde{lb_tramosDctos+1})+", hasta: "+String:C10(alACT_DXThasta{lb_tramosDctos+1})+".")
				Else 
					alACT_DXThasta{lb_tramosDctos-1}:=alACT_DXThasta{lb_tramosDctos}
			End case 
			LOG_RegisterEvt ("Cambio en configuración de descuentos por tramo: Eliminación de línea "+String:C10(lb_tramosDctos)+": "+String:C10(alACT_DXTdesde{lb_tramosDctos})+", hasta: "+String:C10(alACT_DXThasta{lb_tramosDctos})+".")
			LISTBOX DELETE ROWS:C914(*;"lb_tramosDctos";lb_tramosDctos)
			LISTBOX SELECT ROW:C912(*;"lb_tramosDctos";1)
		Else 
			BEEP:C151
		End if 
		
	: ($t_accion="CargaIngresoPagos")
		C_OBJECT:C1216($ob_conf)
		C_BOOLEAN:C305($b_cargosCreados)
		C_DATE:C307($d_fecha)
		
		$d_fecha:=$y_puntero1->
		
		$ob_conf:=ACTpgs_DescuentosXTramo ("LeeConf")  //lee conf
		For ($l_indice;1;Size of array:C274(alACT_AIDAviso))
			$ob_retorno:=ACTdxt_CalculaDesdeIDAC ($ob_conf;$d_fecha;alACT_AIDAviso{$l_indice})
			
			ARRAY LONGINT:C221($al_idCta;0)
			ARRAY REAL:C219($ar_monto;0)
			ARRAY BOOLEAN:C223($ab_exento;0)
			
			OB GET ARRAY:C1229($ob_retorno;"id_cuenta";$al_idCta)
			OB GET ARRAY:C1229($ob_retorno;"montos";$ar_monto)
			OB GET ARRAY:C1229($ob_retorno;"montos_exentos";$ab_exento)
			
			C_LONGINT:C283($l_indiceDXT;$el;$l_existe;$i;$le)
			C_REAL:C285($afecto)
			C_BOOLEAN:C305($b_continuar;vb_descuentoBorrado)
			C_TEXT:C284($t_llave)
			
			For ($l_indiceDXT;1;Size of array:C274($ar_monto))
				If ($ar_monto{$l_indiceDXT}#0)
					$el:=Find in array:C230(alACT_AIDAviso;[ACT_Avisos_de_Cobranza:124]ID_Aviso:1)
					
					$b_continuar:=True:C214
					$t_llave:=String:C10(Choose:C955($ab_exento{$l_indiceDXT};-141;-140))+";"+String:C10($al_idCta{$l_indiceDXT})+";"+String:C10([ACT_Avisos_de_Cobranza:124]ID_Aviso:1)
					If (vb_descuentoBorrado)  //Se setea al borrar un cargo
						$l_existe:=Find in array:C230(atACT_llaveDctoEliminado;$t_llave)
						If ($l_existe>0)
							$b_continuar:=False:C215
						End if 
					End if 
					
					If ($b_continuar)
						$b_cargosCreados:=True:C214
						
						For ($i;1;Size of array:C274(ap_arrays2Pay))
							AT_Insert (0;1;ap_arrays2Pay{$i})
						End for 
						READ ONLY:C145([ACT_CuentasCorrientes:175])
						READ ONLY:C145([Alumnos:2])
						QUERY:C277([ACT_CuentasCorrientes:175];[ACT_CuentasCorrientes:175]ID:1=$al_idCta{$l_indiceDXT})
						alACT_CIDCtaCte{Size of array:C274(alACT_CIDCtaCte)}:=[ACT_CuentasCorrientes:175]ID:1
						QUERY:C277([Alumnos:2];[Alumnos:2]numero:1=[ACT_CuentasCorrientes:175]ID_Alumno:3)
						atACT_CAlumno{Size of array:C274(atACT_CAlumno)}:=[Alumnos:2]apellidos_y_nombres:40
						alACT_CidCargoGenInt{Size of array:C274(alACT_CidCargoGenInt)}:=0
						adACT_CfechaInteres{Size of array:C274(adACT_CfechaInteres)}:=$d_fecha
						alACT_CRefs{Size of array:C274(alACT_CRefs)}:=Choose:C955($ab_exento{$l_indiceDXT};-141;-140)
						atACT_CGlosa{Size of array:C274(atACT_CGlosa)}:=KRL_GetTextFieldData (->[xxACT_Items:179]ID:1;->alACT_CRefs{Size of array:C274(alACT_CRefs)};->[xxACT_Items:179]Glosa:2)
						arACT_MontoMoneda{Size of array:C274(arACT_MontoMoneda)}:=$ar_monto{$l_indiceDXT}
						arACT_CMontoNeto{Size of array:C274(arACT_CMontoNeto)}:=$ar_monto{$l_indiceDXT}
						arACT_CSaldo{Size of array:C274(arACT_CSaldo)}:=$ar_monto{$l_indiceDXT}*-1
						abACT_ASelectedCargo{Size of array:C274(abACT_ASelectedCargo)}:=False:C215
						GET PICTURE FROM LIBRARY:C565("XS_EntryCancel";apACT_ASelectedCargo{Size of array:C274(apACT_ASelectedCargo)})
						For ($i;-1001;-2000;-1)  //Se usan ids diferentes de los intereses
							$le:=Find in array:C230(alACT_RecNumsCargos;$i)
							If ($le=-1)
								alACT_RecNumsCargos{Size of array:C274(alACT_RecNumsCargos)}:=$i
								$i:=-2000
							End if 
						End for 
						$afecto:=arACT_CMontoNeto{Size of array:C274(arACT_CMontoNeto)}/<>vrACT_FactorIVA
						
						If (KRL_GetBooleanFieldData (->[xxACT_Items:179]ID:1;->alACT_CRefs{Size of array:C274(alACT_CRefs)};->[xxACT_Items:179]Afecto_IVA:12))
							arACT_MontoIVA{Size of array:C274(arACT_MontoIVA)}:=Round:C94($afecto*<>vrACT_TasaIVA/100;<>vlACT_Decimales)
							arACT_CMontoAfecto{Size of array:C274(arACT_CMontoAfecto)}:=arACT_CMontoNeto{Size of array:C274(arACT_CMontoNeto)}-arACT_MontoIVA{Size of array:C274(arACT_MontoIVA)}
						End if 
						
						atACT_MonedaCargo{Size of array:C274(atACT_MonedaCargo)}:=KRL_GetTextFieldData (->[xxACT_Items:179]ID:1;->alACT_CRefs{Size of array:C274(alACT_CRefs)};->[xxACT_Items:179]Moneda:10)
						atACT_MonedaSimbolo{Size of array:C274(atACT_MonedaSimbolo)}:=""
						ACTpgs_SimboloMoneda 
						
						If ($el>0)
							adACT_CFechaEmision{Size of array:C274(adACT_CFechaEmision)}:=adACT_AFechaEmision{$el}
							adACT_CFechaVencimiento{Size of array:C274(adACT_CFechaVencimiento)}:=adACT_AFechaVencimiento{$el}
							alACT_CIdsAvisos{Size of array:C274(alACT_CIdsAvisos)}:=alACT_AIDAviso{$el}
						End if 
					End if 
				End if 
			End for 
			
		End for 
		If ($b_cargosCreados)
			ACTpgs_CargaArreglosInterfaz ($d_fecha)
		End if 
		
	: ($t_accion="CreaDescuentosIngresoPagos")
		  //$d_fecha:=$y_puntero1->
		  //_0000_TestsCreaCargosDCTO ($d_fecha)
		
		  //método que filtra los cargos que se pagarán para reducir el procesamiento de arreglos innecesarios al ingresar pagos por caja, documentar . Cuando se importa se calcula para todo
		C_LONGINT:C283($i)
		ARRAY TEXT:C222(atACT_NombreMonedaEm;0)
		ARRAY DATE:C224(adACT_fechasEm;0)
		C_BOOLEAN:C305($b_enBoleta;$b_avisoXCuenta)
		C_LONGINT:C283($l_idApdo;$l_idTercero;$l_idCargo)
		
		  //para todos los rec num <0 se crean los intereses asociados...
		For ($i;1;Size of array:C274(alACT_RecNumsCargos))
			If (((alACT_RecNumsCargos{$i}<0) & (alACT_CRefs{$i}=-140)) | ((alACT_RecNumsCargos{$i}<0) & (alACT_CRefs{$i}=-141)))
				  //por si se va a pagar un cargo que es de intereses
				$l_idApdo:=KRL_GetNumericFieldData (->[ACT_Avisos_de_Cobranza:124]ID_Aviso:1;->alACT_CIdsAvisos{$i};->[ACT_Avisos_de_Cobranza:124]ID_Apoderado:3)
				$l_idTercero:=KRL_GetNumericFieldData (->[ACT_Avisos_de_Cobranza:124]ID_Aviso:1;->alACT_CIdsAvisos{$i};->[ACT_Avisos_de_Cobranza:124]ID_Tercero:26)
				$b_avisoXCuenta:=(KRL_GetNumericFieldData (->[ACT_Avisos_de_Cobranza:124]ID_Aviso:1;->alACT_CIdsAvisos{$i};->[ACT_Avisos_de_Cobranza:124]ID_CuentaCorrriente:2)>0)
				$b_enBoleta:=KRL_GetBooleanFieldData (->[xxACT_Items:179]ID:1;->alACT_CRefs{$i};->[xxACT_Items:179]No_incluir_en_DocTributario:31)
				
				  ///para asegurarme que quede en el mismo aC
				READ ONLY:C145([ACT_Documentos_de_Cargo:174])
				READ ONLY:C145([ACT_Cargos:173])
				QUERY:C277([ACT_Documentos_de_Cargo:174];[ACT_Documentos_de_Cargo:174]No_ComprobanteInterno:15=alACT_CIdsAvisos{$i})
				While (Not:C34(End selection:C36([ACT_Documentos_de_Cargo:174])))
					QUERY:C277([ACT_Cargos:173];[ACT_Cargos:173]ID_Documento_de_Cargo:3=[ACT_Documentos_de_Cargo:174]ID_Documento:1)  //busco cualquiera
					While (Not:C34(End selection:C36([ACT_Cargos:173])))
						FIRST RECORD:C50([ACT_Cargos:173])
						If ([ACT_Cargos:173]ID:1>0)
							$l_idCargo:=[ACT_Cargos:173]ID:1
							LAST RECORD:C200([ACT_Documentos_de_Cargo:174])
							LAST RECORD:C200([ACT_Cargos:173])
						End if 
						NEXT RECORD:C51([ACT_Cargos:173])
					End while 
					NEXT RECORD:C51([ACT_Documentos_de_Cargo:174])
				End while 
				
				alACT_RecNumsCargos{$i}:=ACTac_CreateCargoDocCargoImp (True:C214;alACT_CRefs{$i};Num:C11(arACT_CMontoNeto{$i});adACT_CFechaVencimiento{$i};True:C214;alACT_CIDCtaCte{$i};$l_idApdo;$b_enBoleta;False:C215;$l_idTercero;$b_avisoXCuenta;$l_idCargo;False:C215)
				If (alACT_RecNumsCargos{$i}>0)
					READ ONLY:C145([ACT_Cargos:173])
					READ ONLY:C145([ACT_Documentos_de_Cargo:174])
					READ ONLY:C145([ACT_Avisos_de_Cobranza:124])
					GOTO RECORD:C242([ACT_Cargos:173];alACT_RecNumsCargos{$i})
					alACT_CIdsCargos{$i}:=[ACT_Cargos:173]ID:1
					QUERY:C277([ACT_Documentos_de_Cargo:174];[ACT_Documentos_de_Cargo:174]ID_Documento:1=[ACT_Cargos:173]ID_Documento_de_Cargo:3)
					alACT_CIdDctoCargo{$i}:=[ACT_Documentos_de_Cargo:174]ID_Documento:1
					QUERY:C277([ACT_Avisos_de_Cobranza:124];[ACT_Avisos_de_Cobranza:124]ID_Aviso:1=[ACT_Documentos_de_Cargo:174]No_ComprobanteInterno:15)
					alACT_CIdsAvisos{$i}:=[ACT_Avisos_de_Cobranza:124]ID_Aviso:1
				End if 
			End if 
			
		End for 
		
		
	: ($t_accion="ValidaEliminaAnulaPago")
		C_LONGINT:C283($i;$l_recs)
		  //elimina cargos de descuentos por tramo que no tienen pago asociado ni DT ni Pagare
		CREATE SET:C116([ACT_Cargos:173];"$cargosAC")
		QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]Saldo:23#0)
		QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]Ref_Item:16=-140;*)
		QUERY SELECTION:C341([ACT_Cargos:173]; | ;[ACT_Cargos:173]Ref_Item:16=-141)
		If (Records in selection:C76([ACT_Cargos:173])>0)
			QUERY SELECTION BY FORMULA:C207([ACT_Cargos:173];Abs:C99([ACT_Cargos:173]Saldo:23)=Abs:C99([ACT_Cargos:173]Monto_Neto:5))
			If (Records in selection:C76([ACT_Cargos:173])>0)
				ACTcc_EliminaCargosLoop 
			End if 
		End if 
		USE SET:C118("$cargosAC")
		SET_ClearSets ("$cargosAC")
		
End case 

$0:=$ob_retorno