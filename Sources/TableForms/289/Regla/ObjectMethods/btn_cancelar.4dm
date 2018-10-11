If (([ACT_MatricesAsignacionAut:289]nombre:3#"") & ([ACT_MatricesAsignacionAut:289]id_matriz:4#0) & (BLOB size:C605([ACT_MatricesAsignacionAut:289]xConsulta_Asociada:7)>0))
	C_TEXT:C284($t_consulta)
	$t_consulta:=AT_Arrays2Text (";";", ";->atQRY_Conector_Literal;->atQRY_NombreVirtualCampo;->atQRY_Operador_Literal;->atQRY_ValorLiteral)
	If (Is new record:C668([ACT_MatricesAsignacionAut:289]))
		[ACT_MatricesAsignacionAut:289]ID:1:=SQ_SeqNumber (->[ACT_MatricesAsignacionAut:289]ID:1)
		LOG_RegisterEvt ("Creación de regla de asignación automática de matriz de cargo. Regla creada: "+[ACT_MatricesAsignacionAut:289]nombre:3+", id: "+String:C10([ACT_MatricesAsignacionAut:289]ID:1)+", matriz a asignar: "+atACT_NombreMatriz{atACT_NombreMatriz}+", id: "+String:C10([ACT_MatricesAsignacionAut:289]id_matriz:4)+". Consulta: "+$t_consulta+". Estado: "+Choose:C955([ACT_MatricesAsignacionAut:289]Inactiva:5;"Inactiva";"Activa")+".")
	Else 
		If (KRL_FieldChanges (->[ACT_MatricesAsignacionAut:289]nombre:3;->[ACT_MatricesAsignacionAut:289]id_matriz:4;->[ACT_MatricesAsignacionAut:289]xConsulta_Asociada:7;->[ACT_MatricesAsignacionAut:289]Inactiva:5))
			LOG_RegisterEvt ("Modificacion de regla de asignación automática de matriz de cargo. Regla creada: "+[ACT_MatricesAsignacionAut:289]nombre:3+", id: "+String:C10([ACT_MatricesAsignacionAut:289]ID:1)+", matriz a asignar: "+atACT_NombreMatriz{atACT_NombreMatriz}+", id: "+String:C10([ACT_MatricesAsignacionAut:289]id_matriz:4)+". Consulta: "+$t_consulta+". Estado: "+Choose:C955([ACT_MatricesAsignacionAut:289]Inactiva:5;"Inactiva";"Activa")+".")
		End if 
	End if 
	SAVE RECORD:C53([ACT_MatricesAsignacionAut:289])
	
	C_REAL:C285(viACT_AsignarMatAdmision)
	$b_continuar:=True:C214
	If (viACT_AsignarMatAdmision=0)
		ACTcfg_OpcionesListaMatrices ("BuscaCuentas";->[ACT_MatricesAsignacionAut:289]ID:1)
		READ ONLY:C145([Alumnos:2])
		KRL_RelateSelection (->[Alumnos:2]numero:1;->[ACT_CuentasCorrientes:175]ID_Alumno:3;"")
		  //QUERY SELECTION([Alumnos];[Alumnos]Nivel_Número=Nivel_AdmisionDirecta)
		QUERY SELECTION:C341([Alumnos:2];[Alumnos:2]nivel_numero:29=Nivel_AdmisionDirecta;*)  //20170801 RCH
		QUERY SELECTION:C341([Alumnos:2]; | ;[Alumnos:2]nivel_numero:29=Nivel_AdmissionTrack)
		If (Records in selection:C76([Alumnos:2])>0)
			$l_resp:=CD_Dlog (0;"AccountTrack está configurado para no asignar matrices a alumnos en admisión y la regla configurada considera a dichos alumnos."+"\r\r"+"Se recomienda marcar la opción para permitir la asignación de matrices a alumnos en admisión o modificar la regla para no incluir a estos alumnos."+"\r\r"+"¿Desea continuar?";"";"Si";"No")
			If ($l_resp=0)
				$b_continuar:=False:C215
			End if 
		End if 
	End if 
	
	C_LONGINT:C283($l_pos)
	$l_pos:=Find in array:C230(alACT_ReglasMatricesID;[ACT_MatricesAsignacionAut:289]ID:1)
	If ($l_pos>0)
		alACT_ReglasMatricesMatriz{$l_pos}:=[ACT_MatricesAsignacionAut:289]id_matriz:4
	End if 
	
	If ($b_continuar)
		ACCEPT:C269
	End if 
Else 
	Case of 
		: ([ACT_MatricesAsignacionAut:289]nombre:3="")
			CD_Dlog (0;"Ingrese un nombre.")
			
		: ([ACT_MatricesAsignacionAut:289]id_matriz:4=0)
			CD_Dlog (0;"Seleccione una matriz.")
			
		: (BLOB size:C605([ACT_MatricesAsignacionAut:289]xConsulta_Asociada:7)=0)
			CD_Dlog (0;"Edite una consulta.")
	End case 
	BEEP:C151
End if 