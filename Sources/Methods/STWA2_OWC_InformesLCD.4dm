//%attributes = {}
  // ----------------------------------------------------
  // Usuario (SO): Alexis Bustamante
  // Fecha y hora: 22-01-18, 10:25:47
  // ----------------------------------------------------
  // Método: STWA2_OWC_InformesLCD
  // Descripción:
  //-Se cargan las asignaturas y  cursos que le corresponde al usuario
  //-Se recibe objeto con los filtrso creados en STWA
  //método no flexible para impresión de otros informes.
  // ----------------------------------------------------
  // 20180517 ASM cambios generales en el método.

C_TEXT:C284($0)
C_TEXT:C284($1)
C_POINTER:C301($2)
C_POINTER:C301($3)

C_BLOB:C604($x_blobPrueba;$x_informes)
C_BOOLEAN:C305($b_error;$b_impresionSimple;$b_imprimir)
C_LONGINT:C283($asig;$l_error;$l_recNumReporte;$pos;$session;$l_ok)
C_POINTER:C301($y_ParameterNames;$y_ParameterValues)
C_TEXT:C284($json;$t_base64;$t_curso;$t_cursoaimprimir;$t_desde;$t_destinoImpresion;$t_expresion;$t_expresionNombreDoc;$t_hasta;$t_informeXML)
C_TEXT:C284($t_mes;$t_modelo;$t_nombreDocPDF;$t_NombreProceso;$t_nomProfejefe;$t_objeto;$t_rutaCarpetaPdf;$uuid;$t_rutaPrint)
C_OBJECT:C1216($ob_AntecedentesGenerales;$ob_asignatura;$ob_ControlAsignatura;$ob_curso;$ob_filtros;$ob_Hojavida;$ob_InformeNotas;$ob_LibroClases;$ob_meses;$ob_periodos)
C_OBJECT:C1216($ob_raiz;$ob_RegistroObjetivo;$ob_Subvencion;$ob_temp)
C_POINTER:C301(vyQR_TablePointer;yBWR_currentTable)
C_DATE:C307(vinidate;venddate)
C_REAL:C285(vi_selectedmonth)
C_BOOLEAN:C305($b_okImpresoraPDF)

ARRAY TEXT:C222($at_mesNombre;0)
ARRAY LONGINT:C221($al_mesNumero;0)
ARRAY BOOLEAN:C223($ab_asigimprimir;0)
ARRAY BOOLEAN:C223($ab_imprimir;0)
ARRAY BOOLEAN:C223($ab_PeriodoImprimir;0)
ARRAY LONGINT:C221($al_cantperiodos;0)
ARRAY LONGINT:C221($al_numAlumnos;0)
ARRAY LONGINT:C221($al_NumAsig;0)
ARRAY LONGINT:C221($al_NumAsignatura;0)
ARRAY LONGINT:C221($DA_return;0)
ARRAY TEXT:C222($at_asignaturas;0)
ARRAY TEXT:C222($at_curso;0)
ARRAY TEXT:C222($at_cursoAsig;0)
ARRAY TEXT:C222($at_cursos;0)
ARRAY TEXT:C222($at_informes;0)
ARRAY TEXT:C222($at_informesUUID;0)
ARRAY TEXT:C222($at_nombre;0)
ARRAY TEXT:C222($at_nombreProfe;0)

$uuid:=$1
$y_ParameterNames:=$2
$y_ParameterValues:=$3
$profID:=STWA2_Session_GetProfID ($uuid)
$userID:=STWA2_Session_GetUserSTID ($uuid)
$admin:=USR_IsGroupMember_by_GrpID (-15001;$userID)
$dato:=NV_GetValueFromPairedArrays ($y_ParameterNames;$y_ParameterValues;"dato")

APPEND TO ARRAY:C911($at_informesUUID;"35D2EF9C4F544CE089F8D36CC522F5E5")
APPEND TO ARRAY:C911($at_informesUUID;"0F1B8ECEE6F047F3B6FF1CEE7D88E9FE")
APPEND TO ARRAY:C911($at_informesUUID;"0B94166FBA6E46F4833197B5D007B181")
APPEND TO ARRAY:C911($at_informesUUID;"DD1F305D1A794D2993BA22070EE2B976")
APPEND TO ARRAY:C911($at_informesUUID;"186DC9619CAF46EB8C139C1F486DD224")
APPEND TO ARRAY:C911($at_informesUUID;"7ED626B0DC5F44AE9A0AE6F53F62CA2D")
APPEND TO ARRAY:C911($at_informesUUID;"D43CCEB705C97A47848E94A54BB16C63")
  //APPEND TO ARRAY($at_informesUUID;"5E6738BD777742B996B7DC4279081F18")//ABC por cambio d einforme en repositorio

APPEND TO ARRAY:C911($at_informes;"LibroClases")
APPEND TO ARRAY:C911($at_informes;"AntecedentesGenerales")
APPEND TO ARRAY:C911($at_informes;"ControlAsignatura")
APPEND TO ARRAY:C911($at_informes;"Subvencion")
APPEND TO ARRAY:C911($at_informes;"InformeNotas")
APPEND TO ARRAY:C911($at_informes;"RegistroObjetivo")
APPEND TO ARRAY:C911($at_informes;"Hojavida")

READ ONLY:C145([xShell_Reports:54])
READ ONLY:C145([Asignaturas:18])
READ ONLY:C145([Cursos:3])
READ ONLY:C145([Alumnos:2])
READ ONLY:C145([Alumnos_Calificaciones:208])

  //Verifico que los reportes existan
