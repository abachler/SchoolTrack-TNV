//%attributes = {}
  //ACTpgs_BuscaDeuda

ACTcfg_LeeBlob ("ACTcfg_GeneralesIngresoPagos")
C_LONGINT:C283($1;$id)
C_LONGINT:C283($vl_idAvisoAPagar;$vl_idItemPagar)
C_TEXT:C284($vt_No_familia)
C_DATE:C307($vd_fecha)
C_REAL:C285(vrACTpgs2_deuda)
C_BOOLEAN:C305(vbACTpgs_ArregloCargos;vbACTpgs_OrdCarXRecNumArr)


  // Modificado por: Saúl Ponce (14/11/2017), agrego la variable local que se utilizará para comparación
C_BOOLEAN:C305($vbACTpgs_ArregloCargos)
$vbACTpgs_ArregloCargos:=vbACTpgs_ArregloCargos

  //15-10-07 JVP arrelgo para las el filtro de las cuentas de la familia
ARRAY LONGINT:C221($alACT_idcuentas;0)
$id:=$1
$vl_idAvisoAPagar:=$2
If (Count parameters:C259>=3)
	$vd_fecha:=$3
End if 
If (Count parameters:C259>=4)
	$vl_idItemPagar:=$4
End if 
If (Count parameters:C259>=5)
	$vt_No_familia:=$5
End if 
If ($vd_fecha=!00-00-00!)
	$vd_fecha:=Current date:C33(*)
End if 
vrACTpgs2_deuda:=0

vbACTpgs_OrdCarXRecNumArr:=False:C215

READ ONLY:C145([ACT_Avisos_de_Cobranza:124])
READ ONLY:C145([ACT_Cargos:173])
READ ONLY:C145([ACT_Pagos:172])
READ ONLY:C145([ACT_Documentos_de_Cargo:174])

MESSAGES OFF:C175

