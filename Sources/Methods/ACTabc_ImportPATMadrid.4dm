//%attributes = {}
  //ACTabc_ImportPATMadrid
  //Last update :  12/01/2011
  //Version:          7
  //Last update :  18/01/2011
  //Version:          8

C_TIME:C306($ref)
C_TEXT:C284($text;$delimiter;$1)
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
ARRAY LONGINT:C221(al_idsCargosAPagar;0)
ARRAY TEXT:C222(aLugarDePago;0)
ARRAY TEXT:C222(atACT_LugarPago;0)
ARRAY TEXT:C222(atACT_idsCargos;0)

C_TEXT:C284($vt_idPago;$vt_msj)
C_LONGINT:C283($vl_lugarPago;$vl_pos;$i;$hh;$vl_recordNumber)
C_REAL:C285($vr_montoCargo;$vr_monto;$vr_montoAviso)
C_DATE:C307($vd_fecha)
C_TEXT:C284($vt_monto;$vt_montoMora;$vt_fechaPago;$vt_fechaVencimiento;$vt_rut;$vt_numTarjeta;$vt_idAviso;$vt_idCargo;$vt_lugarDePago)

ARRAY TEXT:C222(aQR_Text1;0)

READ ONLY:C145([Alumnos:2])
READ ONLY:C145([ACT_Cargos:173])
READ ONLY:C145([ACT_Transacciones:178])
READ ONLY:C145([ACT_Documentos_de_Cargo:174])
READ ONLY:C145([ACT_Avisos_de_Cobranza:124])

$ref:=Open document:C264($1;"";Read mode:K24:5)
$text:=""
RECEIVE PACKET:C104($ref;$text;$delimiter)
$text:=_O_Win to Mac:C464($text)

  //vb_fechaPago:=True

  //LOG_RegisterEvt ("Importación de pago con día de pago leído desde archivo.")
  //revisar $i = 2 31292 - 31298.... 986125  
