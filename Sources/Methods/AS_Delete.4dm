//%attributes = {}
  //AS_Delete


  // Método modificado por ABK 20110827
  // reemplazo de acceso a subtablas de consolidación (via [Asignaturas]Consolidantes por acceso estandar a tabla [Asignaturas_Consolidantes]
  //--------------------------------


C_LONGINT:C283($r;$conNotas;$conInasistencias;$conCompetencias)

$0:=0
If (USR_checkRights ("D";->[Asignaturas:18]))
	MESSAGES OFF:C175
	$id:=[Asignaturas:18]Numero:1
	SET QUERY LIMIT:C395(1)
	
	EV2_RegistrosDeLaAsignatura ([Asignaturas:18]Numero:1)
	QUERY SELECTION:C341([Alumnos_Calificaciones:208];[Alumnos_Calificaciones:208]PeriodosEvaluados_bitField:503>0)
	$conNotas:=Records in selection:C76([Alumnos_Calificaciones:208])
	
	
	SET QUERY DESTINATION:C396(Into variable:K19:4;$conInasistencias)
	QUERY:C277([Asignaturas_Inasistencias:125];[Asignaturas_Inasistencias:125]ID_Asignatura:6=[Asignaturas:18]Numero:1)
	
	SET QUERY DESTINATION:C396(Into variable:K19:4;$conCompetencias)
	QUERY:C277([Alumnos_EvaluacionAprendizajes:203];[Alumnos_EvaluacionAprendizajes:203]ID_Asignatura:1=[Asignaturas:18]Numero:1;*)
	QUERY:C277([Alumnos_EvaluacionAprendizajes:203]; & [Alumnos_EvaluacionAprendizajes:203]PeriodosEvaluados_bitField:63>0)
	
	SET QUERY LIMIT:C395(0)
	SET QUERY DESTINATION:C396(Into current selection:K19:1)
	
	$OKparaEliminar:=True:C214
	If (($conCompetencias+$conInasistencias+$conNotas)=0)
		$r:=CD_Dlog (2;__ ("¿Desea Ud. realmente eliminar esta asignatura?");__ ("");__ ("Cancelar");__ ("Sí. Eliminar"))
		If ($r=1)
			$OKparaEliminar:=False:C215
		Else 
			$OKparaEliminar:=True:C214
		End if 
		
	Else 
		If ($conInasistencias#0)
			$r:=CD_Dlog (2;__ ("Hay inasistencias registradas en esta asignatura.\r¿Esta usted seguro(a) de eliminar esta asignatura?");__ ("");__ ("Cancelar");__ ("Sí. Eliminar"))
			Case of 
				: ($r=1)
					$OKparaEliminar:=False:C215
				: ($r=2)
					$OKparaEliminar:=True:C214
			End case 
		End if 
		
		If (($conCompetencias+$conInasistencias+$conNotas)>0)
			$r:=CD_Dlog (2;__ ("Hay evaluaciones registradas en esta asignatura.\r¿Esta usted seguro(a) de eliminar esta asignatura?");__ ("");__ ("Cancelar");__ ("Si. Eliminar"))
			Case of 
				: ($r=1)
					$OKparaEliminar:=False:C215
				: ($r=2)
					$OKparaEliminar:=True:C214
			End case 
		End if 
	End if 
	
	
	If ($OKparaEliminar)
		$Process:=IT_UThermometer (1;0;__ ("Eliminando asignatura...\rUn momento por favor."))
		$id:=[Asignaturas:18]Numero:1
		START TRANSACTION:C239
		
		EV2_RegistrosDeLaAsignatura ($id)
		$Process:=IT_UThermometer (0;$Process;__ ("Eliminando ")+[Asignaturas:18]denominacion_interna:16+__ (", ")+[Asignaturas:18]Curso:5+__ ("\rUn momento por favor."))
		OK:=KRL_DeleteSelection (->[Alumnos_Calificaciones:208];False:C215)
		If (OK=1)
			OK:=KRL_DeleteSelection (->[Asignaturas_SintesisAnual:202];False:C215)
		End if 
		If (ok=1)
			QUERY:C277([xxSTR_Subasignaturas:83];[xxSTR_Subasignaturas:83]ID_Mother:6=$id)
			OK:=KRL_DeleteSelection (->[xxSTR_Subasignaturas:83];False:C215)
			
			
			SET AUTOMATIC RELATIONS:C310(True:C214)
			QUERY:C277([Asignaturas:18];[Asignaturas_Consolidantes:231]ID_AsignaturaMadre:1;=;$id)
			SET AUTOMATIC RELATIONS:C310(False:C215)
			  //--------------------------------
			
			ARRAY LONGINT:C221($aRecNums;0)
			LONGINT ARRAY FROM SELECTION:C647([Asignaturas:18];$aRecNums;"")
			For ($i;1;Size of array:C274($aRecNums))
				READ WRITE:C146([Asignaturas:18])
				GOTO RECORD:C242([Asignaturas:18];$aRecNums{$i})
				$idParentRecord:=[Asignaturas:18]Numero:1
				
				  //buscabamos las asignaturas que consolidan en la asignatura madre en proceso de eliminación y las descolgamos de la madre
				AScsd_EliminaReferencias ($idParentRecord)
				
				GOTO RECORD:C242([Asignaturas:18];$aRecNums{$i})
				AScsd_LeeReferencias ([Asignaturas:18]Numero:1)
				Case of 
					: (Records in selection:C76([Asignaturas_Consolidantes:231])=0)  //si después de desconectar de la asignatura que se elimina borramos la referencia a la madre (la que eliminamos)
						[Asignaturas:18]Consolidacion_Madre_Id:7:=0
						[Asignaturas:18]Consolidacion_Madre_nombre:8:=""
						[Asignaturas:18]ordenGeneral:105:=Substring:C12([Asignaturas:18]ordenGeneral:105;1;Length:C16([Asignaturas:18]ordenGeneral:105)-3)
						[Asignaturas:18]posicion_en_informes_de_notas:36:=Num:C11(Substring:C12([Asignaturas:18]ordenGeneral:105;1;2))
						SAVE RECORD:C53([Asignaturas:18])
					: (Records in selection:C76([Asignaturas_Consolidantes:231])=1)  //si queda sólo una se asigna a los campos principales de la tabala asignatura
						[Asignaturas:18]Consolidacion_Madre_Id:7:=[Asignaturas_Consolidantes:231]ID_AsignaturaMadre:1
						[Asignaturas:18]Consolidacion_Madre_nombre:8:=[Asignaturas_Consolidantes:231]Name:2
						SAVE RECORD:C53([Asignaturas:18])
					: (Records in selection:C76([Asignaturas_Consolidantes:231])>1)
						[Asignaturas:18]Consolidacion_Madre_Id:7:=-1
						[Asignaturas:18]Consolidacion_Madre_nombre:8:="Varía según período"
						SAVE RECORD:C53([Asignaturas:18])
				End case 
				SAVE RECORD:C53([Asignaturas:18])
			End for 
			
			UNLOAD RECORD:C212([Asignaturas:18])
			READ WRITE:C146([Asignaturas:18])
		End if 
		
		
		OK:=AScsd_EliminaReferencias ($id)
		
		If (ok=1)
			EV2_RegistrosDeLaAsignatura ($id)
			OK:=KRL_DeleteSelection (->[Alumnos_Calificaciones:208];False:C215)
		End if 
		
		If (ok=1)
			QUERY:C277([Asignaturas_Eventos:170];[Asignaturas_Eventos:170]ID_asignatura:1=$id)
			OK:=KRL_DeleteSelection (->[Asignaturas_Eventos:170];False:C215)
		End if 
		If (ok=1)
			QUERY:C277([Asignaturas_PlanesDeClases:169];[Asignaturas_PlanesDeClases:169]ID_Asignatura:2=$id)
			OK:=KRL_DeleteSelection (->[Asignaturas_PlanesDeClases:169];False:C215)
		End if 
		If (ok=1)
			QUERY:C277([Asignaturas_RegistroSesiones:168];[Asignaturas_RegistroSesiones:168]ID_Asignatura:2=$id)
			OK:=KRL_DeleteSelection (->[Asignaturas_RegistroSesiones:168];False:C215)
		End if 
		If (ok=1)
			QUERY:C277([Asignaturas_Inasistencias:125];[Asignaturas_Inasistencias:125]ID_Asignatura:6=$id)
			OK:=KRL_DeleteSelection (->[Asignaturas_Inasistencias:125];False:C215)
		End if 
		If (ok=1)
			QUERY:C277([TMT_Horario:166];[TMT_Horario:166]ID_Asignatura:5=$id)
			OK:=KRL_DeleteSelection (->[TMT_Horario:166];False:C215)
		End if 
		If (ok=1)
			QUERY:C277([Alumnos_EvaluacionAprendizajes:203];[Alumnos_EvaluacionAprendizajes:203]ID_Asignatura:1=$id)
			OK:=KRL_DeleteSelection (->[Alumnos_EvaluacionAprendizajes:203];False:C215)
		End if 
		
		If (OK=1)
			READ WRITE:C146([Asignaturas:18])
			QUERY:C277([Asignaturas:18];[Asignaturas:18]Numero:1=$id)
			LOG_RegisterEvt ("Asignaturas - Eliminación: "+[Asignaturas:18]Asignatura:3+", "+[Asignaturas:18]Curso:5;Table:C252(->[Asignaturas:18]);$id)
			DELETE RECORD:C58([Asignaturas:18])
		End if 
		
		IT_UThermometer (-2;$Process)
		If (oK=1)
			VALIDATE TRANSACTION:C240
			NIV_LoadArrays 
			KRL_ExecuteOnConnectedClients ("NIV_LoadArrays")
		Else 
			CANCEL TRANSACTION:C241
			CD_Dlog (0;__ ("La asignatura no pudo ser eliminada porque algunops registros asociados estaban siendo utilizados en otros procesos o por otros usuarios.\rPor favor inténtelo nuevamente más tarde."))
		End if 
		$0:=OK
	End if 
	
Else 
	USR_ALERT_UserHasNoRights (3;2)
End if 