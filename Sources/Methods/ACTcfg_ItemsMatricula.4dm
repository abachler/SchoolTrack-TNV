//%attributes = {}
  //ACTcfg_ItemsMatricula

C_TEXT:C284($1;$vt_accion)
C_POINTER:C301(${2})
C_POINTER:C301($ptr1;$ptr2;$ptr3)
C_BLOB:C604($xBlob)
C_BOOLEAN:C305($0;$vb_retorno)

$vt_accion:=$1
If (Count parameters:C259>=2)
	$ptr1:=$2
End if 

If (Count parameters:C259>=3)
	$ptr2:=$3
End if 

  // Añadido por: Saúl Ponce (03-01-2017) - Ticket N° 172266, para procesar fecha de pago
If (Count parameters:C259>=4)
	$ptr3:=$4
End if 


$vb_retorno:=False:C215
Case of 
	: ($vt_accion="InicializaYLee")
		ACTcfg_ItemsMatricula ("InicializaArreglos")
		ACTcfg_ItemsMatricula ("LeeArreglo")
		
	: ($vt_accion="InicializaYLeeBlob")
		ACTcfg_ItemsMatricula ("InicializaArreglos")
		ACTcfg_ItemsMatricula ("LeeBlob")
		
	: ($vt_accion="InicializaArreglos")
		C_REAL:C285(cs_MatriculadoAuto;btn_Proyectado;btn_Emitido;btn_pagoParcial;btn_pagoCompleto;btn_noEmiteMatriculado;btn_noEmiteAluXEgresar;btn_asignaFechaMatriculado)
		C_TEXT:C284(vtACTcfg_Fecha)
		C_DATE:C307(vdACTcfg_Fecha)
		ARRAY LONGINT:C221(alACTcfg_IdItemMatricula;0)
		ARRAY TEXT:C222(atACTcfg_GlosaItemMatricula;0)
		ARRAY LONGINT:C221(alACT_cfgItemRecNumCargos;0)
		cs_MatriculadoAuto:=0
		btn_Proyectado:=0
		btn_Emitido:=0
		btn_pagoParcial:=0
		btn_pagoCompleto:=0
		vdACTcfg_Fecha:=!00-00-00!
		vtACTcfg_Fecha:=""
		btn_noEmiteMatriculado:=0
		btn_noEmiteAluXEgresar:=0
		btn_asignaFechaMatriculado:=0
		
	: ($vt_accion="LeeBlob")
		  //20130314 RCH Se pasa a caso para leer desde otro lugar
		ACTcfg_ItemsMatricula ("Variables2Blob";->$xBlob)
		$xBlob:=PREF_fGetBlob (0;"ParametrosMatriculadoAuto";$xBlob)
		BLOB_Blob2Vars (->$xBlob;0;->alACTcfg_IdItemMatricula;->cs_MatriculadoAuto;->btn_Proyectado;->btn_Emitido;->btn_pagoParcial;->btn_pagoCompleto;->vdACTcfg_Fecha;->btn_noEmiteMatriculado;->btn_noEmiteAluXEgresar;->btn_asignaFechaMatriculado)
		ACTcfg_ItemsMatricula ("LlenaGlosas";->alACTcfg_IdItemMatricula;->atACTcfg_GlosaItemMatricula)
		vtACTcfg_Fecha:=String:C10(vdACTcfg_Fecha)
		SET BLOB SIZE:C606($xBlob;0)
		
	: ($vt_accion="LeeArreglo")
		ACTcfg_ItemsMatricula ("LeeBlob")
		
		  //20110125 RCH cuando se eliminaba un cargo desde dentro de la ficha de una cuenta se actualizaban los datos del explorador con los datos del primer 
		  //alumno (en niv_loadarrays se hace un all records de alumnos...) y no correspondia al que estaba listado antes de entrar a la ficha de la cuenta
		CREATE SET:C116([Alumnos:2];"setAlumnos")
		NIV_LoadArrays   //se utiliza en una de las opciones
		USE SET:C118("setAlumnos")
		SET_ClearSets ("setAlumnos")
		
	: ($vt_accion="Variables2Blob")
		BLOB_Variables2Blob ($ptr1;0;->alACTcfg_IdItemMatricula;->cs_MatriculadoAuto;->btn_Proyectado;->btn_Emitido;->btn_pagoParcial;->btn_pagoCompleto;->vdACTcfg_Fecha;->btn_noEmiteMatriculado;->btn_noEmiteAluXEgresar;->btn_asignaFechaMatriculado)
		
	: ($vt_accion="LlenaGlosas")
		AT_Initialize ($ptr2)
		For ($i;1;Size of array:C274($ptr1->))
			$vl_idItem:=$ptr1->{$i}
			APPEND TO ARRAY:C911($ptr2->;KRL_GetTextFieldData (->[xxACT_Items:179]ID:1;->$vl_idItem;->[xxACT_Items:179]Glosa:2))
		End for 
		
	: ($vt_accion="GuardaArreglo")
		ACTcfg_ItemsMatricula ("Variables2Blob";->$xBlob)
		PREF_SetBlob (0;"ParametrosMatriculadoAuto";$xBlob)
		ACTcfg_ItemsMatricula ("InicializaArreglos")
		SET BLOB SIZE:C606($xBlob;0)
		
	: ($vt_accion="EliminacionItem")
		ACTcfg_ItemsMatricula ("InicializaArreglos")
		ACTcfg_ItemsMatricula ("Variables2Blob";->$xBlob)
		$xBlob:=PREF_fGetBlob (0;"ParametrosMatriculadoAuto";$xBlob)
		BLOB_Blob2Vars (->$xBlob;0;->alACTcfg_IdItemMatricula;->cs_MatriculadoAuto;->btn_Proyectado;->btn_Emitido;->btn_pagoParcial;->btn_pagoCompleto;->vdACTcfg_Fecha;->btn_noEmiteMatriculado;->btn_noEmiteAluXEgresar;->btn_asignaFechaMatriculado)
		If (Find in array:C230(alACTcfg_IdItemMatricula;$ptr1->)#-1)
			AT_Delete (Find in array:C230(alACTcfg_IdItemMatricula;$ptr1->);1;->alACTcfg_IdItemMatricula)
			ACTcfg_ItemsMatricula ("GuardaArreglo")
		End if 
		
	: ($vt_accion="SeteaEstadosObjetosCfg")
		ARRAY INTEGER:C220($al_selected;0)
		$err:=AL_GetSelect (xAL_ACT_cfg_ItemsMatricula;$al_selected)
		IT_SetButtonState ((Size of array:C274($al_selected)>0);->bDeleteLineMat)
		
		If (cs_MatriculadoAuto=1)
			If ((btn_Proyectado=0) & (btn_Emitido=0) & (btn_pagoParcial=0) & (btn_pagoCompleto=0))
				btn_Proyectado:=1
				btn_Emitido:=0
				btn_pagoParcial:=0
				btn_pagoCompleto:=0
			End if 
			_O_ENABLE BUTTON:C192(*;"matriculaAuto@")
		Else 
			btn_Proyectado:=0
			btn_Emitido:=0
			btn_pagoParcial:=0
			btn_pagoCompleto:=0
			btn_noEmiteMatriculado:=0
			btn_noEmiteAluXEgresar:=0
			btn_asignaFechaMatriculado:=0
			_O_DISABLE BUTTON:C193(*;"matriculaAuto@")
		End if 
		IT_SetEnterable ((cs_MatriculadoAuto=1);0;->btn_Proyectado;->btn_Emitido;->btn_pagoParcial;->btn_pagoCompleto;->vtACTcfg_Fecha;->btn_noEmiteMatriculado;->btn_noEmiteAluXEgresar;->btn_asignaFechaMatriculado)
		Case of 
			: (btn_pagoCompleto=1)
				btn_Proyectado:=1
				btn_Emitido:=1
				btn_pagoParcial:=1
			: (btn_pagoParcial=1)
				btn_Proyectado:=1
				btn_Emitido:=1
				btn_pagoCompleto:=0
			: (btn_Emitido=1)
				btn_Proyectado:=1
				btn_pagoParcial:=0
				btn_pagoCompleto:=0
			: (btn_Proyectado=1)
				btn_Emitido:=0
				btn_pagoParcial:=0
				btn_pagoCompleto:=0
		End case 
		
	: ($vt_accion="CambioFecha")
		C_LONGINT:C283($resp)
		$resp:=CD_Dlog (0;__ ("¿Desea limpiar el campo Matriculado y el campo Matriculado el para todas las cuentas corrientes?");__ ("");__ ("Cancelar");__ ("Si");__ ("No"))
		If ($resp=2)
			ACTexe_LimpiaCampoMatriculado (True:C214)
		End if 
		
	: ($vt_accion="AplicarConfiguracion")
		
		  //20120723 RCH Guarda cambios
		
		
		ACTcfg_ItemsMatricula ("GuardaArreglo")
		ACTcfg_ItemsMatricula ("GuardaLogItems")
		
		ACTcfg_ItemsMatricula ("LeeArreglo")
		
		C_POINTER:C301($ptrDate)
		ARRAY LONGINT:C221(al_idsCtasCtes;0)
		If (cs_MatriculadoAuto=1)
			If (Size of array:C274(alACTcfg_IdItemMatricula)>0)
				READ ONLY:C145([ACT_CuentasCorrientes:175])
				SET QUERY LIMIT:C395(1)
				QUERY:C277([ACT_CuentasCorrientes:175];[ACT_CuentasCorrientes:175]Matriculado:29=True:C214)
				SET QUERY LIMIT:C395(0)
				If (Records in selection:C76([ACT_CuentasCorrientes:175])>0)
					ACTcfg_ItemsMatricula ("CambioFecha")
				End if 
				ACTcfg_ItemsMatricula ("BuscaCargos";->al_idsCtasCtes)
				ACTcfg_ItemsMatricula ("AplicaConfiguracionDesdeArreglo";->al_idsCtasCtes)
				AT_Initialize (->al_idsCtasCtes)
			End if 
		End if 
		
	: ($vt_accion="ActualizaCampoMatriculado")
		  //debe venir cargada la preferencia
		C_LONGINT:C283($vl_idItem;$vl_idCta;$vl_existe)
		ARRAY LONGINT:C221($al_idsCta;0)
		If (cs_MatriculadoAuto=1)
			$vl_idItem:=$ptr1->
			$vl_idCta:=$ptr2->
			$vb_campo:=KRL_GetBooleanFieldData (->[ACT_CuentasCorrientes:175]ID:1;->$vl_idCta;->[ACT_CuentasCorrientes:175]Matriculado:29)
			If (Not:C34($vb_campo))
				REDUCE SELECTION:C351([ACT_Cargos:173];0)
				KRL_FindAndLoadRecordByIndex (->[ACT_Cargos:173]ID:1;->$vl_idItem)
				ACTcfg_ItemsMatricula ("BuscaCargos";->$al_idsCta;->$vl_idItem)
				If (Size of array:C274($al_idsCta)>0)
					ACTcfg_ItemsMatricula ("AplicaConfiguracionCuenta";->$vl_idCta)
				End if 
			End if 
		End if 
		
	: ($vt_accion="AplicaConfiguracionCuenta")
		
		  // Añadido por: Saúl Ponce (03-01-2017) - Ticket N° 172266, para recibir la primera fecha en que se pagó el cargo configurado como matrícula
		C_DATE:C307($vd_fecha)
		C_TEXT:C284($vt_parametro)
		
		$vd_fecha:=!00-00-00!
		If (Not:C34(Is nil pointer:C315($ptr3)))
			$vd_fecha:=$ptr3->
		Else 
			$vd_fecha:=Current date:C33(*)
		End if 
		
		KRL_FindAndLoadRecordByIndex (->[ACT_CuentasCorrientes:175]ID:1;$ptr1;True:C214)
		If (ok=1)
			If (Not:C34([ACT_CuentasCorrientes:175]Matriculado:29))
				[ACT_CuentasCorrientes:175]Matriculado:29:=True:C214
				If (btn_asignaFechaMatriculado=1)
					  //[ACT_CuentasCorrientes]Matriculado_el:=Current date(*)
					[ACT_CuentasCorrientes:175]Matriculado_el:54:=$vd_fecha  // Saúl Ponce (03-01-2017) - Ticket N° 172266
				End if 
				SAVE RECORD:C53([ACT_CuentasCorrientes:175])
			End if 
		Else 
			If (Not:C34(Is nil pointer:C315($ptr2))) & (Is nil pointer:C315($ptr3))
				$ptr2->:=$ptr2->+1
			Else 
				  // Añadido por: Saúl Ponce (03-01-2017) - Ticket N° 172266
				$ptr2->:=$ptr2->+1
				$vt_parametro:=ST_Concatenate ("";$ptr1;->$vd_fecha)
				BM_CreateRequest ("ACT_CampoMatriculado";$vt_parametro;String:C10($ptr1->))
			End if 
		End if 
		KRL_UnloadReadOnly (->[ACT_CuentasCorrientes:175])
		
	: ($vt_accion="AplicaConfiguracionDesdeArreglo")
		C_LONGINT:C283($vr_contadorTomados;$vl_idCtaCte)
		$vr_contadorTomados:=0
		$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;__ ("Aplicando configuración"))
		REDUCE SELECTION:C351([ACT_CuentasCorrientes:175];0)
		For ($i;1;Size of array:C274($ptr1->))
			$vl_idCtaCte:=$ptr1->{$i}
			ACTcfg_ItemsMatricula ("AplicaConfiguracionCuenta";->$vl_idCtaCte;->$vr_contadorTomados)
			$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$i/Size of array:C274($ptr1->);__ ("Aplicando configuración"))
		End for 
		$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
		
		If ($vr_contadorTomados>0)
			CD_Dlog (0;__ ("Existían cuentas en uso durante la ejecución del script. Algunas cuentas no fueron marcadas como Matriculado"))
		End if 
		
	: ($vt_accion="AgregaElementoArreglo")
		If (cs_MatriculadoAuto=1)
			If (Find in array:C230(alACTcfg_IdItemMatricula;[ACT_Cargos:173]Ref_Item:16)#-1)
				C_POINTER:C301($ptrDate)
				If (btn_Emitido=1)
					$ptrDate:=->[ACT_Cargos:173]FechaEmision:22
				Else 
					$ptrDate:=->[ACT_Cargos:173]Fecha_de_generacion:4
				End if 
				If ($ptrDate->>=vdACTcfg_Fecha)
					$vb_append:=False:C215
					Case of 
						: (btn_pagoCompleto=1)
							If (([ACT_Cargos:173]Saldo:23=0) & (([ACT_Cargos:173]Monto_Neto:5>0) & ([ACT_Cargos:173]MontosPagados:8>0)))
								$vb_append:=True:C214
							Else 
								If ([ACT_Cargos:173]Monto_Neto:5=0)
									$vb_append:=True:C214
								End if 
							End if 
						: (btn_pagoParcial=1)
							If ([ACT_Cargos:173]MontosPagados:8>0)
								$vb_append:=True:C214
							End if 
						: (btn_Emitido=1)
							If ([ACT_Cargos:173]FechaEmision:22#!00-00-00!)
								$vb_append:=True:C214
							End if 
						: (btn_Proyectado=1)
							  //If ([ACT_Cargos]FechaEmision=!00-00-00!)
							$vb_append:=True:C214
							  //End if 
					End case 
					If ($vb_append)
						APPEND TO ARRAY:C911(alACT_cfgItemRecNumCargos;Record number:C243([ACT_Cargos:173]))
					End if 
				End if 
			End if 
		End if 
		
	: ($vt_accion="AgregaElementosArreglo")
		FIRST RECORD:C50([ACT_Cargos:173])
		While (Not:C34(End selection:C36([ACT_Cargos:173])))
			ACTcfg_ItemsMatricula ("AgregaElementoArreglo")
			NEXT RECORD:C51([ACT_Cargos:173])
		End while 
		
	: ($vt_accion="ActualizaCampoDesdeRecNumArray")
		ARRAY LONGINT:C221($al_idsCtas;0)
		ARRAY LONGINT:C221($al_idsItems;0)
		CREATE SELECTION FROM ARRAY:C640([ACT_Cargos:173];$ptr1->;"")
		SELECTION TO ARRAY:C260([ACT_Cargos:173]ID_CuentaCorriente:2;$al_idsCtas;[ACT_Cargos:173]ID:1;$al_idsItems)
		For ($i;1;Size of array:C274($al_idsCtas))
			$vl_idItem:=$al_idsItems{$i}
			$vl_idCta:=$al_idsCtas{$i}
			ACTcfg_ItemsMatricula ("ActualizaCampoMatriculado";->$vl_idItem;->$vl_idCta)
		End for 
		
	: ($vt_accion="ActualizaCampoDesdeProyectado")
		If (cs_MatriculadoAuto=1)
			If (btn_Emitido=0)  //actualiza si est‡ marcado s—lo btn_proyectado
				ACTcfg_ItemsMatricula ("ActualizaCampoDesdeRecNumArray";->alACT_cfgItemRecNumCargos)
			End if 
		End if 
		ACTcfg_ItemsMatricula ("InicializaArreglos")
		
	: ($vt_accion="ActualizaCampoDesdeEmitido")
		If (cs_MatriculadoAuto=1)
			If (btn_pagoParcial=0)  //actualiza si est‡ marcado s—lo btn_proyectado
				ACTcfg_ItemsMatricula ("ActualizaCampoDesdeRecNumArray";->alACT_cfgItemRecNumCargos)
			End if 
		End if 
		ACTcfg_ItemsMatricula ("InicializaArreglos")
	: ($vt_accion="ActualizaCampoDesdePagado")
		If (cs_MatriculadoAuto=1)
			If ((btn_pagoParcial=1) | (btn_pagoCompleto=1))
				$vb_readOnlyMode:=Read only state:C362([ACT_CuentasCorrientes:175])
				$vl_recNum:=Record number:C243([ACT_CuentasCorrientes:175])
				ACTcfg_ItemsMatricula ("ActualizaCampoDesdeRecNumArray";->alACT_cfgItemRecNumCargos)
				KRL_GotoRecord (->[ACT_CuentasCorrientes:175];$vl_recNum;Not:C34($vb_readOnlyMode))
			End if 
		End if 
		ACTcfg_ItemsMatricula ("InicializaArreglos")
		
	: ($vt_accion="ActualizaCampoDesdePagoEliminado")
		If (cs_MatriculadoAuto=1)
			Case of 
				: (btn_pagoCompleto=1)
					ACTcfg_ItemsMatricula ("ActualizaCampoDesdePagado")
				: (btn_pagoParcial=1)
					ACTcfg_ItemsMatricula ("ActualizaCampoDesdePagado")
				: (btn_Emitido=1)
					ACTcfg_ItemsMatricula ("ActualizaCampoDesdeEmitido")
				: (btn_Proyectado=1)
					ACTcfg_ItemsMatricula ("ActualizaCampoDesdeProyectado")
			End case 
		End if 
		
	: ($vt_accion="ProcesaBash")
		
		  // Añadido por: Saúl Ponce (03-01-2017) - Ticket N° 172266, para aceptar la primera fecha en que se pagó el cargo configurado como matrícula
		C_LONGINT:C283($vr_contadorTomados;$vl_idCtaCte)
		C_DATE:C307($vd_date)
		$vr_contadorTomados:=0
		
		  // utilizar la fecha de pago que se está recibiendo
		If (Position:C15(";";$ptr1->;1)>0)
			ST_Deconcatenate ("";$ptr1->;->$vl_idCtaCte;->$vd_date)
			ACTcfg_ItemsMatricula ("AplicaConfiguracionCuenta";->$vl_idCtaCte;->$vr_contadorTomados;->$vd_date)
		Else 
			  // así estaba antes de modificar
			$vl_idCtaCte:=Num:C11($ptr1->)
			ACTcfg_ItemsMatricula ("AplicaConfiguracionCuenta";->$vl_idCtaCte;->$vr_contadorTomados)
		End if 
		
		If ($vr_contadorTomados=0)
			$vb_retorno:=True:C214
		End if 
	: ($vt_accion="BuscaCargos")
		C_BOOLEAN:C305($vb_buscarEnSeleccion)
		C_POINTER:C301($ptrDate)
		READ ONLY:C145([ACT_Cargos:173])
		If (btn_Emitido=1)
			$ptrDate:=->[ACT_Cargos:173]FechaEmision:22
		Else 
			$ptrDate:=->[ACT_Cargos:173]Fecha_de_generacion:4
		End if 
		If (Not:C34(Is nil pointer:C315($ptr2)))
			QUERY SELECTION:C341([ACT_Cargos:173];$ptrDate->;>=vdACTcfg_Fecha;*)
			$vb_buscarEnSeleccion:=True:C214
		Else 
			QUERY:C277([ACT_Cargos:173];$ptrDate->;>=vdACTcfg_Fecha;*)
			$vb_buscarEnSeleccion:=False:C215
		End if 
		If (Not:C34($vb_buscarEnSeleccion))
			$proc:=IT_UThermometer (1;0;__ ("Buscando cargos..."))
		End if 
		
		Case of 
			: (btn_pagoCompleto=1)
				If ($vb_buscarEnSeleccion)
					QUERY SELECTION:C341([ACT_Cargos:173]; & ;[ACT_Cargos:173]Saldo:23=0)
				Else 
					QUERY:C277([ACT_Cargos:173]; & ;[ACT_Cargos:173]Saldo:23=0)
				End if 
			: (btn_pagoParcial=1)
				If ($vb_buscarEnSeleccion)
					QUERY SELECTION:C341([ACT_Cargos:173]; & ;[ACT_Cargos:173]MontosPagados:8>0)
				Else 
					QUERY:C277([ACT_Cargos:173]; & ;[ACT_Cargos:173]MontosPagados:8>0)
				End if 
			: (btn_Emitido=1)
				If ($vb_buscarEnSeleccion)
					QUERY SELECTION:C341([ACT_Cargos:173]; & ;[ACT_Cargos:173]FechaEmision:22#!00-00-00!)
				Else 
					QUERY:C277([ACT_Cargos:173]; & ;[ACT_Cargos:173]FechaEmision:22#!00-00-00!)
				End if 
			: (btn_Proyectado=1)
				If ($vb_buscarEnSeleccion)
					  //QUERY SELECTION([ACT_Cargos]; & ;[ACT_Cargos]FechaEmision=!00-00-00!)
					QUERY SELECTION:C341([ACT_Cargos:173])
				Else 
					  //QUERY([ACT_Cargos]; & ;[ACT_Cargos]FechaEmision=!00-00-00!)
					QUERY:C277([ACT_Cargos:173])
				End if 
			Else 
				QUERY:C277([ACT_Cargos:173])
		End case 
		If ($vb_buscarEnSeleccion)
			If (Find in array:C230(alACTcfg_IdItemMatricula;[ACT_Cargos:173]Ref_Item:16)=-1)
				REDUCE SELECTION:C351([ACT_Cargos:173];0)
			End if 
		Else 
			QRY_QueryWithArray (->[ACT_Cargos:173]Ref_Item:16;->alACTcfg_IdItemMatricula;True:C214)
		End if 
		AT_DistinctsFieldValues (->[ACT_Cargos:173]ID_CuentaCorriente:2;$ptr1)
		If (Not:C34($vb_buscarEnSeleccion))
			IT_UThermometer (-2;$proc)
		End if 
		
	: ($vt_accion="EliminaPago")
		ACTcfg_ItemsMatricula ("InicializaArreglos")
		ACTcfg_ItemsMatricula ("LeeArreglo")
		If (cs_MatriculadoAuto=1)
			If (Size of array:C274(alACTcfg_IdItemMatricula)>0)
				ARRAY LONGINT:C221($al_recNums;0)
				ARRAY LONGINT:C221($al_refItems;0)
				ARRAY LONGINT:C221($al_refsItems;0)
				ARRAY LONGINT:C221($al_recNumArrays2;0)
				C_LONGINT:C283($vl_idCtaCte)
				READ ONLY:C145([ACT_Cargos:173])
				For ($j;1;Size of array:C274($ptr1->))
					$vl_idCtaCte:=$ptr1->{$j}
					KRL_FindAndLoadRecordByIndex (->[ACT_CuentasCorrientes:175]ID:1;->$vl_idCtaCte;True:C214)
					[ACT_CuentasCorrientes:175]Matriculado:29:=False:C215
					SAVE RECORD:C53([ACT_CuentasCorrientes:175])
					QUERY:C277([ACT_Cargos:173];[ACT_Cargos:173]ID_CuentaCorriente:2=[ACT_CuentasCorrientes:175]ID:1)
					SELECTION TO ARRAY:C260([ACT_Cargos:173];$al_recNums;[ACT_Cargos:173]Ref_Item:16;$al_refItems)
					KRL_UnloadReadOnly (->[ACT_CuentasCorrientes:175])
					AT_intersect (->alACTcfg_IdItemMatricula;->$al_refItems;->$al_refsItems)
					For ($i;1;Size of array:C274($al_refsItems))
						$al_refItems{0}:=$al_refsItems{$i}
						ARRAY LONGINT:C221($DA_Return;0)
						AT_SearchArray (->$al_refItems;"=";->$DA_Return)
						For ($x;1;Size of array:C274($DA_Return))
							APPEND TO ARRAY:C911($al_recNumArrays2;$al_recNums{$DA_Return{$x}})
						End for 
					End for 
					ACTcfg_ItemsMatricula ("ActualizaCampoDesdeRecNumArray";->$al_recNumArrays2)
					
					ACTcfg_ItemsMatricula ("VerificaFechaCampoMatriculado";->$al_recNumArrays2)
				End for 
			End if 
		End if 
		ACTcfg_ItemsMatricula ("InicializaArreglos")
		
	: ($vt_accion="VerificaFechaCampoMatriculado")
		ARRAY LONGINT:C221($al_idsCtas;0)
		READ ONLY:C145([ACT_Cargos:173])
		CREATE SELECTION FROM ARRAY:C640([ACT_Cargos:173];$ptr1->;"")
		SELECTION TO ARRAY:C260([ACT_Cargos:173]ID_CuentaCorriente:2;$al_idsCtas)
		For ($i;1;Size of array:C274($al_idsCtas))
			READ ONLY:C145([ACT_CuentasCorrientes:175])
			KRL_FindAndLoadRecordByIndex (->[ACT_CuentasCorrientes:175]ID:1;->$al_idsCtas{$i})
			If (Not:C34([ACT_CuentasCorrientes:175]Matriculado:29))
				KRL_ReloadInReadWriteMode (->[ACT_CuentasCorrientes:175])
				If (Not:C34(Locked:C147([ACT_CuentasCorrientes:175])))
					[ACT_CuentasCorrientes:175]Matriculado_el:54:=!00-00-00!
					SAVE RECORD:C53([ACT_CuentasCorrientes:175])
				Else 
					LOG_RegisterEvt ("El campo Matriculado el, para el alumno: "+KRL_GetTextFieldData (->[Alumnos:2]numero:1;->[ACT_CuentasCorrientes:175]ID_Alumno:3;->[Alumnos:2]apellidos_y_nombres:40)+", no pudo ser actualizado porque el registro estaba en uso.")
				End if 
				KRL_UnloadReadOnly (->[ACT_CuentasCorrientes:175])
			End if 
			
		End for 
		
	: ($vt_accion="ExisteItemEnArreglo")
		If (Find in array:C230(alACTcfg_IdItemMatricula;$ptr1->)#-1)
			$vb_retorno:=True:C214
		Else 
			$vb_retorno:=False:C215
		End if 
		
	: ($vt_accion="ValidaEmisionAlumnoMatriculado")
		C_REAL:C285(cs_MatriculadoAuto;btn_noEmiteMatriculado)
		$vb_retorno:=True:C214
		If (cs_MatriculadoAuto=1)
			If ((btn_noEmiteMatriculado=1) & ($ptr1->))
				If (ACTcfg_ItemsMatricula ("ExisteItemEnArreglo";$ptr2))
					$vb_retorno:=False:C215
				End if 
			End if 
		End if 
		
	: ($vt_accion="ValidaEmisionAlumnoXEgresar")
		C_REAL:C285(cs_MatriculadoAuto;btn_noEmiteAluXEgresar)
		$vb_retorno:=True:C214
		If (cs_MatriculadoAuto=1)
			If (btn_noEmiteAluXEgresar=1)
				READ ONLY:C145([Alumnos:2])
				KRL_FindAndLoadRecordByIndex (->[Alumnos:2]numero:1;$ptr1)
				If (Find in array:C230(<>al_NumeroNivelRegular;[Alumnos:2]nivel_numero:29)=Size of array:C274(<>al_NumeroNivelRegular))
					If (ACTcfg_ItemsMatricula ("ExisteItemEnArreglo";$ptr2))
						$vb_retorno:=False:C215
					End if 
				End if 
			End if 
		End if 
		
	: ($vt_accion="InitLogItems")
		ARRAY TEXT:C222(atACTcfg_LogItemMatricula;0)
		
	: ($vt_accion="SetCalendarioInputCta")
		OBJECT SET ENABLED:C1123(*;"matricula";[ACT_CuentasCorrientes:175]Matriculado:29)
		
	: ($vt_accion="AgregaLogItemsMatricula")
		APPEND TO ARRAY:C911(atACTcfg_LogItemMatricula;$ptr1->)
		
	: ($vt_accion="GuardaLogItems")
		For ($i;1;Size of array:C274(atACTcfg_LogItemMatricula))
			LOG_RegisterEvt (atACTcfg_LogItemMatricula{$i})
		End for 
		AT_Initialize (->atACTcfg_LogItemMatricula)
	: ($vt_accion="BuscaPagosDeMatricula")
		
		  // Añadido por: Saúl Ponce (03-01-2017) - Ticket N° 172266, para buscar la primera fecha en que se pagó el cargo configurado como matrícula
		READ ONLY:C145([ACT_Cargos:173])
		READ ONLY:C145([ACT_Pagos:172])
		C_DATE:C307($vd_fechaPago)
		$vd_fechaPago:=!00-00-00!
		QUERY:C277([ACT_Cargos:173];[ACT_Cargos:173]ID_CuentaCorriente:2=$ptr1->)
		QUERY SELECTION WITH ARRAY:C1050([ACT_Cargos:173]Ref_Item:16;alACTcfg_IdItemMatricula)
		If (Records in selection:C76([ACT_Cargos:173])>0)
			KRL_RelateSelection (->[ACT_Transacciones:178]ID_Item:3;->[ACT_Cargos:173]ID:1;"")
			KRL_RelateSelection (->[ACT_Pagos:172]ID:1;->[ACT_Transacciones:178]ID_Pago:4;"")
			ORDER BY:C49([ACT_Pagos:172];[ACT_Pagos:172]Fecha:2;[ACT_Pagos:172]ID:1;>)
			REDUCE SELECTION:C351([ACT_Pagos:172];1)
			$vd_fechaPago:=[ACT_Pagos:172]Fecha:2
		End if 
		REDUCE SELECTION:C351([ACT_Pagos:172];0)
		REDUCE SELECTION:C351([ACT_Transacciones:178];0)
		ACTcfg_ItemsMatricula ("AplicaConfiguracionCuenta";$ptr1;$ptr2;->$vd_fechaPago)
End case 
$0:=$vb_retorno