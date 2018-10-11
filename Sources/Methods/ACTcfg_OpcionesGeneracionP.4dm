//%attributes = {}
  // Método: ACTcfg_OpcionesGeneracionP
  //----------------------------------------------
  // Usuario (OS): roberto
  // Fecha: 11-09-10, 16:13:26
  // ---------------------------------------------
  // Descripción: 
  // 
  // Parámetros:
  // 
  //----------------------------------------------
  // Declaraciones e inicializaciones


  // Código principal




  // ----------------------------------------------------
  // Nombre usuario (OS): roberto
  // Fecha y hora: 03-07-10, 15:05:20
  // ----------------------------------------------------
  // Método: ACTcfg_OpcionesGeneracionP
  // Descripción
  // 
  //
  // Parámetros
  // ----------------------------------------------------


C_POINTER:C301(${2};$ptr1;$ptr2;$ptr3)
C_TEXT:C284($vt_accion;$1;$0;$vt_retorno)
C_BOOLEAN:C305($vb_saltarValidacion;$vb_asignacionOK)
$vt_accion:=$1

If (Count parameters:C259>=2)
	$ptr1:=$2
End if 
If (Count parameters:C259>=3)
	$ptr2:=$3
End if 
If (Count parameters:C259>=4)
	$ptr3:=$4