While ($text#"")
	$vt_idPago:=Substring:C12($text;297;20)
	$vl_pos:=Find in array:C230(aQR_Text1;$vt_idPago)
	$vt_monto:=ST_GetCleanString (Substring:C12($text;51;13))
	$vt_monto:=Replace string:C233($vt_monto;",";"")
	$vt_monto:=Replace string:C233($vt_monto;".";<>tXS_RS_DecimalSeparator)
	$vr_montoCargo:=Num:C11($vt_monto)
	$vt_idAviso:=Substring:C12($text;184;30)
	
	If ($vl_pos=-1)
		AT_Insert (0;1;->aMonto;->aRUT;->aDescCodigo;->aCodAprobacion;->aNumTarjeta;->aNombre;->aMontoMora;->ad_fechaVcto;->aFechaPagos;->al_idAvisoAPagar;->aQR_Text1;->al_idsCargosAPagar;->atACT_LugarPago;->atACT_idsCargos)
		$hh:=Size of array:C274(aMonto)
		
		$vt_monto:=ST_GetCleanString (Substring:C12($text;347;22))
		$vt_monto:=Replace string:C233($vt_monto;",";"")
		$vt_monto:=Replace string:C233($vt_monto;".";<>tXS_RS_DecimalSeparator)
		
		$vt_montoMora:="0"
		$vt_fechaPago:=Substring:C12($text;244;10)
		$vt_fechaVencimiento:=Substring:C12($text;369;10)
		$vt_rut:=ST_GetCleanString (Substring:C12($text;1;20))
		$vt_numTarjeta:=Substring:C12($text;272;25)
		
		$vt_idCargo:=Substring:C12($text;64;30)
		$vt_lugarDePago:=Substring:C12($text;270;2)
		
		aQR_Text1{$hh}:=$vt_idPago
		aMonto{$hh}:=Num:C11($vt_monto)
		aRUT{$hh}:=$vt_rut
		aNumTarjeta{$hh}:=""
		aNombre{$hh}:=""
		aMontoMora{$hh}:=0
		aFechaPagos{$hh}:=DT_GetDateFromDayMonthYear (Num:C11(Substring:C12($vt_fechaPago;9;2));Num:C11(Substring:C12($vt_fechaPago;6;2));Num:C11(Substring:C12($vt_fechaPago;1;4)))
		ad_fechaVcto{$hh}:=DT_GetDateFromDayMonthYear (Num:C11(Substring:C12($vt_fechaVencimiento;9;2));Num:C11(Substring:C12($vt_fechaVencimiento;6;2));Num:C11(Substring:C12($vt_fechaVencimiento;1;4)))
		al_idAvisoAPagar{$hh}:=Num:C11($vt_idAviso)
		
		$vt_msj:="Aviso número "+String:C10(al_idAvisoAPagar{$hh})+"."
		
		QUERY:C277([ACT_Avisos_de_Cobranza:124];[ACT_Avisos_de_Cobranza:124]ID_Aviso:1=al_idAvisoAPagar{Size of array:C274(al_idAvisoAPagar)})
		If (Records in selection:C76([ACT_Avisos_de_Cobranza:124])=1)
			$vl_recordNumber:=Record number:C243([ACT_Avisos_de_Cobranza:124])
			If (Abs:C99(ACTcar_CalculaMontos ("calcMontoFromNumAvisoMEmision";->[ACT_Avisos_de_Cobranza:124]ID_Aviso:1;->[ACT_Cargos:173]Saldo:23;Current date:C33(*)))=[ACT_Avisos_de_Cobranza:124]Monto_Neto:11)
				QUERY:C277([ACT_Documentos_de_Cargo:174];[ACT_Documentos_de_Cargo:174]No_ComprobanteInterno:15=[ACT_Avisos_de_Cobranza:124]ID_Aviso:1)
				KRL_RelateSelection (->[ACT_Cargos:173]ID_Documento_de_Cargo:3;->[ACT_Documentos_de_Cargo:174]ID_Documento:1;"")
				CREATE SET:C116([ACT_Cargos:173];"setCargos")
				QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]Ref_Item:16=Num:C11($vt_idCargo))
				QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]Monto_Neto:5=$vr_montoCargo)
				
				CREATE SET:C116([ACT_Cargos:173];"cargos1")
				ARRAY LONGINT:C221(aQR_Longint2;0)
				AT_Text2Array (->aQR_Longint2;atACT_idsCargos{Size of array:C274(atACT_idsCargos)};"-")
				
				QUERY WITH ARRAY:C644([ACT_Cargos:173]ID:1;aQR_Longint2)
				CREATE SET:C116([ACT_Cargos:173];"cargos2")
				
				DIFFERENCE:C122("cargos1";"cargos2";"cargos1")
				USE SET:C118("cargos1")
				SET_ClearSets ("cargos1";"cargos2")
				
				If (Records in selection:C76([ACT_Cargos:173])>0)
					FIRST RECORD:C50([ACT_Cargos:173])
					atACT_idsCargos{Size of array:C274(atACT_idsCargos)}:=String:C10([ACT_Cargos:173]ID:1)
					
					  //elimino posibles recargos por multa automatica
					USE SET:C118("setCargos")
					QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]Ref_AvisoMulta:53#"")
					If (Records in selection:C76([ACT_Cargos:173])>0)
						ARRAY LONGINT:C221(aQR_Longint1;0)
						LONGINT ARRAY FROM SELECTION:C647([ACT_Cargos:173];aQR_Longint1;"")
						For ($i;1;Size of array:C274(aQR_Longint1))
							GOTO RECORD:C242([ACT_Cargos:173];aQR_Longint1{$i})
							$vd_fecha:=DT_GetDateFromDayMonthYear (Num:C11(Substring:C12([ACT_Cargos:173]Ref_AvisoMulta:53;7;2));Num:C11(Substring:C12([ACT_Cargos:173]Ref_AvisoMulta:53;5;2));Num:C11(Substring:C12([ACT_Cargos:173]Ref_AvisoMulta:53;1;4)))
							  //If ($vd_fecha>=aFechaPagos{Size of array(aFechaPagos)})
							If ($vd_fecha>aFechaPagos{Size of array:C274(aFechaPagos)})
								QUERY:C277([ACT_Transacciones:178];[ACT_Transacciones:178]ID_Item:3=[ACT_Cargos:173]ID:1)
								C_LONGINT:C283($vl_records)
								SET QUERY DESTINATION:C396(Into variable:K19:4;$vl_records)
								QUERY SELECTION:C341([ACT_Transacciones:178];[ACT_Transacciones:178]No_Boleta:9#0)
								SET QUERY DESTINATION:C396(Into current selection:K19:1)
								If ((Sum:C1([ACT_Cargos:173]MontosPagados:8)=0) & ($vl_records=0))
									ACTcc_EliminaCargosLoop 
									ACTac_Recalcular ($vl_recordNumber)
									LOG_RegisterEvt ("Eliminación de cargo generado como multa automática durante el proceso de importa"+"ción de pagos."+$vt_msj)
								Else 
									aDescCodigo{Size of array:C274(aDescCodigo)}:="Cargo de multa no puede ser eliminado porque está pagado o está en Document"+"o Tributario. "+$vt_msj
									aCodAprobacion{Size of array:C274(aCodAprobacion)}:="-1"
								End if 
							End if 
						End for 
					End if 
				End if 
			Else 
				aDescCodigo{Size of array:C274(aDescCodigo)}:="Aviso parcial o completamente pagado. "+$vt_msj
				aCodAprobacion{Size of array:C274(aCodAprobacion)}:="-1"
			End if 
			al_idsCargosAPagar{Size of array:C274(al_idsCargosAPagar)}:=Num:C11($vt_idCargo)
			$vl_lugarPago:=Num:C11($vt_lugarDePago)
			Case of 
				: ($vl_lugarPago=1)
					atACT_LugarPago{Size of array:C274(atACT_LugarPago)}:="Multipagos - TDC"
				: ($vl_lugarPago=2)
					atACT_LugarPago{Size of array:C274(atACT_LugarPago)}:="Multipagos - CIE"
				: ($vl_lugarPago=3)
					atACT_LugarPago{Size of array:C274(atACT_LugarPago)}:="Multipagos - CLABE"
				: ($vl_lugarPago=4)
					atACT_LugarPago{Size of array:C274(atACT_LugarPago)}:="Multipagos - Sucursal"
			End case 
			If (aDescCodigo{Size of array:C274(aDescCodigo)}="")
				aCodAprobacion{Size of array:C274(aCodAprobacion)}:="0"
			Else 
				aCodAprobacion{Size of array:C274(aCodAprobacion)}:="-1"
			End if 
		Else 
			aDescCodigo{Size of array:C274(aDescCodigo)}:="No existe Aviso de Cobranza emitido para el mes que desea pagar. "+$vt_msj
			aCodAprobacion{Size of array:C274(aCodAprobacion)}:="-1"
		End if 
	Else 
		al_idsCargosAPagar{$vl_pos}:=0
		If (al_idAvisoAPagar{$vl_pos}#Num:C11($vt_idAviso))
			al_idAvisoAPagar{$vl_pos}:=0
			QUERY:C277([ACT_Avisos_de_Cobranza:124];[ACT_Avisos_de_Cobranza:124]ID_Aviso:1=Num:C11($vt_idAviso))
			If (Records in selection:C76([ACT_Avisos_de_Cobranza:124])=1)
				$vl_recordNumber:=Record number:C243([ACT_Avisos_de_Cobranza:124])
				If (Abs:C99(ACTcar_CalculaMontos ("calcMontoFromNumAvisoMEmision";->[ACT_Avisos_de_Cobranza:124]ID_Aviso:1;->[ACT_Cargos:173]Saldo:23;Current date:C33(*)))=[ACT_Avisos_de_Cobranza:124]Monto_Neto:11)
					QUERY:C277([ACT_Documentos_de_Cargo:174];[ACT_Documentos_de_Cargo:174]No_ComprobanteInterno:15=[ACT_Avisos_de_Cobranza:124]ID_Aviso:1)
					KRL_RelateSelection (->[ACT_Cargos:173]ID_Documento_de_Cargo:3;->[ACT_Documentos_de_Cargo:174]ID_Documento:1;"")
					CREATE SET:C116([ACT_Cargos:173];"setCargos")
					QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]Ref_Item:16=Num:C11(Substring:C12($text;64;30)))
					QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]Monto_Neto:5=$vr_montoCargo)
					
					CREATE SET:C116([ACT_Cargos:173];"cargos1")
					ARRAY LONGINT:C221(aQR_Longint2;0)
					AT_Text2Array (->aQR_Longint2;atACT_idsCargos{Size of array:C274(atACT_idsCargos)};"-")
					
					QUERY WITH ARRAY:C644([ACT_Cargos:173]ID:1;aQR_Longint2)
					CREATE SET:C116([ACT_Cargos:173];"cargos2")
					
					DIFFERENCE:C122("cargos1";"cargos2";"cargos1")
					USE SET:C118("cargos1")
					SET_ClearSets ("cargos1";"cargos2")
					
					If (Records in selection:C76([ACT_Cargos:173])>0)
						FIRST RECORD:C50([ACT_Cargos:173])
						atACT_idsCargos{Size of array:C274(atACT_idsCargos)}:=atACT_idsCargos{Size of array:C274(atACT_idsCargos)}+"-"+String:C10([ACT_Cargos:173]ID:1)
						
						  //elimino posibles recargos por multa automatica
						USE SET:C118("setCargos")
						QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]Ref_AvisoMulta:53#"")
						If (Records in selection:C76([ACT_Cargos:173])>0)
							ARRAY LONGINT:C221(aQR_Longint1;0)
							LONGINT ARRAY FROM SELECTION:C647([ACT_Cargos:173];aQR_Longint1;"")
							For ($i;1;Size of array:C274(aQR_Longint1))
								GOTO RECORD:C242([ACT_Cargos:173];aQR_Longint1{$i})
								$vd_fecha:=DT_GetDateFromDayMonthYear (Num:C11(Substring:C12([ACT_Cargos:173]Ref_AvisoMulta:53;7;2));Num:C11(Substring:C12([ACT_Cargos:173]Ref_AvisoMulta:53;5;2));Num:C11(Substring:C12([ACT_Cargos:173]Ref_AvisoMulta:53;1;4)))
								  //If ($vd_fecha>=aFechaPagos{Size of array(aFechaPagos)})
								If ($vd_fecha>aFechaPagos{Size of array:C274(aFechaPagos)})
									QUERY:C277([ACT_Transacciones:178];[ACT_Transacciones:178]ID_Item:3=[ACT_Cargos:173]ID:1)
									C_LONGINT:C283($vl_records)
									SET QUERY DESTINATION:C396(Into variable:K19:4;$vl_records)
									QUERY SELECTION:C341([ACT_Transacciones:178];[ACT_Transacciones:178]No_Boleta:9#0)
									SET QUERY DESTINATION:C396(Into current selection:K19:1)
									If ((Sum:C1([ACT_Cargos:173]MontosPagados:8)=0) & ($vl_records=0))
										ACTcc_EliminaCargosLoop 
										ACTac_Recalcular ($vl_recordNumber)
										LOG_RegisterEvt ("Eliminación de cargo generado como multa automática durante el proceso de importa"+"ción de pagos."+$vt_msj)
									Else 
										aDescCodigo{Size of array:C274(aDescCodigo)}:="Cargo de multa no puede ser eliminado porque está pagado o está en Document"+"o Tributario. "+$vt_msj
										aCodAprobacion{Size of array:C274(aCodAprobacion)}:="-1"
									End if 
								End if 
							End for 
						End if 
						
					End if 
				Else 
					aDescCodigo{Size of array:C274(aDescCodigo)}:="Aviso parcial o completamente pagado. "+$vt_msj
					aCodAprobacion{Size of array:C274(aCodAprobacion)}:="-1"
				End if 
			End if 
		Else 
			QUERY:C277([ACT_Avisos_de_Cobranza:124];[ACT_Avisos_de_Cobranza:124]ID_Aviso:1=al_idAvisoAPagar{$vl_pos})
			If (Records in selection:C76([ACT_Avisos_de_Cobranza:124])=1)
				$vl_recordNumber:=Record number:C243([ACT_Avisos_de_Cobranza:124])
				If (Abs:C99(ACTcar_CalculaMontos ("calcMontoFromNumAvisoMEmision";->[ACT_Avisos_de_Cobranza:124]ID_Aviso:1;->[ACT_Cargos:173]Saldo:23;Current date:C33(*)))=[ACT_Avisos_de_Cobranza:124]Monto_Neto:11)
					QUERY:C277([ACT_Documentos_de_Cargo:174];[ACT_Documentos_de_Cargo:174]No_ComprobanteInterno:15=[ACT_Avisos_de_Cobranza:124]ID_Aviso:1)
					KRL_RelateSelection (->[ACT_Cargos:173]ID_Documento_de_Cargo:3;->[ACT_Documentos_de_Cargo:174]ID_Documento:1;"")
					CREATE SET:C116([ACT_Cargos:173];"setCargos")
					QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]Ref_Item:16=Num:C11(Substring:C12($text;64;30)))
					QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]Monto_Neto:5=$vr_montoCargo)
					
					CREATE SET:C116([ACT_Cargos:173];"cargos1")
					ARRAY LONGINT:C221(aQR_Longint2;0)
					AT_Text2Array (->aQR_Longint2;atACT_idsCargos{Size of array:C274(atACT_idsCargos)};"-")
					
					QUERY WITH ARRAY:C644([ACT_Cargos:173]ID:1;aQR_Longint2)
					CREATE SET:C116([ACT_Cargos:173];"cargos2")
					
					DIFFERENCE:C122("cargos1";"cargos2";"cargos1")
					USE SET:C118("cargos1")
					SET_ClearSets ("cargos1";"cargos2")
					
					If (Records in selection:C76([ACT_Cargos:173])>0)
						Case of 
							: (Records in selection:C76([ACT_Cargos:173])=1)
								atACT_idsCargos{Size of array:C274(atACT_idsCargos)}:=atACT_idsCargos{Size of array:C274(atACT_idsCargos)}+"-"+String:C10([ACT_Cargos:173]ID:1)
							Else 
								FIRST RECORD:C50([ACT_Cargos:173])
								atACT_idsCargos{Size of array:C274(atACT_idsCargos)}:=atACT_idsCargos{Size of array:C274(atACT_idsCargos)}+"-"+String:C10([ACT_Cargos:173]ID:1)
						End case 
						
						  //elimino posibles recargos por multa automatica
						USE SET:C118("setCargos")
						QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]Ref_AvisoMulta:53#"")
						If (Records in selection:C76([ACT_Cargos:173])>0)
							ARRAY LONGINT:C221(aQR_Longint1;0)
							LONGINT ARRAY FROM SELECTION:C647([ACT_Cargos:173];aQR_Longint1;"")
							For ($i;1;Size of array:C274(aQR_Longint1))
								GOTO RECORD:C242([ACT_Cargos:173];aQR_Longint1{$i})
								$vd_fecha:=DT_GetDateFromDayMonthYear (Num:C11(Substring:C12([ACT_Cargos:173]Ref_AvisoMulta:53;7;2));Num:C11(Substring:C12([ACT_Cargos:173]Ref_AvisoMulta:53;5;2));Num:C11(Substring:C12([ACT_Cargos:173]Ref_AvisoMulta:53;1;4)))
								  //If ($vd_fecha>=aFechaPagos{Size of array(aFechaPagos)})
								If ($vd_fecha>aFechaPagos{Size of array:C274(aFechaPagos)})
									QUERY:C277([ACT_Transacciones:178];[ACT_Transacciones:178]ID_Item:3=[ACT_Cargos:173]ID:1)
									C_LONGINT:C283($vl_records)
									SET QUERY DESTINATION:C396(Into variable:K19:4;$vl_records)
									QUERY SELECTION:C341([ACT_Transacciones:178];[ACT_Transacciones:178]No_Boleta:9#0)
									SET QUERY DESTINATION:C396(Into current selection:K19:1)
									If ((Sum:C1([ACT_Cargos:173]MontosPagados:8)=0) & ($vl_records=0))
										ACTcc_EliminaCargosLoop 
										ACTac_Recalcular ($vl_recordNumber)
										LOG_RegisterEvt ("Eliminación de cargo generado como multa automática durante el proceso de importa"+"ción de pagos."+$vt_msj)
									Else 
										aDescCodigo{Size of array:C274(aDescCodigo)}:="Cargo de multa no puede ser eliminado porque está pagado o está en Document"+"o Tributario. "+$vt_msj
										aCodAprobacion{Size of array:C274(aCodAprobacion)}:="-1"
									End if 
								End if 
							End for 
						End if 
						
					End if 
				Else 
					aDescCodigo{Size of array:C274(aDescCodigo)}:="Aviso parcial o completamente pagado. "+$vt_msj
					aCodAprobacion{Size of array:C274(aCodAprobacion)}:="-1"
				End if 
			End if 
		End if 
	End if 
	SET_ClearSets ("setCargos")
	RECEIVE PACKET:C104($ref;$text;$delimiter)
	$text:=_O_Win to Mac:C464($text)
End while 


  //valida montos de avisos
For ($i;1;Size of array:C274(atACT_idsCargos))
	READ ONLY:C145([ACT_Cargos:173])
	READ ONLY:C145([ACT_Documentos_de_Cargo:174])
	
	ARRAY LONGINT:C221(aQR_Longint2;0)
	ARRAY LONGINT:C221(aQR_Longint3;0)
	
	AT_Text2Array (->aQR_Longint2;atACT_idsCargos{$i};"-")
	QUERY WITH ARRAY:C644([ACT_Cargos:173]ID:1;aQR_Longint2)
	$vr_monto:=Abs:C99(ACTcar_CalculaMontos ("redondeadoFromCurrentRecordsMPago";->[ACT_Cargos:173]Saldo:23;->[ACT_Cargos:173]Saldo:23;Current date:C33(*)))
	KRL_RelateSelection (->[ACT_Documentos_de_Cargo:174]ID_Documento:1;->[ACT_Cargos:173]ID_Documento_de_Cargo:3;"")
	DISTINCT VALUES:C339([ACT_Documentos_de_Cargo:174]No_ComprobanteInterno:15;aQR_Longint3)
	$vr_montoAviso:=Abs:C99(ACTcar_CalculaMontos ("calcMontoFromArrNumAvisoMPago";->aQR_Longint3;->[ACT_Cargos:173]Saldo:23;Current date:C33(*)))
	If (($vr_monto#$vr_montoAviso) | ($vr_montoAviso=0))
		If ($vr_montoAviso=0)
			aDescCodigo{$i}:="Aviso(s) de cobranza asociado(s) al pago se encuentra(n) pagado(s)."
		Else 
			aDescCodigo{$i}:="Suma de aviso(s) de cobranza asociado(s) al pago no corresponde. Avisos: "+AT_array2text (->aQR_Longint3;"-";"### ### ###")
		End if 
		aCodAprobacion{$i}:="-1"
	Else 
		aDescCodigo{$i}:=""
		aCodAprobacion{$i}:="0"
	End if 
End for 


<>vRUTField:=Field:C253(->[Personas:7]Codigo_interno:22)
<>vRUTTable:=Table:C252(->[Personas:7])
<>vLabelLink:="Codigo Interno"
CLOSE DOCUMENT:C267($ref)