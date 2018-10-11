//%attributes = {}
C_TEXT:C284($vt_accion;$1;$0;$vt_retorno)
C_POINTER:C301($ptr1;$ptr2;$ptr3)
C_POINTER:C301(${2})
C_LONGINT:C283($vl_idFormaDePago;$vl_idEstado;$vl_records;$vl_numFormasDePago;$vl_inicio)
C_BOOLEAN:C305($vb_nulo)

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
	: ($vt_accion="ColorFormasDePagoXDefecto")
		ARRAY INTEGER:C220($aInt2D;2;0)
		For ($i;1;Size of array:C274(alACT_estadosID))
			If (alACT_estadosID{$i}<0)
				$vl_numFormasDePago:=$vl_numFormasDePago+1
			End if 
		End for 
		If ($vl_numFormasDePago>0)
			$vl_inicio:=1
		End if 
		AL_SetCellEnter (xALP_EstadosFDP;1;$vl_inicio;1;$vl_numFormasDePago;$aInt2D;0)
		AL_SetCellColor (xALP_EstadosFDP;1;$vl_inicio;1;$vl_numFormasDePago;$aInt2D;"Red";0;"";0)
		
	: ($vt_accion="DeclaraArreglos")
		ARRAY LONGINT:C221(alACT_estadosID;0)
		ARRAY LONGINT:C221(alACT_estadosIDFDP;0)
		ARRAY TEXT:C222(atACT_estados;0)
		ARRAY TEXT:C222(atACT_estadosCI;0)
		ARRAY TEXT:C222(atACT_estadosCta;0)
		ARRAY TEXT:C222(atACT_estadosCtaCA;0)
		ARRAY TEXT:C222(atACT_estadosCentro;0)
		ARRAY TEXT:C222(atACT_estadosCCta;0)
		ARRAY TEXT:C222(atACT_estadosCCtaCA;0)
		ARRAY TEXT:C222(atACT_estadosCCentro;0)
		ARRAY LONGINT:C221(alACT_estadosIDCta;0)
		ARRAY LONGINT:C221(alACT_estadosIDCentro;0)
		ARRAY LONGINT:C221(alACT_estadosIDCCta;0)
		ARRAY LONGINT:C221(alACT_estadosIDCCentro;0)
		ARRAY BOOLEAN:C223(abACT_generaMovimientoCont;0)
		
		  //setea estado por defecto
		ARRAY TEXT:C222(atACT_estados2;0)
		
	: ($vt_accion="EliminaElementoArreglo")
		AT_Delete ($ptr1->;1;->alACT_estadosID;->alACT_estadosIDFDP;->atACT_estados;->atACT_estadosCI;\
			->atACT_estadosCta;->atACT_estadosCtaCA;->atACT_estadosCentro;->atACT_estadosCCta;->atACT_estadosCCtaCA;\
			->atACT_estadosCCentro;->alACT_estadosIDCta;->alACT_estadosIDCentro;->alACT_estadosIDCCta;\
			->alACT_estadosIDCCentro;->abACT_generaMovimientoCont)
		
	: ($vt_accion="InsertaNuevoEstado")
		$vl_idFormaDePago:=$ptr1->
		If ($vl_idFormaDePago#0)
			$vt_glosaOrg:=__ ("Nuevo estado")
			$vl_contador:=1
			$vl_existe:=1
			While ($vl_existe#-1)
				$vt_glosa:=$vt_glosaOrg+" "+String:C10($vl_contador)
				$vl_contador:=$vl_contador+1
				$vl_existe:=Find in field:C653([ACT_EstadosFormasdePago:201]Estado:3;$vt_glosa)
			End while 
			ACTcfg_OpcionesEstadosPagos ("CreateRecord";->$vt_glosa;->$vl_idFormaDePago;->$vb_nulo)
			ACTcfg_OpcionesEstadosPagos ("CargaArreglos";->$vl_idFormaDePago)
		Else 
			BEEP:C151
		End if 
		
	: ($vt_accion="ObtieneEstadoNulo")
		$vl_idFormaDePago:=$ptr1->
		READ ONLY:C145([ACT_EstadosFormasdePago:201])
		QUERY:C277([ACT_EstadosFormasdePago:201];[ACT_EstadosFormasdePago:201]id_forma_pago:2=$vl_idFormaDePago;*)
		QUERY:C277([ACT_EstadosFormasdePago:201]; & ;[ACT_EstadosFormasdePago:201]anula_pago:10=True:C214)
		If (Records in selection:C76([ACT_EstadosFormasdePago:201])=1)
			$vt_retorno:=String:C10([ACT_EstadosFormasdePago:201]id:1)
		Else 
			$vt_retorno:="0"
		End if 
		
	: ($vt_accion="CreateRecord")
		$vt_glosa:=$ptr1->
		$vl_idFormaDePago:=$ptr2->
		$vb_nulo:=$ptr3->
		
		CREATE RECORD:C68([ACT_EstadosFormasdePago:201])
		$vl_idEstado:=SQ_SeqNumber (->[ACT_EstadosFormasdePago:201]id:1)
		[ACT_EstadosFormasdePago:201]id:1:=$vl_idEstado
		[ACT_EstadosFormasdePago:201]Estado:3:=$vt_glosa
		[ACT_EstadosFormasdePago:201]id_forma_pago:2:=$vl_idFormaDePago
		[ACT_EstadosFormasdePago:201]anula_pago:10:=$vb_nulo
		  // asigno id negativo desde el -1000 a los estados por defecto "nulo" que se crean cada vez que se crea una nueva forma de pago
		If (([ACT_EstadosFormasdePago:201]anula_pago:10) & ($vl_idEstado>0))
			While ($vl_idEstado>-1000)
				$vl_idEstado:=SQ_SeqNumber (->[ACT_EstadosFormasdePago:201]id:1;True:C214)
			End while 
			[ACT_EstadosFormasdePago:201]id:1:=$vl_idEstado
		End if 
		KRL_SaveUnLoadReadOnly (->[ACT_EstadosFormasdePago:201])
		If ($vl_idFormaDePago=-16)  // llena lista pagares
			KRL_ExecuteEverywhere ("ACTpagares_CargaArregloEstados")
		End if 
		$vt_retorno:=String:C10($vl_idEstado)
		
	: ($vt_accion="ObtieneEstado")
		$vl_idFormaDePago:=$ptr1->
		$vl_idEstado:=$ptr2->
		If ($vl_idEstado=0)
			$vt_retorno:=KRL_GetTextFieldData (->[ACT_Formas_de_Pago:287]id:1;->$vl_idFormaDePago;->[ACT_Formas_de_Pago:287]estado:13)
		Else 
			$vt_retorno:=KRL_GetTextFieldData (->[ACT_EstadosFormasdePago:201]id:1;->$vl_idEstado;->[ACT_EstadosFormasdePago:201]Estado:3)
		End if 
		
	: ($vt_accion="CargaArreglos")
		ACTcfg_OpcionesEstadosPagos ("DeclaraArreglos")
		
		ARRAY LONGINT:C221($alACT_ids;0)
		ARRAY LONGINT:C221($alACT_recNums;0)
		ARRAY LONGINT:C221($alACT_recNums2;0)
		ARRAY LONGINT:C221($alACT_DAReturn;0)
		
		READ ONLY:C145([ACT_EstadosFormasdePago:201])
		
		$vl_idFormaDePago:=$ptr1->
		
		QUERY:C277([ACT_EstadosFormasdePago:201];[ACT_EstadosFormasdePago:201]id_forma_pago:2=$vl_idFormaDePago)
		SELECTION TO ARRAY:C260([ACT_EstadosFormasdePago:201];$alACT_recNums;[ACT_EstadosFormasdePago:201]id:1;alACT_estadosID;[ACT_EstadosFormasdePago:201]Estado:3;atACT_estados;\
			[ACT_EstadosFormasdePago:201]Codigo_interno:4;atACT_estadosCI;[ACT_EstadosFormasdePago:201]id_forma_pago:2;alACT_estadosIDFDP;\
			[ACT_EstadosFormasdePago:201]id_cuenta_contable:5;alACT_estadosIDCta;[ACT_EstadosFormasdePago:201]id_centro_costo:6;alACT_estadosIDCentro;\
			[ACT_EstadosFormasdePago:201]id_cuenta_contable_contra:7;alACT_estadosIDCCta;[ACT_EstadosFormasdePago:201]id_centro_costo_contra:8;alACT_estadosIDCCentro;\
			[ACT_EstadosFormasdePago:201]genera_movimiento_contable:9;abACT_generaMovimientoCont)
		
		  // para ordenar las formas de pago...
		
		alACT_estadosID{0}:=0
		AT_SearchArray (->alACT_estadosID;"<";->$alACT_DAReturn)
		For ($i;1;Size of array:C274($alACT_DAReturn))
			APPEND TO ARRAY:C911($alACT_ids;Abs:C99(alACT_estadosID{$alACT_DAReturn{$i}}))
			APPEND TO ARRAY:C911($alACT_recNums2;$alACT_recNums{$alACT_DAReturn{$i}})
		End for 
		SORT ARRAY:C229($alACT_ids;$alACT_recNums2;>)
		AT_OrderArraysByArray (MAXLONG:K35:2;->$alACT_recNums2;->$alACT_recNums;->alACT_estadosID;->atACT_estados;->atACT_estadosCI;->alACT_estadosIDFDP;->alACT_estadosIDCta;->alACT_estadosIDCentro;->alACT_estadosIDCCta;->alACT_estadosIDCCentro;->abACT_generaMovimientoCont)
		
		ACTcfg_LoadConfigData (10)
		
		For ($i;1;Size of array:C274(alACT_estadosIDCta))
			AT_Insert ($i;1;->atACT_estadosCta;->atACT_estadosCtaCA;->atACT_estadosCentro;->atACT_estadosCCta;->atACT_estadosCCtaCA;->atACT_estadosCCentro)
			
			  // plan de cuenta
			$vl_existe:=Find in array:C230(<>alACT_idCta;alACT_estadosIDCta{$i})
			If ($vl_existe>0)
				atACT_estadosCta{$i}:=<>asACT_CuentaCta{$vl_existe}
				atACT_estadosCtaCA{$i}:=<>asACT_CodAuxCta{$vl_existe}
			End if 
			  // centro de costo
			$vl_existe:=Find in array:C230(<>alACT_idCentro;alACT_estadosIDCentro{$i})
			If ($vl_existe>0)
				atACT_estadosCentro{$i}:=<>asACT_Centro{$vl_existe}
			End if 
			  // plan cuenta contra
			$vl_existe:=Find in array:C230(<>alACT_idCta;alACT_estadosIDCCta{$i})
			If ($vl_existe>0)
				atACT_estadosCCta{$i}:=<>asACT_CuentaCta{$vl_existe}
				atACT_estadosCCtaCA{$i}:=<>asACT_CodAuxCta{$vl_existe}
			End if 
			  // centro costo contra
			$vl_existe:=Find in array:C230(<>alACT_idCentro;alACT_estadosIDCCentro{$i})
			If ($vl_existe>0)
				atACT_estadosCCentro{$i}:=<>asACT_Centro{$vl_existe}
			End if 
		End for 
		
	: ($vt_accion="VerificaUtilizacionEstado")
		$vl_idEstado:=$ptr1->
		
		If ($vl_idEstado#0)
			SET QUERY DESTINATION:C396(Into variable:K19:4;$vl_records)
			QUERY:C277([ACT_Documentos_de_Pago:176];[ACT_Documentos_de_Pago:176]id_estado:53=$vl_idEstado)
			If ($vl_records=0)
				QUERY:C277([ACT_Documentos_en_Cartera:182];[ACT_Documentos_en_Cartera:182]id_estado:21=$vl_idEstado)
			End if 
			SET QUERY DESTINATION:C396(Into current selection:K19:1)
			$vt_retorno:=String:C10($vl_records)
			
		End if 
		
	: ($vt_accion="EliminaFormaDePagoConf")
		$vl_idEstado:=$ptr1->
		If ($ptr1->>0)
			If (Num:C11(ACTcfg_OpcionesEstadosPagos ("VerificaUtilizacionEstado";$ptr1))=0)
				READ WRITE:C146([ACT_EstadosFormasdePago:201])
				QUERY:C277([ACT_EstadosFormasdePago:201];[ACT_EstadosFormasdePago:201]id:1=$ptr1->)
				$vl_idFormaDePago:=[ACT_EstadosFormasdePago:201]id_forma_pago:2
				DELETE RECORD:C58([ACT_EstadosFormasdePago:201])
				KRL_UnloadReadOnly (->[ACT_EstadosFormasdePago:201])
				ACTcfg_OpcionesEstadosPagos ("CargaArreglos";->$vl_idFormaDePago)
			Else 
				BEEP:C151
			End if 
		End if 
		
	: ($vt_accion="GuardaArreglos")
		For ($i;Size of array:C274(atACT_estados);1;-1)
			If (atACT_estados{$i}="")
				ACTcfg_OpcionesEstadosPagos ("EliminaElementoArreglo")
			End if 
		End for 
		
		For ($i;1;Size of array:C274(alACT_estadosID))
			READ WRITE:C146([ACT_EstadosFormasdePago:201])
			QUERY:C277([ACT_EstadosFormasdePago:201];[ACT_EstadosFormasdePago:201]id:1=alACT_estadosID{$i})
			[ACT_EstadosFormasdePago:201]Estado:3:=atACT_estados{$i}
			[ACT_EstadosFormasdePago:201]Codigo_interno:4:=atACT_estadosCI{$i}
			[ACT_EstadosFormasdePago:201]id_cuenta_contable:5:=alACT_estadosIDCta{$i}
			[ACT_EstadosFormasdePago:201]id_centro_costo:6:=alACT_estadosIDCentro{$i}
			[ACT_EstadosFormasdePago:201]id_cuenta_contable_contra:7:=alACT_estadosIDCCta{$i}
			[ACT_EstadosFormasdePago:201]id_centro_costo_contra:8:=alACT_estadosIDCCentro{$i}
			[ACT_EstadosFormasdePago:201]genera_movimiento_contable:9:=abACT_generaMovimientoCont{$i}
			SAVE RECORD:C53([ACT_EstadosFormasdePago:201])
			KRL_UnloadReadOnly (->[ACT_EstadosFormasdePago:201])
		End for 
		ACTcfg_OpcionesEstadosPagos ("DeclaraArreglos")
		
	: ($vt_accion="ObtieneIDEstadoPagoXDef")
		$vl_idFormaDePago:=$ptr1->
		$vt_retorno:=String:C10(KRL_GetNumericFieldData (->[ACT_Formas_de_Pago:287]id:1;->$vl_idFormaDePago;->[ACT_Formas_de_Pago:287]id_estado_por_defecto:14))
		
	: ($vt_accion="ObtieneIDEstadosPagoXIDFormaPago")
		ARRAY LONGINT:C221($DA_Return;0)
		$vl_idFormaDePago:=$ptr1->
		If ($vl_idFormaDePago#0)
			ACTcfg_OpcionesEstadosPagos ("CargaArreglos";->$vl_idFormaDePago)
			alACT_estadosIDFDP{0}:=$vl_idFormaDePago
			AT_SearchArray (->alACT_estadosIDFDP;"=";->$DA_Return)
			For ($i;1;Size of array:C274($DA_Return))
				APPEND TO ARRAY:C911($ptr2;alACT_estadosID{$DA_Return{$i}})
			End for 
			
		End if 
		
	: ($vt_accion="EstadoXDefecto")
		ARRAY TEXT:C222(atACT_estados2;0)
		If (vbACT_mostrarEstadoXDef)
			COPY ARRAY:C226(atACT_estados;atACT_estados2)
			$vl_linea:=Find in array:C230(alACT_estadosID;KRL_GetNumericFieldData (->[ACT_Formas_de_Pago:287]id:1;->vlACT_idFormaDePago;->[ACT_Formas_de_Pago:287]id_estado_por_defecto:14))
			If ($vl_linea#-1)
				atACT_estados2:=$vl_linea
			End if 
		End if 
		OBJECT SET VISIBLE:C603(*;"estados@";vbACT_mostrarEstadoXDef)
		
	: ($vt_accion="ObtieneEstadoProtestado")
		$vl_idFormaDePago:=$ptr1->
		If ($vl_idFormaDePago#0)
			Case of 
				: ($vl_idFormaDePago=-4)
					$vt_retorno:="-2"
				: ($vl_idFormaDePago=-8)
					$vt_retorno:="-51"
			End case 
		Else 
			$vt_retorno:="0"
		End if 
		
	: ($vt_accion="ObtieneEstadoDepositado")
		$vl_idFormaDePago:=$ptr1->
		If ($vl_idFormaDePago#0)
			Case of 
				: ($vl_idFormaDePago=-4)
					$vt_retorno:="-11"
				: ($vl_idFormaDePago=-8)
					$vt_retorno:="-58"
			End case 
		Else 
			$vt_retorno:="0"
		End if 
		
	: ($vt_accion="ObtieneEstadoReemplazado")
		$vl_idFormaDePago:=$ptr1->
		If ($vl_idFormaDePago#0)
			Case of 
				: ($vl_idFormaDePago=-4)
					$vt_retorno:="-6"
				: ($vl_idFormaDePago=-8)
					$vt_retorno:="-53"
			End case 
		Else 
			$vt_retorno:="0"
		End if 
		
	: ($vt_accion="ObtieneEstadoProtestadoYReemp")
		$vl_idFormaDePago:=$ptr1->
		If ($vl_idFormaDePago#0)
			Case of 
				: ($vl_idFormaDePago=-4)
					$vt_retorno:="-7"
				: ($vl_idFormaDePago=-8)
					$vt_retorno:="-54"
			End case 
		Else 
			$vt_retorno:="0"
		End if 
		
	: ($vt_accion="ObtieneEstadoNuloYProtestado")
		$vl_idFormaDePago:=$ptr1->
		If ($vl_idFormaDePago#0)
			Case of 
				: ($vl_idFormaDePago=-4)
					$vt_retorno:="-8"
				: ($vl_idFormaDePago=-8)
					$vt_retorno:="-55"
			End case 
		Else 
			$vt_retorno:="0"
		End if 
		
	: ($vt_accion="ObtieneEstadoNuloYReemp")
		$vl_idFormaDePago:=$ptr1->
		If ($vl_idFormaDePago#0)
			Case of 
				: ($vl_idFormaDePago=-4)
					$vt_retorno:="-9"
				: ($vl_idFormaDePago=-8)
					$vt_retorno:="-56"
			End case 
		Else 
			$vt_retorno:="0"
		End if 
		
	: ($vt_accion="ObtieneEstadoNuloProtYReemp")
		$vl_idFormaDePago:=$ptr1->
		If ($vl_idFormaDePago#0)
			Case of 
				: ($vl_idFormaDePago=-4)
					$vt_retorno:="-10"
				: ($vl_idFormaDePago=-8)
					$vt_retorno:="-57"
			End case 
		Else 
			$vt_retorno:="0"
		End if 
		
	: ($vt_accion="GuardaIDContabilidad")
		$vl_idEstado:=$ptr1->
		
		KRL_FindAndLoadRecordByIndex (->[ACT_EstadosFormasdePago:201]id:1;->$vl_idEstado;True:C214)
		If (ok=1)
			$ptr2->:=$ptr3->
			SAVE RECORD:C53([ACT_EstadosFormasdePago:201])
			$vt_retorno:="1"
		Else 
			BEEP:C151
			$vt_retorno:="0"
		End if 
		KRL_UnloadReadOnly (->[ACT_EstadosFormasdePago:201])
		
	: ($vt_accion="ObtieneIDEstadoXDefReemplazo")
		$vl_idFormaDePago:=$ptr1->
		$vl_idEstado:=$ptr2->
		$vt_retorno:="0"
		
		Case of 
			: ($vl_idFormaDePago=-4)  //cheque
				Case of 
					: ($vl_idEstado=-2)  //protestado
						$vt_retorno:=ACTcfg_OpcionesEstadosPagos ("ObtieneEstadoNuloProtYReemp";->[ACT_Documentos_en_Cartera:182]id_forma_de_pago:19)
					: ($vl_idEstado=-7)  //protestado y reemplazado
						$vt_retorno:=ACTcfg_OpcionesEstadosPagos ("ObtieneEstadoNuloProtYReemp";->[ACT_Documentos_en_Cartera:182]id_forma_de_pago:19)
					Else 
						$vt_retorno:=ACTcfg_OpcionesEstadosPagos ("ObtieneEstadoReemplazado";->[ACT_Documentos_en_Cartera:182]id_forma_de_pago:19)
				End case 
				
			: ($vl_idFormaDePago=-8)  //letra
				  //20120524 RCH Se cambia estado por defecto a docPago
				$vt_retorno:=ACTcfg_OpcionesEstadosPagos ("ObtieneEstadoNulo";->$vl_idFormaDePago)
				
		End case 
		
End case 

$0:=$vt_retorno