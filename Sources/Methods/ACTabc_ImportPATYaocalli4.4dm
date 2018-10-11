//%attributes = {}
  //ACTabc_ImportPATYaocalli4

  //HSBC

C_TIME:C306($ref)
C_TEXT:C284($text;$delimiter)
C_LONGINT:C283($vl_noCuota;$vl_ciclo;$vl_year;$vl_mes;$vlACT_concepto)

vVerifier:="ColegiumTransferFile"
vType:="importer"

$delimiter:=ACTabc_DetectDelimiter ($1)
C_TEXT:C284($vt_monto;$vt_referencia)
ARRAY REAL:C219(aMonto;0)
ARRAY TEXT:C222(aRUT;0)
ARRAY TEXT:C222(aDescCodigo;0)
ARRAY TEXT:C222(aCodAprobacion;0)
ARRAY TEXT:C222(aNumTarjeta;0)
ARRAY TEXT:C222(aNombre;0)
ARRAY REAL:C219(aMontoMora;0)
ARRAY DATE:C224(ad_fechaVcto;0)
ARRAY DATE:C224(aFechaPagos;0)
ARRAY LONGINT:C221(al_idAvisoAPagar;0)

C_LONGINT:C283($vlACT_idCategoria;$vlACT_idCategoriaIns;$vl_idCta;$vl_idAl)
C_DATE:C307($vd_fechaAC;$vd_fechaV)
C_TEXT:C284($vt_referencia;$vt_msj;$vt_fechaPago;$vt_dia;$vt_mes;$vt_year)

ARRAY LONGINT:C221(aQR_Longint1;0)
ARRAY LONGINT:C221(aQR_Longint2;0)

ARRAY TEXT:C222(aQR_Text1;0)
APPEND TO ARRAY:C911(aQR_Text1;"JAN")
APPEND TO ARRAY:C911(aQR_Text1;"FEB")
APPEND TO ARRAY:C911(aQR_Text1;"MAR")
APPEND TO ARRAY:C911(aQR_Text1;"APR")
APPEND TO ARRAY:C911(aQR_Text1;"MAY")
APPEND TO ARRAY:C911(aQR_Text1;"JUN")
APPEND TO ARRAY:C911(aQR_Text1;"JUL")
APPEND TO ARRAY:C911(aQR_Text1;"AUG")
APPEND TO ARRAY:C911(aQR_Text1;"SEP")
APPEND TO ARRAY:C911(aQR_Text1;"OCT")
APPEND TO ARRAY:C911(aQR_Text1;"NOV")
APPEND TO ARRAY:C911(aQR_Text1;"DEC")

READ ONLY:C145([Alumnos:2])

READ ONLY:C145([xxACT_ItemsCategorias:98])
READ ONLY:C145([xxACT_Items:179])
READ ONLY:C145([ACT_Cargos:173])
READ ONLY:C145([ACT_Transacciones:178])
READ ONLY:C145([ACT_CuentasCorrientes:175])
READ ONLY:C145([ACT_Documentos_de_Cargo:174])
READ ONLY:C145([ACT_Avisos_de_Cobranza:124])

  //vb_fechaPago:=True
  //LOG_RegisterEvt ("Importación de pago con día de pago leído desde archivo.")

QUERY:C277([xxACT_ItemsCategorias:98];[xxACT_ItemsCategorias:98]Nombre:1="Colegiatura@")
If (Records in selection:C76([xxACT_ItemsCategorias:98])=1)
	$vlACT_idCategoria:=[xxACT_ItemsCategorias:98]ID:2
	QUERY:C277([xxACT_Items:179];[xxACT_Items:179]ID_Categoria:8=$vlACT_idCategoria)
	SELECTION TO ARRAY:C260([xxACT_Items:179]ID:1;aQR_Longint1)
End if 

QUERY:C277([xxACT_ItemsCategorias:98];[xxACT_ItemsCategorias:98]Nombre:1="Inscripciones@")
If (Records in selection:C76([xxACT_ItemsCategorias:98])=1)
	$vlACT_idCategoriaIns:=[xxACT_ItemsCategorias:98]ID:2
	QUERY:C277([xxACT_Items:179];[xxACT_Items:179]ID_Categoria:8=$vlACT_idCategoriaIns)
	SELECTION TO ARRAY:C260([xxACT_Items:179]ID:1;aQR_Longint2)
End if 


