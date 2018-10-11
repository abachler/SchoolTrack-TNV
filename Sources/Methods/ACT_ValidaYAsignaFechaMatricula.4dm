//%attributes = {}

  // ----------------------------------------------------
  // Usuario (SO): Saúl Ponce
  // Fecha y hora: 03-01-17, 09:08:21
  // ----------------------------------------------------
  // Método: ACT_ValidaYAsignaFechaMatricula
  // Descripción:
  // Creado para validar que los cargos de matrícula hayan asignado correctamente el campo "matriculado" y "matriculado el" en cada cta. cte. de acuerdo a lo configurado.
  //
  // Parámetros:
  // No requiere.
  // ----------------------------------------------------



If (<>bXS_esServidorOficial)
	If (ACT_AccountTrackInicializado )
		
		C_DATE:C307($vd_fechaAnterior)
		C_LONGINT:C283($z;$vl_bloqueados)
		C_TEXT:C284($vt_opcBusqueda;$vt_mensaje;$vt_para;$vt_asunto;$vt_regActividades)
		
		ARRAY LONGINT:C221($al_IDCargo;0)
		ARRAY LONGINT:C221($al_idsCtas;0)
		
		ACTcfg_ItemsMatricula ("InicializaYLee")
		If (Size of array:C274(alACTcfg_IdItemMatricula)>0)
			$vt_opcBusqueda:=Choose:C955((btn_pagoParcial=1) | (btn_pagoCompleto=1);"BuscaPagosDeMatricula";"AplicaConfiguracionCuenta")
			
			QUERY WITH ARRAY:C644([ACT_Cargos:173]Ref_Item:16;alACTcfg_IdItemMatricula)
			DISTINCT VALUES:C339([ACT_Cargos:173]ID_CuentaCorriente:2;$al_idsCtas)
			ACTcfg_ItemsMatricula ("BuscaCargos";->$al_idsCtas)
			
			If (Records in selection:C76([ACT_Cargos:173])>0)
				
				SET AUTOMATIC RELATIONS:C310(True:C214;False:C215)
				QUERY SELECTION:C341([ACT_Cargos:173];[ACT_CuentasCorrientes:175]Matriculado:29=False:C215;*)
				QUERY SELECTION:C341([ACT_Cargos:173]; & ;[ACT_CuentasCorrientes:175]Matriculado_el:54=!00-00-00!)
				SET AUTOMATIC RELATIONS:C310(False:C215;False:C215)
				
				If (Records in selection:C76([ACT_Cargos:173])>0)
					$vt_asunto:="Actualización de campo "+ST_Qte ("Matriculado")+" y "+ST_Qte ("Matriculado el")+" en "+<>gCustom
					$vt_para:="sponce@colegium.com"
					$vt_mensaje:="AccountTrack actualizó de forma automática, en el equipo "+Current machine:C483+" - usuario "+Current system user:C484
					$vt_mensaje:=$vt_mensaje+", la fecha de matrícula de la/las siguiente(s) cuenta(s) corriente(s):"+("\r"*2)
					
					
					SELECTION TO ARRAY:C260([ACT_Cargos:173]ID:1;$al_IDCargo;[ACT_Cargos:173]ID_CuentaCorriente:2;$al_idsCtas)
					For ($z;1;Size of array:C274($al_IDCargo))
						$vt_regActividades:=""
						
						QUERY:C277([ACT_CuentasCorrientes:175];[ACT_CuentasCorrientes:175]ID:1=$al_idsCtas{$z})
						QUERY:C277([Alumnos:2];[Alumnos:2]numero:1=[ACT_CuentasCorrientes:175]ID_Alumno:3)
						$vd_fechaAnterior:=[ACT_CuentasCorrientes:175]Matriculado_el:54
						
						ACTcfg_ItemsMatricula ($vt_opcBusqueda;->$al_idsCtas{$z};->$vl_bloqueados)
						
						$vt_mensaje:=$vt_mensaje+String:C10($al_idsCtas{$z})+" - "+[Alumnos:2]apellidos_y_nombres:40+" ("+[Alumnos:2]curso:20+")."+"\r"
						
						LOAD RECORD:C52([ACT_CuentasCorrientes:175])
						$vt_regActividades:="Asignación de fecha de matrícula automática de la cuenta corriente ID: "+String:C10($al_idsCtas{$z})+", para el alumno "+[Alumnos:2]apellidos_y_nombres:40+"."
						$vt_regActividades:=$vt_regActividades+" Cambió de "+String:C10($vd_fechaAnterior)+" a "+String:C10([ACT_CuentasCorrientes:175]Matriculado_el:54)+"."
						LOG_RegisterEvt ($vt_regActividades)
						
						UNLOAD RECORD:C212([ACT_CuentasCorrientes:175])
						UNLOAD RECORD:C212([Alumnos:2])
					End for 
					Mail_EnviaNotificacion ($vt_asunto;$vt_mensaje;$vt_para)
				End if 
			End if 
		End if 
	End if 
End if 

