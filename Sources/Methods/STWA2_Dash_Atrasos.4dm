//%attributes = {}
C_POINTER:C301($1;$2)
C_POINTER:C301($parameterNames;$parameterValues)
C_OBJECT:C1216($ob_raiz)

$parameterNames:=$1
$parameterValues:=$2

$action:=NV_GetValueFromPairedArrays ($parameterNames;$parameterValues;"action")

Case of 
	: ($action="detallealumno")
		$alumnoidx:=Num:C11(NV_GetValueFromPairedArrays ($parameterNames;$parameterValues;"alumno"))
		$curso:=Num:C11(NV_GetValueFromPairedArrays ($parameterNames;$parameterValues;"curso"))
		$nivel:=Num:C11(NV_GetValueFromPairedArrays ($parameterNames;$parameterValues;"nivel"))
		$orden:=Num:C11(NV_GetValueFromPairedArrays ($parameterNames;$parameterValues;"orden"))
		$nivel:=<>al_NumeroNivelesActivos{$nivel+1}
		$curso:=$curso+1
		$alumnoidx:=$alumnoidx+1
		READ ONLY:C145([Alumnos:2])
		READ ONLY:C145([Cursos:3])
		QUERY:C277([Cursos:3];[Cursos:3]Nivel_Numero:7=$nivel;*)
		QUERY:C277([Cursos:3]; & ;[Cursos:3]Numero_del_curso:6>=0)
		ARRAY TEXT:C222($cursos;0)
		SELECTION TO ARRAY:C260([Cursos:3]Curso:1;$cursos)
		QUERY:C277([Alumnos:2];[Alumnos:2]curso:20=$cursos{$curso};*)
		QUERY:C277([Alumnos:2]; & ;[Alumnos:2]Status:50#"@Retirado@")
		ARRAY TEXT:C222($alumnos;0)
		ARRAY LONGINT:C221($alumnosRNs;0)
		LONGINT ARRAY FROM SELECTION:C647([Alumnos:2];$alumnosRNs;"")
		SELECTION TO ARRAY:C260([Alumnos:2]apellidos_y_nombres:40;$alumnos)
		SORT ARRAY:C229($alumnos;$alumnosRNs;>)
		$rn:=$alumnosRNs{$alumnoidx}
		KRL_GotoRecord (->[Alumnos:2];$rn;False:C215)
		READ ONLY:C145([Alumnos_Atrasos:55])
		QUERY:C277([Alumnos_Atrasos:55];[Alumnos_Atrasos:55]Alumno_numero:1=[Alumnos:2]numero:1;*)
		QUERY:C277([Alumnos_Atrasos:55]; & ;[Alumnos_Atrasos:55]Año:6=<>gYear)
		ORDER BY:C49([Alumnos_Atrasos:55];[Alumnos_Atrasos:55]Fecha:2;<)
		ARRAY DATE:C224($aAtrasosFecha;0)
		ARRAY TEXT:C222($aAtrasosObservaciones;0)
		ARRAY BOOLEAN:C223($aAtrasosTipo;0)
		ARRAY TEXT:C222($aAtrasosTipoTxt;0)
		SELECTION TO ARRAY:C260([Alumnos_Atrasos:55]Fecha:2;$aAtrasosFecha;[Alumnos_Atrasos:55]Observaciones:3;$aAtrasosObservaciones;[Alumnos_Atrasos:55]EsAtrasoInterSesiones:4;$aAtrasosTipo)
		ARRAY TEXT:C222($aAtrasosFechaTxt;Size of array:C274($aAtrasosFecha))
		ARRAY TEXT:C222($aAtrasosTipoTxt;Size of array:C274($aAtrasosFecha))
		For ($i;1;Size of array:C274($aAtrasosFecha))
			$aAtrasosFechaTxt{$i}:=STWA2_MakeDate4JS ($aAtrasosFecha{$i})
			$aAtrasosTipoTxt{$i}:=ST_Boolean2Text ($aAtrasosTipo{$i};"Inter sesión";"Inicio jornada")
		End for 
		If ($orden#0)
			If ($orden>0)
				$ordersym:="<"
			Else 
				$ordersym:=">"
			End if 
			$orden:=Abs:C99($orden)
			Case of 
				: ($orden=1)
					AT_MultiLevelSort ($ordersym+">";->$aAtrasosFecha;->$aAtrasosTipoTxt;->$aAtrasosObservaciones;->$aAtrasosFechaTxt)
				: ($orden=2)
					AT_MultiLevelSort ($ordersym+">";->$aAtrasosObservaciones;->$aAtrasosFecha;->$aAtrasosTipoTxt;->$aAtrasosFechaTxt)
				: ($orden=3)
					AT_MultiLevelSort ($ordersym+">";->$aAtrasosTipoTxt;->$aAtrasosFecha;->$aAtrasosObservaciones;->$aAtrasosFechaTxt)
			End case 
		Else 
			AT_MultiLevelSort (">>";->$aAtrasosFecha;->$aAtrasosTipoTxt;->$aAtrasosObservaciones;->$aAtrasosFechaTxt)
		End if 
		$ob_raiz:=OB_Create 
		OB_SET ($ob_raiz;->$aAtrasosFechaTxt;"fecha")
		OB_SET ($ob_raiz;->$aAtrasosObservaciones;"observaciones")
		OB_SET ($ob_raiz;->$aAtrasosTipoTxt;"tipo")
		OB_SET ($ob_raiz;->[Alumnos:2]apellidos_y_nombres:40;"alumno")
		$json:=OB_Object2Json ($ob_raiz)
		  //$jsonT:=JSON New 
		  //$node:=JSON Append text array ($jsonT;"fecha";$aAtrasosFechaTxt)
		  //$node:=JSON Append text array ($jsonT;"observaciones";$aAtrasosObservaciones)
		  //$node:=JSON Append text array ($jsonT;"tipo";$aAtrasosTipoTxt)
		  //$node:=JSON Append text ($jsonT;"alumno";[Alumnos]Apellidos_y_Nombres)
		  //$json:=JSON Export to text ($jsonT;JSON_WITHOUT_WHITE_SPACE)
		  //JSON CLOSE ($jsonT)  //20150421 RCH Se agrega cierre
	: ($action="atrasoscurso")
		$curso:=Num:C11(NV_GetValueFromPairedArrays ($parameterNames;$parameterValues;"curso"))
		$nivel:=Num:C11(NV_GetValueFromPairedArrays ($parameterNames;$parameterValues;"nivel"))
		$uuid:=NV_GetValueFromPairedArrays ($parameterNames;$parameterValues;"uuid")  //20180621 RCH Ticket 207351
		$l_userID:=STWA2_Session_GetUserSTID ($uuid)
		$nivel:=<>al_NumeroNivelesActivos{$nivel+1}
		$curso:=$curso+1
		$lateMode:=KRL_GetNumericFieldData (->[xxSTR_Niveles:6]NoNivel:5;->$nivel;->[xxSTR_Niveles:6]Lates_Mode:16)
		READ ONLY:C145([Alumnos:2])
		READ ONLY:C145([Cursos:3])
		QUERY:C277([Cursos:3];[Cursos:3]Nivel_Numero:7=$nivel;*)
		QUERY:C277([Cursos:3]; & ;[Cursos:3]Numero_del_curso:6>=0)
		ARRAY TEXT:C222($cursos;0)
		SELECTION TO ARRAY:C260([Cursos:3]Curso:1;$cursos)
		If (($curso>0) & ($curso<=Size of array:C274($cursos)))  //20180621 RCH Ticket 207351
			QUERY:C277([Alumnos:2];[Alumnos:2]curso:20=$cursos{$curso};*)
			QUERY:C277([Alumnos:2]; & ;[Alumnos:2]Status:50#"@Retirado@")
		Else 
			REDUCE SELECTION:C351([Alumnos:2];0)
			Log_RegisterEvtSTW ("Error STWA2 Atrasos: Problema en índice de búsqueda. Elemento: "+String:C10($curso)+", tamaño arreglo: "+String:C10(Size of array:C274($cursos))+", nivel: "+String:C10($nivel)+".";$l_userID)
		End if 
		ARRAY TEXT:C222($alumnos;0)
		ARRAY LONGINT:C221($aAtrasosLI;0)
		ARRAY LONGINT:C221($aAtrasosInterLI;0)
		ARRAY INTEGER:C220($aAtrasos;0)
		ARRAY INTEGER:C220($aAtrasosInter;0)
		ARRAY LONGINT:C221($alumnosRNs;0)
		SET AUTOMATIC RELATIONS:C310(True:C214;False:C215)
		SELECTION TO ARRAY:C260([Alumnos:2];$alumnosRNs;[Alumnos:2]apellidos_y_nombres:40;$alumnos;[Alumnos_SintesisAnual:210]Atrasos_Jornada:40;$aAtrasos;[Alumnos_SintesisAnual:210]Atrasos_Sesiones:41;$aAtrasosInter)
		SET AUTOMATIC RELATIONS:C310(False:C215;False:C215)
		SORT ARRAY:C229($alumnos;$aAtrasos;$aAtrasosInter;$alumnosRNs;>)
		AT_CopyArrayElements (->$aAtrasos;->$aAtrasosLI)
		AT_CopyArrayElements (->$aAtrasosInter;->$aAtrasosInterLI)
		$ob_raiz:=OB_Create 
		OB_SET ($ob_raiz;->$alumnos;"alumnos")
		OB_SET ($ob_raiz;->$alumnosRNs;"alumnosrn")
		OB_SET ($ob_raiz;->$aAtrasosLI;"atrasos")
		OB_SET ($ob_raiz;->$aAtrasosInterLI;"atrasosinter")
		OB_SET ($ob_raiz;->$lateMode;"mode")
		$json:=OB_Object2Json ($ob_raiz)
		  //$jsonT:=JSON New 
		  //$node:=JSON Append text array ($jsonT;"alumnos";$alumnos)
		  //$node:=JSON Append long array ($jsonT;"alumnosrn";$alumnosRNs)
		  //$node:=JSON Append long array ($jsonT;"atrasos";$aAtrasosLI)
		  //$node:=JSON Append long array ($jsonT;"atrasosinter";$aAtrasosInterLI)
		  //$node:=JSON Append long ($jsonT;"mode";$lateMode)
		  //$json:=JSON Export to text ($jsonT;JSON_WITHOUT_WHITE_SPACE)
		  //JSON CLOSE ($jsonT)  //20150421 RCH Se agrega cierre
	: ($action="atrasosnivel")
		$nivel:=Num:C11(NV_GetValueFromPairedArrays ($parameterNames;$parameterValues;"nivel"))
		$nivel:=<>al_NumeroNivelesActivos{$nivel+1}
		READ ONLY:C145([Alumnos:2])
		READ ONLY:C145([Cursos:3])
		READ ONLY:C145([xxSTR_Niveles:6])
		READ ONLY:C145([Alumnos_Atrasos:55])
		QUERY:C277([Cursos:3];[Cursos:3]Nivel_Numero:7=$nivel;*)
		QUERY:C277([Cursos:3]; & ;[Cursos:3]Numero_del_curso:6>=0)
		ARRAY TEXT:C222($aCursos;0)
		SELECTION TO ARRAY:C260([Cursos:3]Curso:1;$aCursos)
		ARRAY LONGINT:C221($aAtrasosLI;0)
		ARRAY LONGINT:C221($aAtrasosInterLI;0)
		For ($i;1;Size of array:C274($aCursos))
			QUERY:C277([Alumnos:2];[Alumnos:2]curso:20=$aCursos{$i};*)
			QUERY:C277([Alumnos:2]; & ;[Alumnos:2]Status:50#"@Retirado@")
			KRL_RelateSelection (->[Alumnos_SintesisAnual:210]ID_Alumno:4;->[Alumnos:2]numero:1;"")
			APPEND TO ARRAY:C911($aAtrasosLI;Sum:C1([Alumnos_SintesisAnual:210]Atrasos_Jornada:40))
			APPEND TO ARRAY:C911($aAtrasosInterLI;Sum:C1([Alumnos_SintesisAnual:210]Atrasos_Sesiones:41))
		End for 
		$ob_raiz:=OB_Create 
		OB_SET ($ob_raiz;->$aCursos;"cursos")
		OB_SET ($ob_raiz;->$aAtrasosLI;"atrasos")
		OB_SET ($ob_raiz;->$aAtrasosInterLI;"atrasosinter")
		$json:=OB_Object2Json ($ob_raiz)
		  //$jsonT:=JSON New 
		  //$node:=JSON Append text array ($jsonT;"cursos";$aCursos)
		  //$node:=JSON Append long array ($jsonT;"atrasos";$aAtrasosLI)
		  //$node:=JSON Append long array ($jsonT;"atrasosinter";$aAtrasosInterLI)
		  //$json:=JSON Export to text ($jsonT;JSON_WITHOUT_WHITE_SPACE)
		  //JSON CLOSE ($jsonT)  //20150421 RCH Se agrega cierre
	: ($action="dashboard")
		NIV_LoadArrays 
		PERIODOS_Init 
		READ ONLY:C145([xxSTR_Niveles:6])
		READ ONLY:C145([Alumnos:2])
		READ ONLY:C145([Alumnos_SintesisAnual:210])
		QUERY WITH ARRAY:C644([xxSTR_Niveles:6]NoNivel:5;<>al_NumeroNivelesActivos)
		ORDER BY:C49([xxSTR_Niveles:6];[xxSTR_Niveles:6]NoNivel:5;>)
		ARRAY LONGINT:C221($aRNNiveles;0)
		ARRAY TEXT:C222($aNombreNivel;0)
		LONGINT ARRAY FROM SELECTION:C647([xxSTR_Niveles:6];$aRNNiveles;"")
		ARRAY LONGINT:C221($aAtrasosLI;0)
		ARRAY LONGINT:C221($aAtrasosInterLI;0)
		For ($i;1;Size of array:C274($aRNNiveles))
			KRL_GotoRecord (->[xxSTR_Niveles:6];$aRNNiveles{$i};False:C215)
			PERIODOS_LoadData ([xxSTR_Niveles:6]NoNivel:5)
			QUERY:C277([Alumnos_SintesisAnual:210];[Alumnos_SintesisAnual:210]NumeroNivel:6=[xxSTR_Niveles:6]NoNivel:5;*)
			QUERY:C277([Alumnos_SintesisAnual:210]; & ;[Alumnos_SintesisAnual:210]ID_Alumno:4>=0)
			APPEND TO ARRAY:C911($aAtrasosLI;Sum:C1([Alumnos_SintesisAnual:210]Atrasos_Jornada:40))
			APPEND TO ARRAY:C911($aAtrasosInterLI;Sum:C1([Alumnos_SintesisAnual:210]Atrasos_Sesiones:41))
			APPEND TO ARRAY:C911($aNombreNivel;[xxSTR_Niveles:6]Nivel:1)
		End for 
		$ob_raiz:=OB_Create 
		OB_SET ($ob_raiz;-><>tXS_RS_DecimalSeparator;"sepDecimal")
		OB_SET ($ob_raiz;-><>tXS_RS_ThousandsSeparator;"sepMiles")
		OB_SET ($ob_raiz;->$aNombreNivel;"niveles")
		OB_SET ($ob_raiz;->$aAtrasosLI;"atrasos")
		OB_SET ($ob_raiz;->$aAtrasosInterLI;"atrasosinter")
		$json:=OB_Object2Json ($ob_raiz)
		  //$jsonT:=JSON New 
		  //$node:=JSON Append text ($jsonT;"sepDecimal";<>tXS_RS_DecimalSeparator)
		  //$node:=JSON Append text ($jsonT;"sepMiles";<>tXS_RS_ThousandsSeparator)
		  //$node:=JSON Append text array ($jsonT;"niveles";$aNombreNivel)
		  //$node:=JSON Append long array ($jsonT;"atrasos";$aAtrasosLI)
		  //$node:=JSON Append long array ($jsonT;"atrasosinter";$aAtrasosInterLI)
		  //$json:=JSON Export to text ($jsonT;JSON_WITHOUT_WHITE_SPACE)
		  //JSON CLOSE ($jsonT)  //20150421 RCH Se agrega cierre
End case 
$0:=$json