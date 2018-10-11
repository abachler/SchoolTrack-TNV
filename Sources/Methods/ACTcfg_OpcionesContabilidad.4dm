//%attributes = {}
C_TEXT:C284($vt_accion;$1;$0;$vt_retorno)
C_LONGINT:C283($vl_id;$vl_tipo;$vl_records)
C_POINTER:C301($vy_pointer1;$vy_pointer2)
C_POINTER:C301(${2})

$vt_accion:=$1
If (Count parameters:C259>=2)
	$vy_pointer1:=$2
End if 
If (Count parameters:C259>=3)
	$vy_pointer2:=$3
End if 

Case of 
	: ($vt_accion="DeclaraArreglosCuentasContables")
		ARRAY LONGINT:C221(<>alACT_idCta;0)
		_O_ARRAY STRING:C218(80;<>asACT_GlosaCta;0)
		_O_ARRAY STRING:C218(80;<>asACT_CuentaCta;0)
		_O_ARRAY STRING:C218(80;<>asACT_CodAuxCta;0)
		
	: ($vt_accion="DeclaraArreglosCentrosCosto")
		ARRAY LONGINT:C221(<>alACT_idCentro;0)
		_O_ARRAY STRING:C218(80;<>asACT_Centro;0)
		ARRAY TEXT:C222(<>atACT_CentroGlosa;0)
		
	: ($vt_accion="DeclaraArreglosCuentasEspeciales")
		ARRAY LONGINT:C221(alACT_idCtaEspecial;0)
		ARRAY TEXT:C222(atACT_CtasEspecialesGlosa;0)
		_O_ARRAY STRING:C218(80;asACT_CtasEspecialesCta;0)
		_O_ARRAY STRING:C218(80;asACT_CtasEspecialesCentro;0)
		ARRAY LONGINT:C221(alACT_idCtasEspeciales;0)
		ARRAY LONGINT:C221(alACT_idCentroEspeciales;0)
		
	: ($vt_accion="OrdenaRegistros")
		ORDER BY:C49([ACT_Cuentas_Contables:286];[ACT_Cuentas_Contables:286]glosa:3;>)
		
	: ($vt_accion="BuscaCuentasContables")
		READ ONLY:C145([ACT_Cuentas_Contables:286])
		QUERY:C277([ACT_Cuentas_Contables:286];[ACT_Cuentas_Contables:286]id_tipo_cta:2=1)
		ACTcfg_OpcionesContabilidad ("OrdenaRegistros")
		
	: ($vt_accion="CargaArreglosCuentasContables")
		ACTcfg_OpcionesContabilidad ("DeclaraArreglosCuentasContables")
		ACTcfg_OpcionesContabilidad ("BuscaCuentasContables")
		SELECTION TO ARRAY:C260([ACT_Cuentas_Contables:286]id:1;<>alACT_idCta;[ACT_Cuentas_Contables:286]glosa:3;<>asACT_GlosaCta;[ACT_Cuentas_Contables:286]codigo_plan_cuenta:4;<>asACT_CuentaCta;[ACT_Cuentas_Contables:286]codigo_aux:5;<>asACT_CodAuxCta)
		
	: ($vt_accion="BuscaCentrosCosto")
		READ ONLY:C145([ACT_Cuentas_Contables:286])
		QUERY:C277([ACT_Cuentas_Contables:286];[ACT_Cuentas_Contables:286]id_tipo_cta:2=2)
		ACTcfg_OpcionesContabilidad ("OrdenaRegistros")
		
	: ($vt_accion="CargaArreglosCentrosCosto")
		ACTcfg_OpcionesContabilidad ("DeclaraArreglosCentrosCosto")
		ACTcfg_OpcionesContabilidad ("BuscaCentrosCosto")
		SELECTION TO ARRAY:C260([ACT_Cuentas_Contables:286]id:1;<>alACT_idCentro;[ACT_Cuentas_Contables:286]codigo_plan_cuenta:4;<>asACT_Centro;[ACT_Cuentas_Contables:286]glosa:3;<>atACT_CentroGlosa)
		
	: ($vt_accion="CargaArreglosCuentasEspeciales")
		ACTcfg_OpcionesContabilidad ("DeclaraArreglosCuentasEspeciales")
		READ ONLY:C145([ACT_Cuentas_Contables:286])
		QUERY:C277([ACT_Cuentas_Contables:286];[ACT_Cuentas_Contables:286]id_tipo_cta:2=3)
		ACTcfg_OpcionesContabilidad ("OrdenaRegistros")
		SELECTION TO ARRAY:C260([ACT_Cuentas_Contables:286]id:1;alACT_idCtaEspecial;[ACT_Cuentas_Contables:286]glosa:3;atACT_CtasEspecialesGlosa;[ACT_Cuentas_Contables:286]id_cta_asociada:6;alACT_idCtasEspeciales;[ACT_Cuentas_Contables:286]id_centro_asociado:7;alACT_idCentroEspeciales)
		
		ARRAY TEXT:C222($atACT_CtasEspeciales;0)
		ARRAY LONGINT:C221($alACT_CtasEspeciales;0)
		ACTcfg_OpcionesContabilidad ("ObtieneCuentasEspeciales";->$atACT_CtasEspeciales;->$alACT_CtasEspeciales)
		
		For ($i;1;Size of array:C274(alACT_idCtasEspeciales))
			QUERY:C277([ACT_Cuentas_Contables:286];[ACT_Cuentas_Contables:286]id:1=alACT_idCtasEspeciales{$i};*)
			QUERY:C277([ACT_Cuentas_Contables:286]; & ;[ACT_Cuentas_Contables:286]id_tipo_cta:2=1)
			APPEND TO ARRAY:C911(asACT_CtasEspecialesCta;[ACT_Cuentas_Contables:286]codigo_plan_cuenta:4)
			
			QUERY:C277([ACT_Cuentas_Contables:286];[ACT_Cuentas_Contables:286]id:1=alACT_idCentroEspeciales{$i};*)
			QUERY:C277([ACT_Cuentas_Contables:286]; & ;[ACT_Cuentas_Contables:286]id_tipo_cta:2=2)
			APPEND TO ARRAY:C911(asACT_CtasEspecialesCentro;[ACT_Cuentas_Contables:286]codigo_plan_cuenta:4)
			
			$vl_existe:=Find in array:C230($alACT_CtasEspeciales;alACT_idCtaEspecial{$i})
			If ($vl_existe>0)
				atACT_CtasEspecialesGlosa{$i}:=$atACT_CtasEspeciales{$vl_existe}
			End if 
		End for 
		
	: ($vt_accion="PintaCtasEspeciales")
		  //ACTcfg_OpcionesContabilidad ("PintaCtasEspeciales")
		  //20121105 RCH pinta lineas de cuentas especiales por defecto
		ARRAY INTEGER:C220($aInt2D;2;0)
		For ($i;1;Size of array:C274(alACT_idCtaEspecial))
			If (alACT_idCtaEspecial{$i}<0)
				AL_SetCellColor (xALP_CtasEspeciales;1;$i;5;$i;$aInt2D;"Red";0;"";0)
			End if 
		End for 
		
	: ($vt_accion="CreaRegistro")
		$vl_tipo:=$vy_pointer1->
		CREATE RECORD:C68([ACT_Cuentas_Contables:286])
		  //20130813 RCH
		  //$vl_id:=SQ_SeqNumber (->[ACT_Cuentas_Contables]id)
		$l_existe:=0
		While ($l_existe#-1)
			$vl_id:=SQ_SeqNumber (->[ACT_Cuentas_Contables:286]id:1)
			$l_existe:=Find in field:C653([ACT_Cuentas_Contables:286]id:1;$vl_id)
		End while 
		[ACT_Cuentas_Contables:286]id:1:=$vl_id
		[ACT_Cuentas_Contables:286]id_tipo_cta:2:=$vl_tipo
		SAVE RECORD:C53([ACT_Cuentas_Contables:286])
		$vt_retorno:=String:C10($vl_id)
		
	: ($vt_accion="InsertaArreglosCuentasContables")
		  //20111025 RCH Al crear una cuenta se eliminaba la anterior ingresada
		ACTcfg_OpcionesContabilidad ("GuardaConfiguracion")
		$vl_tipo:=1
		$vt_retorno:=ACTcfg_OpcionesContabilidad ("CreaRegistro";->$vl_tipo)
		ACTcfg_OpcionesContabilidad ("CargaArreglosCuentasContables")
		
	: ($vt_accion="InsertaArreglosCentrosCosto")
		  //20111025 RCH Al crear una cuenta se eliminaba la anterior ingresada
		ACTcfg_OpcionesContabilidad ("GuardaConfiguracion")
		$vl_tipo:=2
		$vt_retorno:=ACTcfg_OpcionesContabilidad ("CreaRegistro";->$vl_tipo)
		ACTcfg_OpcionesContabilidad ("CargaArreglosCentrosCosto")
		
	: ($vt_accion="InsertaArreglosCuentasEspeciales")
		  //20111025 RCH Al crear una cuenta se eliminaba la anterior ingresada
		ACTcfg_OpcionesContabilidad ("GuardaConfiguracion")
		$vl_tipo:=3
		$vt_retorno:=ACTcfg_OpcionesContabilidad ("CreaRegistro";->$vl_tipo)
		ACTcfg_OpcionesContabilidad ("CargaArreglosCuentasEspeciales")
		
	: ($vt_accion="EliminaRegistro")
		READ WRITE:C146([ACT_Cuentas_Contables:286])
		QUERY:C277([ACT_Cuentas_Contables:286];[ACT_Cuentas_Contables:286]id:1=$vy_pointer1->)
		DELETE RECORD:C58([ACT_Cuentas_Contables:286])
		KRL_UnloadReadOnly (->[ACT_Cuentas_Contables:286])
		
	: ($vt_accion="EliminaArreglosCuentasContables")
		ACTcfg_OpcionesContabilidad ("EliminaRegistro";$vy_pointer1)
		ACTcfg_OpcionesContabilidad ("CargaArreglosCuentasContables")
		
	: ($vt_accion="EliminaArreglosCentrosCosto")
		ACTcfg_OpcionesContabilidad ("EliminaRegistro";$vy_pointer1)
		ACTcfg_OpcionesContabilidad ("CargaArreglosCentrosCosto")
		
	: ($vt_accion="EliminaArreglosCuentasEspeciales")
		ARRAY TEXT:C222($atACT_CtasEspeciales;0)
		ARRAY LONGINT:C221($alACT_CtasEspeciales;0)
		ACTcfg_OpcionesContabilidad ("ObtieneCuentasEspeciales";->$atACT_CtasEspeciales;->$alACT_CtasEspeciales)
		If (Find in array:C230($alACT_CtasEspeciales;$vy_pointer1->)=-1)
			ACTcfg_OpcionesContabilidad ("EliminaRegistro";$vy_pointer1)
			ACTcfg_OpcionesContabilidad ("CargaArreglosCuentasEspeciales")
		Else 
			CD_Dlog (0;__ ("Las cuentas especiales por defecto no pueden ser eliminadas."))
		End if 
		
	: ($vt_accion="ObtieneCuentasEspeciales")
		AT_Initialize ($vy_pointer1;$vy_pointer2)
		APPEND TO ARRAY:C911($vy_pointer1->;__ ("IVA Debito Fiscal"))
		APPEND TO ARRAY:C911($vy_pointer2->;-1)
		
		APPEND TO ARRAY:C911($vy_pointer1->;__ ("Saldos disponibles"))
		APPEND TO ARRAY:C911($vy_pointer2->;-2)
		
		APPEND TO ARRAY:C911($vy_pointer1->;__ ("Descuentos"))
		APPEND TO ARRAY:C911($vy_pointer2->;-3)
		
	: ($vt_accion="VerificaCuentasEspeciales")
		ARRAY TEXT:C222($atACT_CtasEspeciales;0)
		ARRAY LONGINT:C221($alACT_CtasEspeciales;0)
		ACTcfg_OpcionesContabilidad ("ObtieneCuentasEspeciales";->$atACT_CtasEspeciales;->$alACT_CtasEspeciales)
		
		For ($i;1;Size of array:C274($atACT_CtasEspeciales))
			READ WRITE:C146([ACT_Cuentas_Contables:286])
			QUERY:C277([ACT_Cuentas_Contables:286];[ACT_Cuentas_Contables:286]id:1=$alACT_CtasEspeciales{$i})
			If (Records in selection:C76([ACT_Cuentas_Contables:286])=0)
				CREATE RECORD:C68([ACT_Cuentas_Contables:286])
				[ACT_Cuentas_Contables:286]id:1:=$alACT_CtasEspeciales{$i}
				[ACT_Cuentas_Contables:286]glosa:3:=$atACT_CtasEspeciales{$i}
				SAVE RECORD:C53([ACT_Cuentas_Contables:286])
			Else 
				If (Records in selection:C76([ACT_Cuentas_Contables:286])=1)
					[ACT_Cuentas_Contables:286]glosa:3:=$atACT_CtasEspeciales{$i}
					SAVE RECORD:C53([ACT_Cuentas_Contables:286])
				End if 
			End if 
			KRL_UnloadReadOnly (->[ACT_Cuentas_Contables:286])
		End for 
		
	: ($vt_accion="GuardaConfiguracion")
		For ($i;Size of array:C274(<>asACT_CuentaCta);1;-1)
			If (<>asACT_CuentaCta{$i}="")
				ACTcfg_OpcionesContabilidad ("EliminaRegistro";-><>alACT_idCta{$i})
				AT_Delete ($i;1;-><>alACT_idCta;-><>asACT_GlosaCta;-><>asACT_CuentaCta;-><>asACT_CodAuxCta)
			End if 
		End for 
		For ($i;Size of array:C274(<>asACT_Centro);1;-1)
			If (<>asACT_Centro{$i}="")
				ACTcfg_OpcionesContabilidad ("EliminaRegistro";-><>alACT_idCentro{$i})
				AT_Delete ($i;1;-><>alACT_idCentro;-><>asACT_Centro;-><>atACT_CentroGlosa)
			End if 
		End for 
		For ($i;Size of array:C274(atACT_CtasEspecialesGlosa);1;-1)
			If (atACT_CtasEspecialesGlosa{$i}="")
				ACTcfg_OpcionesContabilidad ("EliminaRegistro";->alACT_idCtaEspecial{$i})
				AT_Delete ($i;1;->alACT_idCtaEspecial;->alACT_idCtasEspeciales;->alACT_idCentroEspeciales;->atACT_CtasEspecialesGlosa;->asACT_CtasEspecialesCta;->asACT_CtasEspecialesCentro)
			End if 
		End for 
		
		READ WRITE:C146([ACT_Cuentas_Contables:286])
		For ($i;Size of array:C274(<>asACT_CuentaCta);1;-1)
			QUERY:C277([ACT_Cuentas_Contables:286];[ACT_Cuentas_Contables:286]id:1=<>alACT_idCta{$i})
			[ACT_Cuentas_Contables:286]glosa:3:=<>asACT_GlosaCta{$i}
			[ACT_Cuentas_Contables:286]codigo_plan_cuenta:4:=<>asACT_CuentaCta{$i}
			[ACT_Cuentas_Contables:286]codigo_aux:5:=<>asACT_CodAuxCta{$i}
			[ACT_Cuentas_Contables:286]id_tipo_cta:2:=1
			SAVE RECORD:C53([ACT_Cuentas_Contables:286])
		End for 
		
		For ($i;Size of array:C274(<>asACT_Centro);1;-1)
			QUERY:C277([ACT_Cuentas_Contables:286];[ACT_Cuentas_Contables:286]id:1=<>alACT_idCentro{$i})
			[ACT_Cuentas_Contables:286]codigo_plan_cuenta:4:=<>asACT_Centro{$i}
			[ACT_Cuentas_Contables:286]glosa:3:=<>atACT_CentroGlosa{$i}
			[ACT_Cuentas_Contables:286]id_tipo_cta:2:=2
			SAVE RECORD:C53([ACT_Cuentas_Contables:286])
		End for 
		
		For ($i;Size of array:C274(atACT_CtasEspecialesGlosa);1;-1)
			QUERY:C277([ACT_Cuentas_Contables:286];[ACT_Cuentas_Contables:286]id:1=alACT_idCtaEspecial{$i})
			[ACT_Cuentas_Contables:286]glosa:3:=atACT_CtasEspecialesGlosa{$i}
			[ACT_Cuentas_Contables:286]id_cta_asociada:6:=alACT_idCtasEspeciales{$i}
			[ACT_Cuentas_Contables:286]id_centro_asociado:7:=alACT_idCentroEspeciales{$i}
			[ACT_Cuentas_Contables:286]id_tipo_cta:2:=3
			SAVE RECORD:C53([ACT_Cuentas_Contables:286])
		End for 
		KRL_UnloadReadOnly (->[ACT_Cuentas_Contables:286])
		
	: ($vt_accion="CargaConfiguracion")
		ACTcfg_OpcionesContabilidad ("CargaArreglosCuentasContables")
		ACTcfg_OpcionesContabilidad ("CargaArreglosCentrosCosto")
		ACTcfg_OpcionesContabilidad ("CargaArreglosCuentasEspeciales")
		
	: ($vt_accion="ValidaELiminacionCtaContable")
		$vl_id:=$vy_pointer1->
		READ ONLY:C145([ACT_Cuentas_Contables:286])
		READ ONLY:C145([ACT_Formas_de_Pago:287])
		READ ONLY:C145([ACT_EstadosFormasdePago:201])
		
		SET QUERY DESTINATION:C396(Into variable:K19:4;$vl_records)
		QUERY:C277([ACT_Cuentas_Contables:286];[ACT_Cuentas_Contables:286]id_cta_asociada:6=$vl_id)
		If ($vl_records=0)
			QUERY:C277([ACT_Formas_de_Pago:287];[ACT_Formas_de_Pago:287]id_cuenta_contra:6=$vl_id;*)
			QUERY:C277([ACT_Formas_de_Pago:287]; | ;[ACT_Formas_de_Pago:287]id_cuenta_plan:4=$vl_id)
		End if 
		If ($vl_records=0)
			QUERY:C277([ACT_EstadosFormasdePago:201];[ACT_EstadosFormasdePago:201]id_cuenta_contable:5=$vl_id;*)
			QUERY:C277([ACT_EstadosFormasdePago:201]; | ;[ACT_EstadosFormasdePago:201]id_cuenta_contable_contra:7=$vl_id)
		End if 
		SET QUERY DESTINATION:C396(Into current selection:K19:1)
		
		If ($vl_records>0)  // no se continua...
			$vt_retorno:="0"
		Else 
			$vt_retorno:="1"
		End if 
		
	: ($vt_accion="ValidaELiminacionCentroCostos")
		$vl_id:=$vy_pointer1->
		READ ONLY:C145([ACT_Cuentas_Contables:286])
		READ ONLY:C145([ACT_Formas_de_Pago:287])
		READ ONLY:C145([ACT_EstadosFormasdePago:201])
		
		SET QUERY DESTINATION:C396(Into variable:K19:4;$vl_records)
		QUERY:C277([ACT_Cuentas_Contables:286];[ACT_Cuentas_Contables:286]id_cta_asociada:6=$vl_id)
		If ($vl_records=0)
			QUERY:C277([ACT_Formas_de_Pago:287];[ACT_Formas_de_Pago:287]id_centro_contra:7=$vl_id;*)
			QUERY:C277([ACT_Formas_de_Pago:287]; | ;[ACT_Formas_de_Pago:287]id_centro_plan:5=$vl_id)
		End if 
		If ($vl_records=0)
			QUERY:C277([ACT_EstadosFormasdePago:201];[ACT_EstadosFormasdePago:201]id_centro_costo:6=$vl_id;*)
			QUERY:C277([ACT_EstadosFormasdePago:201]; | ;[ACT_EstadosFormasdePago:201]id_centro_costo_contra:8=$vl_id)
		End if 
		SET QUERY DESTINATION:C396(Into current selection:K19:1)
		
		If ($vl_records>0)  // no se continua...
			$vt_retorno:="0"
		Else 
			$vt_retorno:="1"
		End if 
		
	: ($vt_accion="SetEstadoBotonCtasEspeciales")
		$line:=$vy_pointer1->
		If (Size of array:C274(alACT_idCtaEspecial)>=$line)
			ARRAY TEXT:C222($atACT_CtasEspeciales;0)
			ARRAY LONGINT:C221($alACT_CtasEspeciales;0)
			ACTcfg_OpcionesContabilidad ("ObtieneCuentasEspeciales";->$atACT_CtasEspeciales;->$alACT_CtasEspeciales)
			IT_SetButtonState ((Find in array:C230($alACT_CtasEspeciales;alACT_idCtaEspecial{$line})=-1);->bClearCEsp)
		Else 
			IT_SetButtonState (False:C215;->bClearCEsp)
		End if 
		
End case 

$0:=$vt_retorno