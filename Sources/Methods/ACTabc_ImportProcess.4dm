//%attributes = {}
  //ACTabc_ImportProcess
TRACE:C157
C_TEXT:C284($vt_valor)
C_DATE:C307($2;$fecha)
C_REAL:C285(vrACT_MontoMora)
C_DATE:C307(vdACT_fechaVencimiento;vdACTpgs_fechaDesde)
C_LONGINT:C283(vl_cargosEliminados;$vl_valor)
C_BOOLEAN:C305(vb_interesBorrado)
C_BOOLEAN:C305(vb_descuentoBorrado)  //20170714 RCH
C_POINTER:C301($ptr_Id)
C_DATE:C307($vdACT_FechaUF)
C_BOOLEAN:C305(vbACTpgs_ArregloCargos)
vl_cargosEliminados:=0

$formadePago:=$1
vLabelLink:=<>vLabelLink  //ASM 
vRUTTable:=<>vRUTTable

If (Size of array:C274(aRUT)#Size of array:C274(aMontoMora))
	AT_RedimArrays (Size of array:C274(aRUT);->aMontoMora)
End if 
If (Size of array:C274(aRUT)#Size of array:C274(al_idAvisoAPagar))
	AT_RedimArrays (Size of array:C274(aRUT);->al_idAvisoAPagar)
End if 
If (Size of array:C274(aRUT)#Size of array:C274(ad_fechaVcto))
	AT_RedimArrays (Size of array:C274(aRUT);->ad_fechaVcto)
End if 
If (Size of array:C274(aRUT)#Size of array:C274(aFechaPagos))
	AT_RedimArrays (Size of array:C274(aRUT);->aFechaPagos)
End if 
If (Size of array:C274(aRUT)#Size of array:C274(al_idsCargosAPagar))
	AT_RedimArrays (Size of array:C274(aRUT);->al_idsCargosAPagar)
End if 
If (Size of array:C274(aRUT)#Size of array:C274(adACT_FechasInicio))
	AT_RedimArrays (Size of array:C274(aRUT);->adACT_FechasInicio)
End if 
If (Size of array:C274(aRUT)#Size of array:C274(atACT_idsCargos))
	AT_RedimArrays (Size of array:C274(aRUT);->atACT_idsCargos)
End if 
If (Size of array:C274(aRUT)#Size of array:C274(atACT_LugarPago))
	AT_RedimArrays (Size of array:C274(aRUT);->atACT_LugarPago)
End if 
If (Size of array:C274(aRUT)#Size of array:C274(aLugarDePago))
	AT_RedimArrays (Size of array:C274(aRUT);->aLugarDePago)
End if 

$fecha:=$2
If (Count parameters:C259>=3)
	$vdACT_FechaUF:=$3
End if 

  //20130729 RCH
$t_nombreUsuario:=$4

If ($vdACT_FechaUF=!00-00-00!)
	$vdACT_FechaUF:=$fecha
End if 
$fechaTemp:=$fecha

ACTinit_LoadFdPago 
ACTcfg_LoadBancos 

  //$formaIdx:=Find in array(atACT_FormasdePago;$formadePago)
$formaIdx:=Find in array:C230(alACT_FormasdePagoID;$formadePago)
$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;__ ("Procesando archivo ")+atACT_FormasdePagoNew{$formaIdx}+__ ("..."))
<>numProcesados:=Size of array:C274(aRUT)
<>montoProcesado:=AT_GetSumArray (->aMonto)
vLinkingField:=Field:C253(<>vRUTTable;<>vRUTField)
vLinkingTable:=Table:C252(<>vRUTTable)
ACTpgs_LimpiaVarsInterfaz ("InitVarsApdoCtaTer")
For ($i;1;Size of array:C274(aRUT))
	ARRAY LONGINT:C221(alACTpgs_Avisos2Recalc;0)
	vdACT_fechaVencimiento:=!00-00-00!
	If ($fechaTemp=!00-00-00!) | (vb_fechaPago)  //llena la variable fecha de acuerdo a lo que se necesite. Import pagos normales (efectivo, cheque), vb_fechaPago no se usa actualmente
		If (aFechaPagos{$i}=!00-00-00!)
			$fecha:=Current date:C33(*)
		Else 
			$fecha:=aFechaPagos{$i}
			$vdACT_FechaUF:=$fecha  //20130422 ASM .Para evitar generar intereses al momento de realizar el pago
		End if 
	End if 
	ARRAY LONGINT:C221(alACTpgs_idsCargos;0)
	If (atACT_idsCargos{$i}#"")
		AT_Text2Array (->alACTpgs_idsCargos;atACT_idsCargos{$i};"-")
		vbACTpgs_ArregloCargos:=True:C214
	Else 
		vbACTpgs_ArregloCargos:=False:C215
	End if 
	aRUT{$i}:=ST_GetCleanString (aRUT{$i})
	If (<>vLabelLink="RUT")
		$rut:=CTRY_CL_VerifRUT (aRUT{$i};False:C215)
	Else 
		$rut:=aRUT{$i}
	End if 
	If ($rut#"")
		If (<>vLabelLink="ID")
			If (aCodAprobacion{$i}="0")
				$vl_valor:=Num:C11(aRUT{$i})
			Else 
				$vl_valor:=-1
			End if 
			$ptr_Id:=->$vl_valor
		Else 
			$vt_valor:=aRUT{$i}
			$ptr_Id:=->$vt_valor
		End if 
		QUERY:C277(vLinkingTable->;vLinkingField->=$ptr_Id->)
		If (Records in selection:C76(vLinkingTable->)=1)
			  //If (((Table(vLinkingTable)=Table(->[Personas])) & ([Personas]ES_Apoderado_de_Cuentas)) | (Table(vLinkingTable)=Table(->[ACT_CuentasCorrientes])))
			If (((Table:C252(vLinkingTable)=Table:C252(->[Personas:7])) & ([Personas:7]ES_Apoderado_de_Cuentas:42)) | (Table:C252(vLinkingTable)=Table:C252(->[ACT_CuentasCorrientes:175])) | (Table:C252(vLinkingTable)=Table:C252(->[Alumnos:2])))
				If (aCodAprobacion{$i}="0")
					If (aMonto{$i}>0)
						Case of 
							: (Table:C252(vLinkingTable)=Table:C252(->[Personas:7]))
								RNApdo:=Record number:C243([Personas:7])
								ACTpgs_LimpiaVarsInterfaz ("SetVarsIngresoPago")
								  //02-10-125
								  // validacion ticket 150497 JVP para cargar solo la deuda de la familia que corresponda
								  //en caso de que el importador sea por familia
								
								If (<>vLabelLink="Código de familia")
									ACTpgs_CargaDatosPagoApdo (False:C215;$fecha;al_idAvisoAPagar{$i};al_idsCargosAPagar{$i};$vdACT_FechaUF;False:C215;aCodigoFamilia{$i})
								Else 
									ACTpgs_CargaDatosPagoApdo (False:C215;$fecha;al_idAvisoAPagar{$i};al_idsCargosAPagar{$i};$vdACT_FechaUF)
								End if 
								<>vbACT_ImportacionApdos:=True:C214
								$process:=True:C214
							: (Table:C252(vLinkingTable)=Table:C252(->[ACT_CuentasCorrientes:175]))
								If ([ACT_CuentasCorrientes:175]ID_Apoderado:9#0)
									QUERY:C277([Alumnos:2];[Alumnos:2]numero:1=[ACT_CuentasCorrientes:175]ID_Alumno:3)
									QUERY:C277([Personas:7];[Personas:7]No:1=[ACT_CuentasCorrientes:175]ID_Apoderado:9)
									RNCta:=Record number:C243([ACT_CuentasCorrientes:175])
									ACTpgs_LimpiaVarsInterfaz ("SetVarsIngresoPago")
									ACTpgs_CargaDatosPagoCta (False:C215;$fecha;al_idAvisoAPagar{$i};al_idsCargosAPagar{$i};$vdACT_FechaUF)
									<>vbACT_ImportacionApdos:=False:C215
									$process:=True:C214
								Else 
									AT_Insert (0;1;-><>aRUTApdoNoCta;-><>aARXTransbankApdoNoCta)
									If (aCodAprobacion{$i}="0")
										<>aARXTransbankApdoNoCta{Size of array:C274(<>aARXTransbankApdoNoCta)}:="A"
									Else 
										<>aARXTransbankApdoNoCta{Size of array:C274(<>aARXTransbankApdoNoCta)}:="R"
									End if 
									<>aRUTApdoNoCta{Size of array:C274(<>aRUTApdoNoCta)}:=aRUT{$i}
									<>montoNoApdoCta:=<>montoNoApdoCta+aMonto{$i}
									$process:=False:C215
								End if 
							: (Table:C252(vLinkingTable)=Table:C252(->[Alumnos:2]))
								If ([Alumnos:2]Apoderado_Cuentas_Número:28#0)
									QUERY:C277([Personas:7];[Personas:7]No:1=[Alumnos:2]Apoderado_Cuentas_Número:28)
									QUERY:C277([ACT_CuentasCorrientes:175];[ACT_CuentasCorrientes:175]ID_Alumno:3=[Alumnos:2]numero:1)
									RNCta:=Record number:C243([ACT_CuentasCorrientes:175])
									ACTpgs_LimpiaVarsInterfaz ("SetVarsIngresoPago")
									ACTpgs_CargaDatosPagoCta (False:C215;$fecha;al_idAvisoAPagar{$i};al_idsCargosAPagar{$i};$vdACT_FechaUF)
									<>vbACT_ImportacionApdos:=False:C215
									$process:=True:C214
								Else 
									AT_Insert (0;1;-><>aRUTApdoNoCta;-><>aARXTransbankApdoNoCta)
									If (aCodAprobacion{$i}="0")
										<>aARXTransbankApdoNoCta{Size of array:C274(<>aARXTransbankApdoNoCta)}:="A"
									Else 
										<>aARXTransbankApdoNoCta{Size of array:C274(<>aARXTransbankApdoNoCta)}:="R"
									End if 
									<>aRUTApdoNoCta{Size of array:C274(<>aRUTApdoNoCta)}:=aRUT{$i}
									<>montoNoApdoCta:=<>montoNoApdoCta+aMonto{$i}
									$process:=False:C215
								End if 
						End case 
						If ($process)
							  //VALIDATE TRANSACTION
							QRY_QueryWithArray (->[ACT_Avisos_de_Cobranza:124]ID_Aviso:1;->alACT_AIDAviso)
							ORDER BY:C49([ACT_Avisos_de_Cobranza:124];[ACT_Avisos_de_Cobranza:124]Fecha_Vencimiento:5;>;[ACT_Avisos_de_Cobranza:124]Monto_a_Pagar:14;<)
							  //LONGINT ARRAY FROM SELECTION([ACT_Avisos_de_Cobranza];alACT_RecNumsAvisos;"")
							SELECTION TO ARRAY:C260([ACT_Avisos_de_Cobranza:124];alACT_RecNumsAvisos)
							Case of   //según forma de pago lleno variables tengan o no tengan datos 
								: ($formaDePago=-4)
									  //actCFG_LOADbANCOS
									$id:=Find in array:C230(atACT_BankID;aBancoCheque{$I})
									If ($id#-1)
										vtACT_BancoNombre:=atACT_BankName{$id}
										vtACT_BancoCodigo:=aBancoCheque{$I}
									Else 
										vtACT_BancoNombre:=""
									End if 
									vtACT_NoSerie:=aSerieCheque{$i}
									vdACT_FechaDocumento:=aFechaDctoCheque{$i}
									vtACT_BancoCuenta:=aCuentaCheque{$i}  //20141218 RCH NO se estaba llenando la variable.
								: ($formaDePago=-6)
									vtACT_TCDocumento:=aNoOperacion{$i}
									vtACT_TCNumero:=aNumTarjeta{$i}
								: ($formaDePago=-11)
									  //vrACT_MontoMora:=aMontoMora{$i}
									  //vdACT_fechaVencimiento:=ad_fechaVcto{$i}
							End case 
							If (aMontoMora{$i}#0)
								vrACT_MontoMora:=aMontoMora{$i}
							Else 
								vrACT_MontoMora:=0
							End if 
							If (ad_fechaVcto{$i}#!00-00-00!)
								vdACT_fechaVencimiento:=ad_fechaVcto{$i}
							Else 
								vdACT_fechaVencimiento:=!00-00-00!
							End if 
							If (adACT_FechasInicio{$i}#!00-00-00!)
								vdACTpgs_fechaDesde:=adACT_FechasInicio{$i}
							Else 
								vdACTpgs_fechaDesde:=!00-00-00!
							End if 
							If (atACT_LugarPago{$i}="")
								Case of 
									: (vtACT_BancoArchivo#"")
										vsACT_LugardePago:=vtACT_BancoArchivo
									: (aLugarDePago{$i}#"")
										vsACT_LugardePago:=aLugarDePago{$i}
									Else 
										vsACT_LugardePago:=""
								End case 
							Else 
								vsACT_LugardePago:=atACT_LugarPago{$i}
								If (vtACT_BancoArchivo#"")
									vsACT_LugardePago:=vsACT_LugardePago+". "+vtACT_BancoArchivo
								End if 
							End if 
							vrACT_MontoPago:=aMonto{$i}
							vtACT_ObservacionesPago:=__ ("Importado desde archivo ")+vtACT_fileName+__ (", el ")+String:C10(Current date:C33(*);5)
							vlACT_FormasdePago:=$formadePago
							vsACT_FormasdePago:=ACTcfgfdp_OpcionesGenerales ("GetFormaDePagoFromID";->vlACT_FormasdePago)
							vdACT_FechaPago:=$fecha
							ACTcfg_OpcionesFormasDePago ("CargaCuentasContables";->vsACT_FormasdePago;->vlACT_FormasdePago)
							  //20130729 RCH
							  //$deudaOriginal:=ACTpgs_IngresarPagos (vlACT_FormasdePago;False;True;$vdACT_FechaUF)
							ARRAY LONGINT:C221($alACTpgs_Avisos2Recalc;0)
							$deudaOriginal:=ACTpgs_IngresarPagos (vlACT_FormasdePago;False:C215;True:C214;$vdACT_FechaUF;False:C215;$t_nombreUsuario)
							COPY ARRAY:C226(alACTpgs_Avisos2Recalc;$alACTpgs_Avisos2Recalc)
							For ($r;1;Size of array:C274($alACTpgs_Avisos2Recalc))  //para reflejar el dcto en caja, si es que lo hay, en el monto total del aviso.
								ACTac_Recalcular ($alACTpgs_Avisos2Recalc{$r};vdACT_FechaPago;False:C215;True:C214)
							End for 
							  //20131210 RCH Cambio arreglo alACT_RecNumsAvisos por $alACTpgs_Avisos2Recalc
							For ($tt;1;Size of array:C274($alACTpgs_Avisos2Recalc))
								ACTac_Prepagar ($alACTpgs_Avisos2Recalc{$tt};True:C214)
							End for 
							ACTmnu_RecalcularSaldosAvisos (->$alACTpgs_Avisos2Recalc;Current date:C33(*);False:C215;True:C214)
							  //If ((vb_faltanDatos) | (vb_serieDuplicada) | (vb_descuadre))  //si faltan datos se setea el cod de aprob en -1 (estos pagos no fueron ingresados
							If ((vb_faltanDatos) | (vb_serieDuplicada) | (vb_descuadre) | (vb_fechaPagoNoPermitida))  // 179864
								aCodAprobacion{$i}:="-1"
							End if 
							If (aCodAprobacion{$i}="0")  //``rch
								<>montoAprobado:=<>montoAprobado+aMonto{$i}
							Else 
								AT_Insert (0;1;-><>aRUTRechazo;-><>aDescRechazo;-><>aNumTarjetaRe;-><>aVencTarjetaRe;-><>aIDAvisoRechazo;-><>aMontoRechazo)
								<>aRUTRechazo{Size of array:C274(<>aRUTRechazo)}:=aRUT{$i}
								Case of 
									: (vb_faltanDatos)
										<>aDescRechazo{Size of array:C274(<>aDescRechazo)}:=__ ("Faltan datos para ingresar el pago")
									: (vb_serieDuplicada)
										<>aDescRechazo{Size of array:C274(<>aDescRechazo)}:=__ ("Cheque con número de serie duplicado")
									: (vb_descuadre)
										<>aDescRechazo{Size of array:C274(<>aDescRechazo)}:=__ ("Monto del archivo no cuadra con el monto del período seleccionado")
									: (vb_fechaPagoNoPermitida)  // 179864
										<>aDescRechazo{Size of array:C274(<>aDescRechazo)}:=__ ("La configuración de AccountTrack no permite asignar una fecha anterior a la del último pago registrado en la Base de Datos.")
								End case 
								  //<>aDescRechazo{Size of array(<>aDescRechazo)}:=aDescCodigo{$i}
								<>aNumTarjetaRe{Size of array:C274(<>aNumTarjetaRe)}:=aNumTarjeta{$i}
								<>aMontoRechazo{Size of array:C274(<>aMontoRechazo)}:=aMonto{$i}
								<>montoRechazos:=<>montoRechazos+aMonto{$i}
								If (al_idAvisoAPagar{$i}#0)
									<>aIDAvisoRechazo{Size of array:C274(<>aIDAvisoRechazo)}:=al_idAvisoAPagar{$i}
								End if 
							End if 
							  //If ($deudaOriginal<=0)
							  //If (($deudaOriginal<=0) & (Not(vb_faltanDatos)) & (Not(vb_serieDuplicada)))
							If (($deudaOriginal<=0) & (Not:C34(vb_faltanDatos)) & (Not:C34(vb_serieDuplicada)) & (Not:C34(vb_fechaPagoNoPermitida)))  // 179864
								AT_Insert (0;1;-><>aSinDeuda)
								If ((<>vLabelLink="ID") & (al_idAvisoAPagar{$i}#0))
									<>aSinDeuda{Size of array:C274(<>aSinDeuda)}:=String:C10(al_idAvisoAPagar{$i})
								Else 
									<>aSinDeuda{Size of array:C274(<>aSinDeuda)}:=aRUT{$i}
								End if 
							End if 
						Else 
							  //CANCEL TRANSACTION
						End if 
					Else 
						AT_Insert (0;1;-><>aMontoCero)
						<>aMontoCero{Size of array:C274(<>aMontoCero)}:=aRUT{$i}
					End if 
				Else 
					AT_Insert (0;1;-><>aRUTRechazo;-><>aDescRechazo;-><>aNumTarjetaRe;-><>aVencTarjetaRe;-><>aIDAvisoRechazo;-><>aMontoRechazo)
					<>aRUTRechazo{Size of array:C274(<>aRUTRechazo)}:=aRUT{$i}
					<>aDescRechazo{Size of array:C274(<>aDescRechazo)}:=aDescCodigo{$i}
					<>aNumTarjetaRe{Size of array:C274(<>aNumTarjetaRe)}:=aNumTarjeta{$i}
					<>aMontoRechazo{Size of array:C274(<>aMontoRechazo)}:=aMonto{$i}
					<>montoRechazos:=<>montoRechazos+aMonto{$i}
					If (al_idAvisoAPagar{$i}#0)
						<>aIDAvisoRechazo{Size of array:C274(<>aIDAvisoRechazo)}:=al_idAvisoAPagar{$i}
					End if 
				End if 
			Else 
				AT_Insert (0;1;-><>aRUTApdoNoCta;-><>aARXTransbankApdoNoCta)
				If (aCodAprobacion{$i}="0")
					<>aARXTransbankApdoNoCta{Size of array:C274(<>aARXTransbankApdoNoCta)}:="A"
				Else 
					<>aARXTransbankApdoNoCta{Size of array:C274(<>aARXTransbankApdoNoCta)}:="R"
				End if 
				<>aRUTApdoNoCta{Size of array:C274(<>aRUTApdoNoCta)}:=aRUT{$i}
				<>montoNoApdoCta:=<>montoNoApdoCta+aMonto{$i}
			End if 
		Else 
			If (Records in selection:C76(vLinkingTable->)=0)
				If ((<>vLabelLink="ID") & (al_idAvisoAPagar{$i}#0))
					If (aDescCodigo{Size of array:C274(aDescCodigo)}=__ ("Aviso no encontrado"))
						AT_Insert (0;1;-><>aRUTNoIdentif;-><>aARXTransbankNoIdentif)
						If (aCodAprobacion{$i}="0")
							<>aARXTransbankNoIdentif{Size of array:C274(<>aARXTransbankNoIdentif)}:="A"
						Else 
							<>aARXTransbankNoIdentif{Size of array:C274(<>aARXTransbankNoIdentif)}:="R"
						End if 
						<>aRUTNoIdentif{Size of array:C274(<>aRUTNoIdentif)}:=String:C10(al_idAvisoAPagar{$i})
					Else 
						AT_Insert (0;1;-><>aRUTRechazo;-><>aDescRechazo;-><>aNumTarjetaRe;-><>aVencTarjetaRe;-><>aIDAvisoRechazo;-><>aMontoRechazo)
						<>aRUTRechazo{Size of array:C274(<>aRUTRechazo)}:=String:C10(al_idAvisoAPagar{$i})
						<>aDescRechazo{Size of array:C274(<>aDescRechazo)}:=aDescCodigo{$i}
						<>aNumTarjetaRe{Size of array:C274(<>aNumTarjetaRe)}:=aNumTarjeta{$i}
						<>montoRechazos:=<>montoRechazos+aMonto{$i}
						<>aMontoRechazo{Size of array:C274(<>aMontoRechazo)}:=aMonto{$i}
						If (al_idAvisoAPagar{$i}#0)
							<>aIDAvisoRechazo{Size of array:C274(<>aIDAvisoRechazo)}:=al_idAvisoAPagar{$i}
						End if 
					End if 
				Else 
					AT_Insert (0;1;-><>aRUTNoIdentif;-><>aARXTransbankNoIdentif)
					If (aCodAprobacion{$i}="0")
						<>aARXTransbankNoIdentif{Size of array:C274(<>aARXTransbankNoIdentif)}:="A"
					Else 
						<>aARXTransbankNoIdentif{Size of array:C274(<>aARXTransbankNoIdentif)}:="R"
					End if 
					<>aRUTNoIdentif{Size of array:C274(<>aRUTNoIdentif)}:=aRUT{$i}
					<>montoNoIdentif:=<>montoNoIdentif+aMonto{$i}
				End if 
			Else 
				AT_Insert (0;1;-><>aRUTDoble;-><>aARXTransbankDoble)
				If (aCodAprobacion{$i}="0")
					<>aARXTransbankDoble{Size of array:C274(<>aARXTransbankDoble)}:="A"
				Else 
					<>aARXTransbankDoble{Size of array:C274(<>aARXTransbankDoble)}:="R"
				End if 
				<>aRUTDoble{Size of array:C274(<>aRUTDoble)}:=aRUT{$i}
				<>montoDoble:=<>montoDoble+aMonto{$i}
			End if 
		End if 
	Else 
		AT_Insert (0;1;-><>aRUTInvalidos;-><>aARXTransbankInvalidos)
		If (aCodAprobacion{$i}="0")
			<>aARXTransbankInvalidos{Size of array:C274(<>aARXTransbankInvalidos)}:="A"
		Else 
			<>aARXTransbankInvalidos{Size of array:C274(<>aARXTransbankInvalidos)}:="R"
		End if 
		If (aRUT{$i}#"")
			<>aRUTInvalidos{Size of array:C274(<>aRUTInvalidos)}:=aRUT{$i}
		Else 
			<>aRUTInvalidos{Size of array:C274(<>aRUTInvalidos)}:=__ ("Sin Identificador")
		End if 
		<>montoInvalidos:=<>montoInvalidos+aMonto{$i}
	End if 
	$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$i/Size of array:C274(aRUT);__ ("Procesando archivo ")+atACT_FormasdePagoNew{$formaIdx}+__ ("..."))
End for 
$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
AT_Initialize (->aMonto;->aNombre;->aRUT;->aCodAprobacion;->aNumTarjeta)
DELAY PROCESS:C323(Current process:C322;5)