QUERY WITH ARRAY:C644([xShell_Reports:54]UUID:47;$at_informesUUID)
If (Records in selection:C76([xShell_Reports:54])#Size of array:C274($at_informesUUID))
	SR_CargaInformesLCD 
End if 

$t_extension:=".pdf"

Case of 
	: ($dato="asignaturas")
		
		  //cargo las asignaturas que el profesor puede ver.
		If (($profID=0) | ($admin))
			ALL RECORDS:C47([Asignaturas:18])
		Else 
			dhSTWA2_SpecialSearch ("SchoolTrack";->[Asignaturas:18];$profID)
		End if   //utilizar filtro de las aisgnaturas special serach para mostrar
		  //
		CREATE SET:C116([Asignaturas:18];"$asignaturas")
		  //AT_DistinctsArrayValues (->[Asignaturas]Curso;->$at_cursos)
		ORDER BY:C49([Asignaturas:18];[Asignaturas:18]Numero_del_Nivel:6;>;[Asignaturas:18]ordenGeneral:105;>)
		
		If (Records in selection:C76([Asignaturas:18])>0)
			SELECTION TO ARRAY:C260([Asignaturas:18]Curso:5;$at_cursoAsig)
			  //para desplegar los cursos de forma ordenada al nivel que le corresponde.
			
			For ($asig;1;Size of array:C274($at_cursoAsig))
				$pos:=Find in array:C230($at_cursos;$at_cursoAsig{$asig})
				If ($pos=-1)
					APPEND TO ARRAY:C911($at_cursos;$at_cursoAsig{$asig})
				End if 
			End for 
			
			
			For ($curso;1;Size of array:C274($at_cursos))
				USE SET:C118("$asignaturas")
				QUERY SELECTION:C341([Asignaturas:18];[Asignaturas:18]Curso:5=$at_cursos{$curso})
				QUERY:C277([Cursos:3];[Cursos:3]Curso:1=$at_cursos{$curso})
				If (Records in selection:C76([Cursos:3])>0)
					QUERY:C277([Profesores:4];[Profesores:4]Numero:1=[Cursos:3]Numero_del_profesor_jefe:2)
					$t_nomProfejefe:=[Profesores:4]Apellidos_y_nombres:28
				Else 
					$t_nomProfejefe:=""
				End if 
				
				PERIODOS_LoadData ([Asignaturas:18]Numero_del_Nivel:6)
				  //cargo el inicio y fin de periodo y feriados para los cursos
				OB SET ARRAY:C1227($ob_periodos;"inicio";adSTR_Periodos_Desde)
				OB SET ARRAY:C1227($ob_periodos;"fin";adSTR_Periodos_Hasta)
				OB SET ARRAY:C1227($ob_periodos;"feriados";adSTR_Calendario_Feriados)
				OB SET:C1220($ob_periodos;"desde";STWA2_MakeDate4JS (adSTR_Periodos_Desde{1}))
				OB SET:C1220($ob_periodos;"hasta";STWA2_MakeDate4JS (adSTR_Periodos_Hasta{Size of array:C274(adSTR_Periodos_Hasta)}))
				OB SET:C1220($ob_periodos;"fechaActual";STWA2_MakeDate4JS (Current date:C33(*)))
				
				$d_fechaIniciomes:=DT_GetDateFromDayMonthYear (1;Month of:C24(Current date:C33(*));Year of:C25(Current date:C33(*)))
				While ((Not:C34(DateIsValid ($d_fechaIniciomes;0))) & ($d_fechaIniciomes<adSTR_Periodos_Hasta{Size of array:C274(adSTR_Periodos_Hasta)}))
					$d_fechaIniciomes:=$d_fechaIniciomes+1
				End while 
				
				OB SET:C1220($ob_periodos;"inicioFechaActual";STWA2_MakeDate4JS ($d_fechaIniciomes))
				
				CREATE SET:C116([Asignaturas:18];"$temp")
				DIFFERENCE:C122("$asignaturas";"$temp";"$asignaturas")
				ORDER BY:C49([Asignaturas:18];[Asignaturas:18]ordenGeneral:105;>)
				
				SELECTION TO ARRAY:C260([Asignaturas:18]Numero:1;$al_NumAsignatura;[Asignaturas:18]Asignatura:3;$at_asignaturas)
				ARRAY BOOLEAN:C223($ab_imprimir;Size of array:C274($al_NumAsignatura))
				For ($u;1;Size of array:C274($ab_imprimir))  //para que  solo 3 asignaturas marcadas para la visualización del ejemplo en STWA.
					If ($u=1)
						$ab_imprimir{$u}:=True:C214
					Else 
						$ab_imprimir{$u}:=False:C215
					End if 
				End for 
				
				CLEAR VARIABLE:C89($ob_temp)
				$ob_temp:=OB_Create 
				OB SET ARRAY:C1227($ob_temp;"AsignaturasImprimir";$ab_imprimir)
				OB SET ARRAY:C1227($ob_temp;"AsignaturasNumero";$al_NumAsignatura)
				OB SET ARRAY:C1227($ob_temp;"AsignaturasNombre";$at_asignaturas)
				OB SET ARRAY:C1227($ob_temp;"PeriodosNombre";atSTR_Periodos_Nombre)
				OB SET:C1220($ob_temp;"ProfesorJefe";$t_nomProfejefe)
				OB SET:C1220($ob_temp;"periodos";$ob_periodos)
				OB SET:C1220($ob_raiz;$at_cursos{$curso};$ob_temp)
				CLEAR VARIABLE:C89($ob_periodos)
			End for 
			OB SET ARRAY:C1227($ob_raiz;"cursos";$at_cursos)  //este arreglo lo utilizo para desplegar en STWA
			OB SET:C1220($ob_raiz;"mesActual";Month of:C24(Current date:C33(*)))
			
			  //Cargo los meses del año con nombre y numero
			For ($i;1;12)
				$t_mesNombre:=DT_GetMonthNameFromMonthNum ($i)
				APPEND TO ARRAY:C911($at_mesNombre;$t_mesNombre)
				APPEND TO ARRAY:C911($al_mesNumero;$i)
			End for 
			OB SET ARRAY:C1227($ob_meses;"nombre";$at_mesNombre)
			OB SET ARRAY:C1227($ob_meses;"numero";$al_mesNumero)
			OB SET:C1220($ob_raiz;"meses";$ob_meses)
			
			
		Else 
			$b_error:=True:C214
		End if 
		
		OB_SET ($ob_raiz;->$b_error;"ERR")
		$json:=OB_Object2Json ($ob_raiz)
		$0:=$json
		
	: ($dato="imprimir")
		
		$t_objeto:=NV_GetValueFromPairedArrays ($y_ParameterNames;$y_ParameterValues;"filtros")
		$ob_filtros:=OB_Create 
		$ob_filtros:=OB_JsonToObject ($t_objeto)
		
		OB_GET ($ob_filtros;->$ob_LibroClases;"LibroClases")
		OB_GET ($ob_filtros;->$ob_AntecedentesGenerales;"AntecedentesGenerales")
		OB_GET ($ob_filtros;->$ob_ControlAsignatura;"ControlAsignatura")
		OB_GET ($ob_filtros;->$ob_Subvencion;"Subvencion")
		OB_GET ($ob_filtros;->$ob_InformeNotas;"InformeNotas")
		OB_GET ($ob_filtros;->$ob_RegistroObjetivo;"RegistroObjetivo")
		OB_GET ($ob_filtros;->$ob_Hojavida;"Hojavida")
		
		OB_GET ($ob_LibroClases;->$t_cursoaimprimir;"cursoaimprimir")
		APPEND TO ARRAY:C911($at_curso;$t_cursoaimprimir)
		OB_GET ($ob_AntecedentesGenerales;->$t_cursoaimprimir;"cursoaimprimir")
		APPEND TO ARRAY:C911($at_curso;$t_cursoaimprimir)
		OB_GET ($ob_ControlAsignatura;->$t_cursoaimprimir;"cursoaimprimir")
		APPEND TO ARRAY:C911($at_curso;$t_cursoaimprimir)
		OB_GET ($ob_Subvencion;->$t_cursoaimprimir;"cursoaimprimir")
		APPEND TO ARRAY:C911($at_curso;$t_cursoaimprimir)
		OB_GET ($ob_InformeNotas;->$t_cursoaimprimir;"cursoaimprimir")
		APPEND TO ARRAY:C911($at_curso;$t_cursoaimprimir)
		OB_GET ($ob_RegistroObjetivo;->$t_cursoaimprimir;"cursoaimprimir")
		APPEND TO ARRAY:C911($at_curso;$t_cursoaimprimir)
		OB_GET ($ob_Hojavida;->$t_cursoaimprimir;"cursoaimprimir")
		APPEND TO ARRAY:C911($at_curso;$t_cursoaimprimir)
		
		AT_DistinctsArrayValues (->$at_curso)
		
		For ($l_indice;Size of array:C274($at_curso);1;-1)
			If ($at_curso{$l_indice}="")
				DELETE FROM ARRAY:C228($at_curso;$l_indice)
			End if 
		End for 
		
		
		$t_cursoaimprimir:=$at_curso{Size of array:C274($at_curso)}
		$t_NombreDoc:="InformeLCD-"+$t_cursoaimprimir+$t_extension
		$t_rutaCarpetaPDF:=SYS_CarpetaAplicacion (CLG_Estructura)
		$t_rutaDocumento:=$t_rutaCarpetaPDF+"Carpeta Web"+SYS_FolderDelimiterOnServer +"InformesLCD"+SYS_FolderDelimiterOnServer +String:C10($userID)+SYS_FolderDelimiterOnServer 
		SYS_CreaCarpeta ($t_rutaDocumento)
		$t_rutaPrint:=$t_rutaDocumento
		$t_rutaDocumento:=$t_rutaDocumento+$t_NombreDoc
		
		$l_error:=SR_PrintReports ("openSession";->$t_rutaDocumento;->$t_NombreDoc;->$session)
		
		For ($i;1;Size of array:C274($at_informes))
			
			$t_curso:=""
			$b_imprimir:=False:C215
			b_esGrupal:=False:C215
			
			QUERY:C277([xShell_Reports:54];[xShell_Reports:54]UUID:47=$at_informesUUID{$i})
			$l_recNumReporte:=Record number:C243([xShell_Reports:54])
			
			Case of 
				: ($at_informes{$i}="LibroClases")
					
					vyQR_TablePointer:=->[Cursos:3]
					yBWR_currentTable:=->[Cursos:3]
					
					OB_GET ($ob_LibroClases;->$b_imprimir;"imprimir")
					QUERY:C277([Cursos:3];[Cursos:3]Curso:1=$t_cursoaimprimir)
					
					If (Records in selection:C76([Cursos:3])=0)
						b_esGrupal:=True:C214
					End if 
					
					If ($b_imprimir)
						$l_error:=SR_PrintReports ("print";->$l_recNumReporte;->$t_rutaPrint;->$session)
					End if 
					
				: ($at_informes{$i}="AntecedentesGenerales")
					
					vyQR_TablePointer:=->[Cursos:3]
					yBWR_currentTable:=->[Cursos:3]
					
					OB_GET ($ob_AntecedentesGenerales;->$b_imprimir;"imprimir")
					QUERY:C277([Cursos:3];[Cursos:3]Curso:1=$t_cursoaimprimir)
					
					If (Records in selection:C76([Cursos:3])=0)
						b_esGrupal:=True:C214
					End if 
					
					If ($b_imprimir)
						$l_error:=SR_PrintReports ("print";->$l_recNumReporte;->$t_rutaPrint;->$session)
					End if 
					
				: ($at_informes{$i}="ControlAsignatura")
					
					vyQR_TablePointer:=->[Cursos:3]
					yBWR_currentTable:=->[Cursos:3]
					
					OB_GET ($ob_ControlAsignatura;->$b_imprimir;"imprimir")
					QUERY:C277([Cursos:3];[Cursos:3]Curso:1=$t_cursoaimprimir)
					
					$t_desde:=""
					$t_hasta:=""
					
					OB_GET ($ob_ControlAsignatura;->$t_desde;"fechadesde")
					OB_GET ($ob_ControlAsignatura;->$t_hasta;"fechahasta")
					
					$t_desde:=Replace string:C233($t_desde;"-";"/")
					$t_hasta:=Replace string:C233($t_hasta;"-";"/")
					$l_dia:=Num:C11(ST_GetWord ($t_desde;1;"/"))
					$l_mes:=Num:C11(ST_GetWord ($t_desde;2;"/"))
					$l_año:=Num:C11(ST_GetWord ($t_desde;3;"/"))
					vinidate:=DT_GetDateFromDayMonthYear ($l_dia;$l_mes;$l_año)
					
					$l_dia:=Num:C11(ST_GetWord ($t_hasta;1;"/"))
					$l_mes:=Num:C11(ST_GetWord ($t_hasta;2;"/"))
					$l_año:=Num:C11(ST_GetWord ($t_hasta;3;"/"))
					venddate:=DT_GetDateFromDayMonthYear ($l_dia;$l_mes;$l_año)
					
					
					If (Records in selection:C76([Cursos:3])=0)
						b_esGrupal:=True:C214
					End if 
					
					If ($b_imprimir)
						$l_error:=SR_PrintReports ("print";->$l_recNumReporte;->$t_rutaPrint;->$session)
					End if 
					
				: ($at_informes{$i}="Subvencion")
					
					OB_GET ($ob_filtros;->$ob_Subvencion;"Subvencion")
					OB_GET ($ob_Subvencion;->$b_imprimir;"imprimir")
					OB_GET ($ob_Subvencion;->$ab_imprimir;"Mesesimprimir")
					
					vyQR_TablePointer:=->[Cursos:3]
					yBWR_currentTable:=->[Cursos:3]
					
					
					QUERY:C277([Cursos:3];[Cursos:3]Curso:1=$t_cursoaimprimir)
					
					If (Records in selection:C76([Cursos:3])=0)
						b_esGrupal:=True:C214
					End if 
					
					If ($b_imprimir)
						ARRAY LONGINT:C221($DA_return;0)
						$ab_imprimir{0}:=True:C214
						AT_SearchArray (->$ab_imprimir;"=";->$DA_return)
						For ($m;1;Size of array:C274($DA_return))
							vi_selectedmonth:=$DA_return{$m}
							$l_error:=SR_PrintReports ("print";->$l_recNumReporte;->$t_rutaPrint;->$session)
						End for 
					End if 
					
				: ($at_informes{$i}="InformeNotas")
					
					
					OB_GET ($ob_InformeNotas;->$b_imprimir;"imprimir")
					If ($b_imprimir)
						
						vyQR_TablePointer:=->[Asignaturas:18]
						yBWR_currentTable:=->[Asignaturas:18]
						
						OB_GET ($ob_InformeNotas;->$al_NumAsignatura;"AsignaturasNumero")
						OB_GET ($ob_InformeNotas;->$ab_asigimprimir;"AsignaturasImprimir")
						OB_GET ($ob_InformeNotas;->$ab_PeriodoImprimir;"PeriodosImprimir")
						
						For ($asig;1;Size of array:C274($al_NumAsignatura))
							If ($ab_asigimprimir{$asig})  //valido si esta aisgnatura se imprime
								QUERY:C277([Asignaturas:18];[Asignaturas:18]Numero:1=$al_NumAsignatura{$asig})
								If (Records in selection:C76([Asignaturas:18])>0)
									For ($periodo;1;Size of array:C274($ab_PeriodoImprimir))
										If ($ab_PeriodoImprimir{$periodo})
											vperiodo:=$periodo
											$l_error:=SR_PrintReports ("print";->$l_recNumReporte;->$t_rutaPrint;->$session)
										End if 
									End for 
								End if 
							End if 
						End for 
					End if 
					
				: ($at_informes{$i}="RegistroObjetivo")
					
					OB_GET ($ob_RegistroObjetivo;->$b_imprimir;"imprimir")
					
					If ($b_imprimir)
						
						$t_desde:=""
						$t_hasta:=""
						OB_GET ($ob_RegistroObjetivo;->$al_NumAsignatura;"AsignaturasNumero")
						OB_GET ($ob_RegistroObjetivo;->$ab_asigimprimir;"AsignaturasImprimir1")
						OB_GET ($ob_RegistroObjetivo;->$t_desde;"fechadesde1")
						OB_GET ($ob_RegistroObjetivo;->$t_hasta;"fechahasta1")
						
						$t_desde:=Replace string:C233($t_desde;"-";"/")
						$t_hasta:=Replace string:C233($t_hasta;"-";"/")
						$l_dia:=Num:C11(ST_GetWord ($t_desde;1;"/"))
						$l_mes:=Num:C11(ST_GetWord ($t_desde;2;"/"))
						$l_año:=Num:C11(ST_GetWord ($t_desde;3;"/"))
						vinidate:=DT_GetDateFromDayMonthYear ($l_dia;$l_mes;$l_año)
						
						$l_dia:=Num:C11(ST_GetWord ($t_hasta;1;"/"))
						$l_mes:=Num:C11(ST_GetWord ($t_hasta;2;"/"))
						$l_año:=Num:C11(ST_GetWord ($t_hasta;3;"/"))
						venddate:=DT_GetDateFromDayMonthYear ($l_dia;$l_mes;$l_año)
						
						vyQR_TablePointer:=->[Asignaturas:18]
						yBWR_currentTable:=->[Asignaturas:18]
						
						For ($asig;1;Size of array:C274($al_NumAsignatura))
							If ($ab_asigimprimir{$asig})
								QUERY:C277([Asignaturas:18];[Asignaturas:18]Numero:1=$al_NumAsignatura{$asig})
								$l_error:=SR_PrintReports ("print";->$l_recNumReporte;->$t_rutaPrint;->$session)
							End if 
						End for 
					End if 
					
				: ($at_informes{$i}="Hojavida")
					OB_GET ($ob_Hojavida;->$b_imprimir;"imprimir")
					
					If ($b_imprimir)
						
						$t_desde:=""
						$t_hasta:=""
						OB_GET ($ob_Hojavida;->$t_desde;"fechadesde")
						OB_GET ($ob_Hojavida;->$t_hasta;"fechahasta")
						
						$t_desde:=Replace string:C233($t_desde;"-";"/")
						$t_hasta:=Replace string:C233($t_hasta;"-";"/")
						$l_dia:=Num:C11(ST_GetWord ($t_desde;1;"/"))
						$l_mes:=Num:C11(ST_GetWord ($t_desde;2;"/"))
						$l_año:=Num:C11(ST_GetWord ($t_desde;3;"/"))
						vinidate:=DT_GetDateFromDayMonthYear ($l_dia;$l_mes;$l_año)
						
						$l_dia:=Num:C11(ST_GetWord ($t_hasta;1;"/"))
						$l_mes:=Num:C11(ST_GetWord ($t_hasta;2;"/"))
						$l_año:=Num:C11(ST_GetWord ($t_hasta;3;"/"))
						venddate:=DT_GetDateFromDayMonthYear ($l_dia;$l_mes;$l_año)
						
						vyQR_TablePointer:=->[Alumnos:2]
						yBWR_currentTable:=->[Alumnos:2]
						
						QUERY:C277([Cursos:3];[Cursos:3]Curso:1=$t_cursoaimprimir)
						
						If (Records in selection:C76([Cursos:3])=0)
							b_esGrupal:=True:C214
						End if 
						
						If (Records in selection:C76([Cursos:3])>0)
							QUERY:C277([Alumnos:2];[Alumnos:2]curso:20=$t_cursoaimprimir)
						Else 
							QUERY:C277([Asignaturas:18];[Asignaturas:18]Curso:5=$t_cursoaimprimir)
							QUERY:C277([Alumnos_Calificaciones:208];[Alumnos_Calificaciones:208]ID_Asignatura:5=[Asignaturas:18]Numero:1)
							KRL_RelateSelection (->[Alumnos:2]numero:1;->[Alumnos_Calificaciones:208]ID_Alumno:6;"")
						End if 
						
						ORDER BY:C49([Alumnos:2];[Alumnos:2]no_de_lista:53;>)
						SELECTION TO ARRAY:C260([Alumnos:2]numero:1;$al_numAlumnos)
						
						For ($alu;1;Size of array:C274($al_numAlumnos))
							QUERY:C277([Alumnos:2];[Alumnos:2]numero:1=$al_numAlumnos{$alu})
							$l_error:=SR_PrintReports ("print";->$l_recNumReporte;->$t_rutaPrint;->$session)
						End for 
					End if 
			End case 
		End for 
		$l_error:=SR_PrintReports ("CloseSession";->$session)
		
		CLEAR VARIABLE:C89($b_error)
		
		If ($l_error#0)
			$b_error:=True:C214
		Else 
			$t_url:="../InformesLCD/"+String:C10($userID)+"/"+$t_NombreDoc
		End if 
		
		$ob_temp:=OB_Create 
		OB_SET ($ob_temp;->$b_error;"ERR")
		OB_SET ($ob_temp;->$t_url;"url")
		$json:=OB_Object2Json ($ob_temp)
		$0:=$json
		
	: ($dato="imprimirsimple")
		
		$t_objeto:=NV_GetValueFromPairedArrays ($y_ParameterNames;$y_ParameterValues;"filtros")
		$t_modelo:=NV_GetValueFromPairedArrays ($y_ParameterNames;$y_ParameterValues;"modelo")
		$ob_filtros:=OB_Create 
		$ob_filtros:=OB_JsonToObject ($t_objeto)
		b_esGrupal:=False:C215
		$t_rutaCarpetaPDF:=SYS_CarpetaAplicacion (CLG_Estructura)
		$t_rutaDocumento:=$t_rutaCarpetaPDF+"Carpeta Web"+SYS_FolderDelimiterOnServer +"InformesLCD"+SYS_FolderDelimiterOnServer +String:C10($userID)+SYS_FolderDelimiterOnServer 
		$t_rutaPrint:=$t_rutaDocumento
		SYS_CreaCarpeta ($t_rutaDocumento)
		
		Case of 
			: ($t_modelo="LibroClases")
				OB_GET ($ob_filtros;->$ob_LibroClases;"LibroClases")
				OB_GET ($ob_LibroClases;->$t_cursoaimprimir;"cursoaimprimir")
				$t_NombreDoc:="Identificación Libro de Clases-"+$t_cursoaimprimir+$t_extension
				$t_rutaDocumento:=$t_rutaDocumento+$t_NombreDoc
				  //$t_rutaCarpetaPDF:=Temporary folder
				  //$t_rutaDocumento:=$t_rutaCarpetaPdf+$t_NombreDoc
				
				$l_error:=SR_PrintReports ("openSession";->$t_rutaDocumento;->$t_NombreDoc;->$session)
				
				QUERY:C277([Cursos:3];[Cursos:3]Curso:1=$t_cursoaimprimir)
				
				If (Records in selection:C76([Cursos:3])=0)
					b_esGrupal:=True:C214
				End if 
				
				vyQR_TablePointer:=->[Cursos:3]
				yBWR_currentTable:=->[Cursos:3]
				
				QUERY:C277([xShell_Reports:54];[xShell_Reports:54]UUID:47=$at_informesUUID{1})
				$l_recNumReporte:=Record number:C243([xShell_Reports:54])
				$l_error:=SR_PrintReports ("print";->$l_recNumReporte;->$t_rutaPrint;->$session)
				$l_error:=SR_PrintReports ("CloseSession";->$session)
				
				
			: ($t_modelo="AntecedentesGenerales")
				
				OB_GET ($ob_filtros;->$ob_AntecedentesGenerales;"AntecedentesGenerales")
				OB_GET ($ob_AntecedentesGenerales;->$t_cursoaimprimir;"cursoaimprimir")
				
				$t_NombreDoc:="Antecedentes Generales-"+$t_cursoaimprimir+$t_extension
				$t_rutaDocumento:=$t_rutaDocumento+$t_NombreDoc
				
				$l_error:=SR_PrintReports ("openSession";->$t_rutaDocumento;->$t_NombreDoc;->$session)
				
				QUERY:C277([Cursos:3];[Cursos:3]Curso:1=$t_cursoaimprimir)
				
				If (Records in selection:C76([Cursos:3])=0)
					b_esGrupal:=True:C214
				End if 
				
				vyQR_TablePointer:=->[Cursos:3]
				yBWR_currentTable:=->[Cursos:3]
				
				QUERY:C277([xShell_Reports:54];[xShell_Reports:54]UUID:47=$at_informesUUID{2})
				$l_recNumReporte:=Record number:C243([xShell_Reports:54])
				$l_error:=SR_PrintReports ("print";->$l_recNumReporte;->$t_rutaPrint;->$session)
				$l_error:=SR_PrintReports ("CloseSession";->$session)
				
			: ($t_modelo="ControlAsignatura")
				
				OB_GET ($ob_filtros;->$ob_ControlAsignatura;"ControlAsignatura")
				OB_GET ($ob_ControlAsignatura;->$t_cursoaimprimir;"cursoaimprimir")
				
				$t_NombreDoc:="Registro de Control de Asignatura-"+$t_cursoaimprimir+$t_extension
				$t_rutaDocumento:=$t_rutaDocumento+$t_NombreDoc
				
				$l_error:=SR_PrintReports ("openSession";->$t_rutaDocumento;->$t_NombreDoc;->$session)
				
				QUERY:C277([Cursos:3];[Cursos:3]Curso:1=$t_cursoaimprimir)
				
				If (Records in selection:C76([Cursos:3])=0)
					b_esGrupal:=True:C214
				End if 
				
				vyQR_TablePointer:=->[Cursos:3]
				yBWR_currentTable:=->[Cursos:3]
				
				$t_desde:=""
				$t_hasta:=""
				
				OB_GET ($ob_ControlAsignatura;->$t_desde;"fechadesde")
				OB_GET ($ob_ControlAsignatura;->$t_hasta;"fechahasta")
				
				$t_desde:=Replace string:C233($t_desde;"-";"/")
				$t_hasta:=Replace string:C233($t_hasta;"-";"/")
				$l_dia:=Num:C11(ST_GetWord ($t_desde;1;"/"))
				$l_mes:=Num:C11(ST_GetWord ($t_desde;2;"/"))
				$l_año:=Num:C11(ST_GetWord ($t_desde;3;"/"))
				vinidate:=DT_GetDateFromDayMonthYear ($l_dia;$l_mes;$l_año)
				
				$l_dia:=Num:C11(ST_GetWord ($t_hasta;1;"/"))
				$l_mes:=Num:C11(ST_GetWord ($t_hasta;2;"/"))
				$l_año:=Num:C11(ST_GetWord ($t_hasta;3;"/"))
				venddate:=DT_GetDateFromDayMonthYear ($l_dia;$l_mes;$l_año)
				
				QUERY:C277([xShell_Reports:54];[xShell_Reports:54]UUID:47=$at_informesUUID{3})
				$l_recNumReporte:=Record number:C243([xShell_Reports:54])
				$l_error:=SR_PrintReports ("print";->$l_recNumReporte;->$t_rutaPrint;->$session)
				$l_error:=SR_PrintReports ("CloseSession";->$session)
				
			: ($t_modelo="Subvencion")
				
				OB_GET ($ob_filtros;->$ob_Subvencion;"Subvencion")
				OB_GET ($ob_Subvencion;->$t_cursoaimprimir;"cursoaimprimir")
				
				$t_NombreDoc:="Registro control de subvenciones-"+$t_cursoaimprimir+$t_extension
				$t_rutaDocumento:=$t_rutaDocumento+$t_NombreDoc
				
				$l_error:=SR_PrintReports ("openSession";->$t_rutaDocumento;->$t_NombreDoc;->$session)
				
				QUERY:C277([Cursos:3];[Cursos:3]Curso:1=$t_cursoaimprimir)
				
				If (Records in selection:C76([Cursos:3])=0)
					b_esGrupal:=True:C214
				End if 
				
				If (Records in selection:C76([Cursos:3])=0)
					QUERY:C277([Asignaturas:18];[Asignaturas:18]Curso:5=$t_cursoaimprimir)
					KRL_RelateSelection (->[Alumnos_Calificaciones:208]ID_Asignatura:5;->[Asignaturas:18]Numero:1;"")
					KRL_RelateSelection (->[Alumnos:2]numero:1;->[Alumnos_Calificaciones:208]ID_Alumno:6;"")
				End if 
				
				vyQR_TablePointer:=->[Cursos:3]
				yBWR_currentTable:=->[Cursos:3]
				
				OB_GET ($ob_Subvencion;->$ab_imprimir;"Mesesimprimir")
				QUERY:C277([xShell_Reports:54];[xShell_Reports:54]UUID:47=$at_informesUUID{4})
				$l_recNumReporte:=Record number:C243([xShell_Reports:54])
				
				$ab_imprimir{0}:=True:C214
				AT_SearchArray (->$ab_imprimir;"=";->$DA_return)
				For ($m;1;Size of array:C274($DA_return))
					vi_selectedmonth:=$DA_return{$m}
					$l_error:=SR_PrintReports ("print";->$l_recNumReporte;->$t_rutaPrint;->$session)
				End for 
				$l_error:=SR_PrintReports ("CloseSession";->$session)
				
			: ($t_modelo="InformeNotas")
				
				OB_GET ($ob_filtros;->$ob_InformeNotas;"InformeNotas")
				OB_GET ($ob_InformeNotas;->$t_cursoaimprimir;"cursoaimprimir")
				OB_GET ($ob_InformeNotas;->$al_NumAsignatura;"AsignaturasNumero")
				OB_GET ($ob_InformeNotas;->$ab_asigimprimir;"AsignaturasImprimir")
				OB_GET ($ob_InformeNotas;->$ab_PeriodoImprimir;"PeriodosImprimir")
				
				$t_NombreDoc:="Informe de notas"+$t_cursoaimprimir+$t_extension
				$t_rutaDocumento:=$t_rutaDocumento+$t_NombreDoc
				
				$l_error:=SR_PrintReports ("openSession";->$t_rutaDocumento;->$t_NombreDoc;->$session)
				
				vyQR_TablePointer:=->[Asignaturas:18]
				yBWR_currentTable:=->[Asignaturas:18]
				
				QUERY:C277([xShell_Reports:54];[xShell_Reports:54]UUID:47=$at_informesUUID{5})
				$l_recNumReporte:=Record number:C243([xShell_Reports:54])
				
				For ($asig;1;Size of array:C274($al_NumAsignatura))
					If ($ab_asigimprimir{$asig})  //valido si esta aisgnatura se imprime
						QUERY:C277([Asignaturas:18];[Asignaturas:18]Numero:1=$al_NumAsignatura{$asig})
						If (Records in selection:C76([Asignaturas:18])>0)
							For ($periodo;1;Size of array:C274($ab_PeriodoImprimir))
								If ($ab_PeriodoImprimir{$periodo})
									vperiodo:=$periodo
									$l_error:=SR_PrintReports ("print";->$l_recNumReporte;->$t_rutaPrint;->$session)
								End if 
							End for   //por periodos aca imprimir
						End if 
					End if 
				End for   //asignatura
				$l_error:=SR_PrintReports ("CloseSession";->$session)
				
			: ($t_modelo="RegistroObjetivo")
				
				OB_GET ($ob_filtros;->$ob_RegistroObjetivo;"RegistroObjetivo")
				OB_GET ($ob_RegistroObjetivo;->$t_cursoaimprimir;"cursoaimprimir")
				
				$t_desde:=""
				$t_hasta:=""
				
				OB_GET ($ob_RegistroObjetivo;->$al_NumAsignatura;"AsignaturasNumero")
				OB_GET ($ob_RegistroObjetivo;->$ab_asigimprimir;"AsignaturasImprimir1")
				OB_GET ($ob_RegistroObjetivo;->$t_desde;"fechadesde1")
				OB_GET ($ob_RegistroObjetivo;->$t_hasta;"fechahasta1")
				
				$t_desde:=Replace string:C233($t_desde;"-";"/")
				$t_hasta:=Replace string:C233($t_hasta;"-";"/")
				$l_dia:=Num:C11(ST_GetWord ($t_desde;1;"/"))
				$l_mes:=Num:C11(ST_GetWord ($t_desde;2;"/"))
				$l_año:=Num:C11(ST_GetWord ($t_desde;3;"/"))
				vinidate:=DT_GetDateFromDayMonthYear ($l_dia;$l_mes;$l_año)
				
				$l_dia:=Num:C11(ST_GetWord ($t_hasta;1;"/"))
				$l_mes:=Num:C11(ST_GetWord ($t_hasta;2;"/"))
				$l_año:=Num:C11(ST_GetWord ($t_hasta;3;"/"))
				venddate:=DT_GetDateFromDayMonthYear ($l_dia;$l_mes;$l_año)
				
				$t_NombreDoc:="registro de objetivos-contenidos de materias"+$t_cursoaimprimir+$t_extension
				$t_rutaDocumento:=$t_rutaDocumento+$t_NombreDoc
				
				$l_error:=SR_PrintReports ("openSession";->$t_rutaDocumento;->$t_NombreDoc;->$session)
				
				vyQR_TablePointer:=->[Asignaturas:18]
				yBWR_currentTable:=->[Asignaturas:18]
				
				QUERY:C277([xShell_Reports:54];[xShell_Reports:54]UUID:47=$at_informesUUID{6})
				$l_recNumReporte:=Record number:C243([xShell_Reports:54])
				
				For ($asig;1;Size of array:C274($al_NumAsignatura))
					If ($ab_asigimprimir{$asig})
						QUERY:C277([Asignaturas:18];[Asignaturas:18]Numero:1=$al_NumAsignatura{$asig})
						$l_error:=SR_PrintReports ("print";->$l_recNumReporte;->$t_rutaPrint;->$session)
					End if 
				End for 
				$l_error:=SR_PrintReports ("CloseSession";->$session)
				
			: ($t_modelo="Hojavida")
				OB_GET ($ob_filtros;->$ob_Hojavida;"Hojavida")
				$t_desde:=""
				$t_hasta:=""
				OB_GET ($ob_Hojavida;->$t_desde;"fechadesde")
				OB_GET ($ob_Hojavida;->$t_hasta;"fechahasta")
				OB_GET ($ob_Hojavida;->$t_cursoaimprimir;"cursoaimprimir")
				
				$t_desde:=Replace string:C233($t_desde;"-";"/")
				$t_hasta:=Replace string:C233($t_hasta;"-";"/")
				$l_dia:=Num:C11(ST_GetWord ($t_desde;1;"/"))
				$l_mes:=Num:C11(ST_GetWord ($t_desde;2;"/"))
				$l_año:=Num:C11(ST_GetWord ($t_desde;3;"/"))
				vinidate:=DT_GetDateFromDayMonthYear ($l_dia;$l_mes;$l_año)
				
				$l_dia:=Num:C11(ST_GetWord ($t_hasta;1;"/"))
				$l_mes:=Num:C11(ST_GetWord ($t_hasta;2;"/"))
				$l_año:=Num:C11(ST_GetWord ($t_hasta;3;"/"))
				venddate:=DT_GetDateFromDayMonthYear ($l_dia;$l_mes;$l_año)
				
				$t_NombreDoc:="Hoja de vida de los alumnos"+$t_cursoaimprimir+$t_extension
				$t_rutaDocumento:=$t_rutaDocumento+$t_NombreDoc
				$l_error:=SR_PrintReports ("openSession";->$t_rutaDocumento;->$t_NombreDoc;->$session)
				
				vyQR_TablePointer:=->[Alumnos:2]
				yBWR_currentTable:=->[Alumnos:2]
				
				QUERY:C277([Cursos:3];[Cursos:3]Curso:1=$t_cursoaimprimir)
				
				If (Records in selection:C76([Cursos:3])=0)
					b_esGrupal:=True:C214
				End if 
				
				QUERY:C277([xShell_Reports:54];[xShell_Reports:54]UUID:47=$at_informesUUID{7})
				$l_recNumReporte:=Record number:C243([xShell_Reports:54])
				
				If (Records in selection:C76([Cursos:3])>0)
					QUERY:C277([Alumnos:2];[Alumnos:2]curso:20=$t_cursoaimprimir)
				Else 
					QUERY:C277([Asignaturas:18];[Asignaturas:18]Curso:5=$t_cursoaimprimir)
					QUERY:C277([Alumnos_Calificaciones:208];[Alumnos_Calificaciones:208]ID_Asignatura:5=[Asignaturas:18]Numero:1)
					KRL_RelateSelection (->[Alumnos:2]numero:1;->[Alumnos_Calificaciones:208]ID_Alumno:6;"")
				End if 
				ORDER BY:C49([Alumnos:2];[Alumnos:2]no_de_lista:53;>)
				SELECTION TO ARRAY:C260([Alumnos:2]numero:1;$al_numAlumnos)
				For ($alu;1;Size of array:C274($al_numAlumnos))
					QUERY:C277([Alumnos:2];[Alumnos:2]numero:1=$al_numAlumnos{$alu})
					$l_error:=SR_PrintReports ("print";->$l_recNumReporte;->$t_rutaPrint;->$session)
				End for 
				$l_error:=SR_PrintReports ("CloseSession";->$session)
		End case 
		
		CLEAR VARIABLE:C89($b_error)
		
		If ($l_error#0)
			$b_error:=True:C214
		Else 
			$t_url:="../InformesLCD/"+String:C10($userID)+"/"+$t_NombreDoc
		End if 
		
		$ob_temp:=OB_Create 
		OB_SET ($ob_temp;->$b_error;"ERR")
		OB_SET ($ob_temp;->$t_url;"url")
		$json:=OB_Object2Json ($ob_temp)
		$0:=$json
		
End case 

