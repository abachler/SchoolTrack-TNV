//%attributes = {}
  // Método: ACTabc_ImportPATYaocalli1
  //----------------------------------------------
  // Usuario (OS): roberto
  // Fecha: 31-03-10, 11:44:07
  // ---------------------------------------------
  // Descripción: 
  // 
  // Parámetros:
  // 
  //----------------------------------------------
  // Declaraciones e inicializaciones


  // Código principal

  //ACTabc_ImportPATYaocalli1

  //Bancomer
C_TIME:C306($ref)
C_TEXT:C284($text;$delimiter)
C_LONGINT:C283($vl_noCuota;$vl_ciclo;$vl_year;$vl_mes;$vlACT_concepto)

C_LONGINT:C283($vl_idCta;$vl_idAl;$vlACT_idCategoria)
C_DATE:C307($vd_fechaAC)
C_TEXT:C284($vt_referencia;$vt_msj)
C_REAL:C285($vr_montoActualAviso;$vr_montoNetoActualAviso)

vVerifier:="ColegiumTransferFile"
vType:="importer"

$delimiter:=ACTabc_DetectDelimiter ($1)

ARRAY REAL:C219(aMonto;0)
ARRAY TEXT:C222(aRUT;0)
ARRAY TEXT:C222(aDescCodigo;0)
ARRAY TEXT:C222(aCodAprobacion;0)
ARRAY TEXT:C222(aNumTarjeta;0)
ARRAY TEXT:C222(aNombre;0)
ARRAY REAL:C219(aMontoMora;0)
ARRAY DATE:C224(ad_fechaVcto;0)
ARRAY LONGINT:C221(al_idAvisoAPagar;0)
ARRAY DATE:C224(aFechaPagos;0)

READ ONLY:C145([Alumnos:2])
READ ONLY:C145([xxACT_ItemsCategorias:98])
READ ONLY:C145([xxACT_Items:179])
READ ONLY:C145([ACT_Cargos:173])
READ ONLY:C145([ACT_Transacciones:178])
READ ONLY:C145([ACT_CuentasCorrientes:175])
READ ONLY:C145([ACT_Documentos_de_Cargo:174])
READ ONLY:C145([ACT_Avisos_de_Cobranza:124])

ARRAY LONGINT:C221(aQR_Longint1;0)

QUERY:C277([xxACT_ItemsCategorias:98];[xxACT_ItemsCategorias:98]Nombre:1="Colegiatura@")
If (Records in selection:C76([xxACT_ItemsCategorias:98])=1)
	$vlACT_idCategoria:=[xxACT_ItemsCategorias:98]ID:2
	QUERY:C277([xxACT_Items:179];[xxACT_Items:179]ID_Categoria:8=$vlACT_idCategoria)
	SELECTION TO ARRAY:C260([xxACT_Items:179]ID:1;aQR_Longint1)
End if 

