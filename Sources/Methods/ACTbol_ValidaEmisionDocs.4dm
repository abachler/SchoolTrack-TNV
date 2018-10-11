//%attributes = {}
  //ACTbol_ValidaEmisionDocs

C_BOOLEAN:C305($vb_emitir;$0)

$set:=$1
READ ONLY:C145([ACT_Avisos_de_Cobranza:124])
READ ONLY:C145([ACT_Transacciones:178])
READ ONLY:C145([ACT_Cargos:173])
USE SET:C118($set)
KRL_RelateSelection (->[ACT_Transacciones:178]No_Comprobante:10;->[ACT_Avisos_de_Cobranza:124]ID_Aviso:1;"")
KRL_RelateSelection (->[ACT_Cargos:173]ID:1;->[ACT_Transacciones:178]ID_Item:3;"")
  //QUERY SELECTION([ACT_Cargos];[ACT_Cargos]EmitidoSegúnMonedaCargo=True;*)
  //QUERY SELECTION([ACT_Cargos]; & ;[ACT_Cargos]No_Incluir_en_DocTrib=False)

ARRAY LONGINT:C221($alACT_idRazonSocial;0)
AT_DistinctsFieldValues (->[ACT_Cargos:173]ID_RazonSocial:57;->$alACT_idRazonSocial)

QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]EmitidoSegúnMonedaCargo:11=True:C214;*)
QUERY SELECTION:C341([ACT_Cargos:173]; & ;[ACT_Cargos:173]No_Incluir_en_DocTrib:50=False:C215;*)
QUERY SELECTION:C341([ACT_Cargos:173]; & ;[ACT_Cargos:173]Saldo:23#0;*)
QUERY SELECTION:C341([ACT_Cargos:173]; & ;[ACT_Cargos:173]Moneda:28#ST_GetWord (ACT_DivisaPais ;1;";"))

ARRAY TEXT:C222($at_Monedas;0)
If (cbEmitirXMonedas=0)
	AT_DistinctsFieldValues (->[ACT_Cargos:173]Moneda:28;->$at_Monedas)
End if 

Case of 
	: (Size of array:C274($at_Monedas)=0)
		$vb_emitir:=True:C214
	: (Size of array:C274($at_Monedas)=1)
		If ($at_Monedas{1}=ST_GetWord (ACT_DivisaPais ;1;";"))
			$vb_emitir:=True:C214
		End if 
End case 

  //valida emisión de docs para cargos en moneda variable
If ($vb_emitir)
	C_LONGINT:C283($vl_NoRegistros)
	SET QUERY DESTINATION:C396(Into variable:K19:4;$vl_NoRegistros)
	QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]Ref_Item:16=-101)
	SET QUERY DESTINATION:C396(Into current selection:K19:1)
	If ($vl_NoRegistros>0)
		$vb_emitir:=False:C215
	End if 
End if 

  //valida CAF para DTES con proveedor Colegium Chile
If ($vb_emitir)
	
	For ($i;1;Size of array:C274($alACT_idRazonSocial))
		$vl_idRS:=$alACT_idRazonSocial{$i}
		If ($vl_idRS=0)
			$vl_idRS:=-1
		End if 
		$vb_emitir:=(Num:C11(ACTcfgbol_OpcionesDTE ("ValidaInicioEmisionMasiva";->$vl_idRS))=1)
		
	End for 
End if 

  //20150203 RCH valida direcciones
If ($vb_emitir)
	CREATE SET:C116([ACT_Avisos_de_Cobranza:124];"setAC")
	$vb_emitir:=ACTbol_ValidaEmisionDTE ("avisos";"setAC")
	If ($vb_emitir)
		vbACT_validacionDirDTE:=False:C215
	Else 
		vbACT_validacionDirDTE:=True:C214
	End if 
	SET_ClearSets ("setAC")
End if 

$0:=$vb_emitir