//%attributes = {}
  //SN3_BuildSelections


  //`======
  // Modified by: abachler (5/2/10)
vb_ConstantesModificadas:=True:C214
  //`======


$data:=$1
$todos:=True:C214
$useArrays:=False:C215
Case of 
	: (Count parameters:C259=2)
		$todos:=$2
	: (Count parameters:C259=3)
		$todos:=$2
		$useArrays:=$3
	: (Count parameters:C259=4)
		$todos:=$2
		$useArrays:=$3
		$subData:=$4
End case 
MESSAGES OFF:C175
$p:=IT_UThermometer (1;0;__ ("Buscando registros a enviar..."))
Case of 
	: ($data=SN3_DTi_DTrib)
		READ ONLY:C145([ACT_Boletas:181])
		READ ONLY:C145([Alumnos:2])
		READ ONLY:C145([Familia:78])
		READ ONLY:C145([Familia_RelacionesFamiliares:77])
		If ($useArrays)
			$set:="seleccion"+String:C10(Table:C252(->[ACT_Boletas:181]))
			CREATE EMPTY SET:C140([ACT_Boletas:181];$set)
			SET AUTOMATIC RELATIONS:C310(True:C214;False:C215)
			For ($i;1;Size of array:C274(SN3_MasterLevels))
				If (SN3_MasterTipoEnvio{$i})
					QUERY:C277([Alumnos:2];[Alumnos:2]nivel_numero:29=SN3_MasterLevels{$i})
					KRL_RelateSelection (->[Familia:78]Numero:1;->[Alumnos:2]Familia_Número:24;"")
					KRL_RelateSelection (->[Familia_RelacionesFamiliares:77]ID_Familia:2;->[Familia:78]Numero:1;"")
					KRL_RelateSelection (->[ACT_Boletas:181]ID_Apoderado:14;->[Familia_RelacionesFamiliares:77]ID_Persona:3;"")
					QUERY SELECTION:C341([ACT_Boletas:181];[ACT_Boletas:181]Nula:15=False:C215)
				Else 
					ARRAY LONGINT:C221($al_idsDT;0)
					SN3_ManejaReferencias ("buscar";SN3_ACT_DocumentosTributarios;0;SNT_Accion_Actualizar;->$al_idsDT)
					QUERY WITH ARRAY:C644([ACT_Boletas:181]ID:1;$al_idsDT)
					QUERY SELECTION:C341([ACT_Boletas:181];[ACT_Boletas:181]Nula:15=False:C215)
					
					CREATE SET:C116([ACT_Boletas:181];"modificados")
					
					QUERY:C277([Alumnos:2];[Alumnos:2]nivel_numero:29=SN3_MasterLevels{$i})
					KRL_RelateSelection (->[Familia:78]Numero:1;->[Alumnos:2]Familia_Número:24;"")
					KRL_RelateSelection (->[Familia_RelacionesFamiliares:77]ID_Familia:2;->[Familia:78]Numero:1;"")
					KRL_RelateSelection (->[ACT_Boletas:181]ID_Apoderado:14;->[Familia_RelacionesFamiliares:77]ID_Persona:3;"")
					QUERY SELECTION:C341([ACT_Boletas:181];[ACT_Boletas:181]Nula:15=False:C215)
					CREATE SET:C116([ACT_Boletas:181];"todosnivel")
					
					INTERSECTION:C121("modificados";"todosnivel";"tempSelection2")
					USE SET:C118("tempSelection2")
					SET_ClearSets ("modificados";"todosnivel";"tempSelection2")
				End if 
				CREATE SET:C116([ACT_Boletas:181];"tempSelection")
				UNION:C120($set;"tempSelection";$set)
			End for 
			SET AUTOMATIC RELATIONS:C310(False:C215;False:C215)
			USE SET:C118($set)
			SET_ClearSets ($set;"tempSelection")
		Else 
			If ($todos)
				QUERY:C277([ACT_Boletas:181];[ACT_Boletas:181]Nula:15=False:C215)
			Else 
				ARRAY LONGINT:C221($al_idsDT;0)
				SN3_ManejaReferencias ("buscar";SN3_ACT_DocumentosTributarios;0;SNT_Accion_Actualizar;->$al_idsDT)
				QUERY WITH ARRAY:C644([ACT_Boletas:181]ID:1;$al_idsDT)
				QUERY SELECTION:C341([ACT_Boletas:181];[ACT_Boletas:181]Nula:15=False:C215)
			End if 
		End if 
	: ($data=SN3_DTi_EventosAgenda)
		READ ONLY:C145([Asignaturas_Eventos:170])
		$inicio:=PERIODOS_InicioAñoSTrack 
		If ($useArrays)
			$set:="seleccion"+String:C10(Table:C252(->[Asignaturas_Eventos:170]))
			CREATE EMPTY SET:C140([Asignaturas_Eventos:170];$set)
			SET AUTOMATIC RELATIONS:C310(True:C214;False:C215)
			For ($i;1;Size of array:C274(SN3_MasterLevels))
				If (SN3_MasterTipoEnvio{$i})
					QUERY:C277([Asignaturas_Eventos:170];[Asignaturas_Eventos:170]Publicar:5=True:C214;*)
					QUERY:C277([Asignaturas_Eventos:170]; & ;[Asignaturas_Eventos:170]Privado:9=False:C215;*)
					QUERY:C277([Asignaturas_Eventos:170]; & ;[Asignaturas_Eventos:170]Fecha:2>=$inicio;*)
					QUERY:C277([Asignaturas_Eventos:170]; & ;[Asignaturas:18]Numero_del_Nivel:6=SN3_MasterLevels{$i})
				Else 
					ARRAY LONGINT:C221($idArray;0)
					SN3_ManejaReferencias ("buscar";SN3_EventosAgenda;0;SNT_Accion_Actualizar;->$idArray)
					QUERY WITH ARRAY:C644([Asignaturas_Eventos:170]ID_Event:11;$idArray)
					QUERY SELECTION:C341([Asignaturas_Eventos:170];[Asignaturas_Eventos:170]Publicar:5=True:C214;*)
					QUERY SELECTION:C341([Asignaturas_Eventos:170]; & ;[Asignaturas_Eventos:170]Privado:9=False:C215;*)
					QUERY SELECTION:C341([Asignaturas_Eventos:170]; & ;[Asignaturas_Eventos:170]Fecha:2>=$inicio;*)
					QUERY SELECTION:C341([Asignaturas_Eventos:170]; & ;[Asignaturas:18]Numero_del_Nivel:6=SN3_MasterLevels{$i})
				End if 
				CREATE SET:C116([Asignaturas_Eventos:170];"tempSelection")
				UNION:C120($set;"tempSelection";$set)
			End for 
			SET AUTOMATIC RELATIONS:C310(False:C215;False:C215)
			USE SET:C118($set)
			SET_ClearSets ($set;"tempSelection")
		Else 
			If ($todos)
				QUERY:C277([Asignaturas_Eventos:170];[Asignaturas_Eventos:170]Publicar:5=True:C214;*)
				QUERY:C277([Asignaturas_Eventos:170]; & ;[Asignaturas_Eventos:170]Privado:9=False:C215;*)
				QUERY:C277([Asignaturas_Eventos:170]; & ;[Asignaturas_Eventos:170]Fecha:2>=$inicio)
			Else 
				ARRAY LONGINT:C221($idArray;0)
				SN3_ManejaReferencias ("buscar";SN3_EventosAgenda;0;SNT_Accion_Actualizar;->$idArray)
				QUERY WITH ARRAY:C644([Asignaturas_Eventos:170]ID_Event:11;$idArray)
				QUERY SELECTION:C341([Asignaturas_Eventos:170];[Asignaturas_Eventos:170]Publicar:5=True:C214;*)
				QUERY SELECTION:C341([Asignaturas_Eventos:170]; & ;[Asignaturas_Eventos:170]Privado:9=False:C215;*)
				QUERY SELECTION:C341([Asignaturas_Eventos:170]; & ;[Asignaturas_Eventos:170]Fecha:2>=$inicio)
			End if 
		End if 
		SET AUTOMATIC RELATIONS:C310(True:C214;False:C215)
		QUERY SELECTION:C341([Asignaturas_Eventos:170];[Asignaturas:18]Numero_del_Nivel:6<Nivel_Egresados;*)
		QUERY SELECTION:C341([Asignaturas_Eventos:170]; & ;[Asignaturas:18]Numero_del_Nivel:6>Nivel_AdmisionDirecta)
		SET AUTOMATIC RELATIONS:C310(False:C215;False:C215)
	: ($data=SN3_DTi_Calificaciones)
		READ ONLY:C145([Alumnos_Calificaciones:208])
		READ ONLY:C145([Alumnos:2])
		If ($useArrays)
			$set:="seleccion"+String:C10(Table:C252(->[Alumnos_Calificaciones:208]))
			CREATE EMPTY SET:C140([Alumnos_Calificaciones:208];$set)
			SET AUTOMATIC RELATIONS:C310(True:C214;False:C215)
			For ($i;1;Size of array:C274(SN3_MasterLevels))
				If (SN3_MasterTipoEnvio{$i})
					QUERY:C277([Alumnos:2];[Alumnos:2]nivel_numero:29=SN3_MasterLevels{$i})
					KRL_RelateSelection (->[Alumnos_Calificaciones:208]ID_Alumno:6;->[Alumnos:2]numero:1;"")
				Else 
					ARRAY LONGINT:C221($idArray;0)
					SN3_ManejaReferencias ("buscar";SN3_Calificaciones;0;SNT_Accion_Actualizar;->$idArray)
					QUERY WITH ARRAY:C644([Alumnos_Calificaciones:208]ID:506;$idArray)
					QUERY SELECTION:C341([Alumnos_Calificaciones:208];[Alumnos:2]nivel_numero:29=SN3_MasterLevels{$i})
				End if 
				CREATE SET:C116([Alumnos_Calificaciones:208];"tempSelection")
				UNION:C120($set;"tempSelection";$set)
			End for 
			SET AUTOMATIC RELATIONS:C310(False:C215;False:C215)
			USE SET:C118($set)
			SET_ClearSets ($set;"tempSelection")
		Else 
			If ($todos)
				QUERY:C277([Alumnos:2];[Alumnos:2]nivel_numero:29<Nivel_Egresados;*)
				QUERY:C277([Alumnos:2]; & ;[Alumnos:2]nivel_numero:29>Nivel_AdmisionDirecta)
				KRL_RelateSelection (->[Alumnos_Calificaciones:208]ID_Alumno:6;->[Alumnos:2]numero:1;"")
			Else 
				ARRAY LONGINT:C221($idArray;0)
				SN3_ManejaReferencias ("buscar";SN3_Calificaciones;0;SNT_Accion_Actualizar;->$idArray)
				QUERY WITH ARRAY:C644([Alumnos_Calificaciones:208]ID:506;$idArray)
				SET AUTOMATIC RELATIONS:C310(True:C214;False:C215)
				QUERY SELECTION:C341([Alumnos_Calificaciones:208];[Alumnos:2]nivel_numero:29<Nivel_Egresados;*)
				QUERY SELECTION:C341([Alumnos_Calificaciones:208]; & ;[Alumnos:2]nivel_numero:29>Nivel_AdmisionDirecta)
				SET AUTOMATIC RELATIONS:C310(False:C215;False:C215)
			End if 
		End if 
		  //20120426 RCH Se comenta ordenamiento porque en pruebas efectuadas es casi la mitad mas rapido...
		  //SET AUTOMATIC RELATIONS(True;False)
		  //ORDER BY([Alumnos_Calificaciones];[Alumnos]Nivel_Número;>;[Asignaturas]Numero_de_EstiloEvaluacion;>)
		  //SET AUTOMATIC RELATIONS(False;False)
	: ($data=SN3_DTi_Conducta)
		Case of 
			: ($subData=SN3_SDTx_Anotaciones)
				READ ONLY:C145([Alumnos:2])
				READ ONLY:C145([Alumnos_Anotaciones:11])
				If ($useArrays)
					$set:="seleccion"+String:C10(Table:C252(->[Alumnos_Anotaciones:11]))
					CREATE EMPTY SET:C140([Alumnos_Anotaciones:11];$set)
					SET AUTOMATIC RELATIONS:C310(True:C214;False:C215)
					For ($i;1;Size of array:C274(SN3_MasterLevels))
						If (SN3_MasterTipoEnvio{$i})
							QUERY:C277([Alumnos_Anotaciones:11];[Alumnos:2]nivel_numero:29=SN3_MasterLevels{$i};*)
							QUERY:C277([Alumnos_Anotaciones:11]; & ;[Alumnos_Anotaciones:11]Año:11=<>gYear)
						Else 
							ARRAY LONGINT:C221($idArray;0)
							SN3_ManejaReferencias ("buscar";SN3_Anotaciones;0;SNT_Accion_Actualizar;->$idArray)
							QUERY WITH ARRAY:C644([Alumnos_Anotaciones:11]ID:12;$idArray)
							QUERY SELECTION:C341([Alumnos_Anotaciones:11];[Alumnos:2]nivel_numero:29=SN3_MasterLevels{$i};*)
							QUERY SELECTION:C341([Alumnos_Anotaciones:11]; & ;[Alumnos_Anotaciones:11]Año:11=<>gYear)
						End if 
						CREATE SET:C116([Alumnos_Anotaciones:11];"tempSelection")
						UNION:C120($set;"tempSelection";$set)
					End for 
					SET AUTOMATIC RELATIONS:C310(False:C215;False:C215)
					USE SET:C118($set)
					SET_ClearSets ($set;"tempSelection")
				Else 
					If ($todos)
						QUERY:C277([Alumnos_Anotaciones:11];[Alumnos_Anotaciones:11]Año:11=<>gYear)
					Else 
						ARRAY LONGINT:C221($idArray;0)
						SN3_ManejaReferencias ("buscar";SN3_Anotaciones;0;SNT_Accion_Actualizar;->$idArray)
						QUERY WITH ARRAY:C644([Alumnos_Anotaciones:11]ID:12;$idArray)
						QUERY SELECTION:C341([Alumnos_Anotaciones:11];[Alumnos_Anotaciones:11]Año:11=<>gYear)
					End if 
				End if 
				SN3_BuildHeadersSet (->[Alumnos_Anotaciones:11]Alumno_Numero:6;"anotaciones")
			: ($subData=SN3_SDTx_Atrasos)
				READ ONLY:C145([Alumnos:2])
				READ ONLY:C145([Alumnos_Atrasos:55])
				If ($useArrays)
					$set:="seleccion"+String:C10(Table:C252(->[Alumnos_Atrasos:55]))
					CREATE EMPTY SET:C140([Alumnos_Atrasos:55];$set)
					SET AUTOMATIC RELATIONS:C310(True:C214;False:C215)
					For ($i;1;Size of array:C274(SN3_MasterLevels))
						If (SN3_MasterTipoEnvio{$i})
							QUERY:C277([Alumnos_Atrasos:55];[Alumnos:2]nivel_numero:29=SN3_MasterLevels{$i};*)
							QUERY:C277([Alumnos_Atrasos:55]; & ;[Alumnos_Atrasos:55]Año:6=<>gYear)
						Else 
							ARRAY LONGINT:C221($idArray;0)
							SN3_ManejaReferencias ("buscar";SN3_Atrasos;0;SNT_Accion_Actualizar;->$idArray)
							QUERY WITH ARRAY:C644([Alumnos_Atrasos:55]ID:7;$idArray)
							QUERY SELECTION:C341([Alumnos_Atrasos:55];[Alumnos:2]nivel_numero:29=SN3_MasterLevels{$i};*)
							QUERY SELECTION:C341([Alumnos_Atrasos:55]; & ;[Alumnos_Atrasos:55]Año:6=<>gYear)
						End if 
						CREATE SET:C116([Alumnos_Atrasos:55];"tempSelection")
						UNION:C120($set;"tempSelection";$set)
					End for 
					SET AUTOMATIC RELATIONS:C310(False:C215;False:C215)
					USE SET:C118($set)
					SET_ClearSets ($set;"tempSelection")
				Else 
					If ($todos)
						QUERY:C277([Alumnos_Atrasos:55];[Alumnos_Atrasos:55]Año:6=<>gYear)
					Else 
						ARRAY LONGINT:C221($idArray;0)
						SN3_ManejaReferencias ("buscar";SN3_Atrasos;0;SNT_Accion_Actualizar;->$idArray)
						QUERY WITH ARRAY:C644([Alumnos_Atrasos:55]ID:7;$idArray)
						QUERY SELECTION:C341([Alumnos_Atrasos:55];[Alumnos_Atrasos:55]Año:6=<>gYear)
					End if 
				End if 
				SN3_BuildHeadersSet (->[Alumnos_Atrasos:55]Alumno_numero:1;"atrasos")
			: ($subData=SN3_SDTx_Castigos)
				READ ONLY:C145([Alumnos:2])
				READ ONLY:C145([Alumnos_Castigos:9])
				If ($useArrays)
					$set:="seleccion"+String:C10(Table:C252(->[Alumnos_Castigos:9]))
					CREATE EMPTY SET:C140([Alumnos_Castigos:9];$set)
					SET AUTOMATIC RELATIONS:C310(True:C214;False:C215)
					For ($i;1;Size of array:C274(SN3_MasterLevels))
						If (SN3_MasterTipoEnvio{$i})
							QUERY:C277([Alumnos_Castigos:9];[Alumnos:2]nivel_numero:29=SN3_MasterLevels{$i};*)
							QUERY:C277([Alumnos_Castigos:9]; & ;[Alumnos_Castigos:9]Año:5=<>gYear)
						Else 
							ARRAY LONGINT:C221($idArray;0)
							SN3_ManejaReferencias ("buscar";SN3_Castigos;0;SNT_Accion_Actualizar;->$idArray)
							QUERY WITH ARRAY:C644([Alumnos_Castigos:9]ID:10;$idArray)
							QUERY SELECTION:C341([Alumnos_Castigos:9];[Alumnos:2]nivel_numero:29=SN3_MasterLevels{$i};*)
							QUERY SELECTION:C341([Alumnos_Castigos:9]; & ;[Alumnos_Castigos:9]Año:5=<>gYear)
						End if 
						CREATE SET:C116([Alumnos_Castigos:9];"tempSelection")
						UNION:C120($set;"tempSelection";$set)
					End for 
					SET AUTOMATIC RELATIONS:C310(False:C215;False:C215)
					USE SET:C118($set)
					SET_ClearSets ($set;"tempSelection")
				Else 
					If ($todos)
						QUERY:C277([Alumnos_Castigos:9];[Alumnos_Castigos:9]Año:5=<>gYear)
					Else 
						ARRAY LONGINT:C221($idArray;0)
						SN3_ManejaReferencias ("buscar";SN3_Castigos;0;SNT_Accion_Actualizar;->$idArray)
						QUERY WITH ARRAY:C644([Alumnos_Castigos:9]ID:10;$idArray)
						QUERY SELECTION:C341([Alumnos_Castigos:9];[Alumnos_Castigos:9]Año:5=<>gYear)
					End if 
				End if 
				SN3_BuildHeadersSet (->[Alumnos_Castigos:9]Alumno_Numero:8;"castigos")
			: ($subData=SN3_SDTx_InasistDiaria)
				READ ONLY:C145([Alumnos:2])
				READ ONLY:C145([Alumnos_Inasistencias:10])
				If ($useArrays)
					$set:="seleccion"+String:C10(Table:C252(->[Alumnos_Inasistencias:10]))
					CREATE EMPTY SET:C140([Alumnos_Inasistencias:10];$set)
					SET AUTOMATIC RELATIONS:C310(True:C214;False:C215)
					For ($i;1;Size of array:C274(SN3_MasterLevels))
						$nivel:=SN3_MasterLevels{$i}
						If (SN3_MasterTipoEnvio{$i})
							$modoRegistroAsistencia:=KRL_GetNumericFieldData (->[xxSTR_Niveles:6]NoNivel:5;->$nivel;->[xxSTR_Niveles:6]AttendanceMode:3)
							If ($modoRegistroAsistencia=1)
								QUERY:C277([Alumnos_Inasistencias:10];[Alumnos:2]nivel_numero:29=$nivel;*)
								QUERY:C277([Alumnos_Inasistencias:10]; & ;[Alumnos_Inasistencias:10]Año:8=<>gYear)
							End if 
						Else 
							ARRAY LONGINT:C221($idArray;0)
							SN3_ManejaReferencias ("buscar";SN3_Inasistencias;0;SNT_Accion_Actualizar;->$idArray)
							QUERY WITH ARRAY:C644([Alumnos_Inasistencias:10]ID:12;$idArray)
							QUERY SELECTION:C341([Alumnos_Inasistencias:10];[Alumnos:2]nivel_numero:29=$nivel;*)
							QUERY SELECTION:C341([Alumnos_Inasistencias:10]; & ;[Alumnos_Inasistencias:10]Año:8=<>gYear)
						End if 
						CREATE SET:C116([Alumnos_Inasistencias:10];"tempSelection")
						UNION:C120($set;"tempSelection";$set)
					End for 
					SET AUTOMATIC RELATIONS:C310(False:C215;False:C215)
					USE SET:C118($set)
					SET_ClearSets ($set;"tempSelection")
				Else 
					If ($todos)
						ALL RECORDS:C47([Alumnos:2])
						DISTINCT VALUES:C339([Alumnos:2]nivel_numero:29;$al_NivelesConAlumnos)
						QRY_QueryWithArray (->[Alumnos:2]nivel_numero:29;->$al_NivelesConAlumnos)
						ARRAY LONGINT:C221($aNivelesSNConAsistenciaDiaria;0)
						For ($i;1;Size of array:C274($al_NivelesConAlumnos))
							$nivel:=$al_NivelesConAlumnos{$i}
							$modoRegistroAsistencia:=KRL_GetNumericFieldData (->[xxSTR_Niveles:6]NoNivel:5;->$nivel;->[xxSTR_Niveles:6]AttendanceMode:3)
							If ($modoRegistroAsistencia=1)
								APPEND TO ARRAY:C911($aNivelesSNConAsistenciaDiaria;$al_NivelesConAlumnos{$i})
							End if 
						End for 
						QRY_QueryWithArray (->[Alumnos:2]nivel_numero:29;->$aNivelesSNConAsistenciaDiaria)
						KRL_RelateSelection (->[Alumnos_Inasistencias:10]Alumno_Numero:4;->[Alumnos:2]numero:1;"")
					Else 
						ARRAY LONGINT:C221($idArray;0)
						SN3_ManejaReferencias ("buscar";SN3_Inasistencias;0;SNT_Accion_Actualizar;->$idArray)
						QUERY WITH ARRAY:C644([Alumnos_Inasistencias:10]ID:12;$idArray)
					End if 
					QUERY SELECTION:C341([Alumnos_Inasistencias:10];[Alumnos_Inasistencias:10]Año:8=<>gYear)
				End if 
				SN3_BuildHeadersSet (->[Alumnos_Inasistencias:10]Alumno_Numero:4;"inasist1")
			: ($subData=SN3_SDTx_InasistHoraAcumulado)
				READ ONLY:C145([Alumnos:2])
				READ ONLY:C145([Alumnos_ComplementoEvaluacion:209])
				If ($useArrays)
					$set:="seleccion"+String:C10(Table:C252(->[Alumnos_ComplementoEvaluacion:209]))
					CREATE EMPTY SET:C140([Alumnos_ComplementoEvaluacion:209];$set)
					SET AUTOMATIC RELATIONS:C310(True:C214;False:C215)
					For ($i;1;Size of array:C274(SN3_MasterLevels))
						$nivel:=SN3_MasterLevels{$i}
						If (SN3_MasterTipoEnvio{$i})
							$modoRegistroAsistencia:=KRL_GetNumericFieldData (->[xxSTR_Niveles:6]NoNivel:5;->$nivel;->[xxSTR_Niveles:6]AttendanceMode:3)
							If ($modoRegistroAsistencia=4)
								QUERY:C277([Alumnos_ComplementoEvaluacion:209];[Alumnos:2]nivel_numero:29=$nivel;*)
								QUERY:C277([Alumnos_ComplementoEvaluacion:209]; & ;[Alumnos_ComplementoEvaluacion:209]Año:3=<>gYear)
							End if 
						Else 
							ARRAY LONGINT:C221($idArray;0)
							SN3_ManejaReferencias ("buscar";SN3_InasistenciaxHoraAcum;0;SNT_Accion_Actualizar;->$idArray)
							QUERY WITH ARRAY:C644([Alumnos_ComplementoEvaluacion:209]ID:90;$idArray)
							QUERY SELECTION:C341([Alumnos_ComplementoEvaluacion:209];[Alumnos:2]nivel_numero:29=$nivel;*)
							QUERY SELECTION:C341([Alumnos_ComplementoEvaluacion:209]; & ;[Alumnos_ComplementoEvaluacion:209]Año:3=<>gYear)
						End if 
						CREATE SET:C116([Alumnos_ComplementoEvaluacion:209];"tempSelection")
						UNION:C120($set;"tempSelection";$set)
					End for 
					SET AUTOMATIC RELATIONS:C310(False:C215;False:C215)
					USE SET:C118($set)
					SET_ClearSets ($set;"tempSelection")
				Else 
					If ($todos)
						ALL RECORDS:C47([Alumnos:2])
						DISTINCT VALUES:C339([Alumnos:2]nivel_numero:29;$al_NivelesConAlumnos)
						QRY_QueryWithArray (->[Alumnos:2]nivel_numero:29;->$al_NivelesConAlumnos)
						ARRAY LONGINT:C221($aNivelesSNConAsistenciaHAcum;0)
						For ($i;1;Size of array:C274($al_NivelesConAlumnos))
							$nivel:=$al_NivelesConAlumnos{$i}
							$modoRegistroAsistencia:=KRL_GetNumericFieldData (->[xxSTR_Niveles:6]NoNivel:5;->$nivel;->[xxSTR_Niveles:6]AttendanceMode:3)
							If ($modoRegistroAsistencia=4)
								APPEND TO ARRAY:C911($aNivelesSNConAsistenciaHAcum;$al_NivelesConAlumnos{$i})
							End if 
						End for 
						QRY_QueryWithArray (->[Alumnos:2]nivel_numero:29;->$aNivelesSNConAsistenciaHAcum)
						KRL_RelateSelection (->[Alumnos_ComplementoEvaluacion:209]ID_Alumno:6;->[Alumnos:2]numero:1;"")
					Else 
						ARRAY LONGINT:C221($idArray;0)
						SN3_ManejaReferencias ("buscar";SN3_InasistenciaxHoraAcum;0;SNT_Accion_Actualizar;->$idArray)
						QUERY WITH ARRAY:C644([Alumnos_ComplementoEvaluacion:209]ID:90;$idArray)
					End if 
					QUERY SELECTION:C341([Alumnos_ComplementoEvaluacion:209];[Alumnos_ComplementoEvaluacion:209]Año:3=<>gYear)
				End if 
				  //20120426 RCH Se comenta ordenamiento porque en pruebas efectuadas es casi la mitad mas rapido...
				  //SET AUTOMATIC RELATIONS(True;False)
				  //ORDER BY([Alumnos_ComplementoEvaluacion];[Alumnos]Nivel_Número;>)
				  //SET AUTOMATIC RELATIONS(False;False)
				SN3_BuildHeadersSet (->[Alumnos_ComplementoEvaluacion:209]ID_Alumno:6;"inasist2")
			: ($subData=SN3_SDTx_InasistHoraDetalle)
				READ ONLY:C145([Alumnos:2])
				READ ONLY:C145([Asignaturas_Inasistencias:125])
				$inicio:=PERIODOS_InicioAñoSTrack 
				$fin:=PERIODOS_FinAñoPeriodosSTrack 
				If ($useArrays)
					$set:="seleccion"+String:C10(Table:C252(->[Asignaturas_Inasistencias:125]))
					CREATE EMPTY SET:C140([Asignaturas_Inasistencias:125];$set)
					SET AUTOMATIC RELATIONS:C310(True:C214;False:C215)
					For ($i;1;Size of array:C274(SN3_MasterLevels))
						$nivel:=SN3_MasterLevels{$i}
						If (SN3_MasterTipoEnvio{$i})
							$modoRegistroAsistencia:=KRL_GetNumericFieldData (->[xxSTR_Niveles:6]NoNivel:5;->$nivel;->[xxSTR_Niveles:6]AttendanceMode:3)
							If ($modoRegistroAsistencia=2)
								QUERY:C277([Asignaturas_Inasistencias:125];[Alumnos:2]nivel_numero:29=$nivel;*)
								QUERY:C277([Asignaturas_Inasistencias:125]; & ;[Asignaturas_Inasistencias:125]dateSesion:4>=$inicio;*)
								QUERY:C277([Asignaturas_Inasistencias:125]; & ;[Asignaturas_Inasistencias:125]dateSesion:4<=$fin)
							End if 
						Else 
							ARRAY LONGINT:C221($idArray;0)
							SN3_ManejaReferencias ("buscar";SN3_InasistenciaxHoraDetalle;0;SNT_Accion_Actualizar;->$idArray)
							QUERY WITH ARRAY:C644([Asignaturas_Inasistencias:125]ID:10;$idArray)
							QUERY SELECTION:C341([Asignaturas_Inasistencias:125];[Alumnos:2]nivel_numero:29=$nivel;*)
							QUERY SELECTION:C341([Asignaturas_Inasistencias:125]; & ;[Asignaturas_Inasistencias:125]dateSesion:4>=$inicio;*)
							QUERY SELECTION:C341([Asignaturas_Inasistencias:125]; & ;[Asignaturas_Inasistencias:125]dateSesion:4<=$fin)
						End if 
						CREATE SET:C116([Asignaturas_Inasistencias:125];"tempSelection")
						UNION:C120($set;"tempSelection";$set)
					End for 
					SET AUTOMATIC RELATIONS:C310(False:C215;False:C215)
					USE SET:C118($set)
					SET_ClearSets ($set;"tempSelection")
				Else 
					If ($todos)
						ALL RECORDS:C47([Alumnos:2])
						DISTINCT VALUES:C339([Alumnos:2]nivel_numero:29;$al_NivelesConAlumnos)
						QRY_QueryWithArray (->[Alumnos:2]nivel_numero:29;->$al_NivelesConAlumnos)
						ARRAY LONGINT:C221($aNivelesSNConAsistenciaHDetalle;0)
						For ($i;1;Size of array:C274($al_NivelesConAlumnos))
							$nivel:=$al_NivelesConAlumnos{$i}
							$modoRegistroAsistencia:=KRL_GetNumericFieldData (->[xxSTR_Niveles:6]NoNivel:5;->$nivel;->[xxSTR_Niveles:6]AttendanceMode:3)
							If ($modoRegistroAsistencia=2)
								APPEND TO ARRAY:C911($aNivelesSNConAsistenciaHDetalle;$al_NivelesConAlumnos{$i})
							End if 
						End for 
						QRY_QueryWithArray (->[Alumnos:2]nivel_numero:29;->$aNivelesSNConAsistenciaHDetalle)
						KRL_RelateSelection (->[Asignaturas_Inasistencias:125]ID_Alumno:2;->[Alumnos:2]numero:1;"")
					Else 
						ARRAY LONGINT:C221($idArray;0)
						SN3_ManejaReferencias ("buscar";SN3_InasistenciaxHoraDetalle;0;SNT_Accion_Actualizar;->$idArray)
						QUERY WITH ARRAY:C644([Asignaturas_Inasistencias:125]ID:10;$idArray)
					End if 
					QUERY SELECTION:C341([Asignaturas_Inasistencias:125];[Asignaturas_Inasistencias:125]dateSesion:4>=$inicio;*)
					QUERY SELECTION:C341([Asignaturas_Inasistencias:125]; & ;[Asignaturas_Inasistencias:125]dateSesion:4<=$fin)
				End if 
				SN3_BuildHeadersSet (->[Asignaturas_Inasistencias:125]ID_Alumno:2;"inasist3")
			: ($subData=SN3_SDTx_Suspensiones)
				READ ONLY:C145([Alumnos:2])
				READ ONLY:C145([Alumnos_Suspensiones:12])
				If ($useArrays)
					$set:="seleccion"+String:C10(Table:C252(->[Alumnos_Suspensiones:12]))
					CREATE EMPTY SET:C140([Alumnos_Suspensiones:12];$set)
					SET AUTOMATIC RELATIONS:C310(True:C214;False:C215)
					For ($i;1;Size of array:C274(SN3_MasterLevels))
						$nivel:=SN3_MasterLevels{$i}
						If (SN3_MasterTipoEnvio{$i})
							QUERY:C277([Alumnos_Suspensiones:12];[Alumnos:2]nivel_numero:29=SN3_MasterLevels{$i})
						Else 
							ARRAY LONGINT:C221($idArray;0)
							SN3_ManejaReferencias ("buscar";10104;0;SNT_Accion_Actualizar;->$idArray)  // 10104=SNT_Suspensiones
							QUERY WITH ARRAY:C644([Alumnos_Suspensiones:12]ID:9;$idArray)
							QUERY SELECTION:C341([Alumnos_Suspensiones:12];[Alumnos:2]nivel_numero:29=SN3_MasterLevels{$i})
						End if 
						QUERY SELECTION:C341([Alumnos_Suspensiones:12];[Alumnos_Suspensiones:12]Año:1=<>gYear)
						CREATE SET:C116([Alumnos_Suspensiones:12];"tempSelection")
						UNION:C120($set;"tempSelection";$set)
					End for 
					SET AUTOMATIC RELATIONS:C310(False:C215;False:C215)
					USE SET:C118($set)
					SET_ClearSets ($set;"tempSelection")
				Else 
					If ($todos)
						QUERY:C277([Alumnos_Suspensiones:12];[Alumnos_Suspensiones:12]Año:1=<>gYear)
					Else 
						ARRAY LONGINT:C221($idArray;0)
						SN3_ManejaReferencias ("buscar";10104;0;SNT_Accion_Actualizar;->$idArray)  // 10104=SNT_Suspensiones
						QUERY WITH ARRAY:C644([Alumnos_Suspensiones:12]ID:9;$idArray)
						QUERY SELECTION:C341([Alumnos_Suspensiones:12];[Alumnos_Suspensiones:12]Año:1=<>gYear)
					End if 
				End if 
				SN3_BuildHeadersSet (->[Alumnos_Suspensiones:12]Alumno_Numero:7;"suspensiones")
			: ($subData=SN3_SDTx_Condicionalidad)
				READ ONLY:C145([Alumnos:2])
				If ($useArrays)
					$set:="seleccion"+String:C10(Table:C252(->[Alumnos:2]))
					CREATE EMPTY SET:C140([Alumnos:2];$set)
					For ($i;1;Size of array:C274(SN3_MasterLevels))
						If (SN3_MasterTipoEnvio{$i})
							QUERY:C277([Alumnos:2];[Alumnos:2]nivel_numero:29=SN3_MasterLevels{$i})
						Else 
							ARRAY LONGINT:C221($idArray;0)
							SN3_ManejaReferencias ("buscar";10108;0;SNT_Accion_Actualizar;->$idArray)  //10108=SNT_Condicionalidad
							QUERY WITH ARRAY:C644([Alumnos:2]numero:1;$idArray)
							QUERY SELECTION:C341([Alumnos:2];[Alumnos:2]nivel_numero:29=SN3_MasterLevels{$i})
						End if 
						CREATE SET:C116([Alumnos:2];"tempSelection")
						UNION:C120($set;"tempSelection";$set)
					End for 
					USE SET:C118($set)
					SET_ClearSets ($set;"tempSelection")
				Else 
					If ($todos)
						QUERY:C277([Alumnos:2];[Alumnos:2]nivel_numero:29<Nivel_Egresados;*)
						QUERY:C277([Alumnos:2]; & ;[Alumnos:2]nivel_numero:29>Nivel_AdmisionDirecta)
					Else 
						ARRAY LONGINT:C221($idArray;0)
						SN3_ManejaReferencias ("buscar";10108;0;SNT_Accion_Actualizar;->$idArray)  //10108=SNT_Condicionalidad
						QUERY WITH ARRAY:C644([Alumnos:2]numero:1;$idArray)
						QUERY SELECTION:C341([Alumnos:2];[Alumnos:2]nivel_numero:29<Nivel_Egresados;*)
						QUERY SELECTION:C341([Alumnos:2]; & ;[Alumnos:2]nivel_numero:29>Nivel_AdmisionDirecta)
					End if 
				End if 
			: ($subData=-9)  //MONO TICKET 209421 PARA LOS REGISTROS DE SINTESIS ANUAL DONDE ESTAN LAS FALTAS POR ATRASOS
				
				READ ONLY:C145([Alumnos_SintesisAnual:210])
				If ($useArrays)
					$set:="seleccion"+String:C10(Table:C252(->[Alumnos_SintesisAnual:210]))
					CREATE EMPTY SET:C140([Alumnos_SintesisAnual:210];$set)
					For ($i;1;Size of array:C274(SN3_MasterLevels))
						If (SN3_MasterTipoEnvio{$i})
							QUERY:C277([Alumnos_SintesisAnual:210];[Alumnos_SintesisAnual:210]NumeroNivel:6=SN3_MasterLevels{$i};*)
							QUERY:C277([Alumnos_SintesisAnual:210]; & ;[Alumnos_SintesisAnual:210]ID_Alumno:4>0)
						Else 
							ARRAY LONGINT:C221($idArray;0)
							SN3_ManejaReferencias ("buscar";101055;0;SNT_Accion_Actualizar;->$idArray)
							QUERY WITH ARRAY:C644([Alumnos_SintesisAnual:210]ID_Alumno:4;$idArray)
							QUERY SELECTION:C341([Alumnos_SintesisAnual:210];[Alumnos_SintesisAnual:210]NumeroNivel:6=SN3_MasterLevels{$i})
						End if 
						CREATE SET:C116([Alumnos_SintesisAnual:210];"tempSelection")
						UNION:C120($set;"tempSelection";$set)
					End for 
					USE SET:C118($set)
					SET_ClearSets ($set;"tempSelection")
				Else 
					If ($todos)
						QUERY:C277([Alumnos_SintesisAnual:210];[Alumnos_SintesisAnual:210]ID_Alumno:4>0)
					Else 
						ARRAY LONGINT:C221($idArray;0)
						SN3_ManejaReferencias ("buscar";101055;0;SNT_Accion_Actualizar;->$idArray)
						QUERY WITH ARRAY:C644([Alumnos_SintesisAnual:210]ID_Alumno:4;$idArray)
					End if 
				End if 
				
		End case 
	: ($data=SN3_DTi_Companeros)
		
	: ($data=SN3_DTi_Horarios)
		READ ONLY:C145([Alumnos:2])
		READ ONLY:C145([TMT_Horario:166])
		If ($useArrays)
			ARRAY LONGINT:C221($idArray;0)
			SN3_ManejaReferencias ("buscar";SN3_Horarios;0;SNT_Accion_Actualizar;->$idArray)
			QUERY WITH ARRAY:C644([TMT_Horario:166]ID:15;$idArray)
			CREATE SET:C116([TMT_Horario:166];"horariosmodificados")
			CREATE EMPTY SET:C140([TMT_Horario:166];"horarios")
			For ($i;1;Size of array:C274(SN3_MasterLevels))
				QUERY:C277([Alumnos:2];[Alumnos:2]nivel_numero:29=SN3_MasterLevels{$i})
				KRL_RelateSelection (->[Alumnos_Calificaciones:208]ID_Alumno:6;->[Alumnos:2]numero:1;"")
				QUERY SELECTION:C341([Alumnos_Calificaciones:208];[Alumnos_Calificaciones:208]Año:3=<>gYear)
				KRL_RelateSelection (->[TMT_Horario:166]ID_Asignatura:5;->[Alumnos_Calificaciones:208]ID_Asignatura:5;"")
				If (Not:C34(SN3_MasterTipoEnvio{$i}))  //Solo modificados
					CREATE SET:C116([TMT_Horario:166];"todosnivel")
					INTERSECTION:C121("todosnivel";"horariosmodificados";"temp")
				Else 
					CREATE SET:C116([TMT_Horario:166];"temp")
				End if 
				UNION:C120("temp";"horarios";"horarios")
			End for 
			USE SET:C118("horarios")
			SET_ClearSets ("horariosmodificados";"todosnivel";"horarios";"temp")
		Else 
			If ($todos)
				QUERY:C277([Alumnos:2];[Alumnos:2]nivel_numero:29<Nivel_Egresados;*)
				QUERY:C277([Alumnos:2]; & ;[Alumnos:2]nivel_numero:29>Nivel_AdmisionDirecta)
				KRL_RelateSelection (->[Alumnos_Calificaciones:208]ID_Alumno:6;->[Alumnos:2]numero:1;"")
				QUERY SELECTION:C341([Alumnos_Calificaciones:208];[Alumnos_Calificaciones:208]Año:3=<>gYear)
				KRL_RelateSelection (->[TMT_Horario:166]ID_Asignatura:5;->[Alumnos_Calificaciones:208]ID_Asignatura:5;"")
			Else 
				ARRAY LONGINT:C221($idArray;0)
				SN3_ManejaReferencias ("buscar";SN3_Horarios;0;SNT_Accion_Actualizar;->$idArray)
				QUERY WITH ARRAY:C644([TMT_Horario:166]ID:15;$idArray)
			End if 
		End if 
	: ($data=SN3_DTi_Observaciones)
		Case of 
			: ($subData=SN3_SDTx_Asignatura)
				READ ONLY:C145([Alumnos:2])
				READ ONLY:C145([Alumnos_ComplementoEvaluacion:209])
				If ($useArrays)
					$set:="seleccion"+String:C10(Table:C252(->[Alumnos_ComplementoEvaluacion:209]))
					CREATE EMPTY SET:C140([Alumnos_ComplementoEvaluacion:209];$set)
					SET AUTOMATIC RELATIONS:C310(True:C214;False:C215)
					For ($i;1;Size of array:C274(SN3_MasterLevels))
						If (SN3_MasterTipoEnvio{$i})
							QUERY:C277([Alumnos_ComplementoEvaluacion:209];[Alumnos:2]nivel_numero:29=SN3_MasterLevels{$i};*)
							QUERY:C277([Alumnos_ComplementoEvaluacion:209]; & ;[Alumnos_ComplementoEvaluacion:209]Año:3=<>gYear)
						Else 
							ARRAY LONGINT:C221($idArray;0)
							SN3_ManejaReferencias ("buscar";SN3_ObsAsignatura;0;SNT_Accion_Actualizar;->$idArray)
							QUERY WITH ARRAY:C644([Alumnos_ComplementoEvaluacion:209]ID:90;$idArray)
							QUERY SELECTION:C341([Alumnos_ComplementoEvaluacion:209];[Alumnos:2]nivel_numero:29=SN3_MasterLevels{$i};*)
							QUERY SELECTION:C341([Alumnos_ComplementoEvaluacion:209]; & ;[Alumnos_ComplementoEvaluacion:209]Año:3=<>gYear)
						End if 
						CREATE SET:C116([Alumnos_ComplementoEvaluacion:209];"tempSelection")
						UNION:C120($set;"tempSelection";$set)
					End for 
					SET AUTOMATIC RELATIONS:C310(False:C215;False:C215)
					USE SET:C118($set)
					SET_ClearSets ($set;"tempSelection")
				Else 
					If ($todos)
						QUERY:C277([Alumnos_ComplementoEvaluacion:209];[Alumnos_ComplementoEvaluacion:209]Año:3=<>gYear)
					Else 
						ARRAY LONGINT:C221($idArray;0)
						SN3_ManejaReferencias ("buscar";SN3_ObsAsignatura;0;SNT_Accion_Actualizar;->$idArray)
						QUERY WITH ARRAY:C644([Alumnos_ComplementoEvaluacion:209]ID:90;$idArray)
						QUERY SELECTION:C341([Alumnos_ComplementoEvaluacion:209];[Alumnos_ComplementoEvaluacion:209]Año:3=<>gYear)
					End if 
				End if 
				  //20120426 RCH Se comenta ordenamiento porque en pruebas efectuadas es casi la mitad mas rapido...
				  //SET AUTOMATIC RELATIONS(True;False)
				  //ORDER BY([Alumnos_ComplementoEvaluacion];[Alumnos]Nivel_Número;>)
				  //SET AUTOMATIC RELATIONS(False;False)
			: ($subdata=SN3_SDTx_ProfesorJefe)
				READ ONLY:C145([Alumnos:2])
				READ ONLY:C145([Cursos:3])
				READ ONLY:C145([Alumnos_SintesisAnual:210])
				If ($useArrays)
					$set:="seleccion"+String:C10(Table:C252(->[Alumnos_SintesisAnual:210]))
					CREATE EMPTY SET:C140([Alumnos_SintesisAnual:210];$set)
					SET AUTOMATIC RELATIONS:C310(True:C214;False:C215)
					For ($i;1;Size of array:C274(SN3_MasterLevels))
						If (SN3_MasterTipoEnvio{$i})
							  //QUERY([Alumnos_SintesisAnual];[Alumnos]Nivel_Número=SN3_MasterLevels{$i};*)
							  //QUERY([Alumnos_SintesisAnual]; & ;[Alumnos_SintesisAnual]Año=<>gYear)
							QUERY:C277([Alumnos:2];[Alumnos:2]nivel_numero:29=SN3_MasterLevels{$i})
							KRL_RelateSelection (->[Alumnos_SintesisAnual:210]LlavePrincipal:5;->[Alumnos:2]LlaveRegistroCicloActual:76;"")
						Else 
							ARRAY LONGINT:C221($idArray;0)
							SN3_ManejaReferencias ("buscar";SN3_ObsJefatura;0;SNT_Accion_Actualizar;->$idArray)
							QUERY WITH ARRAY:C644([Alumnos_SintesisAnual:210]ID:267;$idArray)
							QUERY SELECTION:C341([Alumnos_SintesisAnual:210];[Alumnos:2]nivel_numero:29=SN3_MasterLevels{$i};*)
							QUERY SELECTION:C341([Alumnos_SintesisAnual:210]; & ;[Alumnos_SintesisAnual:210]Año:2=<>gYear)
						End if 
						CREATE SET:C116([Alumnos_SintesisAnual:210];"tempSelection")
						UNION:C120($set;"tempSelection";$set)
					End for 
					SET AUTOMATIC RELATIONS:C310(False:C215;False:C215)
					USE SET:C118($set)
					SET_ClearSets ($set;"tempSelection")
				Else 
					If ($todos)
						  //QUERY([Alumnos_SintesisAnual];[Alumnos_SintesisAnual]Año=<>gYear)
						QUERY:C277([Alumnos:2];[Alumnos:2]nivel_numero:29<Nivel_Egresados;*)
						QUERY:C277([Alumnos:2]; & ;[Alumnos:2]nivel_numero:29>Nivel_AdmisionDirecta)
						KRL_RelateSelection (->[Alumnos_SintesisAnual:210]LlavePrincipal:5;->[Alumnos:2]LlaveRegistroCicloActual:76;"")
					Else 
						ARRAY LONGINT:C221($idArray;0)
						SN3_ManejaReferencias ("buscar";SN3_ObsJefatura;0;SNT_Accion_Actualizar;->$idArray)
						QUERY WITH ARRAY:C644([Alumnos_SintesisAnual:210]ID:267;$idArray)
						QUERY SELECTION:C341([Alumnos_SintesisAnual:210];[Alumnos_SintesisAnual:210]Año:2=<>gYear)
					End if 
				End if 
				  //20120426 RCH Se comenta ordenamiento porque en pruebas efectuadas es casi la mitad mas rapido...
				  //SET AUTOMATIC RELATIONS(True;False)
				  //ORDER BY([Alumnos_SintesisAnual];[Alumnos]Nivel_Número;>;[Alumnos]Curso;>)
				  //SET AUTOMATIC RELATIONS(False;False)
		End case 
	: ($data=SN3_DTi_Salud)
		Case of 
			: ($subData=SN3_SDTx_EventosEnfermeria)
				READ ONLY:C145([Alumnos:2])
				READ ONLY:C145([Alumnos_EventosEnfermeria:14])
				If ($useArrays)
					$set:="seleccion"+String:C10(Table:C252(->[Alumnos_EventosEnfermeria:14]))
					CREATE EMPTY SET:C140([Alumnos_EventosEnfermeria:14];$set)
					SET AUTOMATIC RELATIONS:C310(True:C214;False:C215)
					For ($i;1;Size of array:C274(SN3_MasterLevels))
						If (SN3_MasterTipoEnvio{$i})
							QUERY:C277([Alumnos_EventosEnfermeria:14];[Alumnos:2]nivel_numero:29=SN3_MasterLevels{$i})
						Else 
							ARRAY LONGINT:C221($idArray;0)
							SN3_ManejaReferencias ("buscar";SN3_EventosEnfermeria;0;SNT_Accion_Actualizar;->$idArray)
							QRY_QueryWithArray (->[Alumnos_EventosEnfermeria:14]ID:15;->$idArray)
							QUERY SELECTION:C341([Alumnos_EventosEnfermeria:14];[Alumnos:2]nivel_numero:29=SN3_MasterLevels{$i})
						End if 
						CREATE SET:C116([Alumnos_EventosEnfermeria:14];"tempSelection")
						UNION:C120($set;"tempSelection";$set)
					End for 
					SET AUTOMATIC RELATIONS:C310(False:C215;False:C215)
					USE SET:C118($set)
					SET_ClearSets ($set;"tempSelection")
				Else 
					If ($todos)
						ALL RECORDS:C47([Alumnos_EventosEnfermeria:14])
					Else 
						ARRAY LONGINT:C221($idArray;0)
						SN3_ManejaReferencias ("buscar";SN3_EventosEnfermeria;0;SNT_Accion_Actualizar;->$idArray)
						QRY_QueryWithArray (->[Alumnos_EventosEnfermeria:14]ID:15;->$idArray)
					End if 
				End if 
			: ($subData=SN3_SDTx_ControlesMedicos)
				READ ONLY:C145([Alumnos_ControlesMedicos:99])
				If ($useArrays)
					$set:="seleccion"+String:C10(Table:C252(->[Alumnos_ControlesMedicos:99]))
					CREATE EMPTY SET:C140([Alumnos_ControlesMedicos:99];$set)
					SET AUTOMATIC RELATIONS:C310(True:C214;False:C215)
					For ($i;1;Size of array:C274(SN3_MasterLevels))
						If (SN3_MasterTipoEnvio{$i})
							QUERY:C277([Alumnos_ControlesMedicos:99];[Alumnos:2]nivel_numero:29=SN3_MasterLevels{$i})
						Else 
							ARRAY LONGINT:C221($idArray;0)
							SN3_ManejaReferencias ("buscar";SN3_ControlesMedicos;0;SNT_Accion_Actualizar;->$idArray)
							QRY_QueryWithArray (->[Alumnos_ControlesMedicos:99]ID:9;->$idArray)
							QUERY SELECTION:C341([Alumnos_ControlesMedicos:99];[Alumnos:2]nivel_numero:29=SN3_MasterLevels{$i})
						End if 
						CREATE SET:C116([Alumnos_ControlesMedicos:99];"tempSelection")
						UNION:C120($set;"tempSelection";$set)
					End for 
					SET AUTOMATIC RELATIONS:C310(False:C215;False:C215)
					USE SET:C118($set)
					SET_ClearSets ($set;"tempSelection")
				Else 
					If ($todos)
						ALL RECORDS:C47([Alumnos_ControlesMedicos:99])
					Else 
						ARRAY LONGINT:C221($idArray;0)
						SN3_ManejaReferencias ("buscar";SN3_ControlesMedicos;0;SNT_Accion_Actualizar;->$idArray)
						QRY_QueryWithArray (->[Alumnos_ControlesMedicos:99]ID:9;->$idArray)
					End if 
				End if 
		End case 
	: ($data=SN3_DTi_PlanesClase)
		Case of 
			: ($subData=SN3_SDTx_Planes)
				READ ONLY:C145([Asignaturas:18])
				READ ONLY:C145([Asignaturas_PlanesDeClases:169])
				$inicio:=PERIODOS_InicioAñoSTrack 
				If ($useArrays)
					$set:="seleccion"+String:C10(Table:C252(->[Asignaturas_PlanesDeClases:169]))
					CREATE EMPTY SET:C140([Asignaturas_PlanesDeClases:169];$set)
					For ($i;1;Size of array:C274(SN3_MasterLevels))
						If (SN3_MasterTipoEnvio{$i})
							QUERY:C277([Asignaturas:18];[Asignaturas:18]Numero_del_Nivel:6=SN3_MasterLevels{$i})
							KRL_RelateSelection (->[Asignaturas_PlanesDeClases:169]ID_Asignatura:2;->[Asignaturas:18]Numero:1;"")
							QUERY SELECTION:C341([Asignaturas_PlanesDeClases:169];[Asignaturas_PlanesDeClases:169]Desde:3>=$inicio)
						Else 
							ARRAY LONGINT:C221($idArray;0)
							SN3_ManejaReferencias ("buscar";SN3_PlanesDeClase;0;SNT_Accion_Actualizar;->$idArray)
							QUERY WITH ARRAY:C644([Asignaturas_PlanesDeClases:169]ID_Plan:1;$idArray)
							QUERY SELECTION:C341([Asignaturas_PlanesDeClases:169];[Asignaturas_PlanesDeClases:169]Desde:3>=$inicio)
							CREATE SET:C116([Asignaturas_PlanesDeClases:169];"modificadas")
							QUERY:C277([Asignaturas:18];[Asignaturas:18]Numero_del_Nivel:6=SN3_MasterLevels{$i})
							KRL_RelateSelection (->[Asignaturas_PlanesDeClases:169]ID_Asignatura:2;->[Asignaturas:18]Numero:1;"")
							QUERY SELECTION:C341([Asignaturas_PlanesDeClases:169];[Asignaturas_PlanesDeClases:169]Desde:3>=$inicio)
							CREATE SET:C116([Asignaturas_PlanesDeClases:169];"nivel")
							INTERSECTION:C121("modificadas";"nivel";"tempSelection2")
							USE SET:C118("tempSelection2")
							SET_ClearSets ("modificadas";"nivel";"tempSelection2")
						End if 
						CREATE SET:C116([Asignaturas_PlanesDeClases:169];"tempSelection")
						UNION:C120($set;"tempSelection";$set)
					End for 
					USE SET:C118($set)
					SET_ClearSets ($set;"tempSelection")
				Else 
					If ($todos)
						QUERY:C277([Asignaturas_PlanesDeClases:169];[Asignaturas_PlanesDeClases:169]Desde:3>=$inicio)
					Else 
						ARRAY LONGINT:C221($idArray;0)
						SN3_ManejaReferencias ("buscar";SN3_PlanesDeClase;0;SNT_Accion_Actualizar;->$idArray)
						QUERY WITH ARRAY:C644([Asignaturas_PlanesDeClases:169]ID_Plan:1;$idArray)
						QUERY SELECTION:C341([Asignaturas_PlanesDeClases:169];[Asignaturas_PlanesDeClases:169]Desde:3>=$inicio)
					End if 
				End if 
			: ($subData=SN3_SDTx_Referencias)
				READ ONLY:C145([Asignaturas:18])
				READ ONLY:C145([Asignaturas_PlanesDeClases:169])
				READ ONLY:C145([xShell_Documents:91])
				$inicio:=PERIODOS_InicioAñoSTrack 
				If ($useArrays)
					$set:="seleccion"+String:C10(Table:C252(->[xShell_Documents:91]))
					CREATE EMPTY SET:C140([xShell_Documents:91];$set)
					SET AUTOMATIC RELATIONS:C310(True:C214;False:C215)
					For ($i;1;Size of array:C274(SN3_MasterLevels))
						If (SN3_MasterTipoEnvio{$i})
							QUERY:C277([Asignaturas_PlanesDeClases:169];[Asignaturas:18]Numero_del_Nivel:6=SN3_MasterLevels{$i};*)
							QUERY:C277([Asignaturas_PlanesDeClases:169]; & ;[Asignaturas_PlanesDeClases:169]Desde:3>=$inicio)
							KRL_RelateSelection (->[xShell_Documents:91]RelatedID:2;->[Asignaturas_PlanesDeClases:169]ID_Plan:1;"")
							QUERY SELECTION:C341([xShell_Documents:91];[xShell_Documents:91]RelatedTable:1=(Table:C252(->[Asignaturas_PlanesDeClases:169])))
						Else 
							ARRAY LONGINT:C221($idArray;0)
							SN3_ManejaReferencias ("buscar";SN3_Documentos;0;SNT_Accion_Actualizar;->$idArray)
							QUERY WITH ARRAY:C644([xShell_Documents:91]DocID:9;$idArray)
							CREATE SET:C116([xShell_Documents:91];"modificadas")
							QUERY:C277([Asignaturas_PlanesDeClases:169];[Asignaturas:18]Numero_del_Nivel:6=SN3_MasterLevels{$i};*)
							QUERY:C277([Asignaturas_PlanesDeClases:169]; & ;[Asignaturas_PlanesDeClases:169]Desde:3>=$inicio)
							KRL_RelateSelection (->[xShell_Documents:91]RelatedID:2;->[Asignaturas_PlanesDeClases:169]ID_Plan:1;"")
							QUERY SELECTION:C341([xShell_Documents:91];[xShell_Documents:91]RelatedTable:1=(Table:C252(->[Asignaturas_PlanesDeClases:169])))
							CREATE SET:C116([xShell_Documents:91];"esteyear")
							INTERSECTION:C121("modificadas";"esteyear";"tempSelection2")
							USE SET:C118("tempSelection2")
							SET_ClearSets ("modificadas";"esteyear";"tempSelection2")
						End if 
						CREATE SET:C116([xShell_Documents:91];"tempSelection")
						UNION:C120($set;"tempSelection";$set)
					End for 
					SET AUTOMATIC RELATIONS:C310(False:C215;False:C215)
					USE SET:C118($set)
					SET_ClearSets ($set;"tempSelection")
				Else 
					If ($todos)
						QUERY:C277([Asignaturas_PlanesDeClases:169];[Asignaturas_PlanesDeClases:169]Desde:3>=$inicio)
						KRL_RelateSelection (->[xShell_Documents:91]RelatedID:2;->[Asignaturas_PlanesDeClases:169]ID_Plan:1;"")
						QUERY SELECTION:C341([xShell_Documents:91];[xShell_Documents:91]RelatedTable:1=(Table:C252(->[Asignaturas_PlanesDeClases:169])))
					Else 
						ARRAY LONGINT:C221($idArray;0)
						SN3_ManejaReferencias ("buscar";SN3_Documentos;0;SNT_Accion_Actualizar;->$idArray)
						QUERY WITH ARRAY:C644([xShell_Documents:91]DocID:9;$idArray)
						CREATE SET:C116([xShell_Documents:91];"modificadas")
						QUERY:C277([Asignaturas_PlanesDeClases:169];[Asignaturas_PlanesDeClases:169]Desde:3>=$inicio)
						KRL_RelateSelection (->[xShell_Documents:91]RelatedID:2;->[Asignaturas_PlanesDeClases:169]ID_Plan:1;"")
						QUERY SELECTION:C341([xShell_Documents:91];[xShell_Documents:91]RelatedTable:1=(Table:C252(->[Asignaturas_PlanesDeClases:169]));*)
						CREATE SET:C116([xShell_Documents:91];"esteyear")
						INTERSECTION:C121("modificadas";"esteyear";"tempSelection2")
						USE SET:C118("tempSelection2")
						SET_ClearSets ("modificadas";"esteyear";"tempSelection2")
					End if 
				End if 
				QUERY SELECTION:C341([xShell_Documents:91];[xShell_Documents:91]URL:11#"http://")
				QUERY SELECTION:C341([xShell_Documents:91];[xShell_Documents:91]DocumentName:3#"";*)
				QUERY SELECTION:C341([xShell_Documents:91]; | ;[xShell_Documents:91]URL:11#"")
				QUERY SELECTION:C341([xShell_Documents:91];[xShell_Documents:91]RefType:10#"HLPR")
		End case 
	: ($data=SN3_DTi_CalificacionesMPA)
		READ ONLY:C145([Alumnos_EvaluacionAprendizajes:203])
		If ($useArrays)
			$set:="seleccion"+String:C10(Table:C252(->[Alumnos_EvaluacionAprendizajes:203]))
			CREATE EMPTY SET:C140([Alumnos_EvaluacionAprendizajes:203];$set)
			SET AUTOMATIC RELATIONS:C310(True:C214;False:C215)
			For ($i;1;Size of array:C274(SN3_MasterLevels))
				If (SN3_MasterTipoEnvio{$i})
					QUERY:C277([Alumnos_EvaluacionAprendizajes:203];[Alumnos:2]nivel_numero:29=SN3_MasterLevels{$i})
				Else 
					ARRAY LONGINT:C221($idArray;0)
					SN3_ManejaReferencias ("buscar";SN3_Aprendizajes_Evaluacion;0;SNT_Accion_Actualizar;->$idArray)
					QUERY WITH ARRAY:C644([Alumnos_EvaluacionAprendizajes:203]ID:90;$idArray)
					QUERY SELECTION:C341([Alumnos_EvaluacionAprendizajes:203];[Alumnos:2]nivel_numero:29=SN3_MasterLevels{$i})
				End if 
				CREATE SET:C116([Alumnos_EvaluacionAprendizajes:203];"tempSelection")
				UNION:C120($set;"tempSelection";$set)
			End for 
			SET AUTOMATIC RELATIONS:C310(False:C215;False:C215)
			USE SET:C118($set)
			SET_ClearSets ($set;"tempSelection")
		Else 
			If ($todos)
				QUERY:C277([Alumnos:2];[Alumnos:2]nivel_numero:29<Nivel_Egresados;*)
				QUERY:C277([Alumnos:2]; & ;[Alumnos:2]nivel_numero:29>Nivel_AdmisionDirecta)
				KRL_RelateSelection (->[Alumnos_EvaluacionAprendizajes:203]ID_Alumno:3;->[Alumnos:2]numero:1;"")
			Else 
				ARRAY LONGINT:C221($idArray;0)
				SN3_ManejaReferencias ("buscar";SN3_Aprendizajes_Evaluacion;0;SNT_Accion_Actualizar;->$idArray)
				QUERY WITH ARRAY:C644([Alumnos_EvaluacionAprendizajes:203]ID:90;$idArray)
			End if 
		End if 
		  //20120426 RCH Se comenta ordenamiento porque en pruebas efectuadas es casi la mitad mas rapido...
		  //SET AUTOMATIC RELATIONS(True;False)
		  //ORDER BY([Alumnos_EvaluacionAprendizajes];[Alumnos]Nivel_Número;>)
		  //SET AUTOMATIC RELATIONS(False;False)
	: ($data=SN3_DTi_CalificacionesExtraCurr)
		READ ONLY:C145([Alumnos:2])
		READ ONLY:C145([Actividades:29])
		READ ONLY:C145([Alumnos_Actividades:28])
		If ($useArrays)
			$set:="seleccion"+String:C10(Table:C252(->[Alumnos_Actividades:28]))
			CREATE EMPTY SET:C140([Alumnos_Actividades:28];$set)
			SET AUTOMATIC RELATIONS:C310(True:C214;False:C215)
			For ($i;1;Size of array:C274(SN3_MasterLevels))
				If (SN3_MasterTipoEnvio{$i})
					QUERY:C277([Alumnos_Actividades:28];[Alumnos:2]nivel_numero:29=SN3_MasterLevels{$i})
				Else 
					ARRAY LONGINT:C221($idArray;0)
					SN3_ManejaReferencias ("buscar";SN3_Actividades_Evaluaciones;0;SNT_Accion_Actualizar;->$idArray)
					QRY_QueryWithArray (->[Alumnos_Actividades:28]ID:63;->$idArray)
					QUERY SELECTION:C341([Alumnos_Actividades:28];[Alumnos:2]nivel_numero:29=SN3_MasterLevels{$i})
				End if 
				CREATE SET:C116([Alumnos_Actividades:28];"tempSelection")
				UNION:C120($set;"tempSelection";$set)
			End for 
			SET AUTOMATIC RELATIONS:C310(False:C215;False:C215)
			USE SET:C118($set)
			SET_ClearSets ($set;"tempSelection")
		Else 
			If ($todos)
				QUERY:C277([Alumnos:2];[Alumnos:2]nivel_numero:29<Nivel_Egresados;*)
				QUERY:C277([Alumnos:2]; & ;[Alumnos:2]nivel_numero:29>Nivel_AdmisionDirecta)
				KRL_RelateSelection (->[Alumnos_Actividades:28]Alumno_Numero:1;->[Alumnos:2]numero:1;"")
			Else 
				ARRAY LONGINT:C221($idArray;0)
				SN3_ManejaReferencias ("buscar";SN3_Actividades_Evaluaciones;0;SNT_Accion_Actualizar;->$idArray)
				QRY_QueryWithArray (->[Alumnos_Actividades:28]ID:63;->$idArray)
			End if 
		End if 
		QUERY SELECTION:C341([Alumnos_Actividades:28];[Alumnos_Actividades:28]Año:3=<>gYear)
		  //20120426 RCH Se comenta ordenamiento porque en pruebas efectuadas es casi la mitad mas rapido...
		  //SET AUTOMATIC RELATIONS(True;False)
		  //ORDER BY([Alumnos_Actividades];[Actividades]ID_ConfiguracionPeriodos;>)
		  //SET AUTOMATIC RELATIONS(False;False)
	: ($data=SN3_DTi_AvisosCobranza)
		READ ONLY:C145([ACT_Cargos:173])
		READ ONLY:C145([Familia:78])
		READ ONLY:C145([Familia_RelacionesFamiliares:77])
		READ ONLY:C145([ACT_Documentos_de_Cargo:174])
		READ ONLY:C145([ACT_Avisos_de_Cobranza:124])
		If ($useArrays)
			$set:="seleccion"+String:C10(Table:C252(->[ACT_Avisos_de_Cobranza:124]))
			CREATE EMPTY SET:C140([ACT_Avisos_de_Cobranza:124];$set)
			SET AUTOMATIC RELATIONS:C310(True:C214;False:C215)
			For ($i;1;Size of array:C274(SN3_MasterLevels))
				If (SN3_MasterTipoEnvio{$i})
					QUERY:C277([Alumnos:2];[Alumnos:2]nivel_numero:29=SN3_MasterLevels{$i})
					KRL_RelateSelection (->[Familia:78]Numero:1;->[Alumnos:2]Familia_Número:24;"")
					KRL_RelateSelection (->[Familia_RelacionesFamiliares:77]ID_Familia:2;->[Familia:78]Numero:1;"")
					KRL_RelateSelection (->[ACT_Avisos_de_Cobranza:124]ID_Apoderado:3;->[Familia_RelacionesFamiliares:77]ID_Persona:3;"")
				Else 
					ARRAY LONGINT:C221($al_idsAvisos;0)
					ARRAY LONGINT:C221($al_idsCargos;0)
					SN3_ManejaReferencias ("buscar";SN3_ACT_Avisos;0;SNT_Accion_Actualizar;->$al_idsAvisos)
					SN3_ManejaReferencias ("buscar";SN3_ACT_Cargos;0;SNT_Accion_Actualizar;->$al_idsCargos)
					QUERY WITH ARRAY:C644([ACT_Avisos_de_Cobranza:124]ID_Aviso:1;$al_idsAvisos)
					CREATE SET:C116([ACT_Avisos_de_Cobranza:124];"avisos")
					QUERY WITH ARRAY:C644([ACT_Cargos:173]ID:1;$al_idsCargos)
					KRL_RelateSelection (->[ACT_Documentos_de_Cargo:174]ID_Documento:1;->[ACT_Cargos:173]ID_Documento_de_Cargo:3;"")
					KRL_RelateSelection (->[ACT_Avisos_de_Cobranza:124]ID_Aviso:1;->[ACT_Documentos_de_Cargo:174]No_ComprobanteInterno:15;"")
					CREATE SET:C116([ACT_Avisos_de_Cobranza:124];"cargos")
					UNION:C120("avisos";"cargos";"avisos")
					USE SET:C118("avisos")
					SET_ClearSets ("avisos";"cargos")
					
					CREATE SET:C116([ACT_Avisos_de_Cobranza:124];"modificados")
					
					QUERY:C277([Alumnos:2];[Alumnos:2]nivel_numero:29=SN3_MasterLevels{$i})
					KRL_RelateSelection (->[Familia:78]Numero:1;->[Alumnos:2]Familia_Número:24;"")
					KRL_RelateSelection (->[Familia_RelacionesFamiliares:77]ID_Familia:2;->[Familia:78]Numero:1;"")
					KRL_RelateSelection (->[ACT_Avisos_de_Cobranza:124]ID_Apoderado:3;->[Familia_RelacionesFamiliares:77]ID_Persona:3;"")
					CREATE SET:C116([ACT_Avisos_de_Cobranza:124];"todosnivel")
					
					INTERSECTION:C121("modificados";"todosnivel";"tempSelection2")
					USE SET:C118("tempSelection2")
					SET_ClearSets ("modificados";"todosnivel";"tempSelection2")
				End if 
				  //QUERY SELECTION([ACT_Avisos_de_Cobranza];[ACT_Avisos_de_Cobranza]Agno=<>gYear;*)
				  //QUERY SELECTION([ACT_Avisos_de_Cobranza]; | ;[ACT_Avisos_de_Cobranza]Monto_a_Pagar#0)
				CREATE SET:C116([ACT_Avisos_de_Cobranza:124];"tempSelection")
				UNION:C120($set;"tempSelection";$set)
			End for 
			USE SET:C118($set)
			SET_ClearSets ($set;"tempSelection")
		Else 
			If ($todos)
				  //QUERY([ACT_Avisos_de_Cobranza];[ACT_Avisos_de_Cobranza]Agno=<>gYear;*)
				  //QUERY([ACT_Avisos_de_Cobranza]; | ;[ACT_Avisos_de_Cobranza]Monto_a_Pagar#0)
				ALL RECORDS:C47([ACT_Avisos_de_Cobranza:124])
			Else 
				ARRAY LONGINT:C221($al_idsAvisos;0)
				ARRAY LONGINT:C221($al_idsCargos;0)
				SN3_ManejaReferencias ("buscar";SN3_ACT_Avisos;0;SNT_Accion_Actualizar;->$al_idsAvisos)
				SN3_ManejaReferencias ("buscar";SN3_ACT_Cargos;0;SNT_Accion_Actualizar;->$al_idsCargos)
				QUERY WITH ARRAY:C644([ACT_Avisos_de_Cobranza:124]ID_Aviso:1;$al_idsAvisos)
				CREATE SET:C116([ACT_Avisos_de_Cobranza:124];"avisos")
				QUERY WITH ARRAY:C644([ACT_Cargos:173]ID:1;$al_idsCargos)
				KRL_RelateSelection (->[ACT_Documentos_de_Cargo:174]ID_Documento:1;->[ACT_Cargos:173]ID_Documento_de_Cargo:3;"")
				KRL_RelateSelection (->[ACT_Avisos_de_Cobranza:124]ID_Aviso:1;->[ACT_Documentos_de_Cargo:174]No_ComprobanteInterno:15;"")
				CREATE SET:C116([ACT_Avisos_de_Cobranza:124];"cargos")
				UNION:C120("avisos";"cargos";"avisos")
				USE SET:C118("avisos")
				SET_ClearSets ("avisos";"cargos")
				
				  //QUERY SELECTION([ACT_Avisos_de_Cobranza];[ACT_Avisos_de_Cobranza]Agno=<>gYear;*)
				  //QUERY SELECTION([ACT_Avisos_de_Cobranza]; | ;[ACT_Avisos_de_Cobranza]Monto_a_Pagar#0)
			End if 
		End if 
	: ($data=SN3_DTi_Pagos)
		READ ONLY:C145([Personas:7])
		READ ONLY:C145([ACT_Pagos:172])
		READ ONLY:C145([Familia:78])
		READ ONLY:C145([Familia_RelacionesFamiliares:77])
		If ($useArrays)
			$set:="seleccion"+String:C10(Table:C252(->[ACT_Pagos:172]))
			CREATE EMPTY SET:C140([ACT_Pagos:172];$set)
			For ($i;1;Size of array:C274(SN3_MasterLevels))
				If (SN3_MasterTipoEnvio{$i})
					QUERY:C277([Alumnos:2];[Alumnos:2]nivel_numero:29=SN3_MasterLevels{$i})
					KRL_RelateSelection (->[Familia:78]Numero:1;->[Alumnos:2]Familia_Número:24;"")
					KRL_RelateSelection (->[Familia_RelacionesFamiliares:77]ID_Familia:2;->[Familia:78]Numero:1;"")
					KRL_RelateSelection (->[ACT_Pagos:172]ID_Apoderado:3;->[Familia_RelacionesFamiliares:77]ID_Persona:3;"")
				Else 
					ARRAY LONGINT:C221($idArray;0)
					SN3_ManejaReferencias ("buscar";SN3_ACT_Pagos;0;SNT_Accion_Actualizar;->$idArray)
					QUERY WITH ARRAY:C644([ACT_Pagos:172]ID:1;$idArray)
					CREATE SET:C116([ACT_Pagos:172];"modificados")
					
					QUERY:C277([Alumnos:2];[Alumnos:2]nivel_numero:29=SN3_MasterLevels{$i})
					KRL_RelateSelection (->[Familia:78]Numero:1;->[Alumnos:2]Familia_Número:24;"")
					KRL_RelateSelection (->[Familia_RelacionesFamiliares:77]ID_Familia:2;->[Familia:78]Numero:1;"")
					KRL_RelateSelection (->[ACT_Pagos:172]ID_Apoderado:3;->[Familia_RelacionesFamiliares:77]ID_Persona:3;"")
					CREATE SET:C116([ACT_Pagos:172];"todosnivel")
					
					INTERSECTION:C121("modificados";"todosnivel";"tempSelection2")
					USE SET:C118("tempSelection2")
					SET_ClearSets ("modificados";"todosnivel";"tempSelection2")
				End if 
				CREATE SET:C116([ACT_Pagos:172];"tempSelection")
				UNION:C120($set;"tempSelection";$set)
			End for 
			USE SET:C118($set)
			SET_ClearSets ($set;"tempSelection")
		Else 
			If ($todos)
				QUERY:C277([Personas:7];[Personas:7]ES_Apoderado_de_Cuentas:42=True:C214;*)
				QUERY:C277([Personas:7]; & ;[Personas:7]Inactivo:46=False:C215)
				CREATE SET:C116([Personas:7];"aposcta")
				ALL RECORDS:C47([ACT_Apoderados_de_Cuenta:107])
				KRL_RelateSelection (->[Personas:7]No:1;->[ACT_Apoderados_de_Cuenta:107]ID_Apoderado:1;"")
				CREATE SET:C116([Personas:7];"exapos")
				UNION:C120("aposcta";"exapos";"aposcta")
				USE SET:C118("aposcta")
				SET_ClearSets ("aposcta";"exapos")
				KRL_RelateSelection (->[ACT_Pagos:172]ID_Apoderado:3;->[Personas:7]No:1;"")
			Else 
				ARRAY LONGINT:C221($idArray;0)
				SN3_ManejaReferencias ("buscar";SN3_ACT_Pagos;0;SNT_Accion_Actualizar;->$idArray)
				QUERY WITH ARRAY:C644([ACT_Pagos:172]ID:1;$idArray)
			End if 
		End if 
		$date:=DT_GetDateFromDayMonthYear (1;1;<>gYear)
		  //////////////MONO 11.7 ticket 109246
		CREATE SET:C116([ACT_Pagos:172];"pagosenseleccion")
		
		$date:=DT_GetDateFromDayMonthYear (1;1;<>gYear)
		
		  //buscamos los cargos que vencen en la año actual
		QUERY:C277([ACT_Cargos:173];[ACT_Cargos:173]Fecha_de_Vencimiento:7>=$date)
		KRL_RelateSelection (->[ACT_Transacciones:178]ID_Item:3;->[ACT_Cargos:173]ID:1;"")
		KRL_RelateSelection (->[ACT_Pagos:172]ID:1;->[ACT_Transacciones:178]ID_Pago:4;"")
		ARRAY LONGINT:C221($al_id_pagosxcargo;0)
		SELECTION TO ARRAY:C260([ACT_Pagos:172]ID:1;$al_id_pagosxcargo)
		
		USE SET:C118("pagosenseleccion")
		QRY_QueryWithArray (->[ACT_Pagos:172]ID:1;->$al_id_pagosxcargo;True:C214)
		CREATE SET:C116([ACT_Pagos:172];"pgs1")  //pagos filtrados por cargos
		
		USE SET:C118("pagosenseleccion")
		QUERY SELECTION:C341([ACT_Pagos:172];[ACT_Pagos:172]Fecha:2>=$date;*)
		QUERY SELECTION:C341([ACT_Pagos:172]; | ;[ACT_Pagos:172]Saldo:15#0)
		CREATE SET:C116([ACT_Pagos:172];"pgs2")  //pagos filtrados por fecha de pago
		
		UNION:C120("pgs1";"pgs2";"pgs3")
		USE SET:C118("pgs3")
		SET_ClearSets ("pgs1";"pgs2";"pgs3";"pagosenseleccion")
		
	: ($data=SN3_DTi_Prestamos)
		READ ONLY:C145([Alumnos:2])
		READ ONLY:C145([BBL_Prestamos:60])
		READ ONLY:C145([BBL_Items:61])
		READ ONLY:C145([BBL_Lectores:72])
		If ($useArrays)
			$set:="seleccion"+String:C10(Table:C252(->[BBL_Prestamos:60]))
			CREATE EMPTY SET:C140([BBL_Prestamos:60];$set)
			For ($i;1;Size of array:C274(SN3_MasterLevels))
				If (SN3_MasterTipoEnvio{$i})
					QUERY:C277([Alumnos:2];[Alumnos:2]nivel_numero:29=SN3_MasterLevels{$i})
					KRL_RelateSelection (->[BBL_Lectores:72]Número_de_alumno:6;->[Alumnos:2]numero:1;"")
					CREATE SET:C116([BBL_Lectores:72];"alumnos")
					QUERY:C277([Personas:7];[Personas:7]Inactivo:46=False:C215)
					KRL_RelateSelection (->[BBL_Lectores:72]Número_de_Persona:31;->[Personas:7]No:1;"")
					CREATE SET:C116([BBL_Lectores:72];"personas")
					UNION:C120("alumnos";"personas";"todos")
					USE SET:C118("todos")
					SET_ClearSets ("alumnos";"personas";"todos")
					KRL_RelateSelection (->[BBL_Prestamos:60]Número_de_lector:2;->[BBL_Lectores:72]ID:1;"")
				Else 
					ARRAY LONGINT:C221($idArray;0)
					SN3_ManejaReferencias ("buscar";SN3_MT_Prestamos;0;SNT_Accion_Actualizar;->$idArray)
					QUERY WITH ARRAY:C644([BBL_Prestamos:60]Número_de_Transacción:8;$idArray)
					CREATE SET:C116([BBL_Prestamos:60];"modificados")
					KRL_RelateSelection (->[BBL_Lectores:72]ID:1;->[BBL_Prestamos:60]Número_de_lector:2;"")
					QUERY SELECTION:C341([BBL_Lectores:72];[BBL_Lectores:72]Número_de_Profesor:30#0;*)
					QUERY SELECTION:C341([BBL_Lectores:72]; & ;[BBL_Lectores:72]Número_de_Persona:31=0;*)
					QUERY SELECTION:C341([BBL_Lectores:72]; & ;[BBL_Lectores:72]Número_de_alumno:6=0)
					KRL_RelateSelection (->[BBL_Prestamos:60]Número_de_lector:2;->[BBL_Lectores:72]ID:1;"")
					CREATE SET:C116([BBL_Prestamos:60];"profesores")
					DIFFERENCE:C122("modificados";"profesores";"modificados")
					
					QUERY:C277([Alumnos:2];[Alumnos:2]nivel_numero:29=SN3_MasterLevels{$i})
					KRL_RelateSelection (->[BBL_Lectores:72]Número_de_alumno:6;->[Alumnos:2]numero:1;"")
					CREATE SET:C116([BBL_Lectores:72];"alumnos")
					QUERY:C277([Personas:7];[Personas:7]Inactivo:46=False:C215)
					KRL_RelateSelection (->[BBL_Lectores:72]Número_de_Persona:31;->[Personas:7]No:1;"")
					CREATE SET:C116([BBL_Lectores:72];"personas")
					UNION:C120("alumnos";"personas";"todos")
					USE SET:C118("todos")
					SET_ClearSets ("alumnos";"personas";"todos")
					KRL_RelateSelection (->[BBL_Prestamos:60]Número_de_lector:2;->[BBL_Lectores:72]ID:1;"")
					CREATE SET:C116([BBL_Prestamos:60];"todosnivel")
					
					INTERSECTION:C121("todosnivel";"modificados";"tempSelection2")
					USE SET:C118("tempSelecion2")
					SET_ClearSets ("todosnivel";"modificados";"tempSelection2";"profesores")
				End if 
				CREATE SET:C116([BBL_Prestamos:60];"tempSelection")
				UNION:C120($set;"tempSelection";$set)
			End for 
			USE SET:C118($set)
			SET_ClearSets ($set;"tempSelection")
		Else 
			If ($todos)
				QUERY:C277([Alumnos:2];[Alumnos:2]nivel_numero:29<Nivel_Egresados;*)
				QUERY:C277([Alumnos:2]; & ;[Alumnos:2]nivel_numero:29>Nivel_AdmisionDirecta)
				KRL_RelateSelection (->[BBL_Lectores:72]Número_de_alumno:6;->[Alumnos:2]numero:1;"")
				CREATE SET:C116([BBL_Lectores:72];"alumnos")
				QUERY:C277([Personas:7];[Personas:7]Inactivo:46=False:C215)
				KRL_RelateSelection (->[BBL_Lectores:72]Número_de_Persona:31;->[Personas:7]No:1;"")
				CREATE SET:C116([BBL_Lectores:72];"personas")
				UNION:C120("alumnos";"personas";"todos")
				USE SET:C118("todos")
				SET_ClearSets ("alumnos";"personas";"todos")
				KRL_RelateSelection (->[BBL_Prestamos:60]Número_de_lector:2;->[BBL_Lectores:72]ID:1;"")
			Else 
				ARRAY LONGINT:C221($idArray;0)
				SN3_ManejaReferencias ("buscar";SN3_MT_Prestamos;0;SNT_Accion_Actualizar;->$idArray)
				QUERY WITH ARRAY:C644([BBL_Prestamos:60]Número_de_Transacción:8;$idArray)
				CREATE SET:C116([BBL_Prestamos:60];"modificados")
				KRL_RelateSelection (->[BBL_Lectores:72]ID:1;->[BBL_Prestamos:60]Número_de_lector:2;"")
				QUERY SELECTION:C341([BBL_Lectores:72];[BBL_Lectores:72]Número_de_Profesor:30#0;*)
				QUERY SELECTION:C341([BBL_Lectores:72]; & ;[BBL_Lectores:72]Número_de_Persona:31=0;*)
				QUERY SELECTION:C341([BBL_Lectores:72]; & ;[BBL_Lectores:72]Número_de_alumno:6=0)
				KRL_RelateSelection (->[BBL_Prestamos:60]Número_de_lector:2;->[BBL_Lectores:72]ID:1;"")
				CREATE SET:C116([BBL_Prestamos:60];"profesores")
				DIFFERENCE:C122("modificados";"profesores";"modificados")
				USE SET:C118("modificados")
				SET_ClearSets ("modificados";"profesores")
			End if 
		End if 
		$inicio:=PERIODOS_InicioAñoSTrack (<>gYear-1)  //se volverá a enviar a los no devueltos y los devueltos en este año, ticket 112778
		QUERY SELECTION:C341([BBL_Prestamos:60];[BBL_Prestamos:60]Fecha_de_devolución:5=!00-00-00!;*)
		QUERY SELECTION:C341([BBL_Prestamos:60]; | ;[BBL_Prestamos:60]Fecha_de_devolución:5>=$inicio)
	: ($data=SN3_DTi_Alumnos)
		READ ONLY:C145([Alumnos:2])
		READ ONLY:C145([Alumnos_FichaMedica:13])
		READ ONLY:C145([Alumnos_Vacunas:101])
		READ ONLY:C145([Alumnos_ControlesMedicos:99])
		READ ONLY:C145([Alumnos_Actividades:28])
		If ($useArrays)
			If (SN3_MasterTipoEnvio{1})
				QUERY:C277([Alumnos:2];[Alumnos:2]nivel_numero:29<Nivel_Egresados;*)
				QUERY:C277([Alumnos:2]; & ;[Alumnos:2]nivel_numero:29>Nivel_AdmisionDirecta)
			Else 
				ARRAY LONGINT:C221($idArray;0)
				SN3_ManejaReferencias ("buscar";SN3_Alumnos;0;SNT_Accion_Actualizar;->$idArray)
				QUERY WITH ARRAY:C644([Alumnos:2]numero:1;$idArray)
				QUERY SELECTION:C341([Alumnos:2];[Alumnos:2]nivel_numero:29<Nivel_Egresados;*)
				QUERY SELECTION:C341([Alumnos:2]; & ;[Alumnos:2]nivel_numero:29>Nivel_AdmisionDirecta)
			End if 
		Else 
			If ($todos)
				QUERY:C277([Alumnos:2];[Alumnos:2]nivel_numero:29<Nivel_Egresados;*)
				QUERY:C277([Alumnos:2]; & ;[Alumnos:2]nivel_numero:29>Nivel_AdmisionDirecta)
			Else 
				ARRAY LONGINT:C221($idArray;0)
				SN3_ManejaReferencias ("buscar";SN3_Alumnos;0;SNT_Accion_Actualizar;->$idArray)
				QUERY WITH ARRAY:C644([Alumnos:2]numero:1;$idArray)
				QUERY SELECTION:C341([Alumnos:2];[Alumnos:2]nivel_numero:29<Nivel_Egresados;*)
				QUERY SELECTION:C341([Alumnos:2]; & ;[Alumnos:2]nivel_numero:29>Nivel_AdmisionDirecta)
			End if 
		End if 
		QUERY SELECTION:C341([Alumnos:2];[Alumnos:2]Familia_Número:24#0)
		SET AUTOMATIC RELATIONS:C310(True:C214;False:C215)
		QUERY SELECTION:C341([Alumnos:2];[Cursos:3]Numero_del_curso:6>0)
		SET AUTOMATIC RELATIONS:C310(False:C215;False:C215)
		QUERY SELECTION:C341([Alumnos:2];[Alumnos:2]Status:50#"Ret@")
		ORDER BY:C49([Alumnos:2];[Alumnos:2]nivel_numero:29;>)
	: ($data=SN3_DTi_Profesores)
		READ ONLY:C145([Profesores:4])
		If ($useArrays)
			If (SN3_MasterTipoEnvio{1})
				QUERY:C277([Profesores:4];[Profesores:4]Inactivo:62=False:C215)
			Else 
				ARRAY LONGINT:C221($idArray;0)
				SN3_ManejaReferencias ("buscar";SN3_Profesores;0;SNT_Accion_Actualizar;->$idArray)
				QUERY WITH ARRAY:C644([Profesores:4]Numero:1;$idArray)
			End if 
		Else 
			If ($todos)
				QUERY:C277([Profesores:4];[Profesores:4]Inactivo:62=False:C215)
			Else 
				ARRAY LONGINT:C221($idArray;0)
				SN3_ManejaReferencias ("buscar";SN3_Profesores;0;SNT_Accion_Actualizar;->$idArray)
				QUERY WITH ARRAY:C644([Profesores:4]Numero:1;$idArray)
			End if 
		End if 
	: ($data=SN3_DTi_Cursos)
		READ ONLY:C145([Cursos:3])
		READ ONLY:C145([Cursos_SintesisAnual:63])
		If ($useArrays)
			If (SN3_MasterTipoEnvio{1})
				QUERY:C277([Cursos:3];[Cursos:3]Numero_del_curso:6>0)
			Else 
				ARRAY LONGINT:C221($idArray;0)
				SN3_ManejaReferencias ("buscar";SN3_Cursos;0;SNT_Accion_Actualizar;->$idArray)
				QUERY WITH ARRAY:C644([Cursos:3]Numero_del_curso:6;$idArray)
			End if 
		Else 
			If ($todos)
				QUERY:C277([Cursos:3];[Cursos:3]Numero_del_curso:6>0)
			Else 
				ARRAY LONGINT:C221($idArray;0)
				SN3_ManejaReferencias ("buscar";SN3_Cursos;0;SNT_Accion_Actualizar;->$idArray)
				QUERY WITH ARRAY:C644([Cursos:3]Numero_del_curso:6;$idArray)
			End if 
		End if 
	: ($data=SN3_DTi_Asignaturas)
		READ ONLY:C145([Asignaturas:18])
		READ ONLY:C145([Alumnos_Calificaciones:208])
		PERIODOS_Init 
		If ($useArrays)
			If (SN3_MasterTipoEnvio{1})
				ALL RECORDS:C47([Asignaturas:18])
			Else 
				ARRAY LONGINT:C221($idArray;0)
				SN3_ManejaReferencias ("buscar";SN3_Asignaturas;0;SNT_Accion_Actualizar;->$idArray)
				QUERY WITH ARRAY:C644([Asignaturas:18]Numero:1;$idArray)
			End if 
		Else 
			If ($todos)
				ALL RECORDS:C47([Asignaturas:18])
			Else 
				ARRAY LONGINT:C221($idArray;0)
				SN3_ManejaReferencias ("buscar";SN3_Asignaturas;0;SNT_Accion_Actualizar;->$idArray)
				QUERY WITH ARRAY:C644([Asignaturas:18]Numero:1;$idArray)
			End if 
		End if 
		NIV_LoadArrays 
		QUERY SELECTION WITH ARRAY:C1050([Asignaturas:18]Numero_del_Nivel:6;<>aNivNo)
		AS_SinEstiloDeEvaluacion ("AsignaturasValidas")  //190897 ABC// 20180227
		ORDER BY:C49([Asignaturas:18];[Asignaturas:18]Numero_del_Nivel:6;>)
	: ($data=SN3_DTi_Familias)
		READ ONLY:C145([Familia:78])
		READ ONLY:C145([Alumnos:2])
		If ($useArrays)
			If (SN3_MasterTipoEnvio{1})
				QUERY:C277([Alumnos:2];[Alumnos:2]nivel_numero:29<Nivel_Egresados;*)
				QUERY:C277([Alumnos:2]; & ;[Alumnos:2]nivel_numero:29>Nivel_AdmisionDirecta;*)
				QUERY:C277([Alumnos:2]; & ;[Alumnos:2]Familia_Número:24#0)
				SET AUTOMATIC RELATIONS:C310(True:C214;False:C215)
				QUERY SELECTION:C341([Alumnos:2];[Cursos:3]Numero_del_curso:6>0)
				SET AUTOMATIC RELATIONS:C310(False:C215;False:C215)
				KRL_RelateSelection (->[Familia:78]Numero:1;->[Alumnos:2]Familia_Número:24;"")
			Else 
				ARRAY LONGINT:C221($idArray;0)
				SN3_ManejaReferencias ("buscar";SN3_Familias;0;SNT_Accion_Actualizar;->$idArray)
				QUERY WITH ARRAY:C644([Familia:78]Numero:1;$idArray)
			End if 
		Else 
			If ($todos)
				QUERY:C277([Alumnos:2];[Alumnos:2]nivel_numero:29<Nivel_Egresados;*)
				QUERY:C277([Alumnos:2]; & ;[Alumnos:2]nivel_numero:29>Nivel_AdmisionDirecta;*)
				QUERY:C277([Alumnos:2]; & ;[Alumnos:2]Familia_Número:24#0)
				SET AUTOMATIC RELATIONS:C310(True:C214;False:C215)
				QUERY SELECTION:C341([Alumnos:2];[Cursos:3]Numero_del_curso:6>0)
				SET AUTOMATIC RELATIONS:C310(False:C215;False:C215)
				KRL_RelateSelection (->[Familia:78]Numero:1;->[Alumnos:2]Familia_Número:24;"")
			Else 
				ARRAY LONGINT:C221($idArray;0)
				SN3_ManejaReferencias ("buscar";SN3_Familias;0;SNT_Accion_Actualizar;->$idArray)
				QUERY WITH ARRAY:C644([Familia:78]Numero:1;$idArray)
			End if 
		End if 
	: ($data=SN3_DTi_RelacionesFamiliares)
		READ ONLY:C145([Personas:7])
		READ ONLY:C145([Alumnos:2])
		READ ONLY:C145([Familia_RelacionesFamiliares:77])
		If ($useArrays)
			If (SN3_MasterTipoEnvio{1})
				QUERY:C277([Alumnos:2];[Alumnos:2]nivel_numero:29>Nivel_AdmisionDirecta;*)
				QUERY:C277([Alumnos:2]; & ;[Alumnos:2]Familia_Número:24#0)
				CREATE SET:C116([Alumnos:2];"todos")
				SET AUTOMATIC RELATIONS:C310(True:C214;False:C215)
				QUERY SELECTION:C341([Alumnos:2];[Cursos:3]Numero_del_curso:6<0)
				SET AUTOMATIC RELATIONS:C310(False:C215;False:C215)
				CREATE SET:C116([Alumnos:2];"post")
				DIFFERENCE:C122("todos";"post";"todos")
				USE SET:C118("todos")
				SET_ClearSets ("todos";"post")
				KRL_RelateSelection (->[Familia_RelacionesFamiliares:77]ID_Familia:2;->[Alumnos:2]Familia_Número:24;"")
				KRL_RelateSelection (->[Personas:7]No:1;->[Familia_RelacionesFamiliares:77]ID_Persona:3;"")
			Else 
				ARRAY LONGINT:C221($idArray;0)
				SN3_ManejaReferencias ("buscar";SN3_RelacionesFamiliares;0;SNT_Accion_Actualizar;->$idArray)
				QUERY WITH ARRAY:C644([Personas:7]No:1;$idArray)
				CREATE SET:C116([Personas:7];"marcas")
				QUERY:C277([Alumnos:2];[Alumnos:2]nivel_numero:29>Nivel_AdmisionDirecta;*)
				QUERY:C277([Alumnos:2]; & ;[Alumnos:2]Familia_Número:24#0)
				CREATE SET:C116([Alumnos:2];"todos")
				SET AUTOMATIC RELATIONS:C310(True:C214;False:C215)
				QUERY SELECTION:C341([Alumnos:2];[Cursos:3]Numero_del_curso:6<0)
				SET AUTOMATIC RELATIONS:C310(False:C215;False:C215)
				CREATE SET:C116([Alumnos:2];"post")
				DIFFERENCE:C122("todos";"post";"todos")
				USE SET:C118("todos")
				SET_ClearSets ("todos";"post")
				KRL_RelateSelection (->[Familia_RelacionesFamiliares:77]ID_Familia:2;->[Alumnos:2]Familia_Número:24;"")
				KRL_RelateSelection (->[Personas:7]No:1;->[Familia_RelacionesFamiliares:77]ID_Persona:3;"")
				CREATE SET:C116([Personas:7];"todos")
				INTERSECTION:C121("marcas";"todos";"marcas")
				USE SET:C118("marcas")
				SET_ClearSets ("marcas";"todos")
			End if 
		Else 
			If ($todos)
				QUERY:C277([Alumnos:2];[Alumnos:2]nivel_numero:29>Nivel_AdmisionDirecta;*)
				QUERY:C277([Alumnos:2]; & ;[Alumnos:2]Familia_Número:24#0)
				CREATE SET:C116([Alumnos:2];"todos")
				SET AUTOMATIC RELATIONS:C310(True:C214;False:C215)
				QUERY SELECTION:C341([Alumnos:2];[Cursos:3]Numero_del_curso:6<0)
				SET AUTOMATIC RELATIONS:C310(False:C215;False:C215)
				CREATE SET:C116([Alumnos:2];"post")
				DIFFERENCE:C122("todos";"post";"todos")
				USE SET:C118("todos")
				SET_ClearSets ("todos";"post")
				KRL_RelateSelection (->[Familia_RelacionesFamiliares:77]ID_Familia:2;->[Alumnos:2]Familia_Número:24;"")
				KRL_RelateSelection (->[Personas:7]No:1;->[Familia_RelacionesFamiliares:77]ID_Persona:3;"")
			Else 
				ARRAY LONGINT:C221($idArray;0)
				SN3_ManejaReferencias ("buscar";SN3_RelacionesFamiliares;0;SNT_Accion_Actualizar;->$idArray)
				QUERY WITH ARRAY:C644([Personas:7]No:1;$idArray)
				CREATE SET:C116([Personas:7];"marcas")
				QUERY:C277([Alumnos:2];[Alumnos:2]nivel_numero:29>Nivel_AdmisionDirecta;*)
				QUERY:C277([Alumnos:2]; & ;[Alumnos:2]Familia_Número:24#0)
				CREATE SET:C116([Alumnos:2];"todos")
				SET AUTOMATIC RELATIONS:C310(True:C214;False:C215)
				QUERY SELECTION:C341([Alumnos:2];[Cursos:3]Numero_del_curso:6<0)
				SET AUTOMATIC RELATIONS:C310(False:C215;False:C215)
				CREATE SET:C116([Alumnos:2];"post")
				DIFFERENCE:C122("todos";"post";"todos")
				USE SET:C118("todos")
				SET_ClearSets ("todos";"post")
				KRL_RelateSelection (->[Familia_RelacionesFamiliares:77]ID_Familia:2;->[Alumnos:2]Familia_Número:24;"")
				KRL_RelateSelection (->[Personas:7]No:1;->[Familia_RelacionesFamiliares:77]ID_Persona:3;"")
				CREATE SET:C116([Personas:7];"todos")
				INTERSECTION:C121("marcas";"todos";"marcas")
				USE SET:C118("marcas")
				SET_ClearSets ("marcas";"todos")
			End if 
		End if 
	: ($data=SN3_DTi_DatosGenerales)
		
	: ($data=SN3_DTi_ActividadesExtraCurr)
		READ ONLY:C145([Actividades:29])
		If ($useArrays)
			If (SN3_MasterTipoEnvio{1})
				ALL RECORDS:C47([Actividades:29])
			Else 
				ARRAY LONGINT:C221($idArray;0)
				SN3_ManejaReferencias ("buscar";SN3_Actividades;0;SNT_Accion_Actualizar;->$idArray)
				QUERY WITH ARRAY:C644([Actividades:29]ID:1;$idArray)
			End if 
		Else 
			If ($todos)
				ALL RECORDS:C47([Actividades:29])
			Else 
				ARRAY LONGINT:C221($idArray;0)
				SN3_ManejaReferencias ("buscar";SN3_Actividades;0;SNT_Accion_Actualizar;->$idArray)
				QUERY WITH ARRAY:C644([Actividades:29]ID:1;$idArray)
			End if 
		End if 
	: ($data=SN3_DTi_MatricesAprendizaje)
		
	: ($data=SN3_DTi_Subasignaturas)
		READ ONLY:C145([xxSTR_Subasignaturas:83])
		READ ONLY:C145([Asignaturas:18])
		If ($useArrays)
			$set:="seleccion"+String:C10(Table:C252(->[xxSTR_Subasignaturas:83]))
			CREATE EMPTY SET:C140([xxSTR_Subasignaturas:83];$set)
			For ($i;1;Size of array:C274(SN3_MasterLevels))
				If (SN3_MasterTipoEnvio{$i})
					QUERY:C277([Asignaturas:18];[Asignaturas:18]Numero_del_Nivel:6=SN3_MasterLevels{$i})
					ARRAY LONGINT:C221($aAsigs;0)
					SELECTION TO ARRAY:C260([Asignaturas:18]Numero:1;$aAsigs)
					CREATE EMPTY SET:C140([xxSTR_Subasignaturas:83];"tempSubAsigs")
					For ($w;1;Size of array:C274($aAsigs))
						QUERY:C277([xxSTR_Subasignaturas:83];[xxSTR_Subasignaturas:83]Referencia:11=String:C10($aAsigs{$w})+".@")
						CREATE SET:C116([xxSTR_Subasignaturas:83];"subAsigsFound")
						UNION:C120("subAsigsFound";"tempSubAsigs";"tempSubAsigs")
					End for 
					  //USE SET("tempSubAsigs")
					UNION:C120($set;"tempSubAsigs";$set)
					SET_ClearSets ("subAsigsFound";"tempSubAsigs")
				Else 
					QUERY:C277([Asignaturas:18];[Asignaturas:18]Numero_del_Nivel:6=SN3_MasterLevels{$i})
					ARRAY LONGINT:C221($aAsigs;0)
					SELECTION TO ARRAY:C260([Asignaturas:18]Numero:1;$aAsigs)
					CREATE EMPTY SET:C140([xxSTR_Subasignaturas:83];"tempSubAsigs")
					For ($w;1;Size of array:C274($aAsigs))
						QUERY:C277([xxSTR_Subasignaturas:83];[xxSTR_Subasignaturas:83]Referencia:11=String:C10($aAsigs{$w})+".@")
						CREATE SET:C116([xxSTR_Subasignaturas:83];"subAsigsFound")
						UNION:C120("subAsigsFound";"tempSubAsigs";"tempSubAsigs")
					End for 
					USE SET:C118("tempSubAsigs")
					SET_ClearSets ("subAsigsFound";"tempSubAsigs")
					CREATE SET:C116([xxSTR_Subasignaturas:83];"temp1")
					ARRAY LONGINT:C221($idArray;0)
					SN3_ManejaReferencias ("buscar";10500;0;SNT_Accion_Actualizar;->$idArray)
					QUERY WITH ARRAY:C644([xxSTR_Subasignaturas:83]ID:19;$idArray)
					CREATE SET:C116([xxSTR_Subasignaturas:83];"temp2")
					INTERSECTION:C121("temp1";"temp2";"temp1")
					  //USE SET("temp1")
					UNION:C120($set;"temp1";$set)
					SET_ClearSets ("temp1";"temp2")
				End if 
			End for 
			USE SET:C118($set)
			CLEAR SET:C117($set)
		Else 
			If ($todos)
				ALL RECORDS:C47([xxSTR_Subasignaturas:83])
			Else 
				ARRAY LONGINT:C221($idArray;0)
				SN3_ManejaReferencias ("buscar";10500;0;SNT_Accion_Actualizar;->$idArray)
				QUERY WITH ARRAY:C644([xxSTR_Subasignaturas:83]ID:19;$idArray)
			End if 
		End if 
		
	: ($data=100022)  //sesiones //MONO 22-05-14: pub sesiones
		
		READ ONLY:C145([Asignaturas_RegistroSesiones:168])
		
		$inicio:=PERIODOS_InicioAñoSTrack 
		$fin:=PERIODOS_FinAñoPeriodosSTrack 
		
		If ($todos)
			ALL RECORDS:C47([Asignaturas_RegistroSesiones:168])
		Else 
			ARRAY LONGINT:C221($idArray;0)
			SN3_ManejaReferencias ("buscar";100022;0;SNT_Accion_Actualizar;->$idArray)
			QUERY WITH ARRAY:C644([Asignaturas_RegistroSesiones:168]ID_Sesion:1;$idArray)
		End if 
		QUERY SELECTION:C341([Asignaturas_RegistroSesiones:168];[Asignaturas_RegistroSesiones:168]Fecha_Sesion:3>=$inicio;*)
		QUERY SELECTION:C341([Asignaturas_RegistroSesiones:168]; & ;[Asignaturas_RegistroSesiones:168]Fecha_Sesion:3<=$fin)
	: ($data=10013)  // asignaturas Adjuntos ASM
		
		READ ONLY:C145([Asignaturas_Adjuntos:230])
		READ ONLY:C145([Asignaturas:18])
		If ($todos)
			ALL RECORDS:C47([Asignaturas:18])
			KRL_RelateSelection (->[Asignaturas_Adjuntos:230]id_asignatura:7;->[Asignaturas:18]Numero:1;"")
		Else 
			ARRAY LONGINT:C221($idArray;0)
			SN3_ManejaReferencias ("buscar";10013;0;SNT_Accion_Actualizar;->$idArray)
			QUERY WITH ARRAY:C644([Asignaturas_Adjuntos:230]ID:1;$idArray)
		End if 
End case 

IT_UThermometer (-2;$p)
MESSAGES ON:C181