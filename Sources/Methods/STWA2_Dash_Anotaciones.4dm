//%attributes = {}
C_POINTER:C301($1;$2)
C_POINTER:C301($parameterNames;$parameterValues)
C_LONGINT:C283($recs)
C_OBJECT:C1216($ob_raiz)

$parameterNames:=$1
$parameterValues:=$2

$action:=NV_GetValueFromPairedArrays ($parameterNames;$parameterValues;"action")
STR_LeePreferenciasConducta2 
NIV_LoadArrays 
Case of 
	: ($action="detallealumno")
		$alumnoidx:=Num:C11(NV_GetValueFromPairedArrays ($parameterNames;$parameterValues;"alumno"))
		$curso:=NV_GetValueFromPairedArrays ($parameterNames;$parameterValues;"curso")
		$motivo:=NV_GetValueFromPairedArrays ($parameterNames;$parameterValues;"motivo")
		$categoria:=NV_GetValueFromPairedArrays ($parameterNames;$parameterValues;"cat")
		$alumnoidx:=$alumnoidx+1
		READ ONLY:C145([Alumnos:2])
		READ ONLY:C145([Alumnos_Anotaciones:11])
		QUERY:C277([Alumnos:2];[Alumnos:2]curso:20=$curso)
		ARRAY LONGINT:C221($aIDsAlumnos;0)
		ARRAY TEXT:C222($aNombres;0)
		SELECTION TO ARRAY:C260([Alumnos:2]numero:1;$aIDsAlumnos;[Alumnos:2]apellidos_y_nombres:40;$aNombres)
		SORT ARRAY:C229($aNombres;$aIDsAlumnos;>)
		$idAlumno:=$aIDsAlumnos{$alumnoidx}
		$nombreAlumno:=$aNombres{$alumnoidx}
		QUERY:C277([Alumnos_Anotaciones:11];[Alumnos_Anotaciones:11]Alumno_Numero:6=$idAlumno;*)
		QUERY:C277([Alumnos_Anotaciones:11]; & ;[Alumnos_Anotaciones:11]Año:11=<>gYear;*)
		QUERY:C277([Alumnos_Anotaciones:11]; & ;[Alumnos_Anotaciones:11]Categoria:8=$categoria;*)
		QUERY:C277([Alumnos_Anotaciones:11]; & ;[Alumnos_Anotaciones:11]Motivo:3=$motivo)
		ORDER BY:C49([Alumnos_Anotaciones:11];[Alumnos_Anotaciones:11]Fecha:1;<)
		
		ARRAY DATE:C224($adSTRal_FechaAnotacion;0)
		ARRAY TEXT:C222($afechasAnotaciones;0)
		ARRAY TEXT:C222($atSTRal_NombreProfesorAnot;0)
		ARRAY TEXT:C222($atSTRal_NotasAnotacion;0)
		ARRAY TEXT:C222($atSTRal_CategoriaAnotacion;0)
		ARRAY INTEGER:C220($alSTRal_PuntosAnotacion;0)
		ARRAY TEXT:C222($atSTRal_TipoAnotacion;0)
		SET AUTOMATIC RELATIONS:C310(True:C214;False:C215)
		SELECTION TO ARRAY:C260([Alumnos_Anotaciones:11]Fecha:1;$adSTRal_FechaAnotacion;[Alumnos_Anotaciones:11]Observaciones:4;$atSTRal_NotasAnotacion;[Profesores:4]Nombre_comun:21;$atSTRal_NombreProfesorAnot;[Alumnos_Anotaciones:11]Puntos:9;$alSTRal_PuntosAnotacion;[Alumnos_Anotaciones:11]Signo:7;$atSTRal_TipoAnotacion)
		SET AUTOMATIC RELATIONS:C310(False:C215;False:C215)
		ARRAY TEXT:C222($afechasAnotaciones;Size of array:C274($adSTRal_FechaAnotacion))
		ARRAY LONGINT:C221($apuntosAnotaciones;Size of array:C274($adSTRal_FechaAnotacion))
		If (Size of array:C274($adSTRal_FechaAnotacion)>0)
			For ($i;1;Size of array:C274($adSTRal_FechaAnotacion))
				$afechasAnotaciones{$i}:=STWA2_MakeDate4JS ($adSTRal_FechaAnotacion{$i})
				$apuntosAnotaciones{$i}:=$alSTRal_PuntosAnotacion{$i}
			End for 
		End if 
		$ob_raiz:=OB_Create 
		OB_SET ($ob_raiz;->$nombreAlumno;"alumno")
		OB_SET ($ob_raiz;->$afechasAnotaciones;"fechas")
		OB_SET ($ob_raiz;->$atSTRal_NotasAnotacion;"observaciones")
		OB_SET ($ob_raiz;->$atSTRal_NombreProfesorAnot;"profnombre")
		OB_SET ($ob_raiz;->$apuntosAnotaciones;"puntos")
		OB_SET ($ob_raiz;->$atSTRal_TipoAnotacion;"signos")
		$json:=OB_Object2Json ($ob_raiz)
		  //$anotaciones:=JSON New 
		  //$node:=JSON Append text ($anotaciones;"alumno";$nombreAlumno)
		  //$node:=JSON Append text array ($anotaciones;"fechas";$afechasAnotaciones)
		  //$node:=JSON Append text array ($anotaciones;"observaciones";$atSTRal_NotasAnotacion)
		  //$node:=JSON Append text array ($anotaciones;"profnombre";$atSTRal_NombreProfesorAnot)
		  //$node:=JSON Append long array ($anotaciones;"puntos";$apuntosAnotaciones)
		  //$node:=JSON Append text array ($anotaciones;"signos";$atSTRal_TipoAnotacion)
		  //$json:=JSON Export to text ($anotaciones;JSON_WITHOUT_WHITE_SPACE)
		  //JSON CLOSE ($anotaciones)  //20150421 RCH Se agrega cierre
	: ($action="pormotivocursoalumnos")
		$categoria:=NV_GetValueFromPairedArrays ($parameterNames;$parameterValues;"cat")
		$curso:=NV_GetValueFromPairedArrays ($parameterNames;$parameterValues;"curso")
		$motivo:=NV_GetValueFromPairedArrays ($parameterNames;$parameterValues;"motivo")
		READ ONLY:C145([Alumnos:2])
		READ ONLY:C145([Alumnos_Anotaciones:11])
		QUERY:C277([Alumnos:2];[Alumnos:2]curso:20=$curso)
		ARRAY LONGINT:C221($aIdsAlumnos;0)
		ARRAY TEXT:C222($aNombres;0)
		SELECTION TO ARRAY:C260([Alumnos:2]numero:1;$aIdsAlumnos;[Alumnos:2]apellidos_y_nombres:40;$aNombres)
		KRL_RelateSelection (->[Alumnos_Anotaciones:11]Alumno_Numero:6;->[Alumnos:2]numero:1;"")
		QUERY SELECTION:C341([Alumnos_Anotaciones:11];[Alumnos_Anotaciones:11]Categoria:8=$categoria)
		QUERY SELECTION:C341([Alumnos_Anotaciones:11];[Alumnos_Anotaciones:11]Motivo:3=$motivo)
		CREATE SET:C116([Alumnos_Anotaciones:11];"anotaciones")
		ARRAY LONGINT:C221($aConteoXAlumno;0)
		SET QUERY DESTINATION:C396(Into variable:K19:4;$recs)
		For ($i;1;Size of array:C274($aIdsAlumnos))
			USE SET:C118("anotaciones")
			QUERY SELECTION:C341([Alumnos_Anotaciones:11];[Alumnos_Anotaciones:11]Alumno_Numero:6=$aIdsAlumnos{$i})
			APPEND TO ARRAY:C911($aConteoXAlumno;$recs)
		End for 
		SET QUERY DESTINATION:C396(Into current selection:K19:1)
		SORT ARRAY:C229($aNombres;$aConteoXAlumno;>)
		$ob_raiz:=OB_Create 
		OB_SET ($ob_raiz;->$aNombres;"alumnos")
		OB_SET ($ob_raiz;->$aConteoXAlumno;"registradas")
		$json:=OB_Object2Json ($ob_raiz)
		  //$jsonT:=JSON New 
		  //$node:=JSON Append text array ($jsonT;"alumnos";$aNombres)
		  //$node:=JSON Append long array ($jsonT;"registradas";$aConteoXAlumno)
		  //$json:=JSON Export to text ($jsonT;JSON_WITHOUT_WHITE_SPACE)
		  //JSON CLOSE ($jsonT)  //20150421 RCH Se agrega cierre
	: ($action="porcursocategorianivel")
		$categoria:=NV_GetValueFromPairedArrays ($parameterNames;$parameterValues;"cat")
		$curso:=NV_GetValueFromPairedArrays ($parameterNames;$parameterValues;"curso")
		$el:=Find in array:C230(at_STR_CategoriasAnot_Nombres;$categoria)
		$idCat:=aiSTR_IDCategoria{$el}
		READ ONLY:C145([Alumnos:2])
		READ ONLY:C145([Alumnos_Anotaciones:11])
		ARRAY TEXT:C222(atSTR_Anotaciones_motivo;0)
		ARRAY LONGINT:C221(aiSTR_Anotaciones_Registradas;0)
		For ($i;1;Size of array:C274(<>atSTR_Anotaciones_categorias))
			If (<>aiID_Matriz{$i}=$idCat)
				If (<>atSTR_Anotaciones_motivo{$i}#"")
					QUERY:C277([Alumnos_Anotaciones:11];[Alumnos_Anotaciones:11]Motivo:3;=;<>atSTR_Anotaciones_motivo{$i};*)
					QUERY:C277([Alumnos_Anotaciones:11]; & ;[Alumnos_Anotaciones:11]Año:11=<>gYear)
					CREATE SET:C116([Alumnos_Anotaciones:11];"motivo")
					QUERY:C277([Alumnos:2];[Alumnos:2]curso:20=$curso)
					KRL_RelateSelection (->[Alumnos_Anotaciones:11]Alumno_Numero:6;->[Alumnos:2]numero:1;"")
					QUERY SELECTION:C341([Alumnos_Anotaciones:11]; & ;[Alumnos_Anotaciones:11]Año:11=<>gYear)
					CREATE SET:C116([Alumnos_Anotaciones:11];"curso")
					INTERSECTION:C121("motivo";"curso";"motivo")
					USE SET:C118("motivo")
					AT_Insert (0;1;->atSTR_Anotaciones_motivo;->aiSTR_Anotaciones_puntaje;->aiSTR_Anotaciones_registradas)
					atSTR_Anotaciones_motivo{Size of array:C274(atSTR_Anotaciones_motivo)}:=<>atSTR_Anotaciones_motivo{$i}
					aiSTR_Anotaciones_registradas{Size of array:C274(atSTR_Anotaciones_motivo)}:=Records in selection:C76([Alumnos_Anotaciones:11])
				End if 
			End if 
		End for 
		ARRAY TEXT:C222($aFixedMotivos;0)
		For ($i;1;Size of array:C274(atSTR_Anotaciones_motivo))
			If (Length:C16(atSTR_Anotaciones_motivo{$i})>31)
				$text:=ST_GetStringByLen (atSTR_Anotaciones_motivo{$i};30)+"…"
			Else 
				$text:=atSTR_Anotaciones_motivo{$i}
			End if 
			APPEND TO ARRAY:C911($aFixedMotivos;$text)
		End for 
		$ob_raiz:=OB_Create 
		OB_SET ($ob_raiz;->$aFixedMotivos;"motivos")
		OB_SET ($ob_raiz;->atSTR_Anotaciones_motivo;"motivosenteros")
		OB_SET ($ob_raiz;->aiSTR_Anotaciones_Registradas;"registradas")
		$json:=OB_Object2Json ($ob_raiz)
		  //$jsonT:=JSON New 
		  //$node:=JSON Append text array ($jsonT;"motivos";$aFixedMotivos)
		  //$node:=JSON Append text array ($jsonT;"motivosenteros";atSTR_Anotaciones_motivo)
		  //$node:=JSON Append long array ($jsonT;"registradas";aiSTR_Anotaciones_Registradas)
		  //$json:=JSON Export to text ($jsonT;JSON_WITHOUT_WHITE_SPACE)
		  //JSON CLOSE ($jsonT)  //20150421 RCH Se agrega cierre
	: ($action="pormotivocategorianivel")
		$categoria:=NV_GetValueFromPairedArrays ($parameterNames;$parameterValues;"cat")
		$motivo:=NV_GetValueFromPairedArrays ($parameterNames;$parameterValues;"motivo")
		$nivel:=Num:C11(NV_GetValueFromPairedArrays ($parameterNames;$parameterValues;"nivel"))
		$nivel:=<>al_NumeroNivelesActivos{$nivel+1}
		READ ONLY:C145([Cursos:3])
		READ ONLY:C145([Alumnos:2])
		READ ONLY:C145([Alumnos_Anotaciones:11])
		QUERY:C277([Cursos:3];[Cursos:3]Nivel_Numero:7=$nivel;*)
		QUERY:C277([Cursos:3]; & ;[Cursos:3]Numero_del_curso:6>0)
		ORDER BY:C49([Cursos:3];[Cursos:3]Curso:1;>)
		ARRAY TEXT:C222($aCursos;0)
		ARRAY LONGINT:C221($aConteoXCurso;0)
		SELECTION TO ARRAY:C260([Cursos:3]Curso:1;$aCursos)
		For ($i;1;Size of array:C274($aCursos))
			QUERY:C277([Alumnos:2];[Alumnos:2]curso:20=$aCursos{$i};*)
			QUERY:C277([Alumnos:2]; & ;[Alumnos:2]Status:50#"RET@")
			KRL_RelateSelection (->[Alumnos_Anotaciones:11]Alumno_Numero:6;->[Alumnos:2]numero:1;"")
			QUERY SELECTION:C341([Alumnos_Anotaciones:11];[Alumnos_Anotaciones:11]Año:11=<>gYear)
			QUERY SELECTION:C341([Alumnos_Anotaciones:11];[Alumnos_Anotaciones:11]Categoria:8=$categoria)
			QUERY SELECTION:C341([Alumnos_Anotaciones:11];[Alumnos_Anotaciones:11]Motivo:3=$motivo)
			APPEND TO ARRAY:C911($aConteoXCurso;Records in selection:C76([Alumnos_Anotaciones:11]))
		End for 
		$ob_raiz:=OB_Create 
		OB_SET ($ob_raiz;->$aCursos;"cursos")
		OB_SET ($ob_raiz;->$aConteoXCurso;"registradas")
		$json:=OB_Object2Json ($ob_raiz)
		  //$jsonT:=JSON New 
		  //$node:=JSON Append text array ($jsonT;"cursos";$aCursos)
		  //$node:=JSON Append long array ($jsonT;"registradas";$aConteoXCurso)
		  //$json:=JSON Export to text ($jsonT;JSON_WITHOUT_WHITE_SPACE)
		  //JSON CLOSE ($jsonT)  //20150421 RCH Se agrega cierre
	: ($action="porcategoriacursos")
		$categoria:=NV_GetValueFromPairedArrays ($parameterNames;$parameterValues;"cat")
		$nivel:=Num:C11(NV_GetValueFromPairedArrays ($parameterNames;$parameterValues;"nivel"))
		$nivel:=<>al_NumeroNivelesActivos{$nivel+1}
		READ ONLY:C145([Cursos:3])
		READ ONLY:C145([Alumnos:2])
		READ ONLY:C145([Alumnos_Anotaciones:11])
		QUERY:C277([Cursos:3];[Cursos:3]Nivel_Numero:7=$nivel;*)
		QUERY:C277([Cursos:3]; & ;[Cursos:3]Numero_del_curso:6>0)
		ORDER BY:C49([Cursos:3];[Cursos:3]Curso:1;>)
		ARRAY TEXT:C222($aCursos;0)
		ARRAY LONGINT:C221($aConteoXCurso;0)
		SELECTION TO ARRAY:C260([Cursos:3]Curso:1;$aCursos)
		For ($i;1;Size of array:C274($aCursos))
			QUERY:C277([Alumnos:2];[Alumnos:2]curso:20=$aCursos{$i};*)
			QUERY:C277([Alumnos:2]; & ;[Alumnos:2]Status:50#"RET@")
			KRL_RelateSelection (->[Alumnos_Anotaciones:11]Alumno_Numero:6;->[Alumnos:2]numero:1;"")
			QUERY SELECTION:C341([Alumnos_Anotaciones:11];[Alumnos_Anotaciones:11]Año:11=<>gYear)
			QUERY SELECTION:C341([Alumnos_Anotaciones:11];[Alumnos_Anotaciones:11]Categoria:8=$categoria)
			APPEND TO ARRAY:C911($aConteoXCurso;Records in selection:C76([Alumnos_Anotaciones:11]))
		End for 
		$ob_raiz:=OB_Create 
		OB_SET ($ob_raiz;->$aCursos;"cursos")
		OB_SET ($ob_raiz;->$aConteoXCurso;"registradas")
		$json:=OB_Object2Json ($ob_raiz)
		  //$jsonT:=JSON New 
		  //$node:=JSON Append text array ($jsonT;"cursos";$aCursos)
		  //$node:=JSON Append long array ($jsonT;"registradas";$aConteoXCurso)
		  //$json:=JSON Export to text ($jsonT;JSON_WITHOUT_WHITE_SPACE)
		  //JSON CLOSE ($jsonT)  //20150421 RCH Se agrega cierre
	: ($action="porcategorianivel")
		$categoria:=NV_GetValueFromPairedArrays ($parameterNames;$parameterValues;"cat")
		$nivel:=Num:C11(NV_GetValueFromPairedArrays ($parameterNames;$parameterValues;"nivel"))
		$nivel:=<>al_NumeroNivelesActivos{$nivel+1}
		$el:=Find in array:C230(at_STR_CategoriasAnot_Nombres;$categoria)
		$idCat:=aiSTR_IDCategoria{$el}
		READ ONLY:C145([Alumnos:2])
		READ ONLY:C145([Alumnos_Anotaciones:11])
		ARRAY TEXT:C222(atSTR_Anotaciones_motivo;0)
		ARRAY LONGINT:C221(aiSTR_Anotaciones_Registradas;0)
		For ($i;1;Size of array:C274(<>atSTR_Anotaciones_categorias))
			If (<>aiID_Matriz{$i}=$idCat)
				If (<>atSTR_Anotaciones_motivo{$i}#"")
					QUERY:C277([Alumnos_Anotaciones:11];[Alumnos_Anotaciones:11]Motivo:3;=;<>atSTR_Anotaciones_motivo{$i};*)
					QUERY:C277([Alumnos_Anotaciones:11]; & ;[Alumnos_Anotaciones:11]Año:11=<>gYear)
					CREATE SET:C116([Alumnos_Anotaciones:11];"motivo")
					QUERY:C277([Alumnos:2];[Alumnos:2]nivel_numero:29=$nivel)
					KRL_RelateSelection (->[Alumnos_Anotaciones:11]Alumno_Numero:6;->[Alumnos:2]numero:1;"")
					QUERY SELECTION:C341([Alumnos_Anotaciones:11]; & ;[Alumnos_Anotaciones:11]Año:11=<>gYear)
					CREATE SET:C116([Alumnos_Anotaciones:11];"nivel")
					INTERSECTION:C121("motivo";"nivel";"motivo")
					USE SET:C118("motivo")
					AT_Insert (0;1;->atSTR_Anotaciones_motivo;->aiSTR_Anotaciones_puntaje;->aiSTR_Anotaciones_registradas)
					atSTR_Anotaciones_motivo{Size of array:C274(atSTR_Anotaciones_motivo)}:=<>atSTR_Anotaciones_motivo{$i}
					aiSTR_Anotaciones_registradas{Size of array:C274(atSTR_Anotaciones_motivo)}:=Records in selection:C76([Alumnos_Anotaciones:11])
				End if 
			End if 
		End for 
		ARRAY TEXT:C222($aFixedMotivos;0)
		For ($i;1;Size of array:C274(atSTR_Anotaciones_motivo))
			If (Length:C16(atSTR_Anotaciones_motivo{$i})>31)
				$text:=ST_GetStringByLen (atSTR_Anotaciones_motivo{$i};30)+"…"
			Else 
				$text:=atSTR_Anotaciones_motivo{$i}
			End if 
			APPEND TO ARRAY:C911($aFixedMotivos;$text)
		End for 
		$ob_raiz:=OB_Create 
		OB_SET ($ob_raiz;->$aFixedMotivos;"motivos")
		OB_SET ($ob_raiz;->atSTR_Anotaciones_motivo;"motivosenteros")
		OB_SET ($ob_raiz;->aiSTR_Anotaciones_Registradas;"registradas")
		$json:=OB_Object2Json ($ob_raiz)
		  //$jsonT:=JSON New 
		  //$node:=JSON Append text array ($jsonT;"motivos";$aFixedMotivos)
		  //$node:=JSON Append text array ($jsonT;"motivosenteros";atSTR_Anotaciones_motivo)
		  //$node:=JSON Append long array ($jsonT;"registradas";aiSTR_Anotaciones_Registradas)
		  //$json:=JSON Export to text ($jsonT;JSON_WITHOUT_WHITE_SPACE)
		  //JSON CLOSE ($jsonT)  //20150421 RCH Se agrega cierre
	: ($action="dashboard")
		PERIODOS_Init 
		READ ONLY:C145([Alumnos_Anotaciones:11])
		READ ONLY:C145([Alumnos:2])
		$ob_raiz:=OB_Create 
		OB_SET ($ob_raiz;-><>tXS_RS_DecimalSeparator;"sepDecimal")
		OB_SET ($ob_raiz;-><>tXS_RS_ThousandsSeparator;"sepMiles")
		OB_SET ($ob_raiz;-><>at_NombreNivelesActivos;"niveles")
		OB_SET ($ob_raiz;->at_STR_CategoriasAnot_Nombres;"categorias")
		
		  //$jsonT:=JSON New 
		  //$node:=JSON Append text ($jsonT;"sepDecimal";<>tXS_RS_DecimalSeparator)
		  //$node:=JSON Append text ($jsonT;"sepMiles";<>tXS_RS_ThousandsSeparator)
		  //$node:=JSON Append text array ($jsonT;"niveles";<>at_NombreNivelesActivos)
		  //$node:=JSON Append text array ($jsonT;"categorias";at_STR_CategoriasAnot_Nombres)
		For ($j;1;Size of array:C274(at_STR_CategoriasAnot_Nombres))
			ARRAY LONGINT:C221($aPorCatyNivel;0)
			For ($i;1;Size of array:C274(<>al_NumeroNivelesActivos))
				QUERY:C277([Alumnos:2];[Alumnos:2]nivel_numero:29=<>al_NumeroNivelesActivos{$i})
				KRL_RelateSelection (->[Alumnos_Anotaciones:11]Alumno_Numero:6;->[Alumnos:2]numero:1;"")
				QUERY SELECTION:C341([Alumnos_Anotaciones:11];[Alumnos_Anotaciones:11]Año:11=<>gYear;*)
				QUERY SELECTION:C341([Alumnos_Anotaciones:11]; & ;[Alumnos_Anotaciones:11]Categoria:8=at_STR_CategoriasAnot_Nombres{$j})
				$anotacionesxcat:=Records in selection:C76([Alumnos_Anotaciones:11])
				APPEND TO ARRAY:C911($aPorCatyNivel;$anotacionesxcat)
			End for 
			  //$node:=JSON Append long array ($jsonT;String($j);$aPorCatyNivel)
			OB_SET ($ob_raiz;->$aPorCatyNivel;String:C10($j))
		End for 
		$json:=OB_Object2Json ($ob_raiz)
		  //$json:=JSON Export to text ($jsonT;JSON_WITHOUT_WHITE_SPACE)
		  //JSON CLOSE ($jsonT)  //20150421 RCH Se agrega cierre
End case 
$0:=$json