$ref:=Open document:C264($1;"";Read mode:K24:5)
$text:=""
  //RECEIVE PACKET($ref;$text;$delimiter)
RECEIVE PACKET:C104($ref;$text;$delimiter)
$text:=_O_Win to Mac:C464($text)
While ($text#"")
	AT_Insert (0;1;->aMonto;->aRUT;->aDescCodigo;->aCodAprobacion;->aNumTarjeta;->aNombre;->aMontoMora;->ad_fechaVcto;->aFechaPagos;->al_idAvisoAPagar)
	$vt_monto:=ST_GetCleanString (ST_GetWord ($text;6;"\t"))
	$vt_monto:=Replace string:C233($vt_monto;".";<>tXS_RS_DecimalSeparator)
	$vt_monto:=Replace string:C233($vt_monto;",";<>tXS_RS_DecimalSeparator)
	aMonto{Size of array:C274(aMonto)}:=Num:C11($vt_monto)
	
	$vt_referencia:=ST_GetCleanString (ST_GetWord ($text;4;"\t"))
	aRUT{Size of array:C274(aRUT)}:=ST_DeleteCharsLeft (Substring:C12($vt_referencia;1;6);"0")
	QUERY:C277([Alumnos:2];[Alumnos:2]numero_de_matricula:51=aRUT{Size of array:C274(aRUT)})
	If (Records in selection:C76([Alumnos:2])=0)
		aRUT{Size of array:C274(aRUT)}:=ST_RigthChars (("0"*6)+aRUT{Size of array:C274(aRUT)};6)
		QUERY:C277([Alumnos:2];[Alumnos:2]numero_de_matricula:51=aRUT{Size of array:C274(aRUT)})
	End if 
	
	If (Records in selection:C76([Alumnos:2])=1)
		ACTmx_RetornaDato ("RetornaNumeroMesCuota1Yaocalli";->$vl_mes;->[Alumnos:2]nivel_numero:29)
	Else 
		$vl_mes:=0
	End if 
	
	  //aDescCodigo{Size of array(aDescCodigo)}:=Substring($text;53;2)
	If (aDescCodigo{Size of array:C274(aDescCodigo)}="")
		aCodAprobacion{Size of array:C274(aCodAprobacion)}:="0"
	Else 
		aCodAprobacion{Size of array:C274(aCodAprobacion)}:="-1"
	End if 
	aNumTarjeta{Size of array:C274(aNumTarjeta)}:=""
	aNombre{Size of array:C274(aNombre)}:=""
	aMontoMora{Size of array:C274(aMontoMora)}:=0
	$vl_noCuota:=Num:C11(Substring:C12($vt_referencia;9;2))
	$vl_ciclo:=Num:C11(Substring:C12($vt_referencia;11;2))
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
	$vt_fechaPago:=ST_GetCleanString (ST_GetWord ($text;1;"\t"))
	$vt_dia:=ST_GetWord ($vt_fechaPago;1;" ")
	$vt_mes:=ST_GetWord ($vt_fechaPago;2;" ")
	$vt_year:=ST_GetWord ($vt_fechaPago;3;" ")
	aFechaPagos{Size of array:C274(aFechaPagos)}:=DT_GetDateFromDayMonthYear (Num:C11($vt_dia);Find in array:C230(aQR_Text1;$vt_mes);Num:C11($vt_year))
	$vlACT_concepto:=Num:C11(Substring:C12($vt_referencia;7;2))
	
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
							If ([ACT_Avisos_de_Cobranza:124]Monto_a_Pagar:14#0)
								If (Abs:C99(ACTcar_CalculaMontos ("calcMontoFromNumAvisoMEmision";->[ACT_Avisos_de_Cobranza:124]ID_Aviso:1;->[ACT_Cargos:173]Saldo:23;Current date:C33(*)))=[ACT_Avisos_de_Cobranza:124]Monto_Neto:11)
									al_idAvisoAPagar{Size of array:C274(al_idAvisoAPagar)}:=[ACT_Avisos_de_Cobranza:124]ID_Aviso:1
								Else 
									aDescCodigo{Size of array:C274(aDescCodigo)}:="EL AVISO QUE DESEA PAGAR ESTA PAGADO PARCIALMENTE O TOTALMENTE. Aviso de cobranza"+" paga"+"do para la referencia "+$vt_referencia+", para cargos pertenecientes a la categoría colegiatura."
									aCodAprobacion{Size of array:C274(aCodAprobacion)}:="-1"
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
				
			: ($vlACT_concepto=1)
				If ($vlACT_idCategoriaIns#0)
					$vd_fechaAC:=DT_GetDateFromDayMonthYear (DT_GetLastDay ($vl_noCuota;$vl_year);$vl_noCuota;$vl_year)
					QUERY:C277([ACT_Cargos:173];[ACT_Cargos:173]ID_CuentaCorriente:2=[ACT_CuentasCorrientes:175]ID:1;*)
					QUERY:C277([ACT_Cargos:173]; & ;[ACT_Cargos:173]FechaEmision:22>=ad_fechaVcto{Size of array:C274(ad_fechaVcto)};*)
					QUERY:C277([ACT_Cargos:173]; & ;[ACT_Cargos:173]FechaEmision:22<=$vd_fechaAC)
					QRY_QueryWithArray (->[ACT_Cargos:173]Ref_Item:16;->aQR_Longint2;True:C214)
					If (Records in selection:C76([ACT_Cargos:173])>0)
						KRL_RelateSelection (->[ACT_Documentos_de_Cargo:174]ID_Documento:1;->[ACT_Cargos:173]ID_Documento_de_Cargo:3;"")
						KRL_RelateSelection (->[ACT_Avisos_de_Cobranza:124]ID_Aviso:1;->[ACT_Documentos_de_Cargo:174]No_ComprobanteInterno:15;"")
						If (Records in selection:C76([ACT_Avisos_de_Cobranza:124])=1)
							If ([ACT_Avisos_de_Cobranza:124]Monto_a_Pagar:14#0)
								If (Abs:C99(ACTcar_CalculaMontos ("calcMontoFromNumAvisoMEmision";->[ACT_Avisos_de_Cobranza:124]ID_Aviso:1;->[ACT_Cargos:173]Saldo:23;Current date:C33(*)))=[ACT_Avisos_de_Cobranza:124]Monto_Neto:11)
									al_idAvisoAPagar{Size of array:C274(al_idAvisoAPagar)}:=[ACT_Avisos_de_Cobranza:124]ID_Aviso:1
								Else 
									aDescCodigo{Size of array:C274(aDescCodigo)}:="EL AVISO QUE DESEA PAGAR ESTA PAGADO PARCIALMENTE O TOTALMENTE. Aviso de cobranza"+" paga"+"do para la referencia "+$vt_referencia+", para cargos pertenecientes a la categoría colegiatura."
									aCodAprobacion{Size of array:C274(aCodAprobacion)}:="-1"
								End if 
							Else 
								aDescCodigo{Size of array:C274(aDescCodigo)}:="TODOS LOS AVISOS DE COBRANZA DE ESTE ALUMNO ESTAN PAGADOS. Aviso de cobranza paga"+"do para la referencia "+$vt_referencia+", para cargos pertenecientes a la categoría inscripción."
								aCodAprobacion{Size of array:C274(aCodAprobacion)}:="-1"
							End if 
						Else 
							aDescCodigo{Size of array:C274(aDescCodigo)}:="EXISTE MÁS DE UN AVISO DE COBRANZA EMITIDO PARA EL MES QUE DESEAS PAGAR. Aviso de"+" cobranza no encontrado para la referencia "+$vt_referencia+", para cargos pertenecientes a la categoría inscripción."
							aCodAprobacion{Size of array:C274(aCodAprobacion)}:="-1"
						End if 
					Else 
						aDescCodigo{Size of array:C274(aDescCodigo)}:="NO EXISTE AVISO DE COBRANZA EMITIDO PARA EL MES QUE DESEAS PAGAR. Cargos no encon"+"trados para la referencia "+$vt_referencia+", para cargos pertenecientes a la categoría inscripción."
						aCodAprobacion{Size of array:C274(aCodAprobacion)}:="-1"
					End if 
				Else 
					aDescCodigo{Size of array:C274(aDescCodigo)}:="Aviso de cobranza no encontrado para la referencia "+$vt_referencia+". Categoría inscripción no configurada."
					aCodAprobacion{Size of array:C274(aCodAprobacion)}:="-1"
				End if 
				
			: ($vlACT_concepto=8)
				$vd_fechaAC:=DT_GetDateFromDayMonthYear (DT_GetLastDay ($vl_noCuota;$vl_year);$vl_noCuota;$vl_year)
				QUERY:C277([ACT_Cargos:173];[ACT_Cargos:173]ID_CuentaCorriente:2=[ACT_CuentasCorrientes:175]ID:1;*)
				QUERY:C277([ACT_Cargos:173]; & ;[ACT_Cargos:173]FechaEmision:22>=ad_fechaVcto{Size of array:C274(ad_fechaVcto)};*)
				QUERY:C277([ACT_Cargos:173]; & ;[ACT_Cargos:173]FechaEmision:22<=$vd_fechaAC)
				QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]Glosa:12="@ UNAM @")
				If (Records in selection:C76([ACT_Cargos:173])>0)
					KRL_RelateSelection (->[ACT_Documentos_de_Cargo:174]ID_Documento:1;->[ACT_Cargos:173]ID_Documento_de_Cargo:3;"")
					KRL_RelateSelection (->[ACT_Avisos_de_Cobranza:124]ID_Aviso:1;->[ACT_Documentos_de_Cargo:174]No_ComprobanteInterno:15;"")
					If (Records in selection:C76([ACT_Avisos_de_Cobranza:124])=1)
						If ([ACT_Avisos_de_Cobranza:124]Monto_a_Pagar:14#0)
							If (Abs:C99(ACTcar_CalculaMontos ("calcMontoFromNumAvisoMEmision";->[ACT_Avisos_de_Cobranza:124]ID_Aviso:1;->[ACT_Cargos:173]Saldo:23;Current date:C33(*)))=[ACT_Avisos_de_Cobranza:124]Monto_Neto:11)
								al_idAvisoAPagar{Size of array:C274(al_idAvisoAPagar)}:=[ACT_Avisos_de_Cobranza:124]ID_Aviso:1
							Else 
								aDescCodigo{Size of array:C274(aDescCodigo)}:="EL AVISO QUE DESEA PAGAR ESTA PAGADO PARCIALMENTE O TOTALMENTE. Aviso de cobranza"+" paga"+"do para la referencia "+$vt_referencia+", para cargos pertenecientes a la categoría colegiatura."
								aCodAprobacion{Size of array:C274(aCodAprobacion)}:="-1"
							End if 
						Else 
							aDescCodigo{Size of array:C274(aDescCodigo)}:="Aviso de cobranza pagado para la referencia "+$vt_referencia+", para cargos llamados "+ST_Qte ("UNAM")+"."
							aCodAprobacion{Size of array:C274(aCodAprobacion)}:="-1"
						End if 
					Else 
						aDescCodigo{Size of array:C274(aDescCodigo)}:="Aviso de cobranza no encontrado para la referencia "+$vt_referencia+", para cargos llamados "+ST_Qte ("UNAM")+"."
						aCodAprobacion{Size of array:C274(aCodAprobacion)}:="-1"
					End if 
				Else 
					aDescCodigo{Size of array:C274(aDescCodigo)}:="Cargos no encontrados para la referencia "+$vt_referencia+". Cargo UNAM."
					aCodAprobacion{Size of array:C274(aCodAprobacion)}:="-1"
				End if 
				
		End case 
		
		
		  //********** INICIO  **********
		  //borrar cargos de multa automatica
		If (al_idAvisoAPagar{Size of array:C274(al_idAvisoAPagar)}#0)
			QUERY:C277([ACT_Avisos_de_Cobranza:124];[ACT_Avisos_de_Cobranza:124]ID_Aviso:1=al_idAvisoAPagar{Size of array:C274(al_idAvisoAPagar)})
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
							aDescCodigo{Size of array:C274(aDescCodigo)}:="Cargo de multa no puede ser eliminado porque está pagado o está en Document"+"o Tributario. Referencia número "+$vt_referencia+"."
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
	End if 
	RECEIVE PACKET:C104($ref;$text;$delimiter)
	$text:=_O_Win to Mac:C464($text)
End while 
  //AT_Delete (Size of array(aRUT);1;->aMonto;->aRUT;->aDescCodigo;->aCodAprobacion;->aNumTarjeta;->aNombre;->aMontoMora;->ad_fechaVcto;->aFechaPagos;->al_idAvisoAPagar)
<>vRUTField:=Field:C253(->[Alumnos:2]numero_de_matricula:51)
<>vRUTTable:=Table:C252(->[Alumnos:2])
<>vLabelLink:="Codigo Interno"
CLOSE DOCUMENT:C267($ref)