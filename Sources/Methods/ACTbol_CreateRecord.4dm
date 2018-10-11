//%attributes = {}
  //ACTbol_CreateRecord

C_DATE:C307($vd_fechaEmision)
C_BOOLEAN:C305($vb_esBoletaAfecta;$vb_crearBol;$asignarNumero)
C_REAL:C285($vr_montoTotal;$vr_montoTotal;$vr_montoIVA;$montoAfecto)
C_LONGINT:C283($vl_idCategoria;$vl_idDocumento;$vl_idApdo;$vl_indexDcto;$vl_idBoleta;$vl_idTercero)
C_TEXT:C284($vt_tipoDcto;$setBol)
C_TEXT:C284($vt_observacion)
C_BOOLEAN:C305($vb_dctoDuplicado)
C_LONGINT:C283($0)
C_LONGINT:C283($vl_idRazonSocial)
C_LONGINT:C283($vl_razonReferencia)
  //C_BOOLEAN(vb_DocEmitidoFromPagos)
C_BOOLEAN:C305($b_publicoGeneral)
C_LONGINT:C283($l_idApdoResponsable;$l_idAp;$l_idApdoR;$l_idTerceroR)
C_REAL:C285($r_idCategoria)
C_TEXT:C284($t_moneda)

$noTransacciones:=$1
$vr_montoTotal:=$2
$vd_fechaEmision:=$3
$vb_esBoletaAfecta:=$4
$vl_idCategoria:=$5
$vl_idDocumento:=$6
$vt_tipoDcto:=$7
$vl_idApdo:=$8
$vl_indexDcto:=$9
$setBol:=$10
If (Count parameters:C259>=11)
	$asignarNumero:=$11
Else 
	$asignarNumero:=True:C214
End if 

If ((Not:C34($vb_esBoletaAfecta)) & (Count parameters:C259>=12))
	$montoAfecto:=$12
