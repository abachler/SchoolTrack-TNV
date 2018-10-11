//%attributes = {}
  //ACTcc_EmisionAvisos

C_BLOB:C604($xBlob)
C_LONGINT:C283($vl_idAviso;$vl_proc;$cb_NoPrepagarAuto)
C_BOOLEAN:C305($done)

C_POINTER:C301(ArregloMoneda)
ARRAY LONGINT:C221(alACT_AvisosImprimir;0)
ARRAY LONGINT:C221(al_CtasCte;0)
ARRAY LONGINT:C221(al_IDApoderados;0)
ARRAY LONGINT:C221(alACT_CuentasTomadas;0)
ARRAY DATE:C224(aDate1;0)
ARRAY DATE:C224(aDate2;0)
ARRAY DATE:C224(aDate3;0)
ARRAY DATE:C224(aDate4;0)
ARRAY LONGINT:C221(aLongInt1;0)
ARRAY LONGINT:C221(aLongInt2;0)
  //CREATE EMPTY SET([ACT_Avisos_de_Cobranza];"RecalculoAvisos")  `rch Para el recalculo de saldo anterior de los avisos
ARRAY LONGINT:C221($al_idsAvisos2Recalc;0)
ARRAY LONGINT:C221($al_rn_AC_stsAlert;0)  //STS
ARRAY LONGINT:C221($al_IdCuenta;0)

ARRAY LONGINT:C221($alACT_idsCtas;0)
If (Count parameters:C259>=3)
	COPY ARRAY:C226($3->;$alACT_idsCtas)
End if 

MESSAGES OFF:C175

$opcion:=$1
$fromMonth:=aMeses
$toMonth:=aMeses2
$diaEmision:=vdACT_DiaAviso
$ufDate:=vdACT_FechaUFSel
If (vdACT_AñoAviso=0)
	vdACT_AñoAviso:=Year of:C25(Current date:C33(*))
End if 
$year:=vdACT_AñoAviso
$year2:=vdACT_AñoAviso2
$fecha1:=DT_GetDateFromDayMonthYear (1;$fromMonth;$year)
$fecha2:=DT_GetDateFromDayMonthYear (DT_GetLastDay ($toMonth;$year2);$toMonth;$year2)

  //20151013 RCH
$cb_NoPrepagarAuto:=cb_NoPrepagarAuto