If ($id>0)
	ARRAY LONGINT:C221(al_RecNumsCargos;0)
	ARRAY LONGINT:C221(alACT_AIDAviso;0)
	If (vbACTpgs_ArregloCargos)
		QUERY WITH ARRAY:C644([ACT_Cargos:173]ID:1;alACTpgs_idsCargos)
		ARRAY LONGINT:C221($alACT_recNum;0)
		ARRAY LONGINT:C221($alACT_ids;0)
		SELECTION TO ARRAY:C260([ACT_Cargos:173];$alACT_recNum;[ACT_Cargos:173]ID:1;$alACT_ids)
		AT_OrderArraysByArray (MAXLONG:K35:2;->alACTpgs_idsCargos;->$alACT_ids;->$alACT_recNum)
		CREATE SELECTION FROM ARRAY:C640([ACT_Cargos:173];$alACT_recNum;"")
		vbACTpgs_OrdCarXRecNumArr:=True:C214
	End if 
	Case of 
		: (RNApdo#-1)
			If (Not:C34(vbACTpgs_ArregloCargos))
				If ($vl_idAvisoAPagar#0)
					QUERY:C277([ACT_Avisos_de_Cobranza:124];[ACT_Avisos_de_Cobranza:124]ID_Aviso:1=$vl_idAvisoAPagar;*)
					QUERY:C277([ACT_Avisos_de_Cobranza:124]; & ;[ACT_Avisos_de_Cobranza:124]ID_Apoderado:3=$id;*)
					QUERY:C277([ACT_Avisos_de_Cobranza:124]; & ;[ACT_Avisos_de_Cobranza:124]Monto_a_Pagar:14#0)
				Else 
					QUERY:C277([ACT_Avisos_de_Cobranza:124];[ACT_Avisos_de_Cobranza:124]ID_Apoderado:3=$id;*)
					QUERY:C277([ACT_Avisos_de_Cobranza:124]; & ;[ACT_Avisos_de_Cobranza:124]Monto_a_Pagar:14#0)
				End if 
				QUERY SELECTION:C341([ACT_Avisos_de_Cobranza:124];[ACT_Avisos_de_Cobranza:124]ID_Tercero:26=0)
				If (cb_soloCuotasVencidas=1)
					QUERY SELECTION:C341([ACT_Avisos_de_Cobranza:124];[ACT_Avisos_de_Cobranza:124]Fecha_Vencimiento:5<=Current date:C33(*))
				End if 
				KRL_RelateSelection (->[ACT_Documentos_de_Cargo:174]No_ComprobanteInterno:15;->[ACT_Avisos_de_Cobranza:124]ID_Aviso:1;"")
				KRL_RelateSelection (->[ACT_Cargos:173]ID_Documento_de_Cargo:3;->[ACT_Documentos_de_Cargo:174]ID_Documento:1;"")
				If ($vl_idItemPagar#0)
					QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]Ref_Item:16=$vl_idItemPagar)
				End if 
			Else 
				vbACTpgs_ArregloCargos:=False:C215
			End if 
			LONGINT ARRAY FROM SELECTION:C647([ACT_Cargos:173];al_RecNumsCargos;"")
			
			QUERY:C277([ACT_Pagos:172];[ACT_Pagos:172]ID_Apoderado:3=[Personas:7]No:1;*)
			QUERY:C277([ACT_Pagos:172]; & ;[ACT_Pagos:172]Saldo:15>0)
			$pagosconSaldo:=Sum:C1([ACT_Pagos:172]Saldo:15)
		: (RNCta#-1)
			If (Not:C34(vbACTpgs_ArregloCargos))
				If ($vl_idAvisoAPagar#0)
					QUERY:C277([ACT_Avisos_de_Cobranza:124];[ACT_Avisos_de_Cobranza:124]ID_Aviso:1=$vl_idAvisoAPagar;*)
					QUERY:C277([ACT_Avisos_de_Cobranza:124]; & ;[ACT_Avisos_de_Cobranza:124]Monto_a_Pagar:14#0)
					KRL_RelateSelection (->[ACT_Documentos_de_Cargo:174]No_ComprobanteInterno:15;->[ACT_Avisos_de_Cobranza:124]ID_Aviso:1;"")
					KRL_RelateSelection (->[ACT_Cargos:173]ID_Documento_de_Cargo:3;->[ACT_Documentos_de_Cargo:174]ID_Documento:1;"")
					
					  //ASM 20171107 Ticket 191899 filtro para dejar los cargo de la cuenta corriente.
					QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]ID_CuentaCorriente:2=$id)
				Else 
					QUERY:C277([ACT_Cargos:173];[ACT_Cargos:173]ID_CuentaCorriente:2=$id;*)
					QUERY:C277([ACT_Cargos:173]; & [ACT_Cargos:173]FechaEmision:22#!00-00-00!;*)
					QUERY:C277([ACT_Cargos:173]; & ;[ACT_Cargos:173]Saldo:23#0)
				End if 
				If (cb_soloCuotasVencidas=1)
					QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]Fecha_de_Vencimiento:7<=Current date:C33(*))
				End if 
				If ($vl_idItemPagar#0)
					QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]Ref_Item:16=$vl_idItemPagar)
				End if 
				QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]ID_Tercero:54=0)
			Else 
				vbACTpgs_ArregloCargos:=False:C215
			End if 
			LONGINT ARRAY FROM SELECTION:C647([ACT_Cargos:173];al_RecNumsCargos;"")
			QUERY:C277([ACT_Pagos:172];[ACT_Pagos:172]ID_CtaCte:21=[ACT_CuentasCorrientes:175]ID:1;*)
			QUERY:C277([ACT_Pagos:172]; & ;[ACT_Pagos:172]Saldo:15>0)
			$pagosconSaldo:=Sum:C1([ACT_Pagos:172]Saldo:15)
			
			
		: (RNTercero#-1)
			If (Not:C34(vbACTpgs_ArregloCargos))
				If ($vl_idAvisoAPagar#0)
					QUERY:C277([ACT_Avisos_de_Cobranza:124];[ACT_Avisos_de_Cobranza:124]ID_Aviso:1=$vl_idAvisoAPagar;*)
					QUERY:C277([ACT_Avisos_de_Cobranza:124]; & ;[ACT_Avisos_de_Cobranza:124]ID_Tercero:26=$id;*)
					QUERY:C277([ACT_Avisos_de_Cobranza:124]; & ;[ACT_Avisos_de_Cobranza:124]Monto_a_Pagar:14#0)
				Else 
					QUERY:C277([ACT_Avisos_de_Cobranza:124];[ACT_Avisos_de_Cobranza:124]ID_Tercero:26=$id;*)
					QUERY:C277([ACT_Avisos_de_Cobranza:124]; & ;[ACT_Avisos_de_Cobranza:124]Monto_a_Pagar:14#0)
				End if 
				If (cb_soloCuotasVencidas=1)
					QUERY SELECTION:C341([ACT_Avisos_de_Cobranza:124];[ACT_Avisos_de_Cobranza:124]Fecha_Vencimiento:5<=Current date:C33(*))
				End if 
				KRL_RelateSelection (->[ACT_Documentos_de_Cargo:174]No_ComprobanteInterno:15;->[ACT_Avisos_de_Cobranza:124]ID_Aviso:1;"")
				KRL_RelateSelection (->[ACT_Cargos:173]ID_Documento_de_Cargo:3;->[ACT_Documentos_de_Cargo:174]ID_Documento:1;"")
				If ($vl_idItemPagar#0)
					QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]Ref_Item:16=$vl_idItemPagar)
				End if 
			Else 
				vbACTpgs_ArregloCargos:=False:C215
			End if 
			LONGINT ARRAY FROM SELECTION:C647([ACT_Cargos:173];al_RecNumsCargos;"")
			
			QUERY:C277([ACT_Pagos:172];[ACT_Pagos:172]ID_Tercero:26=[ACT_Terceros:138]Id:1;*)
			QUERY:C277([ACT_Pagos:172]; & ;[ACT_Pagos:172]Saldo:15>0)
			$pagosconSaldo:=Sum:C1([ACT_Pagos:172]Saldo:15)
			
	End case 
	QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]Saldo:23#0)
	
	  //20151007 JVP para validacion de los cargos de las cuentas
	If ($vt_No_familia#"")
		READ ONLY:C145([ACT_CuentasCorrientes:175])
		READ ONLY:C145([Alumnos:2])
		READ ONLY:C145([Familia:78])
		QUERY:C277([Familia:78];[Familia:78]Codigo_interno:14=$vt_No_familia)
		If (Records in selection:C76([Familia:78])>0)
			QUERY:C277([Alumnos:2];[Alumnos:2]Familia_Número:24=[Familia:78]Numero:1)
			KRL_RelateSelection (->[ACT_CuentasCorrientes:175]ID_Alumno:3;->[Alumnos:2]numero:1;"")
			SELECTION TO ARRAY:C260([ACT_CuentasCorrientes:175]ID:1;$alACT_idcuentas)
		End if 
		QUERY SELECTION WITH ARRAY:C1050([ACT_Cargos:173]ID_CuentaCorriente:2;$alACT_idcuentas)
	End if 
	
	
	vrACTpgs2_deuda:=ACTcar_CalculaMontos ("redondeadoFromRecNumArrayMCobro";->al_RecNumsCargos;->[ACT_Cargos:173]Saldo:23;$vd_fecha)
	
	  //20171107 RCH no considera los posibles saldos del apoderado con el objetivo de cargar la deuda correctamente
	  //$0:=vrACTpgs2_deuda+$pagosconSaldo
	If (($vbACTpgs_ArregloCargos) | ($vl_idItemPagar#0) | ($vl_idAvisoAPagar#0))  // Modificado por: Saúl Ponce (14/11/2017), agregué el "$" en la variable $vbACTpgs_ArregloCargos
		$0:=vrACTpgs2_deuda
	Else 
		$0:=vrACTpgs2_deuda+$pagosconSaldo
	End if 
	
Else 
	$0:=0
End if 