Else 
	If ($12#0)
		$montoAfecto:=$12
	Else 
		$montoAfecto:=0
	End if 
End if 

If (Count parameters:C259>=12)  //20130729 RCH Se agrego para manejar las NC...
	If ($12#0)
		$montoAfecto:=$12
	End if 
End if 

If (Count parameters:C259>=13)
	$vl_idTercero:=$13
End if 
If (Count parameters:C259>=14)
	$vt_observacion:=$14
End if 
  //20120907 RCH se asigna la razon social desde la creacion del registro. Es posible que no haya una definicion para el documento tributario de una razon social secundaria y se utilice la definicion por defecto. El metodo anterior podia asignar id por defecto para una boleta emitida para una razon social secundaria
If (Count parameters:C259>=15)
	$vl_idRazonSocial:=$15
End if 
If (Count parameters:C259>=16)
	$vl_emitidoDesde:=$16
End if 
If (Count parameters:C259>=17)
	$vl_razonReferencia:=$17
End if 
If (Count parameters:C259>=18)
	$b_publicoGeneral:=$18
End if 
If (Count parameters:C259>=19)
	$r_idCategoria:=$19
End if 
If (Count parameters:C259>=20)
	$t_moneda:=$20
End if 
If (Count parameters:C259>=21)
	$l_idApdoResponsable:=$21
End if 

If ((cb_GenerarBoletaCero=1) | ($vl_idCategoria=-4))
	$vb_crearBol:=($vr_montoTotal>=0)
Else 
	$vb_crearBol:=($vr_montoTotal>0)
End if 

If ((($vb_crearBol) & ($noTransacciones>0)) | (($noTransacciones=0) & ($vl_idCategoria=-4)))
	READ WRITE:C146([ACT_Boletas:181])
	CREATE RECORD:C68([ACT_Boletas:181])
	[ACT_Boletas:181]ID:1:=SQ_SeqNumber (->[ACT_Boletas:181]ID:1)
	[ACT_Boletas:181]EmitidoPor:17:=<>tUSR_CurrentUser
	[ACT_Boletas:181]FechaEmision:3:=$vd_fechaEmision
	[ACT_Boletas:181]AfectaIVA:9:=$vb_esBoletaAfecta
	[ACT_Boletas:181]Monto_Total:6:=$vr_montoTotal
	[ACT_Boletas:181]Monto_Exento:30:=Round:C94([ACT_Boletas:181]Monto_Total:6-$montoAfecto;<>vlACT_Decimales)
	If ($montoAfecto#0)
		[ACT_Boletas:181]Monto_Afecto:4:=Round:C94($montoAfecto/<>vrACT_FactorIVA;<>vlACT_Decimales)
		[ACT_Boletas:181]Monto_IVA:5:=$montoAfecto-[ACT_Boletas:181]Monto_Afecto:4
		[ACT_Boletas:181]TasaIVA:16:=<>vrACT_TasaIVA
	Else 
		[ACT_Boletas:181]Monto_Afecto:4:=0
		[ACT_Boletas:181]Monto_IVA:5:=0
		[ACT_Boletas:181]TasaIVA:16:=0
	End if 
	[ACT_Boletas:181]ID_Categoria:12:=$vl_idCategoria
	[ACT_Boletas:181]ID_Documento:13:=$vl_idDocumento
	[ACT_Boletas:181]TipoDocumento:7:=$vt_tipoDcto
	[ACT_Boletas:181]ID_Apoderado:14:=$vl_idApdo
	[ACT_Boletas:181]ID_Tercero:21:=$vl_idTercero
	[ACT_Boletas:181]Observacion:18:=$vt_observacion
	
	  //20150317 RCH
	If ($b_publicoGeneral)
		
	Else 
		
		  //If ($l_idApdoResponsable=0)
		If (($l_idApdoResponsable=0) | (($l_idApdoResponsable<0) & ([ACT_Boletas:181]ID_Apoderado:14#0)))  //20170802 RCH
			$l_idAp:=[ACT_Boletas:181]ID_Apoderado:14
		Else 
			$l_idAp:=$l_idApdoResponsable  //Si tenemos apoderado responsable se busca sobre ese campo
		End if 
		If ([ACT_Boletas:181]ID_Apoderado:14#0)
			  //$l_idApdoR:=KRL_GetNumericFieldData (->[Personas]No;->[ACT_Boletas]ID_Apoderado;->[Personas]ACT_ReceptorDT_id_Apdo)
			  //$l_idTerceroR:=KRL_GetNumericFieldData (->[Personas]No;->[ACT_Boletas]ID_Apoderado;->[Personas]ACT_ReceptorDT_id_Ter)
			$l_idApdoR:=KRL_GetNumericFieldData (->[Personas:7]No:1;->$l_idAp;->[Personas:7]ACT_ReceptorDT_id_Apdo:113)
			$l_idTerceroR:=KRL_GetNumericFieldData (->[Personas:7]No:1;->$l_idAp;->[Personas:7]ACT_ReceptorDT_id_Ter:114)
		Else 
			$l_idApdoR:=KRL_GetNumericFieldData (->[ACT_Terceros:138]Id:1;->[ACT_Boletas:181]ID_Tercero:21;->[ACT_Terceros:138]ReceptorDT_id_apoderado:78)
			$l_idTerceroR:=KRL_GetNumericFieldData (->[ACT_Terceros:138]Id:1;->[ACT_Boletas:181]ID_Tercero:21;->[ACT_Terceros:138]ReceptorDT_id_tercero:77)
		End if 
		
		If (($l_idApdoR=0) & ($l_idTerceroR=0) & ($l_idApdoResponsable>0) & ([ACT_Boletas:181]ID_Apoderado:14#$l_idApdoResponsable))  //Si tenemos apoderado responsable se busca sobre ese campo, se verifica si hay receptor. Si no hay definido, se usa el que viene
			$l_idApdoR:=$l_idApdoResponsable
		End if 
		
	End if 
	[ACT_Boletas:181]Es_Publico_General:46:=$b_publicoGeneral
	Case of 
		: ($b_publicoGeneral)
			[ACT_Boletas:181]Receptor_Id_Apdo_org:44:=0
			[ACT_Boletas:181]Receptor_Id_Tercero_org:45:=0
			[ACT_Boletas:181]ID_Apoderado:14:=0
			[ACT_Boletas:181]ID_Tercero:21:=KRL_GetNumericFieldData (->[ACT_Terceros:138]Es_publico_general:79;->$b_publicoGeneral;->[ACT_Terceros:138]Id:1)
		: ($l_idApdoR#0)
			[ACT_Boletas:181]Receptor_Id_Apdo_org:44:=[ACT_Boletas:181]ID_Apoderado:14
			[ACT_Boletas:181]Receptor_Id_Tercero_org:45:=[ACT_Boletas:181]ID_Tercero:21
			[ACT_Boletas:181]ID_Apoderado:14:=$l_idApdoR
			[ACT_Boletas:181]ID_Tercero:21:=0
		: ($l_idTerceroR#0)
			[ACT_Boletas:181]Receptor_Id_Apdo_org:44:=[ACT_Boletas:181]ID_Apoderado:14
			[ACT_Boletas:181]Receptor_Id_Tercero_org:45:=[ACT_Boletas:181]ID_Tercero:21
			[ACT_Boletas:181]ID_Apoderado:14:=0
			[ACT_Boletas:181]ID_Tercero:21:=$l_idTerceroR
	End case 
	
	If ($vl_idRazonSocial=0)
		$vl_idRS:=alACT_RazonSocial{$vl_indexDcto}
		If ($vl_idRS=0)
			$vl_idRS:=-1
		End if 
	Else 
		$vl_idRS:=$vl_idRazonSocial
	End if 
	[ACT_Boletas:181]ID_RazonSocial:25:=$vl_idRS
	
	[ACT_Boletas:181]CL_acteco:28:=KRL_GetTextFieldData (->[ACT_RazonesSociales:279]id:1;->[ACT_Boletas:181]ID_RazonSocial:25;->[ACT_RazonesSociales:279]codigo_actividad_economica:6)
	[ACT_Boletas:181]Emitido_desde:27:=$vl_emitidoDesde
	[ACT_Boletas:181]codigo_referencia:31:=$vl_razonReferencia
	
	If (aiACT_Tipo{$vl_indexDcto}=2)
		[ACT_Boletas:181]documento_electronico:29:=True:C214
	Else 
		[ACT_Boletas:181]documento_electronico:29:=False:C215
	End if 
	
	If ([ACT_Boletas:181]documento_electronico:29)
		If ((at_proveedores{at_proveedores}="Colegium") & (cs_emitirCFDI=1))
			[ACT_Boletas:181]DTE_estado_id:24:=[ACT_Boletas:181]DTE_estado_id:24 ?+ 0
		End if 
	End if 
	
	If (<>gCountryCode="ar")  //20150713 RCH.
		[ACT_Boletas:181]AR_CodigoPtoVenta:47:=vrACT_PuntoDeVenta
	End if 
	
	[ACT_Boletas:181]ID_CategoriaItems:52:=Choose:C955($r_idCategoria=MAXLONG:K35:2;0;$r_idCategoria)
	
	[ACT_Boletas:181]Moneda:53:=Choose:C955($t_moneda="";<>vtACT_monedaPais;$t_moneda)
	
	[ACT_Boletas:181]FechaVencimiento:54:=Add to date:C393([ACT_Boletas:181]FechaEmision:3;0;0;lACTbol_DiaVencimientoSel)
	
	ACTbol_AsignaCodigoSII 
	
	If ($asignarNumero)
		$vb_dctoDuplicado:=(ACTbol_Numbering ($vl_indexDcto;"current";False:C215;False:C215)=-2)
		If (($l_idApdoR#0) | ($l_idTerceroR#0))
			LOG_RegisterEvt ("Documento Tributario id: "+String:C10([ACT_Boletas:181]ID:1)+", folio: "+String:C10([ACT_Boletas:181]Numero:11)+" emitido para "+Choose:C955([ACT_Boletas:181]ID_Apoderado:14#0;"apoderado";"tercero")+" id: "+Choose:C955([ACT_Boletas:181]ID_Apoderado:14#0;String:C10([ACT_Boletas:181]ID_Apoderado:14);String:C10([ACT_Boletas:181]ID_Tercero:21))+Choose:C955([ACT_Boletas:181]Receptor_Id_Apdo_org:44#0;". ID apoderado original: ";". ID tercero original:")+Choose:C955([ACT_Boletas:181]Receptor_Id_Apdo_org:44#0;String:C10([ACT_Boletas:181]Receptor_Id_Apdo_org:44);String:C10([ACT_Boletas:181]Receptor_Id_Tercero_org:45))+".")
		End if 
	Else 
		If (($l_idApdoR#0) | ($l_idTerceroR#0))
			LOG_RegisterEvt ("Documento Tributario id: "+String:C10([ACT_Boletas:181]ID:1)+" emitido para "+Choose:C955([ACT_Boletas:181]ID_Apoderado:14#0;"apoderado";"tercero")+" id: "+Choose:C955([ACT_Boletas:181]ID_Apoderado:14#0;String:C10([ACT_Boletas:181]ID_Apoderado:14);String:C10([ACT_Boletas:181]ID_Tercero:21))+Choose:C955([ACT_Boletas:181]Receptor_Id_Apdo_org:44#0;". Apoderado original: ";". Tercero original:")+Choose:C955([ACT_Boletas:181]Receptor_Id_Apdo_org:44#0;String:C10([ACT_Boletas:181]Receptor_Id_Apdo_org:44);String:C10([ACT_Boletas:181]Receptor_Id_Tercero_org:45))+".")
		End if 
	End if 
	If (Not:C34($vb_dctoDuplicado))
		$vl_idBoleta:=[ACT_Boletas:181]ID:1
		SAVE RECORD:C53([ACT_Boletas:181])
		ADD TO SET:C119([ACT_Boletas:181];$setBol)
	End if 
	KRL_UnloadReadOnly (->[ACT_Boletas:181])
	
	If ($vl_idBoleta=0)
		If ($vb_dctoDuplicado)
			$0:=-2
		Else 
			$0:=-1
		End if 
	Else 
		$0:=$vl_idBoleta
	End if 
End if 