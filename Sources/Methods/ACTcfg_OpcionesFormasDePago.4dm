//%attributes = {}
  //ACTcfg_OpcionesFormasDePago

C_TEXT:C284($vt_accion;$1)
C_POINTER:C301($ptr1;$ptr2;$ptr3)
C_TEXT:C284($vt_nombreFormaDePago;$vt_codFormaDePago)
C_LONGINT:C283($pos;$existe;$vl_numFormasDePago;$vl_records)
C_TEXT:C284($vt_NewName;$vt_oldName)
C_BLOB:C604(xBlob)
C_TEXT:C284($vt_return;$0)
C_LONGINT:C283($vl_IDEstado;$l_IdFdp)

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
		For ($i;1;Size of array:C274(alACT_FormasdePagoID))
			If (alACT_FormasdePagoID{$i}<0)
				$vl_numFormasDePago:=$vl_numFormasDePago+1
			End if 
		End for 
		AL_SetCellEnter (xALP_FormasdePago;1;1;1;$vl_numFormasDePago;$aInt2D;0)
		AL_SetCellColor (xALP_FormasdePago;1;1;1;$vl_numFormasDePago;$aInt2D;"Red";0;"";0)
		
	: ($vt_accion="InitVarsCtas")
		_O_C_STRING:C293(80;VSACT_CTACONTABLEPAGO)
		_O_C_STRING:C293(80;VSACT_CENTROCONTABLEPAGO)
		_O_C_STRING:C293(80;VSACT_CCTACONTABLEPAGO)
		_O_C_STRING:C293(80;VSACT_CCENTROCONTABLEPAGO)
		C_TEXT:C284(VSACT_CODAUXCTAPAGO)
		C_TEXT:C284(VSACT_CODAUXCCTAPAGO;vsACT_CodInterno)
		VSACT_CTACONTABLEPAGO:=""
		VSACT_CENTROCONTABLEPAGO:=""
		VSACT_CCTACONTABLEPAGO:=""
		VSACT_CCENTROCONTABLEPAGO:=""
		VSACT_CODAUXCTAPAGO:=""
		VSACT_CODAUXCCTAPAGO:=""
		vsACT_CodInterno:=""
		
	: ($vt_accion="CargaCuentasContables")
		C_TEXT:C284($vt_nombreFormaPago)
		C_LONGINT:C283($vl_IDFormaPago)
		$vt_nombreFormaPago:=$ptr1->
		If (Not:C34(Is nil pointer:C315($ptr2)))
			$vl_IDFormaPago:=$ptr2->
		End if 
		If (Not:C34(Is nil pointer:C315($ptr3)))
			$vl_IDEstado:=$ptr3->
		End if 
		
		If ($vl_IDEstado=0)
			ACTcfg_OpcionesFormasDePago ("InitVarsCtas")
			  //ACTcfg_LoadConfigData (9) //20180529 RCH Ticket 208159
			If ($vl_IDFormaPago#0)
				ACTinit_LoadFdPago (False:C215;False:C215;$vl_IDFormaPago)
			Else 
				ACTcfg_LoadConfigData (9)
			End if 
			If ($vl_IDFormaPago=0)
				$pos:=Find in array:C230(atACT_FormasdePago;$vt_nombreFormaPago)
			Else 
				$pos:=Find in array:C230(alACT_FormasdePagoID;$vl_IDFormaPago)
			End if 
			If ($pos#-1)
				vsACT_CtaContablePago:=atACT_FdPCtaContable{$pos}
				vsACT_CentroContablePago:=atACT_FdPCentroCostos{$pos}
				vsACT_CCtaContablePago:=atACT_FdPCCtaContable{$pos}
				vsACT_CCentroContablePago:=atACT_FdPCCentroCostos{$pos}
				vsACT_CodAuxCtaPago:=atACT_FdPCtaCodAux{$pos}
				vsACT_CodAuxCCtaPago:=atACT_FdPCCtaCodAux{$pos}
				vsACT_CodInterno:=atACT_FdPCodInterno{$pos}
			End if 
		Else 
			ACTcfg_OpcionesEstadosPagos ("CargaArreglos";->$vl_IDFormaPago)
			$pos:=Find in array:C230(alACT_estadosID;$vl_IDEstado)
			If ($pos#-1)
				vsACT_CtaContablePago:=atACT_estadosCta{$pos}
				vsACT_CentroContablePago:=atACT_estadosCentro{$pos}
				vsACT_CCtaContablePago:=atACT_estadosCCta{$pos}
				vsACT_CCentroContablePago:=atACT_estadosCCentro{$pos}
				vsACT_CodAuxCtaPago:=atACT_estadosCtaCA{$pos}
				vsACT_CodAuxCCtaPago:=atACT_estadosCCtaCA{$pos}
				vsACT_CodInterno:=atACT_estadosCI{$pos}
			End if 
			
		End if 
		
	: ($vt_accion="ObtieneFormasDePagoXDefecto")
		TRACE:C157
		
	: ($vt_accion="VerificaFormaDePago")  //20170112 RCH
		If (Size of array:C274(<>atACT_FormasDePago2D)=0)
			ACTfdp_CargaFormasDePago 
		End if 
		
	: ($vt_accion="GetFormaDePagoXID")
		  //If (Size of array(<>atACT_FormasDePago2D)=0)  //20151231 RCH. Soluciona error cuando que aparece desde el trigger de Personas.
		  //ACTfdp_CargaFormasDePago 
		  //End if 
		ACTcfg_OpcionesFormasDePago ("VerificaFormaDePago")
		
		$vl_existe:=Find in array:C230(<>atACT_FormasDePago2D{1};String:C10($ptr1->))
		If ($vl_existe>0)
			$vt_return:=<>atACT_FormasDePago2D{3}{$vl_existe}
		Else 
			If (Not:C34(Is nil pointer:C315($ptr2)))
				$vt_return:=$ptr2->
			Else 
				$vt_return:=ACTcfgfdp_OpcionesGenerales ("fdpXDefecto")
			End if 
		End if 
		
	: ($vt_accion="FormasAsignables")
		READ ONLY:C145([ACT_Formas_de_Pago:287])
		QUERY:C277([ACT_Formas_de_Pago:287];[ACT_Formas_de_Pago:287]id:1#-12;*)  // se quita nc
		QUERY:C277([ACT_Formas_de_Pago:287]; & ;[ACT_Formas_de_Pago:287]id:1#-5)  // se quita cheque a fecha
		SELECTION TO ARRAY:C260([ACT_Formas_de_Pago:287]glosa_forma_de_pago:9;$ptr1->;[ACT_Formas_de_Pago:287]id:1;$ptr2->)
		For ($i;1;Size of array:C274($ptr2->))
			$l_IdFdp:=$ptr2->{$i}
			$ptr1->{$i}:=ACTcfg_OpcionesFormasDePago ("GetFormaDePagoXID";->$l_IdFdp)
		End for 
	: ($vt_accion="CargaArreglos")
		ACTinit_LoadFdPago 
		
	: ($vt_accion="CargaArreglosConf")
		ACTinit_LoadFdPago (True:C214)
		
	: ($vt_accion="InsertaNuevaFormaDePagoConf")
		$vt_glosaOrg:=__ ("Nueva forma de pago")
		$vl_contador:=1
		$vl_existe:=1
		While ($vl_existe#-1)
			$vt_glosa:=$vt_glosaOrg+" "+String:C10($vl_contador)
			$vl_contador:=$vl_contador+1
			$vl_existe:=Find in field:C653([ACT_Formas_de_Pago:287]glosa_forma_de_pago:9;$vt_glosa)
		End while 
		$vl_IDFormaPago:=Num:C11(ACTcfg_OpcionesFormasDePago ("NuevaFormaDePago";->$vt_glosa))
		ACTcfg_OpcionesFormasDePago ("CargaArreglosConf")
		  //KRL_ExecuteEverywhere ("ACTfdp_CargaFormasDePago")
		
		If ($vl_IDFormaPago#-1)
			SET QUERY DESTINATION:C396(Into variable:K19:4;$vl_records)
			QUERY:C277([ACT_EstadosFormasdePago:201];[ACT_EstadosFormasdePago:201]id_forma_pago:2=$vl_IDFormaPago;*)
			QUERY:C277([ACT_EstadosFormasdePago:201]; & ;[ACT_EstadosFormasdePago:201]anula_pago:10=True:C214)
			SET QUERY DESTINATION:C396(Into current selection:K19:1)
			If ($vl_records=0)
				$vt_glosa:=__ ("Nulo")
				$vb_anula:=True:C214
				ACTcfg_OpcionesEstadosPagos ("CreateRecord";->$vt_glosa;->$vl_IDFormaPago;->$vb_anula)
			End if 
		End if 
		
	: ($vt_accion="EliminaFormaDePagoConf")
		If ($ptr1->>0)
			If (Num:C11(ACTcfg_OpcionesFormasDePago ("VerificaUtilizacionDePago";$ptr1))=0)
				READ WRITE:C146([ACT_Formas_de_Pago:287])
				QUERY:C277([ACT_Formas_de_Pago:287];[ACT_Formas_de_Pago:287]id:1=$ptr1->)
				
				  //20130821 RCH
				LOG_RegisterEvt ("Eliminación de forma de pago: "+ST_Qte ([ACT_Formas_de_Pago:287]glosa_forma_de_pago:9)+", id: "+String:C10([ACT_Formas_de_Pago:287]id:1)+".")
				
				DELETE RECORD:C58([ACT_Formas_de_Pago:287])
				KRL_UnloadReadOnly (->[ACT_Formas_de_Pago:287])
				  //20130820 RCH
				  //KRL_ExecuteEverywhere ("ACTfdp_CargaFormasDePago")
				KRL_ExecuteEverywhere ("ACTinit_LoadPrefs")
				ACTcfg_OpcionesFormasDePago ("CargaArreglosConf")
			Else 
				BEEP:C151
			End if 
		End if 
		
	: ($vt_accion="VerificaUtilizacionDePago")
		$vl_IDFormaPago:=$ptr1->
		
		If ($vl_IDFormaPago#0)
			  //[ACT_Pagos]
			  //[Personas]
			  //[xxACT_ArchivosBancarios]
			  //[ACT_Documentos_en_Cartera]
			  //[ACT_CuentasCorrientes]
			
			SET QUERY DESTINATION:C396(Into variable:K19:4;$vl_records)
			QUERY:C277([ACT_Pagos:172];[ACT_Pagos:172]id_forma_de_pago:30=$vl_IDFormaPago)
			If ($vl_records=0)
				QUERY:C277([Personas:7];[Personas:7]ACT_id_modo_de_pago:94=$vl_IDFormaPago)
				If ($vl_records=0)
					QUERY:C277([xxACT_ArchivosBancarios:118];[xxACT_ArchivosBancarios:118]id_forma_de_pago:13=$vl_IDFormaPago)
					If ($vl_records=0)
						QUERY:C277([ACT_Documentos_en_Cartera:182];[ACT_Documentos_en_Cartera:182]id_forma_de_pago:19=$vl_IDFormaPago)
						If ($vl_records=0)
							QUERY:C277([ACT_CuentasCorrientes:175];[ACT_CuentasCorrientes:175]id_modo_de_pago:32=$vl_IDFormaPago)
						End if 
					End if 
				End if 
			End if 
			SET QUERY DESTINATION:C396(Into current selection:K19:1)
			$vt_return:=String:C10($vl_records)
		End if 
		
	: ($vt_accion="NuevaFormaDePago")
		If (Find in field:C653([ACT_Formas_de_Pago:287]glosa_forma_de_pago:9;$ptr1->)=-1)
			
			$vt_glosa:=""
			$vt_codIngreso:=""
			$vt_codInterno:=""
			$vt_glosa:=$ptr1->
			If ($vt_glosa#"")
				If (Not:C34(Is nil pointer:C315($ptr2)))
					$vt_codIngreso:=$ptr2->
				End if 
				If (Not:C34(Is nil pointer:C315($ptr3)))
					$vt_codInterno:=$ptr3->
				End if 
				
				CREATE RECORD:C68([ACT_Formas_de_Pago:287])
				[ACT_Formas_de_Pago:287]forma_de_pago_old:2:=$vt_glosa
				  //20150105 ASM comento el código ya que en ningún momento acá se actualiza el registro, siempre se crea.
				  //20150304 RCH Se descomenta código porque las formas de pago por defecto no estaban siendo creadas con el id correspondiente negativo.
				$vl_existe:=Find in array:C230(<>atACT_FormasDePago2D{2};[ACT_Formas_de_Pago:287]forma_de_pago_old:2)
				If ($vl_existe>0)
					[ACT_Formas_de_Pago:287]id:1:=Num:C11(<>atACT_FormasDePago2D{1}{$vl_existe})
					[ACT_Formas_de_Pago:287]glosa_forma_de_pago:9:=<>atACT_FormasDePago2D{3}{$vl_existe}
					[ACT_Formas_de_Pago:287]estado:13:=ST_GetWord (<>atACT_FormasDePago2D{7}{$vl_existe};1;"|")
					[ACT_Formas_de_Pago:287]id_estado_por_defecto:14:=Num:C11(ST_GetWord (<>atACT_FormasDePago2D{7}{$vl_existe};2;"|"))
					[ACT_Formas_de_Pago:287]permite_ingreso_pago:11:=(Num:C11(<>atACT_FormasDePago2D{5}{$vl_existe})=1)
					[ACT_Formas_de_Pago:287]visible_en_conf:12:=(Num:C11(<>atACT_FormasDePago2D{6}{$vl_existe})=1)
				Else 
					
					  //20150304 RCH Puede que se pierdan los numeros de secuencia, por lo tanto se valida hasta que el metodo retorne uno válido. Ticket 140289...
					$l_id:=SQ_SeqNumber (->[ACT_Formas_de_Pago:287]id:1)
					While (Find in field:C653([ACT_Formas_de_Pago:287]id:1;$l_id)#-1)
						$l_id:=SQ_SeqNumber (->[ACT_Formas_de_Pago:287]id:1)
					End while 
					
					[ACT_Formas_de_Pago:287]id:1:=SQ_SeqNumber (->[ACT_Formas_de_Pago:287]id:1)
					[ACT_Formas_de_Pago:287]glosa_forma_de_pago:9:=[ACT_Formas_de_Pago:287]forma_de_pago_old:2
					[ACT_Formas_de_Pago:287]estado:13:=""
					[ACT_Formas_de_Pago:287]id_estado_por_defecto:14:=0
					[ACT_Formas_de_Pago:287]permite_ingreso_pago:11:=True:C214
					[ACT_Formas_de_Pago:287]visible_en_conf:12:=True:C214
				End if 
				[ACT_Formas_de_Pago:287]codigo_ingreso:3:=$vt_codIngreso
				[ACT_Formas_de_Pago:287]codigo_interno:8:=$vt_codInterno
				[ACT_Formas_de_Pago:287]Auto_UUID:17:=Generate UUID:C1066  //20141229 ASM  Ticket 140289
				$vt_return:=String:C10([ACT_Formas_de_Pago:287]id:1)
				ACTpgs_SaveFormasDePago 
			End if 
		Else 
			$vt_return:="-1"
		End if 
		
	: ($vt_accion="DeclaraArreglos")
		ARRAY TEXT:C222(atACT_FormasdePago;0)
		ARRAY TEXT:C222(atACT_FdPCodes;0)
		ARRAY TEXT:C222(atACT_FdPCtaContable;0)
		ARRAY TEXT:C222(atACT_FdPCtaCodAux;0)
		ARRAY TEXT:C222(atACT_FdPCentroCostos;0)
		ARRAY TEXT:C222(atACT_FdPCCtaContable;0)
		ARRAY TEXT:C222(atACT_FdPCCtaCodAux;0)
		ARRAY TEXT:C222(atACT_FdPCCentroCostos;0)
		ARRAY TEXT:C222(atACT_FdPCodInterno;0)
		_O_C_STRING:C293(80;vtACT_CICAFecha)
		ARRAY LONGINT:C221(alACT_FormasdePagoID;0)
		ARRAY TEXT:C222(atACT_FormasdePagoNew;0)
		
		ARRAY LONGINT:C221(alACT_idCtaFDP;0)
		ARRAY LONGINT:C221(alACT_idCentroFDP;0)
		ARRAY LONGINT:C221(alACT_idCCtaFDP;0)
		ARRAY LONGINT:C221(alACT_idCCentroFDP;0)
		
		  //20130318 RCH Se utiliza en el ingreso de pago
		ARRAY TEXT:C222(atACT_FormasdePagoNew2;0)
		
	: ($vt_accion="EliminaElementoArreglo")
		If ($ptr1->>0)
			AT_Delete ($ptr1->;1;->atACT_FormasdePago;->atACT_FdPCodes;->atACT_FdPCtaContable;->atACT_FdPCtaCodAux;->atACT_FdPCentroCostos;->atACT_FdPCCtaContable;->atACT_FdPCCtaCodAux;->atACT_FdPCCentroCostos;->atACT_FdPCodInterno;->alACT_FormasdePagoID;->atACT_FormasdePagoNew)
			AT_Delete ($ptr1->;1;->alACT_idCtaFDP;->alACT_idCentroFDP;->alACT_idCCtaFDP;->alACT_idCCentroFDP)
		End if 
		
	: ($vt_accion="GuardarConf")
		C_LONGINT:C283($l_IdFdp)
		For ($i;Size of array:C274(atACT_FormasdePagoNew);1;-1)
			If (atACT_FormasdePagoNew{$i}="")
				$l_IdFdp:=alACT_FormasdePagoID{$i}
				  //AT_Delete ($i;1;->atACT_FormasdePago;->atACT_FdPCodes;->atACT_FdPCtaContable;->atACT_FdPCentroCostos;->atACT_FdPCCtaContable;->atACT_FdPCCentroCostos;->atACT_FdPCtaCodAux;->atACT_FdPCCtaCodAux;->atACT_FdPCodInterno)
				ACTcfg_OpcionesFormasDePago ("EliminaElementoArreglo";->$i)
				
				  //20130712 RCH eliminar fdp vacia 
				ACTcfg_OpcionesFormasDePago ("EliminaFormaDePagoConf";->$l_IdFdp)
			End if 
		End for 
		
		$vb_modificado:=False:C215
		For ($i;1;Size of array:C274(alACT_FormasdePagoID))
			READ WRITE:C146([ACT_Formas_de_Pago:287])
			QUERY:C277([ACT_Formas_de_Pago:287];[ACT_Formas_de_Pago:287]id:1=alACT_FormasdePagoID{$i})
			[ACT_Formas_de_Pago:287]glosa_forma_de_pago:9:=atACT_FormasdePagoNew{$i}
			[ACT_Formas_de_Pago:287]codigo_ingreso:3:=atACT_FdPCodes{$i}
			[ACT_Formas_de_Pago:287]codigo_interno:8:=atACT_FdPCodInterno{$i}
			[ACT_Formas_de_Pago:287]id_cuenta_plan:4:=alACT_idCtaFDP{$i}
			[ACT_Formas_de_Pago:287]id_centro_plan:5:=alACT_idCentroFDP{$i}
			[ACT_Formas_de_Pago:287]id_cuenta_contra:6:=alACT_idCCtaFDP{$i}
			[ACT_Formas_de_Pago:287]id_centro_contra:7:=alACT_idCCentroFDP{$i}
			If (KRL_FieldChanges (->[ACT_Formas_de_Pago:287]glosa_forma_de_pago:9;->[ACT_Formas_de_Pago:287]codigo_ingreso:3;->[ACT_Formas_de_Pago:287]codigo_interno:8;->[ACT_Formas_de_Pago:287]id_cuenta_plan:4;->[ACT_Formas_de_Pago:287]id_centro_plan:5;->[ACT_Formas_de_Pago:287]id_cuenta_contra:6;->[ACT_Formas_de_Pago:287]id_centro_contra:7))
				$vb_modificado:=True:C214
			End if 
			ACTpgs_SaveFormasDePago 
		End for 
		  // si se modificó leo en todos los clientes
		If ($vb_modificado)
			ACTfdp_CargaFormasDePago 
			KRL_ExecuteOnConnectedClients ("ACTfdp_CargaFormasDePago")
		End if 
		
		
	: ($vt_accion="GOTOPAGE")
		$vl_idForma:=$ptr1->
		If ($vl_idForma#0)
			Case of 
				: ($vl_idForma=-3)
					$vl_page:=1
				: ($vl_idForma=-4)
					$vl_page:=2
				: ($vl_idForma=-6)
					$vl_page:=3
				: ($vl_idForma=-7)
					$vl_page:=4
				: ($vl_idForma=-8)
					$vl_page:=5
				Else 
					$vl_page:=1
			End case 
		End if 
		FORM GOTO PAGE:C247($vl_page)
		
	: ($vt_accion="InicializaVariablesIngresoPagos")
		atACT_FormasdePago:=1
		atACT_FormasdePagoNew:=1
		vlACT_FormasdePago:=-3
		vsACT_FormasdePago:=ACTcfgfdp_OpcionesGenerales ("GetFormaDePagoFromID";->vlACT_FormasdePago)
		
	: ($vt_accion="ReemplazaFormaDePago")
		C_LONGINT:C283(vlACT_idFormaDePago)
		vlACT_idFormaDePago:=$ptr1->
		
		If (Num:C11(ACTcfg_OpcionesFormasDePago ("VerificaUtilizacionDePago";$ptr1))>0)
			WDW_OpenFormWindow (->[ACT_Formas_de_Pago:287];"ReemplazoFormasDePago";-1;Movable form dialog box:K39:8;__ ("Eliminar o reemplazar"))
			DIALOG:C40([ACT_Formas_de_Pago:287];"ReemplazoFormasDePago")
			CLOSE WINDOW:C154
			If (ok=1)
				
				C_TEXT:C284($t_ctaContable1;$t_codAux1;$t_centroCosto1;$t_cctaContable1;$t_ccodAux1;$t_ccentroCosto1)
				C_TEXT:C284($t_ctaContable2;$t_codAux2;$t_centroCosto2;$t_cctaContable2;$t_ccodAux2;$t_ccentroCosto2)
				C_TEXT:C284($t_datosCta1;$t_datosCta2)
				C_LONGINT:C283($l_idCta;$l_idEstado)
				C_BOOLEAN:C305($b_asignarDatos)
				C_TEXT:C284($vt_formaDePagoNew;$t_msj;$vt_formaDePagoOld)
				C_LONGINT:C283($l_proc;$l_locked)
				
				$l_idEstado:=0
				$b_asignarDatos:=False:C215
				
				KRL_FindAndLoadRecordByIndex (->[ACT_Formas_de_Pago:287]id:1;->l_antiguoValor)
				$t_ctaContable1:=KRL_GetTextFieldData (->[ACT_Cuentas_Contables:286]id:1;->[ACT_Formas_de_Pago:287]id_cuenta_plan:4;->[ACT_Cuentas_Contables:286]codigo_plan_cuenta:4)
				$t_centroCosto1:=KRL_GetTextFieldData (->[ACT_Cuentas_Contables:286]id:1;->[ACT_Formas_de_Pago:287]id_centro_plan:5;->[ACT_Cuentas_Contables:286]codigo_plan_cuenta:4)
				$t_cctaContable1:=KRL_GetTextFieldData (->[ACT_Cuentas_Contables:286]id:1;->[ACT_Formas_de_Pago:287]id_cuenta_contra:6;->[ACT_Cuentas_Contables:286]codigo_plan_cuenta:4)
				$t_ccentroCosto1:=KRL_GetTextFieldData (->[ACT_Cuentas_Contables:286]id:1;->[ACT_Formas_de_Pago:287]id_centro_contra:7;->[ACT_Cuentas_Contables:286]codigo_plan_cuenta:4)
				$t_codAux1:=KRL_GetTextFieldData (->[ACT_Cuentas_Contables:286]id:1;->[ACT_Formas_de_Pago:287]id_cuenta_plan:4;->[ACT_Cuentas_Contables:286]codigo_aux:5)
				$t_ccodAux1:=KRL_GetTextFieldData (->[ACT_Cuentas_Contables:286]id:1;->[ACT_Formas_de_Pago:287]id_cuenta_contra:6;->[ACT_Cuentas_Contables:286]codigo_aux:5)
				
				
				KRL_FindAndLoadRecordByIndex (->[ACT_Formas_de_Pago:287]id:1;->l_nuevoValor)
				$t_ctaContable2:=KRL_GetTextFieldData (->[ACT_Cuentas_Contables:286]id:1;->[ACT_Formas_de_Pago:287]id_cuenta_plan:4;->[ACT_Cuentas_Contables:286]codigo_plan_cuenta:4)
				$t_centroCosto2:=KRL_GetTextFieldData (->[ACT_Cuentas_Contables:286]id:1;->[ACT_Formas_de_Pago:287]id_centro_plan:5;->[ACT_Cuentas_Contables:286]codigo_plan_cuenta:4)
				$t_cctaContable2:=KRL_GetTextFieldData (->[ACT_Cuentas_Contables:286]id:1;->[ACT_Formas_de_Pago:287]id_cuenta_contra:6;->[ACT_Cuentas_Contables:286]codigo_plan_cuenta:4)
				$t_ccentroCosto2:=KRL_GetTextFieldData (->[ACT_Cuentas_Contables:286]id:1;->[ACT_Formas_de_Pago:287]id_centro_contra:7;->[ACT_Cuentas_Contables:286]codigo_plan_cuenta:4)
				$t_codAux2:=KRL_GetTextFieldData (->[ACT_Cuentas_Contables:286]id:1;->[ACT_Formas_de_Pago:287]id_cuenta_plan:4;->[ACT_Cuentas_Contables:286]codigo_aux:5)
				$t_ccodAux2:=KRL_GetTextFieldData (->[ACT_Cuentas_Contables:286]id:1;->[ACT_Formas_de_Pago:287]id_cuenta_contra:6;->[ACT_Cuentas_Contables:286]codigo_aux:5)
				
				$t_datosCta1:=ST_Concatenate (";";->$t_ctaContable1;->$t_codAux1;->$t_centroCosto1;->$t_cctaContable1;->$t_ccodAux1;->$t_ccentroCosto1)
				$t_datosCta2:=ST_Concatenate (";";->$t_ctaContable2;->$t_codAux2;->$t_centroCosto2;->$t_cctaContable2;->$t_ccodAux2;->$t_ccentroCosto2)
				
				If ($t_datosCta1#$t_datosCta2)
					$t_msj:=__ ("Los datos número de cuenta, código auxiliar y centro de costo para las cuentas y contra cuentas contables asociadas a las 2 formas de pago seleccionadas no son exactamente iguales.")
					$t_msj:=$t_msj+"\r\r"+__ ("Al momento del reemplazo, ¿Desea asignar a los pagos los datos configurados en la nueva forma de pago seleccionada?")
					$l_resp:=CD_Dlog (0;$t_msj;"";__ ("Si");__ ("No"))
					If ($l_resp=1)
						$b_asignarDatos:=True:C214
					End if 
				End if 
				
				START TRANSACTION:C239
				MESSAGES OFF:C175
				$l_proc:=IT_UThermometer (1;0;"Actualizando forma de pago...")
				$vt_formaDePagoNew:=ACTcfg_OpcionesFormasDePago ("GetFormaDePagoXID";->l_nuevoValor)
				$vt_formaDePagoOld:=ACTcfg_OpcionesFormasDePago ("GetFormaDePagoXID";->l_antiguoValor)
				
				READ WRITE:C146([Personas:7])
				QUERY:C277([Personas:7];[Personas:7]ACT_id_modo_de_pago:94=l_antiguoValor)
				APPLY TO SELECTION:C70([Personas:7];[Personas:7]ACT_id_modo_de_pago:94:=l_nuevoValor)
				$l_locked:=$l_locked+Records in set:C195("LockedSet")
				APPLY TO SELECTION:C70([Personas:7];[Personas:7]ACT_modo_de_pago_new:95:=$vt_formaDePagoNew)
				$l_locked:=$l_locked+Records in set:C195("LockedSet")
				KRL_UnloadReadOnly (->[Personas:7])
				
				READ WRITE:C146([ACT_CuentasCorrientes:175])
				QUERY:C277([ACT_CuentasCorrientes:175];[ACT_CuentasCorrientes:175]id_modo_de_pago:32=l_antiguoValor)
				APPLY TO SELECTION:C70([ACT_CuentasCorrientes:175];[ACT_CuentasCorrientes:175]id_modo_de_pago:32:=l_nuevoValor)
				$l_locked:=$l_locked+Records in set:C195("LockedSet")
				KRL_UnloadReadOnly (->[ACT_CuentasCorrientes:175])
				
				READ WRITE:C146([xxACT_ArchivosBancarios:118])
				QUERY:C277([xxACT_ArchivosBancarios:118];[xxACT_ArchivosBancarios:118]id_forma_de_pago:13=l_antiguoValor)
				APPLY TO SELECTION:C70([xxACT_ArchivosBancarios:118];[xxACT_ArchivosBancarios:118]id_forma_de_pago:13:=l_nuevoValor)
				$l_locked:=$l_locked+Records in set:C195("LockedSet")
				APPLY TO SELECTION:C70([xxACT_ArchivosBancarios:118];[xxACT_ArchivosBancarios:118]Tipo:6:=$vt_formaDePagoNew)
				$l_locked:=$l_locked+Records in set:C195("LockedSet")
				KRL_UnloadReadOnly (->[xxACT_ArchivosBancarios:118])
				
				READ WRITE:C146([ACT_Pagos:172])
				QUERY:C277([ACT_Pagos:172];[ACT_Pagos:172]id_forma_de_pago:30=l_antiguoValor)
				APPLY TO SELECTION:C70([ACT_Pagos:172];[ACT_Pagos:172]id_forma_de_pago:30:=l_nuevoValor)
				$l_locked:=$l_locked+Records in set:C195("LockedSet")
				APPLY TO SELECTION:C70([ACT_Pagos:172];[ACT_Pagos:172]forma_de_pago_new:31:=$vt_formaDePagoNew)
				$l_locked:=$l_locked+Records in set:C195("LockedSet")
				  //20130820 RCH
				APPLY TO SELECTION:C70([ACT_Pagos:172];[ACT_Pagos:172]FormaDePago:7:=$vt_formaDePagoNew)
				$l_locked:=$l_locked+Records in set:C195("LockedSet")
				
				  //carga variables con datos de ctas contables
				ACTcfg_OpcionesFormasDePago ("CargaCuentasContables";->$vt_formaDePagoNew;->l_nuevoValor;->$l_idEstado)
				If ($b_asignarDatos)
					APPLY TO SELECTION:C70([ACT_Pagos:172];[ACT_Pagos:172]No_Cuenta_Contable:16:=vsACT_CtaContablePago)
					$l_locked:=$l_locked+Records in set:C195("LockedSet")
					APPLY TO SELECTION:C70([ACT_Pagos:172];[ACT_Pagos:172]No_CCta_Contable:19:=vsACT_CCtaContablePago)
					$l_locked:=$l_locked+Records in set:C195("LockedSet")
					APPLY TO SELECTION:C70([ACT_Pagos:172];[ACT_Pagos:172]Centro_de_costos:17:=vsACT_CentroContablePago)
					$l_locked:=$l_locked+Records in set:C195("LockedSet")
					APPLY TO SELECTION:C70([ACT_Pagos:172];[ACT_Pagos:172]CCentro_de_costos:20:=vsACT_CCentroContablePago)
					$l_locked:=$l_locked+Records in set:C195("LockedSet")
					APPLY TO SELECTION:C70([ACT_Pagos:172];[ACT_Pagos:172]CodAuxCta:22:=vsACT_CodAuxCtaPago)
					$l_locked:=$l_locked+Records in set:C195("LockedSet")
					APPLY TO SELECTION:C70([ACT_Pagos:172];[ACT_Pagos:172]CodAuxCCta:23:=vsACT_CodAuxCCtaPago)
					$l_locked:=$l_locked+Records in set:C195("LockedSet")
				End if 
				KRL_UnloadReadOnly (->[ACT_Pagos:172])
				
				READ WRITE:C146([ACT_Documentos_de_Pago:176])
				QUERY:C277([ACT_Documentos_de_Pago:176];[ACT_Documentos_de_Pago:176]id_forma_de_pago:51=l_antiguoValor)
				APPLY TO SELECTION:C70([ACT_Documentos_de_Pago:176];[ACT_Documentos_de_Pago:176]id_forma_de_pago:51:=l_nuevoValor)
				$l_locked:=$l_locked+Records in set:C195("LockedSet")
				APPLY TO SELECTION:C70([ACT_Documentos_de_Pago:176];[ACT_Documentos_de_Pago:176]forma_de_pago_new:52:=$vt_formaDePagoNew)
				$l_locked:=$l_locked+Records in set:C195("LockedSet")
				
				  //20130820 RCH
				  //APPLY TO SELECTION([ACT_Documentos_de_Pago];[ACT_Documentos_de_Pago]id_estado:=0)
				$l_idEstadoXDef:=Num:C11(ACTcfg_OpcionesEstadosPagos ("ObtieneIDEstadoPagoXDef";->l_nuevoValor))
				APPLY TO SELECTION:C70([ACT_Documentos_de_Pago:176];[ACT_Documentos_de_Pago:176]id_estado:53:=$l_idEstadoXDef)
				$l_locked:=$l_locked+Records in set:C195("LockedSet")
				
				If ($b_asignarDatos)
					APPLY TO SELECTION:C70([ACT_Documentos_de_Pago:176];[ACT_Documentos_de_Pago:176]No_Cuenta_Contable:56:=vsACT_CtaContablePago)
					$l_locked:=$l_locked+Records in set:C195("LockedSet")
					APPLY TO SELECTION:C70([ACT_Documentos_de_Pago:176];[ACT_Documentos_de_Pago:176]No_CCta_Contable:57:=vsACT_CCtaContablePago)
					$l_locked:=$l_locked+Records in set:C195("LockedSet")
					APPLY TO SELECTION:C70([ACT_Documentos_de_Pago:176];[ACT_Documentos_de_Pago:176]Centro_de_costos:58:=vsACT_CentroContablePago)
					$l_locked:=$l_locked+Records in set:C195("LockedSet")
					APPLY TO SELECTION:C70([ACT_Documentos_de_Pago:176];[ACT_Documentos_de_Pago:176]CCentro_de_costos:59:=vsACT_CCentroContablePago)
					$l_locked:=$l_locked+Records in set:C195("LockedSet")
					APPLY TO SELECTION:C70([ACT_Documentos_de_Pago:176];[ACT_Documentos_de_Pago:176]CodAuxCta:60:=vsACT_CodAuxCtaPago)
					$l_locked:=$l_locked+Records in set:C195("LockedSet")
					APPLY TO SELECTION:C70([ACT_Documentos_de_Pago:176];[ACT_Documentos_de_Pago:176]CodAuxCCta:61:=vsACT_CodAuxCCtaPago)
					$l_locked:=$l_locked+Records in set:C195("LockedSet")
				End if 
				KRL_UnloadReadOnly (->[ACT_Documentos_de_Pago:176])
				
				READ WRITE:C146([ACT_Documentos_en_Cartera:182])
				QUERY:C277([ACT_Documentos_en_Cartera:182];[ACT_Documentos_en_Cartera:182]id_forma_de_pago:19=l_antiguoValor)
				APPLY TO SELECTION:C70([ACT_Documentos_en_Cartera:182];[ACT_Documentos_en_Cartera:182]id_forma_de_pago:19:=l_nuevoValor)
				$l_locked:=$l_locked+Records in set:C195("LockedSet")
				APPLY TO SELECTION:C70([ACT_Documentos_en_Cartera:182];[ACT_Documentos_en_Cartera:182]forma_de_pago_new:20:=$vt_formaDePagoNew)
				$l_locked:=$l_locked+Records in set:C195("LockedSet")
				APPLY TO SELECTION:C70([ACT_Documentos_en_Cartera:182];[ACT_Documentos_en_Cartera:182]id_estado:21:=0)
				$l_locked:=$l_locked+Records in set:C195("LockedSet")
				KRL_UnloadReadOnly (->[ACT_Documentos_en_Cartera:182])
				
				IT_UThermometer (-2;$l_proc)
				
				If ($l_locked=0)
					$t_msj:="Reemplazo de forma de pago. La forma de pago fue cambiada de "+ST_Qte ($vt_formaDePagoOld)+" a "+ST_Qte ($vt_formaDePagoNew)+"."
					$t_msj:=$t_msj+Choose:C955($b_asignarDatos;$t_msj+"\r"+"Las cuentas contables de los pagos asociados fueron modificadas";"")
					LOG_RegisterEvt ($t_msj)
					VALIDATE TRANSACTION:C240
					FLUSH CACHE:C297
					CD_Dlog (0;__ ("Forma de pago reemplazada con éxito."))
				Else 
					CANCEL TRANSACTION:C241
					CD_Dlog (0;__ ("La forma de pago "+ST_Qte ($vt_formaDePagoOld)+" no pudo ser reemplazada por "+ST_Qte ($vt_formaDePagoNew)+" debido a que habían registros en uso. Intente nuevamente."))
				End if 
				
				
			End if 
		Else 
			CD_Dlog (0;"La forma de pago seleccionada no está siendo utilizada actualmente.")
		End if 
		
End case 

$0:=$vt_return