End if 
Case of 
	: ($vt_accion="DeclaraArreglosCargos")
		ARRAY TEXT:C222(atACT_NombreCargo;0)
		ARRAY TEXT:C222(atACT_MontoCargos;0)
		ARRAY LONGINT:C221(alACT_IDCargo;0)
		
	: ($vt_accion="DeclaraArreglosDctos")
		ARRAY TEXT:C222(atACT_NombreDcto;0)
		ARRAY TEXT:C222(atACT_MontoDctos;0)
		ARRAY LONGINT:C221(alACT_NombreDcto;0)
		
	: ($vt_accion="InicializaVarsPredefinidas")
		ACTcfg_OpcionesPagares ("LeeBlobs")
		vt_periodo:=vtACTp_Periodo
		vlACT_CuotasC:=vlACTp_Cuota
		vlACT_DiaVencimiento:=vlACTp_Dia
		cs_genPagareC:=cs_genPagare
		cs_imprimirPagareC:=cs_imprimirPagare
		cs_genContratoC:=cs_genContrato
		
	: ($vt_accion="DeclaraArreglosCuotas")
		ARRAY TEXT:C222(atACT_PeriodoCuota;0)
		ARRAY LONGINT:C221(alACT_NumeroCuota;0)
		ARRAY DATE:C224(adACT_FEmisionCuota;0)
		ARRAY DATE:C224(adACT_FVencimientoCuota;0)
		ARRAY REAL:C219(arACT_MontoCuota;0)
		ARRAY PICTURE:C279(apACT_IncluidoEnPagare;0)
		ARRAY BOOLEAN:C223(abACT_IncluidoEnPagare;0)
		
	: ($vt_accion="OnLoadVars")
		C_TEXT:C284(vt_periodo)
		C_TEXT:C284(vtACT_Alumno;vtACT_RUT)
		C_REAL:C285(vrACT_SaldoActual)
		C_TEXT:C284(vtACT_Regimen;vtACT_Carrera;vtACT_Matriz)
		C_LONGINT:C283(vlACT_CuotasC;vlACT_DiaVencimiento)
		C_REAL:C285(vrACT_MontoMatriz;vrACT_MontoDescuento;vrACT_MontoTotal;vrACT_MontoCargo)
		
		vtACT_Alumno:=""
		vtACT_RUT:=""
		vrACT_SaldoActual:=0
		vt_periodo:=""
		
		vtACT_Regimen:=""
		vtACT_Carrera:=""
		vtACT_Matriz:=""
		vlACT_CuotasC:=0
		vlACT_DiaVencimiento:=0
		
		vrACT_MontoMatriz:=0
		vrACT_MontoDescuento:=0
		vrACT_MontoTotal:=0
		vrACT_MontoCargo:=0
		
		ACTcfg_OpcionesGeneracionP ("InicializaVarsPredefinidas")
		  //list boxes
		ACTcfg_OpcionesGeneracionP ("DeclaraArreglosCargos")
		ACTcfg_OpcionesGeneracionP ("DeclaraArreglosDctos")
		$vl_columnasOcultas:=0
		ACTcfg_OpcionesGeneracionP ("SetAreaListAvisos";->$vl_columnasOcultas)
		REDUCE SELECTION:C351([ACT_Pagares:184];0)
		vbACTp_PagareGenerado:=False:C215
		
	: ($vt_accion="SetAreaListAvisos")
		ACTcfg_OpcionesGeneracionP ("DeclaraArreglosCuotas")
		C_LONGINT:C283($error;$vl_columnasOcultas)
		$vl_columnasOcultas:=$ptr1->
		If ($vl_columnasOcultas>0)
			$vl_factor:=60
		Else 
			$vl_factor:=0
		End if 
		AT_Inc (0)
		$error:=ALP_DefaultColSettings (xALP_PagareCuotas;AT_Inc ;"atACT_PeriodoCuota";"Período";50+$vl_factor;"")
		$error:=ALP_DefaultColSettings (xALP_PagareCuotas;AT_Inc ;"alACT_NumeroCuota";"Número\rCuota";50+$vl_factor;"### ###0")
		$error:=ALP_DefaultColSettings (xALP_PagareCuotas;AT_Inc ;"adACT_FEmisionCuota";"Fecha\rEmisión";100+$vl_factor;"";2;0;0)
		$error:=ALP_DefaultColSettings (xALP_PagareCuotas;AT_Inc ;"adACT_FVencimientoCuota";"Fecha\rVencimiento";100+$vl_factor;"";2;0;0)
		$error:=ALP_DefaultColSettings (xALP_PagareCuotas;AT_Inc ;"arACT_MontoCuota";"Monto\rCuota";120+$vl_factor;"|Despliegue_ACT";0;0;0)
		  //$error:=ALP_DefaultColSettings (xALP_PagareCuotas;AT_Inc ;"apACT_IncluidoEnPagare";"Incluido\ren Pagaré";60;"2")
		$error:=ALP_DefaultColSettings (xALP_PagareCuotas;AT_Inc ;"apACT_IncluidoEnPagare";"Incluido\ren Pagaré";60;"1")
		$error:=ALP_DefaultColSettings (xALP_PagareCuotas;AT_Inc ;"abACT_IncluidoEnPagare";"Incluido\ren Pagaré bool";120;"";0;0;0)
		
		ALP_SetDefaultAppareance (xALP_PagareCuotas;9;1;6;2;8)
		AL_SetColOpts (xALP_PagareCuotas;1;1;1;$vl_columnasOcultas;0)
		AL_SetRowOpts (xALP_PagareCuotas;0;1;0;0;1;0)
		AL_SetCellOpts (xALP_PagareCuotas;0;1;1)
		AL_SetMainCalls (xALP_PagareCuotas;"";"")
		AL_SetCallbacks (xALP_PagareCuotas;"";"")
		AL_SetScroll (xALP_PagareCuotas;0;-3)
		AL_SetEntryOpts (xALP_PagareCuotas;3;0;0;0;2;<>tXS_RS_DecimalSeparator)
		AL_SetDrgOpts (xALP_PagareCuotas;0;30;0)
		
	: ($vt_accion="InsertaCargo")
		ARRAY TEXT:C222($atACT_RegimenPagares;0)
		COPY ARRAY:C226(atACTp_RegimenCargo;$atACT_RegimenPagares)
		AT_DistinctsArrayValues (->$atACT_RegimenPagares)
		
		ARRAY TEXT:C222($atACT_Cargos;0)
		ARRAY LONGINT:C221($alACT_Cargos;0)
		$vb_continuar:=True:C214
		
		If (Size of array:C274($atACT_RegimenPagares)>1)
			If (vtACT_Regimen="")
				$vb_continuar:=False:C215
			Else 
				atACTp_RegimenCargo{0}:=vtACT_Regimen
				ARRAY LONGINT:C221($DA_Return;0)
				AT_SearchArray (->atACTp_RegimenCargo;"=";->$DA_Return)
				For ($i;1;Size of array:C274($DA_Return))
					APPEND TO ARRAY:C911($atACT_Cargos;atACTp_ItemCargo{$DA_Return{$i}})
					APPEND TO ARRAY:C911($alACT_Cargos;alACTp_ItemCargo{$DA_Return{$i}})
				End for 
			End if 
		Else 
			COPY ARRAY:C226(atACTp_ItemCargo;$atACT_Cargos)
			COPY ARRAY:C226(alACTp_ItemCargo;$alACT_Cargos)
		End if 
		If ($vb_continuar)
			SORT ARRAY:C229($atACT_Cargos;$alACT_Cargos;>)
			$choice:=ACTKRL_PopUp (->$atACT_Cargos)
			If ($choice>0)
				$vl_idCargo:=$alACT_Cargos{$choice}
				$vb_continuar:=True:C214
				If (Find in array:C230(alACT_IDCargo;$vl_idCargo)#-1)
					$vb_continuar:=(CD_Dlog (0;__ ("Este cargo ya está en la lista."+"\r\r"+"¿Desea cobrarlo nuevamente?");"";__ ("Si");__ ("No"))=1)
				End if 
				If ($vb_continuar)
					AT_Insert (1;1;->atACT_NombreCargo;->atACT_MontoCargos;->alACT_IDCargo)
					atACT_NombreCargo{1}:=$atACT_Cargos{$choice}
					If (Not:C34(KRL_GetBooleanFieldData (->[xxACT_Items:179]ID:1;->$vl_idCargo;->[xxACT_Items:179]EsRelativo:5)))
						$vt_moneda:=KRL_GetTextFieldData (->[xxACT_Items:179]ID:1;->$vl_idCargo;->[xxACT_Items:179]Moneda:10)
						$vt_key:=""
						$vt_simbolo:=""
						$vt_key:=<>gCountryCode+"."+$vt_moneda
						$vt_simbolo:=KRL_GetTextFieldData (->[xxACT_Monedas:146]Key:10;->$vt_key;->[xxACT_Monedas:146]Simbolo:4)
					Else 
						$vt_simbolo:="%"
					End if 
					atACT_MontoCargos{1}:=$vt_simbolo+" "+String:C10(KRL_GetNumericFieldData (->[xxACT_Items:179]ID:1;->$vl_idCargo;->[xxACT_Items:179]Monto:7);"|Despliegue_ACT")
					alACT_IDCargo{1}:=$vl_idCargo
				End if 
			End if 
		Else 
			CD_Dlog (0;__ ("El alumno debe estar asociado a un régimen de estudio antes de poder utilizar esta opción."))
		End if 
		  //ACTcfg_OpcionesGeneracionP ("CalculaMontos")
		
		  //: ($vt_accion="CalculaMontos")
		  //  `QUERY WITH ARRAY([xxACT_Items]ID;alACT_IDCargo)
		  //READ ONLY([xxACT_Items])
		  //CREATE EMPTY SET([xxACT_Items];"ACT_ItemsCargo")
		  //CREATE EMPTY SET([xxACT_Items];"ACT_ItemsCargoRelativo")
		  //$vrACT_MontoCargo:=0
		  //For ($i;1;Size of array(alACT_IDCargo))
		  //QUERY([xxACT_Items];[xxACT_Items]ID=alACT_IDCargo{$i})
		  //If (Not([xxACT_Items]EsRelativo))
		  //ADD TO SET([xxACT_Items];"ACT_ItemsCargo")
		  //$vt_moneda:=[xxACT_Items]Moneda
		  //If ($vt_moneda#ST_GetWord (ACT_DivisaPais ;1;";"))
		  //$pos:=Find in array(abACT_MontosFijosEm;alACT_IDCargo{$i})
		  //If ($pos#-1)
		  //If (abACT_MontosFijosEm{$pos})
		  //$vt_moneda:=ST_GetWord (ACT_DivisaPais ;1;";")
		  //End if 
		  //End if 
		  //End if 
		  //$vrACT_MontoCargo:=$vrACT_MontoCargo+ACTut_retornaMontoEnMoneda ([xxACT_Items]Monto;$vt_moneda;adACT_fechasEm{$i};ST_GetWord (ACT_DivisaPais ;1;";"))
		  //Else 
		  //ADD TO SET([xxACT_Items];"ACT_ItemsCargoRelativo")
		  //End if 
		  //End for 
		  //USE SET("ACT_ItemsCargoRelativo")
		  //$vr_montoDcto:=Sum([xxACT_Items]Monto)
		  //vrACT_MontoCargo:=$vrACT_MontoCargo+Round($vrACT_MontoCargo*$vr_montoDcto/100;<>vlACT_Decimales)
		  //
		  //
		  //SET_ClearSets ("ACT_ItemsCargo";"ACT_ItemsCargoRelativo")
		  //
		  //
		  //QUERY WITH ARRAY([xxACT_Items]ID;alACT_IDCargo)
		  //CREATE SET([xxACT_Items];"ACT_ItemsDescuento")
		  //QUERY SELECTION([xxACT_Items];[xxACT_Items]Afecto_a_descuentos=True;*)
		  //QUERY SELECTION([xxACT_Items]; & ;[xxACT_Items]EsRelativo=False)
		
		
	: ($vt_accion="EliminaCargo")
		C_LONGINT:C283($vl_col;$vl_row)
		LISTBOX GET CELL POSITION:C971(*;"lb_Cargos";$vl_col;$vl_row)
		AT_Delete ($vl_row;1;->atACT_NombreCargo;->atACT_MontoCargos;->alACT_IDCargo)
		
	: ($vt_accion="InsertaDescuento")
		ARRAY TEXT:C222($atACT_RegimenPagares;0)
		COPY ARRAY:C226(atACTp_RegimenDcto;$atACT_RegimenPagares)
		AT_DistinctsArrayValues (->$atACT_RegimenPagares)
		
		ARRAY TEXT:C222($atACT_Descuentos;0)
		ARRAY LONGINT:C221($alACT_Descuentos;0)
		ARRAY BOOLEAN:C223($abACTp_DctoNoAcum;0)
		$vb_continuar:=True:C214
		
		If (Size of array:C274($atACT_RegimenPagares)>1)
			If (vtACT_Regimen="")
				$vb_continuar:=False:C215
			Else 
				atACTp_RegimenDcto{0}:=vtACT_Regimen
				ARRAY LONGINT:C221($DA_Return;0)
				AT_SearchArray (->atACTp_RegimenDcto;"=";->$DA_Return)
				For ($i;1;Size of array:C274($DA_Return))
					APPEND TO ARRAY:C911($atACT_Descuentos;atACTp_ItemDcto{$DA_Return{$i}})
					APPEND TO ARRAY:C911($alACT_Descuentos;alACTp_ItemDcto{$DA_Return{$i}})
					APPEND TO ARRAY:C911($abACTp_DctoNoAcum;abACTp_DctoNoAcum{$DA_Return{$i}})
				End for 
			End if 
		Else 
			COPY ARRAY:C226(atACTp_ItemDcto;$atACT_Descuentos)
			COPY ARRAY:C226(alACTp_ItemDcto;$alACT_Descuentos)
			COPY ARRAY:C226(abACTp_DctoNoAcum;$abACTp_DctoNoAcum)
		End if 
		If ($vb_continuar)
			SORT ARRAY:C229($atACT_Descuentos;$alACT_Descuentos;$abACTp_DctoNoAcum;>)
			$choice:=ACTKRL_PopUp (->$atACT_Descuentos)
			If ($choice>0)
				If ($abACTp_DctoNoAcum{$choice})
					$vb_hayDctoNoAcum:=False:C215
					For ($i;1;Size of array:C274(alACT_NombreDcto))
						$pos:=Find in array:C230(alACTp_ItemDcto;alACT_NombreDcto{$i})
						If ($pos#-1)
							$vb_hayDctoNoAcum:=abACTp_DctoNoAcum{$pos}
						End if 
						If ($vb_hayDctoNoAcum)
							$i:=Size of array:C274(alACT_NombreDcto)
							$vb_continuar:=False:C215
						End if 
					End for 
				End if 
				If ($vb_continuar)
					$vl_idCargo:=$alACT_Descuentos{$choice}
					If (Find in array:C230(alACT_NombreDcto;$vl_idCargo)#-1)
						$vb_continuar:=(CD_Dlog (0;__ ("Este descuento ya está en la lista.")+"\r\r"+__ ("¿Desea cobrarlo nuevamente?");"";__ ("Si");__ ("No"))=1)
					End if 
					If ($vb_continuar)
						AT_Insert (1;1;->atACT_NombreDcto;->atACT_MontoDctos;->alACT_NombreDcto)
						atACT_NombreDcto{1}:=$atACT_Descuentos{$choice}
						
						If (Not:C34(KRL_GetBooleanFieldData (->[xxACT_Items:179]ID:1;->$vl_idCargo;->[xxACT_Items:179]EsRelativo:5)))
							$vt_moneda:=KRL_GetTextFieldData (->[xxACT_Items:179]ID:1;->$vl_idCargo;->[xxACT_Items:179]Moneda:10)
							$vt_key:=""
							$vt_simbolo:=""
							$vt_key:=<>gCountryCode+"."+$vt_moneda
							$vt_simbolo:=KRL_GetTextFieldData (->[xxACT_Monedas:146]Key:10;->$vt_key;->[xxACT_Monedas:146]Simbolo:4)
						Else 
							$vt_simbolo:="%"
						End if 
						atACT_MontoDctos{1}:=$vt_simbolo+" "+String:C10(KRL_GetNumericFieldData (->[xxACT_Items:179]ID:1;->$vl_idCargo;->[xxACT_Items:179]Monto:7);"|Despliegue_ACT")
						alACT_NombreDcto{1}:=$vl_idCargo
					End if 
				Else 
					CD_Dlog (0;__ ("Ya existe un descuento no acumulable. El descuento seleccionado no puede ser agregado."))
				End if 
			End if 
		Else 
			CD_Dlog (0;__ ("El alumno debe estar asociado a un régimen de estudio antes de poder utilizar esta opción."))
		End if 
		
	: ($vt_accion="EliminaDescuento")
		C_LONGINT:C283($vl_col;$vl_row)
		LISTBOX GET CELL POSITION:C971(*;"lb_Descuentos";$vl_col;$vl_row)
		AT_Delete ($vl_row;1;->atACT_NombreDcto;->atACT_MontoDctos;->alACT_NombreDcto)
		
	: ($vt_accion="BuscaAvisosEmitidos")
		  //debe estar definido si se quiere en read only o read write
		QUERY:C277([ACT_Avisos_de_Cobranza:124];[ACT_Avisos_de_Cobranza:124]ID_CuentaCorrriente:2=$ptr1->;*)
		QUERY:C277([ACT_Avisos_de_Cobranza:124]; & ;[ACT_Avisos_de_Cobranza:124]DTS_Creacion:28>$ptr2->;*)
		QUERY:C277([ACT_Avisos_de_Cobranza:124]; & ;[ACT_Avisos_de_Cobranza:124]CreadoPor:29=<>tUSR_CurrentUser)
		
	: ($vt_accion="CargaArreglosAvisos")
		
		ACTcfg_OpcionesGeneracionP ("DeclaraArreglosCuotas")
		ARRAY LONGINT:C221($alACT_idPagares;0)
		SELECTION TO ARRAY:C260([ACT_Avisos_de_Cobranza:124]Fecha_Emision:4;adACT_FEmisionCuota;[ACT_Avisos_de_Cobranza:124]Fecha_Vencimiento:5;adACT_FVencimientoCuota)
		SELECTION TO ARRAY:C260([ACT_Avisos_de_Cobranza:124]Monto_Neto:11;arACT_MontoCuota;[ACT_Avisos_de_Cobranza:124]ID_Pagare:30;$alACT_idPagares)
		
		SORT ARRAY:C229(adACT_FEmisionCuota;adACT_FVencimientoCuota;arACT_MontoCuota;$alACT_idPagares;>)
		$vl_orden:=1
		For ($i;1;Size of array:C274($alACT_idPagares))
			AT_Insert ($i;1;->abACT_IncluidoEnPagare;->alACT_NumeroCuota)
			If ($alACT_idPagares{$i}>0)
				abACT_IncluidoEnPagare{$i}:=True:C214
				alACT_NumeroCuota{$i}:=$vl_orden
				$vl_orden:=$vl_orden+1
			End if 
			$vl_idPagare:=$alACT_idPagares{$i}
			READ ONLY:C145([ACT_Pagares:184])
			KRL_FindAndLoadRecordByIndex (->[ACT_Pagares:184]ID:12;->$vl_idPagare)
			APPEND TO ARRAY:C911(atACT_PeriodoCuota;[ACT_Pagares:184]Periodo:5)
		End for 
		ACTat_LLenaArregloPict (->abACT_IncluidoEnPagare;->apACT_IncluidoEnPagare)
		AT_MultiLevelSort (">>>>>>>";->atACT_PeriodoCuota;->adACT_FEmisionCuota;->adACT_FVencimientoCuota;->alACT_NumeroCuota;->abACT_IncluidoEnPagare;->arACT_MontoCuota;->apACT_IncluidoEnPagare)
		
	: ($vt_accion="ObtieneNumero")
		If (Not:C34(Semaphore:C143("ACT_ConfiguracionPagare";300)))
			If (Not:C34(Semaphore:C143("ACT_NumeracionPagare";120)))
				ACTcfg_OpcionesPagares ("LeeBlobFolio")
				$vl_numero:=vlACTp_Proximo
				vlACTp_Proximo:=vlACTp_Proximo+1
				$vl_ok:=Num:C11(ACTcfg_OpcionesPagares ("GuardaBlobFolio"))
				CLEAR SEMAPHORE:C144("ACT_NumeracionPagare")
				If ($vl_ok=0)
					$vt_retorno:="0"
					CD_Dlog (0;__ ("No fue posible asignar la numeración al Pagaré. Por favor asignar manualmente."))
				Else 
					$vt_retorno:=String:C10($vl_numero)
				End if 
				
			Else 
				CD_Dlog (0;__ ("No fue posible asignar la numeración al Pagaré. Por favor asignar manualmente."))
			End if 
			CLEAR SEMAPHORE:C144("ACT_ConfiguracionPagare")
		Else 
			CD_Dlog (0;__ ("En este momento hay algún usuario generando deudas. Intente ingresar a la configuración en otro momento."))
		End if 
		
	: ($vt_accion="AsignaIDPagareAAC1")
		  //********** INICIO Asignacion pagare a ac **********
		$vb_asignacionOK:=True:C214
		If (Not:C34(Is nil pointer:C315($ptr3)))
			$vb_saltarValidacion:=$ptr3->
		End if 
		ACTcfg_OpcionesGeneracionP ("AsignaIDPagareAAC";$ptr1;$ptr2;->$vb_saltarValidacion)
		If (Size of array:C274($ptr2->)>0)
			$vl_ticks:=Milliseconds:C459
			$vb_salir:=False:C215
			While ((Size of array:C274($ptr2->)>0) & (Not:C34($vb_salir)))
				ACTcfg_OpcionesGeneracionP ("AsignaIDPagareAAC";$ptr1;$ptr2)
				Case of 
					: (Size of array:C274($ptr2->)=0)
						$vb_salir:=True:C214
						
					: ((Milliseconds:C459-$vl_ticks)>=5000)
						$vb_asignacionOK:=False:C215
						$vb_salir:=True:C214
				End case 
			End while 
		End if 
		If (Not:C34($vb_asignacionOK))
			LOG_RegisterEvt ("No fue posible asociar el Pagaré número "+String:C10($vl_idPagare)+" a el/los aviso(s) de cobranza número "+AT_array2text ($ptr2;"-";"### ### ##0")+". Por favor asignar manualmente los pagarés.")
			CD_Dlog (0;__ ("No fue posible asociar el Pagaré número ")+String:C10($vl_idPagare)+__ (" a el/los aviso(s) de cobranza número ")+AT_array2text ($ptr2;"-";"### ### ##0")+__ (". Por favor asignar manualmente los pagarés."))
		End if 
		  //********** FIN **********
		
	: ($vt_accion="AsignaIDPagareAAC")
		If (Not:C34(Is nil pointer:C315($ptr3)))
			$vb_saltarValidacion:=$ptr3->
		End if 
		READ WRITE:C146([ACT_Avisos_de_Cobranza:124])
		QUERY WITH ARRAY:C644([ACT_Avisos_de_Cobranza:124]ID_Aviso:1;$ptr2->)
		If (Not:C34($vb_saltarValidacion))
			QUERY SELECTION:C341([ACT_Avisos_de_Cobranza:124];[ACT_Avisos_de_Cobranza:124]ID_Pagare:30=0)  // por seguridad...
		End if 
		APPLY TO SELECTION:C70([ACT_Avisos_de_Cobranza:124];[ACT_Avisos_de_Cobranza:124]ID_Pagare:30:=$ptr1->)
		If (Records in set:C195("LockedSet")>0)
			USE SET:C118("LockedSet")
			SELECTION TO ARRAY:C260([ACT_Avisos_de_Cobranza:124]ID_Aviso:1;$ptr2->)
		Else 
			AT_Initialize ($ptr2)
		End if 
		KRL_UnloadReadOnly (->[ACT_Avisos_de_Cobranza:124])
		
	: ($vt_accion="CalculaMontoPagare")
		$vl_idPagare:=$ptr1->
		If ($vl_idPagare>0)
			ARRAY LONGINT:C221($alACT_idsAvisos;0)
			READ ONLY:C145([ACT_Avisos_de_Cobranza:124])
			QUERY:C277([ACT_Avisos_de_Cobranza:124];[ACT_Avisos_de_Cobranza:124]ID_Pagare:30=$vl_idPagare)
			SELECTION TO ARRAY:C260([ACT_Avisos_de_Cobranza:124]ID_Aviso:1;$alACT_idsAvisos)
			
			KRL_FindAndLoadRecordByIndex (->[ACT_Pagares:184]ID:12;->$vl_idPagare;True:C214)
			[ACT_Pagares:184]Monto:8:=ACTcar_CalculaMontos ("calcMontoFromArrNumAvisoMPago";->$alACT_idsAvisos;->[ACT_Cargos:173]Monto_Neto:5;Current date:C33(*))
			  //SAVE RECORD([ACT_Pagares])
			ACTpagares_fSave 
			KRL_UnloadReadOnly (->[ACT_Pagares:184])
		End if 
		
	: ($vt_accion="CargaDatosMonedas")
		ACTcfgmyt_OpcionesGenerales ("CargaListBoxEmision")
		cbMontosEnMonedaPago:=Num:C11(PREF_fGet (0;"ACTcfg_EmitirEnMontosFijosP";"0"))
		$vt_opcion:=String:C10(cbMontosEnMonedaPago)
		ACTcfgmyt_OpcionesGenerales ("SetEstadoObjetosMontosFijos";->$vt_opcion)
		
	: ($vt_accion="TestInitVars")
		If (vbACTp_PagareGenerado)
			TRACE:C157
			AL_UpdateArrays (xALP_PagareCuotas;0)
			ACTcfg_OpcionesGeneracionP ("OnLoadVars")
			AL_UpdateArrays (xALP_PagareCuotas;-2)
		End if 
		
End case 
$0:=$vt_retorno