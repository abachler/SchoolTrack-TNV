//%attributes = {}
C_TEXT:C284($vt_accion;$1;$vt_retorno;$0)
C_POINTER:C301(${2})
C_POINTER:C301($vy_pointer1;$vy_pointer2)
C_DATE:C307($vdACT_FechaProtesto)
C_TEXT:C284($vtACT_MotivoProtesto)

$vt_accion:=$1
If (Count parameters:C259>=2)
	$vy_pointer1:=$2
End if 
If (Count parameters:C259>=3)
	$vy_pointer2:=$3
End if 

Case of 
	: ($vt_accion="ProtestaDocumento")
		$vdACT_FechaProtesto:=$vy_pointer1->
		$vtACT_MotivoProtesto:=$vy_pointer2->
		If (cs_ImprimirComprobante=1)
			FORM SET OUTPUT:C54([ACT_Documentos_de_Pago:176];"ComprobanteProtesto")
			PRINT SETTINGS:C106
			If (ok=1)
				PRINT RECORD:C71([ACT_Documentos_de_Pago:176];>)
			End if 
		End if 
		ACTcfg_OpcionesRecargos ("GeneraMultaXProtesto")
		KRL_ReloadInReadWriteMode (->[ACT_Documentos_de_Pago:176])
		If (Not:C34(Locked:C147([ACT_Documentos_de_Pago:176])))
			[ACT_Documentos_de_Pago:176]FechaProtesto:15:=$vdACT_FechaProtesto
			[ACT_Documentos_de_Pago:176]MotivoProtesto:38:=$vtACT_MotivoProtesto
			[ACT_Documentos_de_Pago:176]id_estado:53:=Num:C11(ACTcfg_OpcionesEstadosPagos ("ObtieneEstadoProtestado";->[ACT_Documentos_de_Pago:176]id_forma_de_pago:51))
			[ACT_Documentos_de_Pago:176]Estado:14:=ACTcfg_OpcionesEstadosPagos ("ObtieneEstado";->[ACT_Documentos_de_Pago:176]id_forma_de_pago:51;->[ACT_Documentos_de_Pago:176]id_estado:53)
			[ACT_Documentos_de_Pago:176]En_cartera:34:=True:C214
			[ACT_Documentos_de_Pago:176]Depositado:35:=False:C215
			[ACT_Documentos_de_Pago:176]Protestado:36:=True:C214
			[ACT_Documentos_de_Pago:176]Depositado_en_Banco:39:=""
			[ACT_Documentos_de_Pago:176]Depositado_en_Banco_Codigo:40:=""
			[ACT_Documentos_de_Pago:176]Depositado_en_Cuenta:41:=""
			[ACT_Documentos_de_Pago:176]Depositado_Fecha:42:=!00-00-00!
			[ACT_Documentos_de_Pago:176]Depositado_Por:43:=""
			ACTdp_fSave 
			If (Not:C34(vb_RecordInInputForm))
				REMOVE FROM SET:C561([ACT_Documentos_de_Pago:176];"$RecordSet_Table"+String:C10(Table:C252(->[ACT_Documentos_de_Pago:176])))
			End if 
			ACTdc_CreaDocCarteraProt 
			
		Else 
			BM_CreateRequest ("ACT_ProtestaCheques";String:C10(vdACT_FechaProtesto)+";"+String:C10([ACT_Documentos_de_Pago:176]ID:1)+";"+vtACT_MotivoProtesto)
		End if 
		REDUCE SELECTION:C351([ACT_Documentos_de_Pago:176];0)
		
	: ($vt_accion="CargaNuevoDocumento")
		i_Doc:=i_Doc+1
		If (i_Doc=Size of array:C274(alACT_RecNumsDocs))
			OBJECT SET VISIBLE:C603(*;"@next@";False:C215)
			OBJECT SET VISIBLE:C603(*;"@Ingresar@";True:C214)
		End if 
		ACTdc_DocumentoNoBloq ("ProtestarLiberaRegistros")
		
		If (i_Doc<=Size of array:C274(alACT_RecNumsDocs))
			ACTdd_CargaDatosDDepositados 
		End if 
		
		Case of 
			: (vl_tipoDocumento=-8)
				vMotivos:=LOC_LoadList2Text ("ACT_MotivosProtestoLC")
			Else 
				vMotivos:=LOC_LoadList2Text ("ACT_MotivosProtesto")
		End case 
		GOTO OBJECT:C206(vdACT_FechaProrroga)
		
	: ($vt_accion="ValidaAplicarMotivoATodos")
		C_LONGINT:C283($vl_recNumDocPago;$i)
		ARRAY LONGINT:C221($alACT_RecNumsDocs;0)
		ARRAY LONGINT:C221($alACT_idFormaPago;0)
		$vl_recNumDocPago:=Record number:C243([ACT_Documentos_de_Pago:176])
		For ($i;i_Doc;Size of array:C274(alACT_RecNumsDocs))
			APPEND TO ARRAY:C911($alACT_RecNumsDocs;alACT_RecNumsDocs{$i})
		End for 
		CREATE SELECTION FROM ARRAY:C640([ACT_Documentos_de_Pago:176];$alACT_RecNumsDocs;"")
		DISTINCT VALUES:C339([ACT_Documentos_de_Pago:176]id_forma_de_pago:51;$alACT_idFormaPago)
		If (Size of array:C274($alACT_idFormaPago)>1)
			BEEP:C151
			$vt_retorno:="0"
			CD_Dlog (0;"Hay distintos tipos de documento dentro de la selección de registros de Documentos en Cartera. Para utilizar esta opción seleccione registros con el mismo tipo de documento.")
		Else 
			$vt_retorno:="1"
		End if 
		REDUCE SELECTION:C351([ACT_Documentos_de_Pago:176];0)
		KRL_GotoRecord (->[ACT_Documentos_de_Pago:176];$vl_recNumDocPago)
		
	: ($vt_accion="CargaArregloEstadosXFdP")
		If (vlACT_idFormaDePagoOrg#vlACT_idFormaDePago)
			C_LONGINT:C283($vlACT_idFormaDePago;$vlACT_idEstadoFormaDePago;$vlACT_idEstadoXDef;$vl_linea)
			$vlACT_idFormaDePago:=$vy_pointer1->
			$vlACT_idEstadoFormaDePago:=$vy_pointer2->
			
			ARRAY TEXT:C222(atACT_estadosReemp;0)
			ARRAY LONGINT:C221(alACT_estadosIDReemp;0)
			atACT_estadosReemp:=0
			ACTcfg_OpcionesEstadosPagos ("CargaArreglos";->$vlACT_idFormaDePago)
			COPY ARRAY:C226(atACT_estados;atACT_estadosReemp)
			COPY ARRAY:C226(alACT_estadosID;alACT_estadosIDReemp)
			
			$vlACT_idEstadoXDef:=Num:C11(ACTcfg_OpcionesEstadosPagos ("ObtieneIDEstadoXDefReemplazo";->$vlACT_idFormaDePago;->$vlACT_idEstadoFormaDePago))
			  //elimino estados sistema, excepto el nulo que se asignaba por defecto
			For ($i;Size of array:C274(alACT_estadosIDReemp);1;-1)
				If ((alACT_estadosIDReemp{$i}<0) & (alACT_estadosIDReemp{$i}#$vlACT_idEstadoXDef))
					AT_Delete ($i;1;->alACT_estadosIDReemp;->atACT_estadosReemp)
				End if 
			End for 
			$vl_linea:=Find in array:C230(alACT_estadosIDReemp;$vlACT_idEstadoXDef)
			If ($vl_linea#-1)
				atACT_estadosReemp:=$vl_linea
			End if 
			vlACT_idFormaDePagoOrg:=vlACT_idFormaDePago
		End if 
		
End case 
$0:=$vt_retorno