If (Generar)
	b1:=1
	b2:=0
	b3:=0
	vlACT_SelectedMatrixID:=0
	vlACT_SelectedItemID:=0
	vsACT_Glosa:=""
	vsACT_Moneda:=""
	vrACT_Monto:=0
	cbACT_EsDescuento:=0  //era cbACT_EsDescuento:=False (ABK_Integracion_AT)
	cbACT_Afecto_Iva:=0  // era cbACT_Afecto_Iva:=False (ABK_Integracion_AT)
	bc_ReplaceSameDescription:=0
	viACT_DiaGeneracion:=viACT_DiaDeuda  //Viene de las preferencias
	bc_EliminaDesctos:=0
	vsACT_CtaContable:=""
	vsACT_CentroContable:=""
	vsACT_CCtaContable:=""
	vsACT_CCentroContable:=""
	vsACT_CodAuxCta:=""
	vsACT_CodAuxCCta:=""
	If (Application type:C494#4D Remote mode:K5:5)
		bc_ExecuteOnServer:=0
	Else 
		bc_ExecuteOnServer:=1
	End if 
	vbACT_CargoEspecial:=False:C215
	vbACT_ImputacionUNica:=False:C215
	cbACT_NoDocTrib:=0
	
	
	
	  //BLOB_Variables2Blob (->xBlob;0;->aLong1;->b1;->b2;->b3;->vlACT_SelectedMatrixID;->vlACT_selectedItemId;->vsACT_Glosa;->vsACT_Moneda;->vrACT_Monto;->cbACT_EsDescuento;->cbACT_Afecto_IVA;->bc_ReplaceSameDescription;->aMeses;->aMeses2;->viACT_DiaGeneracion;->bc_ExecuteOnServer;->vbACT_CargoEspecial;->vdACT_AñoAviso;->bc_EliminaDesctos;->vsACT_CtaContable;->vsACT_CentroContable;->vsACT_CCtaContable;->vsACT_CCentroContable;->vbACT_ImputacionUNica;->vsACT_CodAuxCta;->vsACT_CodAuxCCta;->cbACT_NoDocTrib;->vdACT_FechaUFSel;->vdACT_AñoAviso2;->atACT_NombreMonedaEm;->adACT_fechasEm)
	  //$cb_NoPrepagarAuto:=cb_NoPrepagarAuto
	  //ACTcc_GeneraCargos (xBlob)  `Aqui se recalculan todos los cargos para todas las cuentas, para el mes seleccionado.
	
	ACTcar_OpcionesGenerales ("CargaBlobParaGeneracion";->xBlob)
	$cb_NoPrepagarAuto:=cb_NoPrepagarAuto
	
	$processID:=New process:C317("ACTcc_GeneraCargos";Pila_256K;"Generación de deudas";xblob)
	DELAY PROCESS:C323(Current process:C322;60)  //permitir que el proceso se inicie
	$generando:=False:C215
	While (Not:C34($generando))
		IDLE:C311
		GET PROCESS VARIABLE:C371($processID;vbACT_Generando;$generando)
	End while 
	GET PROCESS VARIABLE:C371($processID;alACT_CuentasTomadas;alACT_CuentasTomadas)
	SET PROCESS VARIABLE:C370($processID;vb_calcularCtas;False:C215)
	SET PROCESS VARIABLE:C370($processID;vbACT_TerminardeGenerar;$generando)
	
	For ($i;1;Size of array:C274(alACT_CuentasTomadas))
		$existe:=Find in array:C230(aLong1;alACT_CuentasTomadas{$i})
		AT_Delete ($existe;1;->aLong1)
	End for 
End if 

  //20120616 RCH Para calcular saldos al emitir...
ARRAY LONGINT:C221($alACTpp_idsPersonas;0)
ARRAY LONGINT:C221($alACTter_idsTerceros;0)

If (Size of array:C274(aLong1)>0)
	READ WRITE:C146([ACT_CuentasCorrientes:175])
	CREATE SELECTION FROM ARRAY:C640([ACT_CuentasCorrientes:175];aLong1)
	KRL_RelateSelection (->[Personas:7]No:1;->[ACT_CuentasCorrientes:175]ID_Apoderado:9;"")
	If (mAvisoAlumno=1)
		SELECTION TO ARRAY:C260([ACT_CuentasCorrientes:175]ID:1;$al_IdCuenta)
	End if 
	KRL_RelateSelection (->[ACT_CuentasCorrientes:175]ID_Apoderado:9;->[Personas:7]No:1;"")
	READ WRITE:C146([xxACT_DesctosXItem:103])
	KRL_RelateSelection (->[xxACT_DesctosXItem:103]ID_CtaCte:5;->[ACT_CuentasCorrientes:175]ID:1;"")
	QUERY SELECTION:C341([xxACT_DesctosXItem:103];[xxACT_DesctosXItem:103]Fecha_Generacion:7>=$fecha1;*)
	QUERY SELECTION:C341([xxACT_DesctosXItem:103]; & ;[xxACT_DesctosXItem:103]Fecha_Generacion:7<=$fecha2)
	CREATE SET:C116([xxACT_DesctosXItem:103];"desctos")
	FIRST RECORD:C50([xxACT_DesctosXItem:103])
	While (Not:C34(End selection:C36([xxACT_DesctosXItem:103])))
		If (Not:C34(ACTcm_IsMonthOpenFromDate ([xxACT_DesctosXItem:103]Fecha_Generacion:7)))
			REMOVE FROM SET:C561([xxACT_DesctosXItem:103];"desctos")
		End if 
		NEXT RECORD:C51([xxACT_DesctosXItem:103])
	End while 
	USE SET:C118("desctos")
	CLEAR SET:C117("desctos")
	DELETE SELECTION:C66([xxACT_DesctosXItem:103])
	UNLOAD RECORD:C212([ACT_CuentasCorrientes:175])
	KRL_UnloadReadOnly (->[xxACT_DesctosXItem:103])
	
	READ WRITE:C146([ACT_CuentasCorrientes:175])
	CREATE SELECTION FROM ARRAY:C640([ACT_CuentasCorrientes:175];aLong1)
	KRL_RelateSelection (->[Personas:7]No:1;->[ACT_CuentasCorrientes:175]ID_Apoderado:9;"")
	SELECTION TO ARRAY:C260([Personas:7]No:1;al_IDApoderados)
	KRL_RelateSelection (->[ACT_CuentasCorrientes:175]ID_Apoderado:9;->[Personas:7]No:1;"")
	KRL_RelateSelection (->[ACT_Matrices:177]ID:1;->[ACT_CuentasCorrientes:175]ID_Matriz:7;"")
	SELECTION TO ARRAY:C260([ACT_Matrices:177]Moneda:9;$atACT_MonedasMatrices)
	SELECTION TO ARRAY:C260([ACT_CuentasCorrientes:175];aLong1)
	
	  //ticket 155965  JVP
	  ///para ordenar de manera diferente, es decir segun nivel y curso
	
	If (bAvisoApoderado=0)
		If (OrdenCurNivNom=1)
			ARRAY LONGINT:C221(al_IDApoderados;0)
			CREATE SELECTION FROM ARRAY:C640([ACT_CuentasCorrientes:175];aLong1)
			KRL_RelateSelection (->[Alumnos:2]numero:1;->[ACT_CuentasCorrientes:175]ID_Alumno:3;"")
			ARRAY LONGINT:C221($al_temp;0)
			ARRAY LONGINT:C221($al_alumnos;0)
			ORDER BY:C49([Alumnos:2];[Alumnos:2]nivel_numero:29;>;[Alumnos:2]curso:20;>;[Alumnos:2]apellidos_y_nombres:40;>)
			SELECTION TO ARRAY:C260([Alumnos:2];$al_temp)
			For ($x;1;Size of array:C274($al_temp))
				GOTO RECORD:C242([Alumnos:2];$al_temp{$x})
				QUERY:C277([ACT_CuentasCorrientes:175];[ACT_CuentasCorrientes:175]ID_Alumno:3=[Alumnos:2]numero:1)
				QUERY:C277([Personas:7];[Personas:7]No:1=[ACT_CuentasCorrientes:175]ID_Apoderado:9)
				APPEND TO ARRAY:C911(al_IDApoderados;[Personas:7]No:1)
				APPEND TO ARRAY:C911($al_alumnos;Record number:C243([ACT_CuentasCorrientes:175]))
			End for 
		End if 
	Else 
		
		
		If (OrdenCurNivNom=1)
			  //orden en caso
			CREATE SELECTION FROM ARRAY:C640([ACT_CuentasCorrientes:175];aLong1;"")
			CREATE SET:C116([ACT_CuentasCorrientes:175];"cuentas_todas")
			ARRAY LONGINT:C221($al_tempapoderado;0)
			COPY ARRAY:C226(al_IDApoderados;$al_tempapoderado)
			ARRAY LONGINT:C221(al_IDApoderados;0)
			ARRAY TEXT:C222($at_apellidocuenta;0)
			ARRAY LONGINT:C221($al_cuentanivel;0)
			ARRAY TEXT:C222($at_curso;0)
			For ($x;1;Size of array:C274($al_tempapoderado))
				QUERY:C277([Personas:7];[Personas:7]No:1=$al_tempapoderado{$x})
				QUERY:C277([ACT_CuentasCorrientes:175];[ACT_CuentasCorrientes:175]ID_Apoderado:9=[Personas:7]No:1)
				CREATE SET:C116([ACT_CuentasCorrientes:175];"cuentas_apo")
				INTERSECTION:C121("cuentas_todas";"cuentas_apo";"cuentas_apo")
				USE SET:C118("cuentas_apo")
				KRL_RelateSelection (->[Alumnos:2]numero:1;->[ACT_CuentasCorrientes:175]ID_Alumno:3;"")
				ORDER BY:C49([Alumnos:2];[Alumnos:2]nivel_numero:29;>;[Alumnos:2]curso:20;>;[Alumnos:2]apellidos_y_nombres:40;>)
				REDUCE SELECTION:C351([Alumnos:2];1)
				APPEND TO ARRAY:C911(al_IDApoderados;$al_tempapoderado{$x})
				APPEND TO ARRAY:C911($at_apellidocuenta;[Alumnos:2]apellidos_y_nombres:40)
				APPEND TO ARRAY:C911($al_cuentanivel;[Alumnos:2]nivel_numero:29)
				APPEND TO ARRAY:C911($at_curso;[Alumnos:2]curso:20)
			End for 
			SET_ClearSets ("cuentas_apo";"cuentas_todas")
			
			AT_MultiLevelSort (">>>";->$al_cuentanivel;->$at_curso;->$at_apellidocuenta;->al_IDApoderados)  //20160823 RCH Movi linea ya que daba error cuando no estba dentro del if
		End if 
		
	End if 
	
	If (Application type:C494#4D Server:K5:6)
		$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;__ ("Emitiendo avisos de cobranza para el mes de ")+aMeses{$fromMonth}+__ (" de ")+String:C10($year)+__ ("..."))
	Else 
		$vl_proc:=IT_UThermometer (1;0;__ ("Emitiendo avisos de cobranza..."))
	End if 
	If ($year#$year2)
		$toMonth:=(($year2-$year)*12)+$toMonth-$fromMonth+1
	Else 
		$toMonth:=$toMonth-$fromMonth+1
	End if 
	
	$Iterations:=$toMonth*Size of array:C274(al_IDApoderados)
	If ($Iterations>=30)
		$div:=30
	Else 
		$div:=1
	End if 
	$currentIteration:=0
	$indexPrev:=0
	For ($monthIndex;1;$toMonth)  //Loop por los meses a generar
		If (Int:C8(($monthIndex+$fromMonth+$indexPrev-1)/13)>$indexPrev)
			$indexPrev:=Int:C8(($monthIndex+$fromMonth+$indexPrev-1)/13)
			$month:=$monthIndex-(12*$indexPrev)+$fromMonth-1
			$year:=$year+1
		Else 
			$month:=$monthIndex-(12*$indexPrev)+$fromMonth-1
		End if 
		
		If (ACTcm_IsMonthOpenFromMonthYear ($month;$year))
			  //20140429 RCH Cuando se tenia configurado más de 31 días después de la emisión, el aviso no vencia el mes siguiente.
			If (cbVctoSegunConf=0)  //20180725 RCH Ticket 206430
				viACT_DiaVencimiento:=l_diasEmision
			End if 
			  //mAvisoApoderado y mAvisoAlumno son las variables de control de emision de avisos
			If (cbVctoSegunConf=1)
				$date:=ACTut_fFechaValida (DT_GetDateFromDayMonthYear ($diaEmision;$month;$year))
				$fechaVencimiento:=ACTut_fFechaValida ($date+viACT_DiaVencimiento)
				$fechaPago2:=ACTut_fFechaValida ($fechaVencimiento+viACT_DiaVencimiento2)
				$fechaPago3:=ACTut_fFechaValida ($fechaPago2+viACT_DiaVencimiento3)
				$fechaPago4:=ACTut_fFechaValida ($fechaPago3+viACT_DiaVencimiento4)
			Else 
				$date:=ACTut_fFechaValida2 (DT_GetDateFromDayMonthYear ($diaEmision;$month;$year))
				  //20120616 RCH Se agrega preferencia para que el vencimiento siempre sea el ultimo dia del mes o el siguiente si cae domingo...
				If (cbUltimoDiaMes=0)
					$vl_diaVenc:=Day of:C23($date)+viACT_DiaVencimiento
					If (($vl_diaVenc=29) | ($vl_diaVenc=30) | ($vl_diaVenc=31))
						$fechaVencimiento:=ACTut_fFechaValida2 (DT_GetDateFromDayMonthYear ($vl_diaVenc;Month of:C24($date);Year of:C25($date)))
					Else 
						$fechaVencimiento:=ACTut_fFechaValida2 ($date+viACT_DiaVencimiento)
					End if 
				Else 
					$fechaVencimiento:=ACTut_fFechaValida2 (DT_GetDateFromDayMonthYear (DT_GetLastDay ($month;$year);$month;$year))
				End if 
				$fechaPago2:=ACTut_fFechaValida2 ($fechaVencimiento+viACT_DiaVencimiento2)
				$fechaPago3:=ACTut_fFechaValida2 ($fechaPago2+viACT_DiaVencimiento3)
				$fechaPago4:=ACTut_fFechaValida2 ($fechaPago3+viACT_DiaVencimiento4)
			End if 
			For ($i_Apoderados;1;Size of array:C274(al_IDApoderados))
				$currentIteration:=$currentIteration+1
				  //vlACT_NumMonedas:=ACTcc_OrdenaDocsCargoporMoneda ($i_Apoderados;$month;$year)
				  //ACTcar_RecalculaRXA (al_IDApoderados{$i_Apoderados};$month;$year)
				If ((bAvisoApoderado=0) & (OrdenCurNivNom=1))
					ARRAY LONGINT:C221($alACT_idsCtas;0)
					GOTO RECORD:C242([ACT_CuentasCorrientes:175];$al_alumnos{$i_Apoderados})
					APPEND TO ARRAY:C911($alACT_idsCtas;[ACT_CuentasCorrientes:175]ID:1)
					vlACT_NumMonedas:=ACTcc_OrdenaDocsCargoporMoneda ($i_Apoderados;$month;$year;->$alACT_idsCtas)
					ACTcar_RecalculaRXA (al_IDApoderados{$i_Apoderados};$month;$year;->$alACT_idsCtas)
				Else 
					  //20120718 ASM Para solucionar el problema de emision de cuentas distintas con el mismo apoderado ticket 111078
					vlACT_NumMonedas:=ACTcc_OrdenaDocsCargoporMoneda ($i_Apoderados;$month;$year;->$al_IdCuenta)
					ACTcar_RecalculaRXA (al_IDApoderados{$i_Apoderados};$month;$year;->$al_IdCuenta)
				End if 
				
				
				For ($i_Monedas;1;vlACT_NumMonedas)
					CREATE SELECTION FROM ARRAY:C640([ACT_Documentos_de_Cargo:174];apACT_ArreglosMonedas{$i_Monedas}->)
					
					If (Size of array:C274($alACT_idsCtas)>0)
						QUERY SELECTION WITH ARRAY:C1050([ACT_Documentos_de_Cargo:174]ID_CuentaCorriente:6;$alACT_idsCtas)
					End if 
					
					If (mAvisoAlumno=1)
						ARRAY LONGINT:C221(al_CtasCte;0)
						AT_DistinctsFieldValues (->[ACT_Documentos_de_Cargo:174]ID_CuentaCorriente:6;->al_CtasCte)
					Else 
						  //ARRAY LONGINT(al_CtasCte;1)
						If (cs_GeneraAvisoPorFamilia=0)  //20170507 RCH Nueva pref
							ARRAY LONGINT:C221(al_CtasCte;1)
						Else 
							  //emite un AC por familia
							ARRAY LONGINT:C221($al_idsFamiliasUnicas;0)
							DISTINCT VALUES:C339([ACT_Documentos_de_Cargo:174]ID_CuentaCorriente:6;$al_idsFamiliasUnicas)
							If (Size of array:C274($al_idsFamiliasUnicas)>1)
								KRL_RelateSelection (->[ACT_CuentasCorrientes:175]ID:1;->[ACT_Documentos_de_Cargo:174]ID_CuentaCorriente:6;"")
							Else   // Modificado por: Saúl Ponce (15/11/2017) Ticket 187724, asegurar que exista una cuenta corriente cargada
								LOAD RECORD:C52([ACT_Documentos_de_Cargo:174])
								QUERY:C277([ACT_CuentasCorrientes:175];[ACT_CuentasCorrientes:175]ID:1=[ACT_Documentos_de_Cargo:174]ID_CuentaCorriente:6)
							End if   // Modificado por: Saúl Ponce (15/11/2017) Ticket 187724, moví el end if porque en array de familias quedaba vacío.
							KRL_RelateSelection (->[Alumnos:2]numero:1;->[ACT_CuentasCorrientes:175]ID_Alumno:3;"")
							DISTINCT VALUES:C339([Alumnos:2]Familia_Número:24;al_CtasCte)
							  //End if // Modificado por: Saúl Ponce (15/11/2017) Ticket 187724, acá terminaba la condición antes de cambiarla.
						End if 
					End if 
					For ($jy;1;Size of array:C274(al_CtasCte))
						  //cb_NoPrepagarAuto:=$cb_NoPrepagarAuto  //por si se resetea en alguna parte la variable seleccionada en la ventana de emisión.
						
						  //20170507 RCH
						CREATE SELECTION FROM ARRAY:C640([ACT_Documentos_de_Cargo:174];apACT_ArreglosMonedas{$i_Monedas}->)
						Case of 
							: (mAvisoAlumno=1)
								QUERY SELECTION:C341([ACT_Documentos_de_Cargo:174];[ACT_Documentos_de_Cargo:174]ID_CuentaCorriente:6=al_CtasCte{$jy})
								If (vlACT_numeroCuotas#0)
									$vlACT_idCta:=al_CtasCte{$jy}
									$vlACT_idMatriz:=KRL_GetNumericFieldData (->[ACT_CuentasCorrientes:175]ID:1;->$vlACT_idCta;->[ACT_CuentasCorrientes:175]ID_Matriz:7)
									QUERY SELECTION:C341([ACT_Documentos_de_Cargo:174];[ACT_Documentos_de_Cargo:174]ID_Matriz:2=$vlACT_idMatriz)
								End if 
							: (cs_GeneraAvisoPorFamilia=1)
								
								KRL_RelateSelection (->[ACT_CuentasCorrientes:175]ID:1;->[ACT_Documentos_de_Cargo:174]ID_CuentaCorriente:6;"")
								KRL_RelateSelection (->[Alumnos:2]numero:1;->[ACT_CuentasCorrientes:175]ID_Alumno:3;"")
								QUERY SELECTION:C341([Alumnos:2];[Alumnos:2]Familia_Número:24=al_CtasCte{$jy})
								KRL_RelateSelection (->[ACT_CuentasCorrientes:175]ID_Alumno:3;->[Alumnos:2]numero:1;"")
								SELECTION TO ARRAY:C260([ACT_CuentasCorrientes:175]ID:1;$alACT_idsCtasEXFamilia)
								QUERY SELECTION WITH ARRAY:C1050([ACT_Documentos_de_Cargo:174]ID_CuentaCorriente:6;$alACT_idsCtasEXFamilia)
								
						End case 
						
						ARRAY LONGINT:C221($aDocCargo;0)
						LONGINT ARRAY FROM SELECTION:C647([ACT_Documentos_de_Cargo:174];$aDocCargo;"")
						If (Records in selection:C76([ACT_Documentos_de_Cargo:174])>0)
							If (mAvisoApoderado=1)
								QUERY:C277([ACT_CuentasCorrientes:175];[ACT_CuentasCorrientes:175]ID_Apoderado:9=al_IDApoderados{$i_Apoderados})
							Else 
								QUERY:C277([ACT_CuentasCorrientes:175];[ACT_CuentasCorrientes:175]ID:1=[ACT_Documentos_de_Cargo:174]ID_CuentaCorriente:6)
							End if 
							
							If (Size of array:C274($alACT_idsCtas)>0)
								QUERY SELECTION WITH ARRAY:C1050([ACT_CuentasCorrientes:175]ID:1;$alACT_idsCtas)
							End if 
							
							If (mAvisoAlumno=1)
								$vl_idCtaCte:=[ACT_CuentasCorrientes:175]ID:1
							Else 
								$vl_idCtaCte:=0
							End if 
							ACTac_CreaAviso ($date;$fechaVencimiento;$fechaPago2;$fechaPago3;$fechaPago4;al_IDApoderados{$i_Apoderados};0;$vl_idCtaCte;$month;$year;vtACT_CurrentUser)
							
							If ($opcion=1)
								INSERT IN ARRAY:C227(alACT_AvisosImprimir;Size of array:C274(alACT_AvisosImprimir)+1)
								alACT_AvisosImprimir{Size of array:C274(alACT_AvisosImprimir)}:=Record number:C243([ACT_Avisos_de_Cobranza:124])
							End if 
							
							  // asignacion de fecha de emision a los cargos  y documentos existentes en el período
							  //y asignación de No_comprobante a transacciones y docs de cargo
							
							READ ONLY:C145([ACT_Cargos:173])
							READ ONLY:C145([ACT_Documentos_de_Cargo:174])
							READ ONLY:C145([ACT_Transacciones:178])
							CREATE SELECTION FROM ARRAY:C640([ACT_Documentos_de_Cargo:174];$aDocCargo)
							KRL_RelateSelection (->[ACT_Cargos:173]ID_Documento_de_Cargo:3;->[ACT_Documentos_de_Cargo:174]ID_Documento:1;"")
							$setCargosInvolucrados:="CargosInvolucrados"
							CREATE SET:C116([ACT_Cargos:173];$setCargosInvolucrados)
							SELECTION TO ARRAY:C260([ACT_Cargos:173]Monto_Neto:5;$aNeto;[ACT_Cargos:173]MontosPagados:8;$aPagados)
							ARRAY REAL:C219(aSaldo;Size of array:C274($aNeto))
							
							For ($Cargo;1;Size of array:C274($aNeto))
								aSaldo{$Cargo}:=$aPagados{$Cargo}-$aNeto{$Cargo}
							End for 
							
							KRL_RelateSelection (->[ACT_Transacciones:178]ID_Item:3;->[ACT_Cargos:173]ID:1;"")
							CREATE SET:C116([ACT_Documentos_de_Cargo:174];"DocsdeCargo")
							
							ARRAY DATE:C224(aDate1;Records in selection:C76([ACT_Cargos:173]))
							ARRAY DATE:C224(aDate2;Records in selection:C76([ACT_Documentos_de_Cargo:174]))
							ARRAY DATE:C224(aDate3;Records in selection:C76([ACT_Cargos:173]))
							ARRAY DATE:C224(aDate4;Records in selection:C76([ACT_Documentos_de_Cargo:174]))
							ARRAY LONGINT:C221(aLongInt1;Records in selection:C76([ACT_Transacciones:178]))
							ARRAY LONGINT:C221(aLongInt2;Records in selection:C76([ACT_Documentos_de_Cargo:174]))
							
							AT_Populate (->aDate1;->[ACT_Avisos_de_Cobranza:124]Fecha_Emision:4)
							AT_Populate (->aDate2;->[ACT_Avisos_de_Cobranza:124]Fecha_Emision:4)
							AT_Populate (->aDate3;->[ACT_Avisos_de_Cobranza:124]Fecha_Vencimiento:5)
							AT_Populate (->aDate4;->[ACT_Avisos_de_Cobranza:124]Fecha_Vencimiento:5)
							AT_Populate (->aLongInt1;->[ACT_Avisos_de_Cobranza:124]ID_Aviso:1)
							AT_Populate (->aLongInt2;->[ACT_Avisos_de_Cobranza:124]ID_Aviso:1)
							
							ARRAY LONGINT:C221($aRNT;0)
							ARRAY LONGINT:C221($aRNDC;0)
							ARRAY LONGINT:C221($aRNC;0)
							LONGINT ARRAY FROM SELECTION:C647([ACT_Transacciones:178];$aRNT;"")
							LONGINT ARRAY FROM SELECTION:C647([ACT_Documentos_de_Cargo:174];$aRNDC;"")
							LONGINT ARRAY FROM SELECTION:C647([ACT_Cargos:173];$aRNC;"")
							
							For ($tt;1;Size of array:C274($aRNT))
								READ WRITE:C146([ACT_Transacciones:178])
								GOTO RECORD:C242([ACT_Transacciones:178];$aRNT{$tt})
								$readOnlyState:=KRL_ReadWrite (->[ACT_Transacciones:178])
								If (Not:C34($readOnlyState))
									[ACT_Transacciones:178]No_Comprobante:10:=aLongInt1{$tt}
									SAVE RECORD:C53([ACT_Transacciones:178])
								Else 
									$params:=String:C10([ACT_Transacciones:178]ID_Transaccion:1)+";"+String:C10(aLongInt1{$tt})
									BM_CreateRequest ("ACT_EmiteTransaccion";$params)
								End if 
							End for 
							
							For ($tt;1;Size of array:C274($aRNDC))
								READ WRITE:C146([ACT_Documentos_de_Cargo:174])
								GOTO RECORD:C242([ACT_Documentos_de_Cargo:174];$aRNDC{$tt})
								$readOnlyState:=KRL_ReadWrite (->[ACT_Documentos_de_Cargo:174])
								If (Not:C34($readOnlyState))
									[ACT_Documentos_de_Cargo:174]FechaEmision:21:=aDate2{$tt}
									[ACT_Documentos_de_Cargo:174]Fecha_Vencimiento:20:=aDate4{$tt}
									[ACT_Documentos_de_Cargo:174]No_ComprobanteInterno:15:=aLongInt2{$tt}
									SAVE RECORD:C53([ACT_Documentos_de_Cargo:174])
								Else 
									$params:=String:C10([ACT_Documentos_de_Cargo:174]ID_Documento:1)+";"+String:C10(aDate2{$tt})+";"+String:C10(aDate4{$tt})+";"+String:C10(aLongInt2{$tt})
									BM_CreateRequest ("ACT_EmiteDoc";$params)
								End if 
							End for 
							For ($tt;1;Size of array:C274($aRNC))
								READ WRITE:C146([ACT_Cargos:173])
								GOTO RECORD:C242([ACT_Cargos:173];$aRNC{$tt})
								$readOnlyState:=KRL_ReadWrite (->[ACT_Cargos:173])
								If (Not:C34($readOnlyState))
									[ACT_Cargos:173]FechaEmision:22:=aDate1{$tt}
									[ACT_Cargos:173]Fecha_de_Vencimiento:7:=aDate3{$tt}
									  //[ACT_Cargos]LastInterestsUpdate:=aDate3{$tt}
									[ACT_Cargos:173]LastInterestsUpdate:42:=ACTcar_FechaCalculoIntereses ("ObtieneFecha";->[ACT_Cargos:173]FechaEmision:22;->[ACT_Cargos:173]Fecha_de_Vencimiento:7)  //20140825 RCH Intereses
									[ACT_Cargos:173]Saldo:23:=aSaldo{$tt}
									SAVE RECORD:C53([ACT_Cargos:173])
									ACTcfg_ItemsMatricula ("AgregaElementoArreglo")
								Else 
									$params:=String:C10([ACT_Cargos:173]ID:1)+";"+String:C10(aDate1{$tt})+";"+String:C10(aDate3{$tt})+";"+String:C10(aSaldo{$tt})
									BM_CreateRequest ("ACT_EmiteCargo";$params)
								End if 
							End for 
							
							USE SET:C118("DocsdeCargo")
							FIRST RECORD:C50([ACT_Documentos_de_Cargo:174])
							
							For ($i;1;Records in selection:C76([ACT_Documentos_de_Cargo:174]))
								QUERY:C277([ACT_Cargos:173];[ACT_Cargos:173]ID_Documento_de_Cargo:3=[ACT_Documentos_de_Cargo:174]ID_Documento:1)
								[ACT_Documentos_de_Cargo:174]Saldo:10:=Sum:C1([ACT_Cargos:173]Saldo:23)
								$set2ReCalc:="set2Recalc"
								CREATE SET:C116([ACT_Cargos:173];$set2ReCalc)
								[ACT_Documentos_de_Cargo:174]Saldo:10:=ACTcar_CalculaMontos ("calcMontoFromSetMCobro";->$set2ReCalc;->[ACT_Cargos:173]Saldo:23;vdACT_FechaUFSel)
								SAVE RECORD:C53([ACT_Documentos_de_Cargo:174])
								NEXT RECORD:C51([ACT_Documentos_de_Cargo:174])
							End for 
							
							CLEAR SET:C117("DocsdeCargo")
							
							KRL_UnloadReadOnly (->[ACT_Cargos:173])
							KRL_UnloadReadOnly (->[ACT_Documentos_de_Cargo:174])
							KRL_UnloadReadOnly (->[ACT_Transacciones:178])
							
							AT_Initialize (->aDate1;->aDate2;->aDate3;->aDate4;->aLongInt1;->aLongInt2;->aSaldo)
							
							USE SET:C118($setCargosInvolucrados)
							QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]Ref_Item:16#-2)
							CREATE SET:C116([ACT_Cargos:173];$setCargosInvolucrados)
							$vl_idAviso:=[ACT_Avisos_de_Cobranza:124]ID_Aviso:1
							BLOB_Variables2Blob (->$xBlob;0;->$vl_idAviso;->vdACT_FechaUFSel)
							$done:=ACTac_CalculaMontos ($xBlob)
							If (Not:C34($done))
								BM_CreateRequest ("calculaMontosAvisos";"";String:C10($vl_idAviso);$xBlob)
							End if 
							KRL_FindAndLoadRecordByIndex (->[ACT_Avisos_de_Cobranza:124]ID_Aviso:1;->$vl_idAviso;True:C214)
							SAVE RECORD:C53([ACT_Avisos_de_Cobranza:124])
							CLEAR SET:C117($setCargosInvolucrados)
							
							If (mAvisoApoderado=1)
								QUERY:C277([ACT_Cargos:173];[ACT_Cargos:173]ID_Apoderado:18=al_IDApoderados{$i_Apoderados};*)
							Else 
								QUERY:C277([ACT_Cargos:173];[ACT_Cargos:173]ID_CuentaCorriente:2=al_CtasCte{$jy};*)
							End if 
							
							If (Size of array:C274($alACT_idsCtas)>0)
								QUERY SELECTION WITH ARRAY:C1050([ACT_Cargos:173]ID_CuentaCorriente:2;$alACT_idsCtas)
							End if 
							
							QUERY:C277([ACT_Cargos:173]; & ;[ACT_Cargos:173]FechaEmision:22#!00-00-00!;*)
							QUERY:C277([ACT_Cargos:173]; & ;[ACT_Cargos:173]Fecha_de_Vencimiento:7#!00-00-00!;*)
							QUERY:C277([ACT_Cargos:173]; & ;[ACT_Cargos:173]FechaEmision:22<=$date;*)
							QUERY:C277([ACT_Cargos:173]; & ;[ACT_Cargos:173]Fecha_de_Vencimiento:7<Current date:C33(*);*)
							QUERY:C277([ACT_Cargos:173]; & ;[ACT_Cargos:173]Saldo:23#0)
							CREATE SET:C116([ACT_Cargos:173];"CargosVencImpagos")
							SELECTION TO ARRAY:C260([ACT_Cargos:173];$aRecNumCargos)
							
							READ WRITE:C146([ACT_Cargos:173])
							For ($i_Cargos;1;Size of array:C274($aRecNumCargos))
								GOTO RECORD:C242([ACT_Cargos:173];$aRecNumCargos{$i_Cargos})
								If (([ACT_Cargos:173]Ref_Item:16#-2) & ([ACT_Cargos:173]Saldo:23#0))
									[ACT_Cargos:173]Monto_Vencido:30:=(Abs:C99([ACT_Cargos:173]Monto_Neto:5)-[ACT_Cargos:173]MontosPagados:8)*-1
									SAVE RECORD:C53([ACT_Cargos:173])
								End if 
							End for 
							KRL_UnloadReadOnly (->[ACT_Cargos:173])
							REDUCE SELECTION:C351([ACT_Documentos_de_Cargo:174];0)
							CLEAR SET:C117("CargosVencImpagos")
							
							QUERY:C277([ACT_Cargos:173];[ACT_Cargos:173]ID_Apoderado:18=al_IDApoderados{$i_Apoderados};*)
							QUERY:C277([ACT_Cargos:173]; & ;[ACT_Cargos:173]FechaEmision:22#!00-00-00!;*)
							QUERY:C277([ACT_Cargos:173]; & ;[ACT_Cargos:173]Fecha_de_Vencimiento:7#!00-00-00!;*)
							QUERY:C277([ACT_Cargos:173]; & ;[ACT_Cargos:173]Mes:13=Month of:C24($date);*)  // (ABK_Integracion_AT)
							QUERY:C277([ACT_Cargos:173]; & ;[ACT_Cargos:173]Año:14=Year of:C25($date);*)  //(ABK_Integracion_AT)
							QUERY:C277([ACT_Cargos:173]; & ;[ACT_Cargos:173]Ref_Item:16=-2)
							
							$Excedentes:=Abs:C99(Sum:C1([ACT_Cargos:173]Monto_Neto:5))
							
							SET QUERY DESTINATION:C396(Into variable:K19:4;$OtroAviso)
							QUERY:C277([ACT_Avisos_de_Cobranza:124];[ACT_Avisos_de_Cobranza:124]ID_Apoderado:3=al_IDApoderados{$i_Apoderados};*)
							QUERY:C277([ACT_Avisos_de_Cobranza:124]; & ;[ACT_Avisos_de_Cobranza:124]Mes:6=Month of:C24($date);*)
							QUERY:C277([ACT_Avisos_de_Cobranza:124]; & ;[ACT_Avisos_de_Cobranza:124]Agno:7=Year of:C25($date))
							SET QUERY DESTINATION:C396(Into current selection:K19:1)
							If ($OtroAviso=1)
								[ACT_Avisos_de_Cobranza:124]Saldo_anterior:12:=[ACT_Avisos_de_Cobranza:124]Saldo_anterior:12+$Excedentes
								If ([ACT_Avisos_de_Cobranza:124]Saldo_anterior:12<0)
									[ACT_Avisos_de_Cobranza:124]Monto_a_Pagar:14:=Abs:C99([ACT_Avisos_de_Cobranza:124]Saldo_anterior:12)+[ACT_Avisos_de_Cobranza:124]Monto_Neto:11
								Else 
									[ACT_Avisos_de_Cobranza:124]Monto_a_Pagar:14:=[ACT_Avisos_de_Cobranza:124]Monto_Neto:11-[ACT_Avisos_de_Cobranza:124]Saldo_anterior:12
								End if 
							Else 
								[ACT_Avisos_de_Cobranza:124]Saldo_anterior:12:=$Excedentes
								[ACT_Avisos_de_Cobranza:124]Monto_a_Pagar:14:=([ACT_Avisos_de_Cobranza:124]Saldo_anterior:12*-1)+[ACT_Avisos_de_Cobranza:124]Monto_Neto:11
							End if 
							[ACT_Avisos_de_Cobranza:124]Monto_A_Pagar_Moneda:16:=ACTut_retornaMontoEnMoneda ([ACT_Avisos_de_Cobranza:124]Monto_a_Pagar:14;[ACT_Avisos_de_Cobranza:124]Moneda:17;Current date:C33(*);ST_GetWord (ACT_DivisaPais ;1;";"))
							APPEND TO ARRAY:C911($al_idsAvisos2Recalc;Record number:C243([ACT_Avisos_de_Cobranza:124]))
							
							  //20120616 RCH Para calcular saldos al emitir...
							If (Find in array:C230($alACTpp_idsPersonas;[ACT_Avisos_de_Cobranza:124]ID_Apoderado:3)=-1) & ([ACT_Avisos_de_Cobranza:124]ID_Apoderado:3#0)
								APPEND TO ARRAY:C911($alACTpp_idsPersonas;[ACT_Avisos_de_Cobranza:124]ID_Apoderado:3)
							End if 
							If (Find in array:C230($alACTter_idsTerceros;[ACT_Avisos_de_Cobranza:124]ID_Tercero:26)=-1) & ([ACT_Avisos_de_Cobranza:124]ID_Tercero:26#0)
								APPEND TO ARRAY:C911($alACTter_idsTerceros;[ACT_Avisos_de_Cobranza:124]ID_Tercero:26)
							End if 
							
							SAVE RECORD:C53([ACT_Avisos_de_Cobranza:124])
							APPEND TO ARRAY:C911($al_rn_AC_stsAlert;Record number:C243([ACT_Avisos_de_Cobranza:124]))
							  //ADD TO SET([ACT_Avisos_de_Cobranza];"RecalculoAvisos")  `rch
							  //ACTac_Prepagar (Record number([ACT_Avisos_de_Cobranza]))
							ACTac_Prepagar (Record number:C243([ACT_Avisos_de_Cobranza:124]);False:C215;False:C215;0;$cb_NoPrepagarAuto)  //20140624 RCH Se pasa como parametro lo seleccionado en la ventana de emision de A.C.
							KRL_UnloadReadOnly (->[ACT_Avisos_de_Cobranza:124])
							
							ACTter_EmiteAvisos (al_IDApoderados{$i_Apoderados};$month;$year;$date;$fechaVencimiento;$fechaPago2;$fechaPago3;$fechaPago4;$vl_idCtaCte;$opcion;vtACT_CurrentUser)
							
							  //20110401 RCH hay casos en que se generan avisos con monto 0 cuando hay dctos en la matriz...
							  //20130408 RCH El ac puede ser eliminado porque se emite un 100% al tercero...
							  //GOTO RECORD([ACT_Avisos_de_Cobranza];$al_idsAvisos2Recalc{Size of array($al_idsAvisos2Recalc)})
							KRL_GotoRecord (->[ACT_Avisos_de_Cobranza:124];$al_idsAvisos2Recalc{Size of array:C274($al_idsAvisos2Recalc)})
							If (Records in selection:C76([ACT_Avisos_de_Cobranza:124])>0)
								If ([ACT_Avisos_de_Cobranza:124]Monto_a_Pagar:14<=0)
									ACTac_Recalcular ($al_idsAvisos2Recalc{Size of array:C274($al_idsAvisos2Recalc)})
									AT_Delete (Size of array:C274($al_idsAvisos2Recalc);1;->$al_idsAvisos2Recalc)
								End if 
							End if 
						End if 
						
						ACTcc_DividirEmision ("DivideAvisos";->$vl_idAviso)  //20170627 RCH
						
					End for 
				End for 
				For ($ArreglosMonedas;1;Size of array:C274(apACT_ArreglosMonedas))
					Bash_Return_Variable (apACT_ArreglosMonedas{$ArreglosMonedas})
				End for 
				AT_Initialize (->apACT_ArreglosMonedas)
				
				If (Application type:C494#4D Server:K5:6)
					$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$currentIteration/$iterations;__ ("Emitiendo avisos de cobranza para el mes de ")+aMeses{$month}+__ (" de ")+String:C10($year)+__ ("..."))
				End if 
			End for 
		End if 
	End for 
	If (Application type:C494#4D Server:K5:6)
		$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
	Else 
		If ($vl_proc#0)
			IT_UThermometer (-2;$vl_proc)
		End if 
	End if 
	ACTcfg_ItemsMatricula ("ActualizaCampoDesdeEmitido")
	ACTmnu_RecalcularSaldosAvisos (->$al_idsAvisos2Recalc;vdACT_FechaUFSel)  //RCH
	
	  //20121222 RCH valida descuentos
	ACTcfg_OpcionesEliminacionDctos ("VerificaEliminacionDctosEmisionAC";->$al_idsAvisos2Recalc;->vdACT_FechaUFSel)
	
End if 
AT_Initialize (->aLong1;->al_CtasCte;->al_IDApoderados)
AT_Initialize (->aDate1;->aDate2;->aDate3;->aDate4;->aLongInt1;->aLongInt2)
KRL_UnloadReadOnly (->[ACT_CuentasCorrientes:175])

  //20120616 RCH Para calcular saldos al emitir. Se calcula en tarea bash...
ACTcc_OpcionesCalculoCtaCte ("InitArrays")
COPY ARRAY:C226($alACTpp_idsPersonas;alACTpp_idsPersonas)
COPY ARRAY:C226($alACTter_idsTerceros;alACTter_idsTerceros)
ACTcc_OpcionesCalculoCtaCte ("RecalcularCtasBash")

ACTcfg_LeeBlob ("ACTcfg_GeneralesEmAvisos")
If ((cb_GenerarPDF=1) & (vt_maquinaPDF#""))
	For ($i;1;Size of array:C274($al_rn_AC_stsAlert))
		C_BLOB:C604($blob)
		BM_CreateRequest ("imprimirPDFAviso";"AC_"+String:C10($al_rn_AC_stsAlert{$i});String:C10($al_rn_AC_stsAlert{$i});$blob;vt_maquinaPDF)
	End for 
End if 

  //20131105 RCH Verifica nombre...
ACTac_ActualizaNombre ("VerificaAvisos")
