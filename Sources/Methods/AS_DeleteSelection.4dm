//%attributes = {}
  //AS_DeleteSelection



  // Método modificado por ABK 20110827
  // reemplazo de acceso a subtablas de consolidación (via [Asignaturas]Consolidantes por acceso estandar a tabla [Asignaturas_Consolidantes]
  //--------------------------------




C_LONGINT:C283($r;$conNotas;$conInasistencias;$conCompetencias)
$0:=0
If (USR_checkRights ("D";->[Asignaturas:18]))
	MESSAGES OFF:C175
	SELECTION TO ARRAY:C260([Asignaturas:18]Numero:1;$aIdAsignaturas)
	CREATE SET:C116([Asignaturas:18];"Asignaturas_a_eliminar")
	
	USE SET:C118("Asignaturas_a_eliminar")
	KRL_RelateSelection (->[Alumnos_Calificaciones:208]ID_Asignatura:5;->[Asignaturas:18]Numero:1;"")
	QUERY SELECTION:C341([Alumnos_Calificaciones:208];[Alumnos_Calificaciones:208]Año:3=<>gYear)
	CREATE SET:C116([Alumnos_Calificaciones:208];"Calificaciones")
	
	QUERY SELECTION:C341([Alumnos_Calificaciones:208];[Alumnos_Calificaciones:208]PeriodosEvaluados_bitField:503>0)
	$conNotas:=Records in selection:C76([Alumnos_Calificaciones:208])
	
	USE SET:C118("Asignaturas_a_eliminar")
	KRL_RelateSelection (->[Asignaturas_Inasistencias:125]ID_Asignatura:6;->[Asignaturas:18]Numero:1;"")
	$conInasistencias:=Records in selection:C76([Asignaturas_Inasistencias:125])
	CREATE SET:C116([Asignaturas_Inasistencias:125];"Inasistencias")
	
	USE SET:C118("Asignaturas_a_eliminar")
	KRL_RelateSelection (->[Alumnos_EvaluacionAprendizajes:203]ID_Asignatura:1;->[Asignaturas:18]Numero:1;"")
	CREATE SET:C116([Alumnos_EvaluacionAprendizajes:203];"competencias")
	
	QUERY SELECTION:C341([Alumnos_EvaluacionAprendizajes:203]; & [Alumnos_EvaluacionAprendizajes:203]PeriodosEvaluados_bitField:63>0)
	$conCompetencias:=Records in selection:C76([Alumnos_EvaluacionAprendizajes:203])
	
	
	
	
	$OKparaEliminar:=True:C214
	If (($conCompetencias+$conInasistencias+$conNotas)=0)
		$r:=CD_Dlog (2;__ ("¿Desea Ud. realmente eliminar las asignaturas seleccionadas?");__ ("");__ ("Cancelar");__ ("Sí. Eliminar"))
		If ($r=1)
			$OKparaEliminar:=False:C215
		Else 
			$OKparaEliminar:=True:C214
		End if 
		
	Else 
		If ($conInasistencias#0)
			  //$msg:="Hay inasistencias registradas en ls asignaturas que desea eliminar.\r"+"¿Esta usted seguro(a) de eliminar estas asignaturas?"
			$r:=CD_Dlog (2;__ ("Hay inasistencias registradas en ls asignaturas que desea eliminar.\r¿Esta usted seguro(a) de eliminar estas asignaturas?");__ ("");__ ("Cancelar");__ ("Sí. Eliminar"))
			Case of 
				: ($r=1)
					$OKparaEliminar:=False:C215
				: ($r=2)
					$OKparaEliminar:=True:C214
			End case 
		End if 
		
		If (($conCompetencias+$conInasistencias+$conNotas)>0)
			  //$msg:="Hay evaluaciones registradas en las asignaturas que se dispone a eliminar.\r"+"¿Esta usted seguro(a) de eliminar estas asignaturas?"
			$r:=CD_Dlog (2;__ ("Hay evaluaciones registradas en las asignaturas que se dispone a eliminar.\r¿Esta usted seguro(a) de eliminar estas asignaturas?");__ ("");__ ("Cancelar");__ ("Si. Eliminar"))
			Case of 
				: ($r=1)
					$OKparaEliminar:=False:C215
				: ($r=2)
					$OKparaEliminar:=True:C214
			End case 
		End if 
	End if 
	
	
	If ($OKparaEliminar)
		$Process:=IT_UThermometer (1;0;__ ("Eliminando las asignaturas seleccionadas...\rUn momento por favor."))
		$id:=[Asignaturas:18]Numero:1
		START TRANSACTION:C239
		
		
		  //eliminando calificaciones
		USE SET:C118("Calificaciones")
		CLEAR SET:C117("Calificaciones")
		OK:=1
		If (ok=1)
			OK:=KRL_DeleteSelection (->[Alumnos_Calificaciones:208];False:C215)
		End if 
		
		  //eliminando subasignaturas asociadas
		If (ok=1)
			USE SET:C118("Asignaturas_a_eliminar")
			KRL_RelateSelection (->[xxSTR_Subasignaturas:83]ID_Mother:6;->[Asignaturas:18]Numero:1)
			OK:=KRL_DeleteSelection (->[xxSTR_Subasignaturas:83];False:C215)
		End if 
		
		  //si la asignatura que eliminamos tiene asignaturas hijas, desconectamos sus hijas
		If (OK=1)
			For ($i;1;Size of array:C274($aIdAsignaturas))
				$id:=$aIdAsignaturas{$i}
				
				SET AUTOMATIC RELATIONS:C310(True:C214)
				QUERY:C277([Asignaturas:18];[Asignaturas_Consolidantes:231]ID_AsignaturaMadre:1;=;$id)
				SET AUTOMATIC RELATIONS:C310(False:C215)
				
				ARRAY LONGINT:C221($aRecNums;0)
				LONGINT ARRAY FROM SELECTION:C647([Asignaturas:18];$aRecNums;"")
				For ($i_asignaturasHijas;1;Size of array:C274($aRecNums))
					READ WRITE:C146([Asignaturas:18])
					GOTO RECORD:C242([Asignaturas:18];$aRecNums{$i_asignaturasHijas})
					$idParentRecord:=[Asignaturas:18]Numero:1
					  //buscabamos las asignaturas que consolidan en la asignatura madre en proceso de eliminación y las descolgamos de la madre
					AScsd_EliminaReferencias ($idParentRecord)
					
					GOTO RECORD:C242([Asignaturas:18];$aRecNums{$i_asignaturasHijas})
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
				
			End for 
			UNLOAD RECORD:C212([Asignaturas:18])
		End if 
		
		If (ok=1)
			USE SET:C118("Asignaturas_a_eliminar")
			KRL_RelateSelection (->[Asignaturas_Consolidantes:231]ID_ParentRecord:5;->[Asignaturas:18]Numero:1;"")
			OK:=KRL_DeleteSelection (->[Asignaturas_Consolidantes:231];False:C215)
		End if 
		
		If (ok=1)
			USE SET:C118("Asignaturas_a_eliminar")
			KRL_RelateSelection (->[Asignaturas_Eventos:170]ID_asignatura:1;->[Asignaturas:18]Numero:1;"")
			OK:=KRL_DeleteSelection (->[Asignaturas_Eventos:170];False:C215)
		End if 
		
		If (ok=1)
			USE SET:C118("Asignaturas_a_eliminar")
			KRL_RelateSelection (->[Asignaturas_PlanesDeClases:169]ID_Asignatura:2;->[Asignaturas:18]Numero:1;"")
			OK:=KRL_DeleteSelection (->[Asignaturas_PlanesDeClases:169];False:C215)
		End if 
		
		If (ok=1)
			USE SET:C118("Asignaturas_a_eliminar")
			KRL_RelateSelection (->[Asignaturas_RegistroSesiones:168]ID_Asignatura:2;->[Asignaturas:18]Numero:1;"")
			OK:=KRL_DeleteSelection (->[Asignaturas_RegistroSesiones:168];False:C215)
		End if 
		
		If (ok=1)
			USE SET:C118("Asignaturas_a_eliminar")
			KRL_RelateSelection (->[Asignaturas_Inasistencias:125]ID_Asignatura:6;->[Asignaturas:18]Numero:1;"")
			OK:=KRL_DeleteSelection (->[Asignaturas_Inasistencias:125];False:C215)
		End if 
		
		If (ok=1)
			USE SET:C118("Asignaturas_a_eliminar")
			KRL_RelateSelection (->[TMT_Horario:166]ID_Asignatura:5;->[Asignaturas:18]Numero:1;"")
			OK:=KRL_DeleteSelection (->[TMT_Horario:166];False:C215)
		End if 
		
		If (ok=1)
			USE SET:C118("Asignaturas_a_eliminar")
			KRL_RelateSelection (->[Alumnos_EvaluacionAprendizajes:203]ID_Asignatura:1;->[Asignaturas:18]Numero:1;"")
			OK:=KRL_DeleteSelection (->[Alumnos_EvaluacionAprendizajes:203];False:C215)
		End if 
		
		If (OK=1)
			For ($i;1;Size of array:C274($aIdAsignaturas))
				$id:=$aIdAsignaturas{$i}
				READ WRITE:C146([Asignaturas:18])
				QUERY:C277([Asignaturas:18];[Asignaturas:18]Numero:1=$id)
				LOG_RegisterEvt ("Asignaturas - Eliminación: "+[Asignaturas:18]Asignatura:3+", "+[Asignaturas:18]Curso:5;Table:C252(->[Asignaturas:18]);$id)
				DELETE RECORD:C58([Asignaturas:18])
			End for 
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