$ref:=Open document:C264($1;"";Read mode:K24:5)
$text:=""
RECEIVE PACKET:C104($ref;$text;$delimiter)
RECEIVE PACKET:C104($ref;$text;$delimiter)
$text:=_O_Win to Mac:C464($text)
While ($text#"")
	AT_Insert (0;1;->aMonto;->aRUT;->aDescCodigo;->aCodAprobacion;->aNumTarjeta;->aNombre;->aMontoMora;->ad_fechaVcto;->al_idAvisoAPagar;->aFechaPagos)
	aMonto{Size of array:C274(aMonto)}:=Num:C11(Substring:C12($text;19;10)+<>tXS_RS_DecimalSeparator+Substring:C12($text;29;2))
	aRUT{Size of array:C274(aRUT)}:=ST_DeleteCharsLeft (Substring:C12($text;34;13);"0")
	QUERY:C277([Alumnos:2];[Alumnos:2]numero_de_matricula:51=aRUT{Size of array:C274(aRUT)})
	If (Records in selection:C76([Alumnos:2])=0)
		aRUT{Size of array:C274(aRUT)}:=ST_RigthChars (("0"*6)+aRUT{Size of array:C274(aRUT)};6)
		QUERY:C277([Alumnos:2];[Alumnos:2]numero_de_matricula:51=aRUT{Size of array:C274(aRUT)})
	End if 
	
	$vt_referencia:=Substring:C12($text;47;6)
	
	If (Records in selection:C76([Alumnos:2])=1)
		ACTmx_RetornaDato ("RetornaNumeroMesCuota1Yaocalli";->$vl_mes;->[Alumnos:2]nivel_numero:29)
	Else 
		$vl_mes:=0
	End if 
	
	aDescCodigo{Size of array:C274(aDescCodigo)}:=Substring:C12($text;53;2)
	If (aDescCodigo{Size of array:C274(aDescCodigo)}="00")
		aCodAprobacion{Size of array:C274(aCodAprobacion)}:="0"
	Else 
		aCodAprobacion{Size of array:C274(aCodAprobacion)}:="-1"
	End if 
	aNumTarjeta{Size of array:C274(aNumTarjeta)}:=""
	aNombre{Size of array:C274(aNombre)}:=""
	aMontoMora{Size of array:C274(aMontoMora)}:=0
	$vl_noCuota:=Num:C11(Substring:C12($text;49;2))
	$vl_ciclo:=Num:C11(Substring:C12($text;51;2))
	  //$vl_ciclo=17 para el periodo 2009-2010
	$vl_year:=1992+$vl_ciclo
	If ($vl_mes#0)
		If ($vl_noCuota<(14-$vl_mes))
			$vl_noCuota:=$vl_noCuota+($vl_mes-1)
		Else 
			$vl_noCuota:=$vl_noCuota-(14-$vl_mes)+1
			$vl_year:=$vl_year+1
		End if 
		ad_fechaVcto{Size of array:C274(ad_fechaVcto)}:=DT_GetDateFromDayMonthYear (1;$vl_noCuota;$vl_year)
	End if 
	$vlACT_concepto:=Num:C11(Substring:C12($text;47;2))
	
	If (Records in selection:C76([Alumnos:2])=1)
		QUERY:C277([ACT_CuentasCorrientes:175];[ACT_CuentasCorrientes:175]ID_Alumno:3=[Alumnos:2]numero:1)
		Case of 
			: ($vlACT_concepto=2)
				If ($vlACT_idCategoria#0)
					$vd_fechaAC:=DT_GetDateFromDayMonthYear (DT_GetLastDay ($vl_noCuota;$vl_year);$vl_noCuota;$vl_year)
					QUERY:C277([ACT_Cargos:173];[ACT_Cargos:173]ID_CuentaCorriente:2=[ACT_CuentasCorrientes:175]ID:1;*)
					QUERY:C277([ACT_Cargos:173]; & ;[ACT_Cargos:173]FechaEmision:22>=ad_fechaVcto{Size of array:C274(ad_fechaVcto)};*)
					QUERY:C277([ACT_Cargos:173]; & ;[ACT_Cargos:173]FechaEmision:22<=$vd_fechaAC)
					QRY_QueryWithArray (->[ACT_Cargos:173]Ref_Item:16;->aQR_Longint1;True:C214)
					If (Records in selection:C76([ACT_Cargos:173])>0)
						KRL_RelateSelection (->[ACT_Documentos_de_Cargo:174]ID_Documento:1;->[ACT_Cargos:173]ID_Documento_de_Cargo:3;"")
						KRL_RelateSelection (->[ACT_Avisos_de_Cobranza:124]ID_Aviso:1;->[ACT_Documentos_de_Cargo:174]No_ComprobanteInterno:15;"")
						If (Records in selection:C76([ACT_Avisos_de_Cobranza:124])=1)
							
							  //********** INICIO  **********
							  //borrar cargos de multa automatica
							If ([ACT_Avisos_de_Cobranza:124]ID_Aviso:1#0)
								$vl_idCta:=[ACT_Avisos_de_Cobranza:124]ID_CuentaCorrriente:2
								$vl_idAl:=KRL_GetNumericFieldData (->[ACT_CuentasCorrientes:175]ID:1;->$vl_idCta;->[ACT_CuentasCorrientes:175]ID_Alumno:3)
								$vt_msj:=" Aviso de Cobranza número: "+String:C10([ACT_Avisos_de_Cobranza:124]ID_Aviso:1)+"."
								$vt_msj:=ST_Boolean2Str (($vl_idAl#0);$vt_msj+" Alumno: "+KRL_GetTextFieldData (->[Alumnos:2]numero:1;->$vl_idAl;->[Alumnos:2]apellidos_y_nombres:40)+".";$vt_msj+" Apoderado: "+KRL_GetTextFieldData (->[Personas:7]No:1;->[ACT_Avisos_de_Cobranza:124]ID_Apoderado:3;->[Personas:7]Apellidos_y_nombres:30)+".")
								If (aFechaPagos{Size of array:C274(aFechaPagos)}>[ACT_Avisos_de_Cobranza:124]Fecha_Vencimiento:5)
									$vd_fechaV:=[ACT_Avisos_de_Cobranza:124]Fecha_Vencimiento:5
									$vd_fechaV:=Add to date:C393($vd_fechaV;0;1;0)
									$vd_fechaV:=DT_GetDateFromDayMonthYear (1;Month of:C24($vd_fechaV);Year of:C25($vd_fechaV))
									If (aFechaPagos{Size of array:C274(aFechaPagos)}<=$vd_fechaV)
										QUERY:C277([ACT_Transacciones:178];[ACT_Transacciones:178]No_Comprobante:10=[ACT_Avisos_de_Cobranza:124]ID_Aviso:1)
										KRL_RelateSelection (->[ACT_Cargos:173]ID:1;->[ACT_Transacciones:178]ID_Item:3;"")
										READ WRITE:C146([ACT_Cargos:173])
										QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]Ref_AvisoMulta:53#"")
										If (Records in selection:C76([ACT_Cargos:173])>1)
											ORDER BY:C49([ACT_Cargos:173];[ACT_Cargos:173]Ref_AvisoMulta:53;<)
											REDUCE SELECTION:C351([ACT_Cargos:173];1)
											KRL_RelateSelection (->[ACT_Transacciones:178]ID_Item:3;->[ACT_Cargos:173]ID:1;"")
											C_LONGINT:C283($vl_records)
											SET QUERY DESTINATION:C396(Into variable:K19:4;$vl_records)
											QUERY SELECTION:C341([ACT_Transacciones:178];[ACT_Transacciones:178]No_Boleta:9#0)
											SET QUERY DESTINATION:C396(Into current selection:K19:1)
											If ((Sum:C1([ACT_Cargos:173]MontosPagados:8)=0) & ($vl_records=0))
												ACTcc_EliminaCargosLoop 
												LOG_RegisterEvt ("Eliminación de cargo generado como multa automática durante el proceso de importa"+"ción de pagos."+$vt_msj)
											Else 
												aDescCodigo{Size of array:C274(aDescCodigo)}:="Cargo de multa no puede ser eliminado porque está pagado o está en Documento Trib"+"utario. Referencia número "+$vt_referencia+"."
												aCodAprobacion{Size of array:C274(aCodAprobacion)}:="-1"
											End if 
										End if 
										KRL_UnloadReadOnly (->[ACT_Cargos:173])
									End if 
								Else 
									QUERY:C277([ACT_Transacciones:178];[ACT_Transacciones:178]No_Comprobante:10=[ACT_Avisos_de_Cobranza:124]ID_Aviso:1)
									KRL_RelateSelection (->[ACT_Cargos:173]ID:1;->[ACT_Transacciones:178]ID_Item:3;"")
									READ WRITE:C146([ACT_Cargos:173])
									QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]Ref_AvisoMulta:53#"")
									If (Records in selection:C76([ACT_Cargos:173])>0)
										KRL_RelateSelection (->[ACT_Transacciones:178]ID_Item:3;->[ACT_Cargos:173]ID:1;"")
										C_LONGINT:C283($vl_records)
										SET QUERY DESTINATION:C396(Into variable:K19:4;$vl_records)
										QUERY SELECTION:C341([ACT_Transacciones:178];[ACT_Transacciones:178]No_Boleta:9#0)
										SET QUERY DESTINATION:C396(Into current selection:K19:1)
										If ((Sum:C1([ACT_Cargos:173]MontosPagados:8)=0) & ($vl_records=0))
											ACTcc_EliminaCargosLoop 
											LOG_RegisterEvt ("Eliminación de cargos generados como multa automática durante el proceso de impor"+"tación de pagos."+$vt_msj)
										Else 
											aDescCodigo{Size of array:C274(aDescCodigo)}:="Cargos de multa no pueden ser eliminados porque están pagados o están en Document"+"os Tributarios. Referencia número "+$vt_referencia+"."
											aCodAprobacion{Size of array:C274(aCodAprobacion)}:="-1"
										End if 
									End if 
									KRL_UnloadReadOnly (->[ACT_Cargos:173])
								End if 
							End if 
							  //********** FIN **********
							
							If ([ACT_Avisos_de_Cobranza:124]Monto_a_Pagar:14#0)
								$vr_montoActualAviso:=Abs:C99(ACTcar_CalculaMontos ("calcMontoFromNumAvisoMEmision";->[ACT_Avisos_de_Cobranza:124]ID_Aviso:1;->[ACT_Cargos:173]Saldo:23;Current date:C33(*)))
								If ($vr_montoActualAviso=aMonto{Size of array:C274(aMonto)})
									al_idAvisoAPagar{Size of array:C274(al_idAvisoAPagar)}:=[ACT_Avisos_de_Cobranza:124]ID_Aviso:1
								Else 
									$vr_montoNetoActualAviso:=Abs:C99(ACTcar_CalculaMontos ("calcMontoFromNumAvisoMEmision";->[ACT_Avisos_de_Cobranza:124]ID_Aviso:1;->[ACT_Cargos:173]Monto_Neto:5;Current date:C33(*)))
									If (($vr_montoActualAviso=$vr_montoNetoActualAviso) & ($vr_montoActualAviso#aMonto{Size of array:C274(aMonto)}))
										aDescCodigo{Size of array:C274(aDescCodigo)}:="EL MONTO DEL ARCHIVO DE PAGO ES DIFERENTE AL GENERADO EN EL AVISO DE COBRANZA. Av"+"iso de cobranza"+" paga"+"do para la referencia "+$vt_referencia+", para cargos pertenecientes a la categoría colegiatura."
										aCodAprobacion{Size of array:C274(aCodAprobacion)}:="-1"
									Else 
										aDescCodigo{Size of array:C274(aDescCodigo)}:="EL AVISO QUE DESEA PAGAR ESTA PAGADO PARCIALMENTE O TOTALMENTE. Aviso de cobranza"+" paga"+"do para la referencia "+$vt_referencia+", para cargos pertenecientes a la categoría colegiatura."
										aCodAprobacion{Size of array:C274(aCodAprobacion)}:="-1"
									End if 
								End if 
							Else 
								aDescCodigo{Size of array:C274(aDescCodigo)}:="TODOS LOS AVISOS DE COBRANZA DE ESTE ALUMNO ESTAN PAGADOS. Aviso de cobranza paga"+"do para la referencia "+$vt_referencia+", para cargos pertenecientes a la categoría colegiatura."
								aCodAprobacion{Size of array:C274(aCodAprobacion)}:="-1"
							End if 
						Else 
							aDescCodigo{Size of array:C274(aDescCodigo)}:="EXISTE MÁS DE UN AVISO DE COBRANZA EMITIDO PARA EL MES QUE DESEAS PAGAR. Aviso de"+" cobranza no encontrado para la referencia "+$vt_referencia+", para cargos pertenecientes a la categoría colegiatura."
							aCodAprobacion{Size of array:C274(aCodAprobacion)}:="-1"
						End if 
					Else 
						aDescCodigo{Size of array:C274(aDescCodigo)}:="NO EXISTE AVISO DE COBRANZA EMITIDO PARA EL MES QUE DESEAS PAGAR. Cargos no encon"+"trados para la referencia "+$vt_referencia+", para cargos pertenecientes a la categoría colegiatura."
						aCodAprobacion{Size of array:C274(aCodAprobacion)}:="-1"
					End if 
				Else 
					aDescCodigo{Size of array:C274(aDescCodigo)}:="Aviso de cobranza no encontrado para la referencia "+$vt_referencia+". Categoría colegiatura no configurada."
					aCodAprobacion{Size of array:C274(aCodAprobacion)}:="-1"
				End if 
			Else 
				aDescCodigo{Size of array:C274(aDescCodigo)}:="Concepto de pago no definido."
				aCodAprobacion{Size of array:C274(aCodAprobacion)}:="-1"
		End case 
	End if 
	
	RECEIVE PACKET:C104($ref;$text;$delimiter)
	$text:=_O_Win to Mac:C464($text)
End while 
AT_Delete (Size of array:C274(aRUT);1;->aMonto;->aRUT;->aDescCodigo;->aCodAprobacion;->aNumTarjeta;->aNombre;->aMontoMora;->ad_fechaVcto;->al_idAvisoAPagar;->aFechaPagos)
<>vRUTField:=Field:C253(->[Alumnos:2]numero_de_matricula:51)
<>vRUTTable:=Table:C252(->[Alumnos:2])
<>vLabelLink:="Codigo Interno"
CLOSE DOCUMENT:C267($ref)