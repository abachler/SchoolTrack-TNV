//%attributes = {}
C_TEXT:C284($vt_accion)
C_POINTER:C301($vy_pointer1;${2};$vy_pointer2)
C_LONGINT:C283($vl_seleccionado)

$vt_accion:=$1
If (Count parameters:C259>=2)
	$vy_pointer1:=$2
End if 
If (Count parameters:C259>=3)
	$vy_pointer2:=$3
End if 

Case of 
	: ($vt_accion="OnLoad")
		ACTcfg_OpcionesCambioEstadoPago ("InicializaVars")
		If (vbACT_CEdesdePago)
			DISTINCT VALUES:C339([ACT_Pagos:172]id_forma_de_pago:30;alACT_formaDePagoCE)
		Else 
			APPEND TO ARRAY:C911(alACT_formaDePagoCE;-16)
		End if 
		For ($i;1;Size of array:C274(alACT_formaDePagoCE))
			APPEND TO ARRAY:C911(atACT_formaDePagoCE;ACTcfg_OpcionesFormasDePago ("GetFormaDePagoXID";->alACT_formaDePagoCE{$i}))
		End for 
		
		If (Size of array:C274(alACT_formaDePagoCE)>0)
			$vl_seleccionado:=1
			ACTcfg_OpcionesCambioEstadoPago ("CargaEstados";->$vl_seleccionado)
		End if 
		
	: ($vt_accion="AsignaNuevoEstado")
		$vl_nuevoEstado:=$vy_pointer1->
		If ([ACT_Documentos_de_Pago:176]id_estado:53#$vl_nuevoEstado)
			[ACT_Documentos_de_Pago:176]id_estado:53:=$vl_nuevoEstado
			[ACT_Documentos_de_Pago:176]Estado:14:=ACTcfg_OpcionesEstadosPagos ("ObtieneEstado";->[ACT_Documentos_de_Pago:176]id_forma_de_pago:51;->[ACT_Documentos_de_Pago:176]id_estado:53)
			LOG_RegisterEvt ("Cambio de estado de documento tipo "+[ACT_Documentos_de_Pago:176]Tipodocumento:5+", número de serie "+[ACT_Documentos_de_Pago:176]NoSerie:12+". Estado cambió de "+Old:C35([ACT_Documentos_de_Pago:176]Estado:14)+" a "+[ACT_Documentos_de_Pago:176]Estado:14+".")
		End if 
		
	: ($vt_accion="CargaEstados")
		$vl_seleccionado:=$vy_pointer1->
		
		atACT_formaDePagoCE:=$vl_seleccionado
		alACT_formaDePagoCE:=$vl_seleccionado
		
		ACTcfg_OpcionesEstadosPagos ("CargaArreglos";->alACT_formaDePagoCE{alACT_formaDePagoCE})
		COPY ARRAY:C226(alACT_estadosID;alACT_estadoNuevoCE)
		COPY ARRAY:C226(atACT_estados;atACT_estadoNuevoCE)
		
		  // se da la opcion de que se pueda seleccionar cualquiera de los estaodos
		COPY ARRAY:C226(atACT_estadoNuevoCE;atACT_formaModCE)
		COPY ARRAY:C226(alACT_estadoNuevoCE;alACT_formaModCE)
		
		  // se eliminan los estados por defecto que son manejados por el sistema...
		For ($i;Size of array:C274(alACT_estadoNuevoCE);1;-1)
			If (alACT_estadoNuevoCE{$i}<0)
				AT_Delete ($i;1;->alACT_estadoNuevoCE;->atACT_estadoNuevoCE)
			End if 
		End for 
		
		cs_todosCE:=1
		cs_particularCE:=0
		
	: ($vt_accion="Aceptar")
		C_BOOLEAN:C305($vb_continuar)
		$vb_continuar:=False:C215
		Case of 
			: (atACT_formaDePagoCE=0)
				CD_Dlog (0;__ ("Usted debe seleccionar una forma de pago a modificar."))
			: (atACT_estadoNuevoCE=0)
				CD_Dlog (0;__ ("Usted debe seleccionar un estado a asignar."))
			: ((cs_particularCE=1) & (atACT_formaModCE=0))
				CD_Dlog (0;__ ("Usted debe seleccionar a qué estado de pago desea aplicar el cambio."))
			Else 
				$vb_continuar:=True:C214
		End case 
		If ($vb_continuar)
			C_LONGINT:C283($vlACT_idFormaPago2Aplicar;$vlACT_idFormaPago2Mod)
			$vlACT_idFormaPago2Mod:=alACT_formaDePagoCE{atACT_formaDePagoCE}
			vlACT_nuevoIDEstado2Asi:=alACT_estadoNuevoCE{atACT_estadoNuevoCE}
			$vlACT_idFormaPago2Aplicar:=alACT_formaModCE{atACT_formaModCE}
			If (($vlACT_idFormaPago2Mod#0) & (vlACT_nuevoIDEstado2Asi#0) & (vlACT_nuevoIDEstado2Asi#$vlACT_idFormaPago2Aplicar))
				C_POINTER:C301($vy_ptrTable;$vy_ptrField)
				If (vbACT_CEdesdePago)
					If (Records in set:C195("SetPagosCambioEstado")=0)
						$vb_continuar:=False:C215
					Else 
						USE SET:C118("SetPagosCambioEstado")
					End if 
				Else 
					If (Records in set:C195("SetPagaresCambioEstado")=0)
						$vb_continuar:=False:C215
					Else 
						USE SET:C118("SetPagaresCambioEstado")
					End if 
				End if 
				SET_ClearSets ("SetPagosCambioEstado";"SetPagaresCambioEstado")
				
				If ($vb_continuar)
					If (vbACT_CEdesdePago)
						QUERY SELECTION:C341([ACT_Pagos:172];[ACT_Pagos:172]id_forma_de_pago:30=$vlACT_idFormaPago2Mod)
						KRL_RelateSelection (->[ACT_Documentos_de_Pago:176]ID:1;->[ACT_Pagos:172]ID_DocumentodePago:6;"")
						If (cs_particularCE=1)
							QUERY SELECTION:C341([ACT_Documentos_de_Pago:176];[ACT_Documentos_de_Pago:176]id_estado:53=$vlACT_idFormaPago2Aplicar)
						End if 
					Else 
						If (cs_particularCE=1)
							QUERY SELECTION:C341([ACT_Pagares:184];[ACT_Pagares:184]ID_Estado:6=$vlACT_idFormaPago2Aplicar)
						End if 
					End if 
					ACCEPT:C269
				Else 
					BEEP:C151
				End if 
			Else 
				BEEP:C151
			End if 
		End if 
		
	: ($vt_accion="InicializaVars")
		ARRAY TEXT:C222(atACT_formaDePagoCE;0)
		ARRAY LONGINT:C221(alACT_formaDePagoCE;0)
		
		ARRAY TEXT:C222(atACT_estadoNuevoCE;0)
		ARRAY LONGINT:C221(alACT_estadoNuevoCE;0)
		
		ARRAY TEXT:C222(atACT_formaModCE;0)
		ARRAY LONGINT:C221(alACT_formaModCE;0)
		
		C_REAL:C285(cs_todosCE;cs_particularCE)
		
		C_LONGINT:C283(vlACT_nuevoIDEstado2Asi)
		
		C_TEXT:C284(vtACT_comentarioEstadoNew)
		
		vlACT_nuevoIDEstado2Asi:=0
		vtACT_comentarioEstadoNew:=""
		
End case 