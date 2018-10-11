//%attributes = {}
C_POINTER:C301($1)

READ ONLY:C145([Cursos:3])
READ ONLY:C145([Cursos_SintesisAnual:63])
If (Count parameters:C259=1)
	CREATE SELECTION FROM ARRAY:C640([Cursos:3];$1->)
	QUERY SELECTION:C341([Cursos:3];[Cursos:3]Numero_del_curso:6>0)
Else 
	QUERY:C277([Cursos:3];[Cursos:3]Numero_del_curso:6>0)
End if 

If (Records in selection:C76([Cursos:3])>0)
	$refXMLDoc:=CONDOR_ExportDataGenArchivo ("cursos";->$vt_FileName)
	
	ARRAY LONGINT:C221($recNums;0)
	LONGINT ARRAY FROM SELECTION:C647([Cursos:3];$recNums)
	$size:=Size of array:C274($recNums)
	
	$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;__ ("Generando documento con ")+String:C10($size)+__ (" registros de cursos..."))
	For ($indice;1;$size)
		KRL_GotoRecord (->[Cursos:3];$recNums{$indice};False:C215)
		CONDOR_ExportSAXCreateNode ($refXMLDoc;"curso")
		CONDOR_ExportSAXCreateNode ($refXMLDoc;"uuid";True:C214;CONDOR_ExportDataTransformer (->[Cursos:3]Auto_UUID:47);False:C215)
		CONDOR_ExportSAXCreateNode ($refXMLDoc;"curso";True:C214;CONDOR_ExportDataTransformer (->[Cursos:3]Curso:1);True:C214;False:C215)
		CONDOR_ExportSAXCreateNode ($refXMLDoc;"nombre_largo";True:C214;CONDOR_ExportDataTransformer (->[Cursos:3]Nombre_Largo_curso:46);True:C214;False:C215)
		CONDOR_ExportSAXCreateNode ($refXMLDoc;"nombre_oficial";True:C214;CONDOR_ExportDataTransformer (->[Cursos:3]Nombre_Oficial_Curso:15);True:C214;False:C215)
		CONDOR_ExportSAXCreateNode ($refXMLDoc;"uuid_profesor_jefe";True:C214;CONDOR_ExportDataTransformer (->[Cursos:3]Numero_del_profesor_jefe:2);False:C215;False:C215)
		CONDOR_ExportSAXCreateNode ($refXMLDoc;"sala";True:C214;CONDOR_ExportDataTransformer (->[Cursos:3]Sala:3);True:C214;False:C215)
		CONDOR_ExportSAXCreateNode ($refXMLDoc;"nivel";True:C214;CONDOR_ExportDataTransformer (->[Cursos:3]Nivel_Numero:7);False:C215;False:C215)
		CONDOR_ExportSAXCreateNode ($refXMLDoc;"ciclo";True:C214;CONDOR_ExportDataTransformer (->[Cursos:3]Ciclo:5);True:C214;False:C215)
		CONDOR_ExportSAXCreateNode ($refXMLDoc;"cicloescolar";True:C214;CONDOR_ExportDataTransformer (->[Cursos:3]CicloEscolar:16);True:C214;False:C215)
		CONDOR_ExportSAXCreateNode ($refXMLDoc;"letra";True:C214;CONDOR_ExportDataTransformer (->[Cursos:3]Letra_del_curso:9);True:C214;False:C215)
		CONDOR_ExportSAXCreateNode ($refXMLDoc;"letraoficial";True:C214;CONDOR_ExportDataTransformer (->[Cursos:3]Letra_Oficial_del_Curso:18);True:C214;False:C215)
		CONDOR_ExportSAXCreateNode ($refXMLDoc;"sede";True:C214;CONDOR_ExportDataTransformer (->[Cursos:3]Sede:19);True:C214;False:C215)
		CONDOR_ExportSAXCreateNode ($refXMLDoc;"rol";True:C214;CONDOR_ExportDataTransformer (->[Cursos:3]cl_RolBaseDatos:20);True:C214;False:C215)
		CONDOR_ExportSAXCreateNode ($refXMLDoc;"uuid_director";True:C214;CONDOR_ExportDataTransformer (->[Cursos:3]Director_IdFuncionario:42);False:C215;False:C215)
		CONDOR_ExportSAXCreateNode ($refXMLDoc;"cl_CodigoDecretoEvaluacion";True:C214;CONDOR_ExportDataTransformer (->[Cursos:3]cl_CodigoDecretoEvaluacion:24);True:C214;False:C215)
		CONDOR_ExportSAXCreateNode ($refXMLDoc;"cl_CodigoDecretoPlanEstudios";True:C214;CONDOR_ExportDataTransformer (->[Cursos:3]cl_CodigoDecretoPlanEstudios:22);True:C214;False:C215)
		CONDOR_ExportSAXCreateNode ($refXMLDoc;"cl_CodigoEspecialidadTP";True:C214;CONDOR_ExportDataTransformer (->[Cursos:3]cl_CodigoEspecialidadTP:29);True:C214;False:C215)
		CONDOR_ExportSAXCreateNode ($refXMLDoc;"cl_CodigoNivelEspecial";True:C214;CONDOR_ExportDataTransformer (->[Cursos:3]cl_CodigoNivelEspecial:36);True:C214;False:C215)
		CONDOR_ExportSAXCreateNode ($refXMLDoc;"cl_CodigoPlanEstudios";True:C214;CONDOR_ExportDataTransformer (->[Cursos:3]cl_CodigoPlanEstudios:23);True:C214;False:C215)
		CONDOR_ExportSAXCreateNode ($refXMLDoc;"cl_CodigoTipoEnseñanza";True:C214;CONDOR_ExportDataTransformer (->[Cursos:3]cl_CodigoTipoEnseñanza:21);True:C214;False:C215)
		CONDOR_ExportSAXCreateNode ($refXMLDoc;"cl_EspecialidadTP";True:C214;CONDOR_ExportDataTransformer (->[Cursos:3]cl_EspecialidadTP:28);True:C214;False:C215)
		CONDOR_ExportSAXCreateNode ($refXMLDoc;"cl_RamaTP";True:C214;CONDOR_ExportDataTransformer (->[Cursos:3]cl_RamaTP:26);True:C214;False:C215)
		CONDOR_ExportSAXCreateNode ($refXMLDoc;"cl_SectorEconomicoTP";True:C214;CONDOR_ExportDataTransformer (->[Cursos:3]cl_SectorEconomicoTP:27);True:C214;False:C215)
		CONDOR_ExportSAXCreateNode ($refXMLDoc;"cl_TipoEnseñanza";True:C214;CONDOR_ExportDataTransformer (->[Cursos:3]cl_TipoEnseñanza:25);True:C214;False:C215)
		CONDOR_ExportSAXCreateNode ($refXMLDoc;"jornada";True:C214;CONDOR_ExportDataTransformer (->[Cursos:3]Jornada:32);False:C215;False:C215)
		CONDOR_ExportSAXCreateNode ($refXMLDoc;"capacidad";True:C214;CONDOR_ExportDataTransformer (->[Cursos:3]Capacidad:30);False:C215;False:C215)
		CONDOR_ExportSAXCreateNode ($refXMLDoc;"matricula";True:C214;CONDOR_ExportDataTransformer (->[Cursos:3]Numero_de_Alumnos:11);False:C215;False:C215)
		CONDOR_ExportSAXCreateNode ($refXMLDoc;"vacantes";True:C214;CONDOR_ExportDataTransformer (->[Cursos:3]Vacantes:31);False:C215;False:C215)
		CONDOR_ExportSAXCreateNode ($refXMLDoc;"lastnumber";True:C214;CONDOR_ExportDataTransformer (->[Cursos:3]LastNumber:12);False:C215;False:C215)
		CONDOR_ExportSAXCreateNode ($refXMLDoc;"lastfirst_firstlast";True:C214;CONDOR_ExportDataTransformer (->[Cursos:3]LastFirst_FirstLast:13);False:C215;False:C215)
		CONDOR_ExportSAXCreateNode ($refXMLDoc;"actaespecifica";True:C214;CONDOR_ExportDataTransformer (->[Cursos:3]ActaEspecificaAlCurso:35);False:C215;False:C215)
		CONDOR_ExportSAXCreateNode ($refXMLDoc;"ordensubsectores";True:C214;CONDOR_ExportDataTransformer (->[Cursos:3]Orden_Subsectores:17);True:C214;False:C215)
		CONDOR_ExportSAXCreateNode ($refXMLDoc;"bloqueodiascalendario";True:C214;CONDOR_ExportDataTransformer (->[Cursos:3]xCalendario_DiasBloq:48);True:C214;False:C215)
		CONDOR_ExportSAXCreateNode ($refXMLDoc;"acta";True:C214;CONDOR_ExportDataTransformer (->[Cursos:3]Acta:34);True:C214;False:C215)
		
		QUERY BY FORMULA:C48([Cursos_SintesisAnual:63];([Cursos_SintesisAnual:63]ID_Curso:52=[Cursos:3]Numero_del_curso:6) | ([Cursos_SintesisAnual:63]ID_Curso:52=-Abs:C99([Cursos:3]Numero_del_curso:6)))
		If (Records in selection:C76([Cursos_SintesisAnual:63])>0)
			CONDOR_ExportSAXCreateNode ($refXMLDoc;"historicos")
			ARRAY LONGINT:C221($al_sintesisCursos;0)
			LONGINT ARRAY FROM SELECTION:C647([Cursos_SintesisAnual:63];$al_sintesisCursos)
			For ($x;1;Size of array:C274($al_sintesisCursos))
				KRL_GotoRecord (->[Cursos_SintesisAnual:63];$al_sintesisCursos{$x})
				CONDOR_ExportSAXCreateNode ($refXMLDoc;"historico")
				CONDOR_ExportSAXCreateNode ($refXMLDoc;"year";True:C214;CONDOR_ExportDataTransformer (->[Cursos_SintesisAnual:63]Año:2);False:C215;False:C215)
				CONDOR_ExportSAXCreateNode ($refXMLDoc;"nivel";True:C214;CONDOR_ExportDataTransformer (->[Cursos_SintesisAnual:63]NumeroNivel:3);False:C215;False:C215)
				CONDOR_ExportSAXCreateNode ($refXMLDoc;"cicloescolar";True:C214;CONDOR_ExportDataTransformer (->[Cursos_SintesisAnual:63]CicloEscolar:4);False:C215;False:C215)
				CONDOR_ExportSAXCreateNode ($refXMLDoc;"curso";True:C214;CONDOR_ExportDataTransformer (->[Cursos_SintesisAnual:63]Curso:5);True:C214;False:C215)
				CONDOR_ExportSAXCreateNode ($refXMLDoc;"nombre_oficial";True:C214;CONDOR_ExportDataTransformer (->[Cursos_SintesisAnual:63]NombreOficialCurso:7);True:C214;False:C215)
				CONDOR_ExportSAXCreateNode ($refXMLDoc;"uuid_profesor_jefe";True:C214;CONDOR_ExportDataTransformer (->[Cursos_SintesisAnual:63]ProfesorJefe_ID:8);False:C215;False:C215)
				CONDOR_ExportSAXCreateNode ($refXMLDoc;"sede";True:C214;CONDOR_ExportDataTransformer (->[Cursos_SintesisAnual:63]Sede:53);True:C214;False:C215)
				CONDOR_ExportSAXCreateNode ($refXMLDoc;"cl_CodigoEspecialidadTP";True:C214;CONDOR_ExportDataTransformer (->[Cursos_SintesisAnual:63]cl_CodigoEspecialidadTP:54);False:C215;False:C215)
				CONDOR_ExportSAXCreateNode ($refXMLDoc;"cl_EspecialidadTP";True:C214;CONDOR_ExportDataTransformer (->[Cursos_SintesisAnual:63]cl_EspecialidadTP:55);True:C214;False:C215)
				CONDOR_ExportSAXCreateNode ($refXMLDoc;"cl_SectorEconomicoTP";True:C214;CONDOR_ExportDataTransformer (->[Cursos_SintesisAnual:63]cl_SectorEconomicoTP:56);True:C214;False:C215)
				CONDOR_ExportSAXCreateNode ($refXMLDoc;"acta";True:C214;CONDOR_ExportDataTransformer (->[Cursos_SintesisAnual:63]Actas_y_Certificados:11);True:C214;False:C215)
				CONDOR_ExportSAXCreateNode ($refXMLDoc;"promedios")
				CONDOR_ExportSAXCreateNode ($refXMLDoc;"promedioanual")
				CONDOR_ExportSAXCreateNode ($refXMLDoc;"real";True:C214;CONDOR_ExportDataTransformer (->[Cursos_SintesisAnual:63]PromedioAnual_Real:12);False:C215;False:C215)
				CONDOR_ExportSAXCreateNode ($refXMLDoc;"nota";True:C214;CONDOR_ExportDataTransformer (->[Cursos_SintesisAnual:63]PromedioAnual_Nota:13);False:C215;False:C215)
				CONDOR_ExportSAXCreateNode ($refXMLDoc;"puntos";True:C214;CONDOR_ExportDataTransformer (->[Cursos_SintesisAnual:63]PromedioAnual_Puntos:14);False:C215;False:C215)
				CONDOR_ExportSAXCreateNode ($refXMLDoc;"simbolo";True:C214;CONDOR_ExportDataTransformer (->[Cursos_SintesisAnual:63]PromedioAnual_Simbolo:15);False:C215;False:C215)
				CONDOR_ExportSAXCreateNode ($refXMLDoc;"literal";True:C214;CONDOR_ExportDataTransformer (->[Cursos_SintesisAnual:63]PromedioAnual_Literal:16);False:C215;False:C215)
				SAX CLOSE XML ELEMENT:C854($refXMLDoc)
				CONDOR_ExportSAXCreateNode ($refXMLDoc;"promediofinal")
				CONDOR_ExportSAXCreateNode ($refXMLDoc;"real";True:C214;CONDOR_ExportDataTransformer (->[Cursos_SintesisAnual:63]PromedioFinal_Real:17);False:C215;False:C215)
				CONDOR_ExportSAXCreateNode ($refXMLDoc;"nota";True:C214;CONDOR_ExportDataTransformer (->[Cursos_SintesisAnual:63]PromedioFinal_Nota:18);False:C215;False:C215)
				CONDOR_ExportSAXCreateNode ($refXMLDoc;"puntos";True:C214;CONDOR_ExportDataTransformer (->[Cursos_SintesisAnual:63]PromedioFinal_Puntos:19);False:C215;False:C215)
				CONDOR_ExportSAXCreateNode ($refXMLDoc;"simbolo";True:C214;CONDOR_ExportDataTransformer (->[Cursos_SintesisAnual:63]PromedioFinal_Simbolo:20);False:C215;False:C215)
				CONDOR_ExportSAXCreateNode ($refXMLDoc;"literal";True:C214;CONDOR_ExportDataTransformer (->[Cursos_SintesisAnual:63]PromedioFinal_Literal:21);False:C215;False:C215)
				SAX CLOSE XML ELEMENT:C854($refXMLDoc)
				CONDOR_ExportSAXCreateNode ($refXMLDoc;"promediooficial")
				CONDOR_ExportSAXCreateNode ($refXMLDoc;"real";True:C214;CONDOR_ExportDataTransformer (->[Cursos_SintesisAnual:63]PromedioOficial_Real:22);False:C215;False:C215)
				CONDOR_ExportSAXCreateNode ($refXMLDoc;"nota";True:C214;CONDOR_ExportDataTransformer (->[Cursos_SintesisAnual:63]PromedioOficial_Nota:23);False:C215;False:C215)
				CONDOR_ExportSAXCreateNode ($refXMLDoc;"puntos";True:C214;CONDOR_ExportDataTransformer (->[Cursos_SintesisAnual:63]PromedioOficial_Puntos:24);False:C215;False:C215)
				CONDOR_ExportSAXCreateNode ($refXMLDoc;"simbolo";True:C214;CONDOR_ExportDataTransformer (->[Cursos_SintesisAnual:63]PromedioOficial_Simbolo:25);False:C215;False:C215)
				CONDOR_ExportSAXCreateNode ($refXMLDoc;"literal";True:C214;CONDOR_ExportDataTransformer (->[Cursos_SintesisAnual:63]PromedioOficial_Literal:26);False:C215;False:C215)
				SAX CLOSE XML ELEMENT:C854($refXMLDoc)
				For ($i;1;5)
					CONDOR_ExportSAXCreateNode ($refXMLDoc;"promedioperiodo")
					CONDOR_ExportSAXCreateNode ($refXMLDoc;"periodo";True:C214;String:C10($i);False:C215;False:C215)
					CONDOR_ExportSAXCreateNode ($refXMLDoc;"real";True:C214;CONDOR_ExportDataTransformer (KRL_GetFieldPointerByName ("[Cursos_SintesisAnual]P0"+String:C10($i)+"_Promedio_Real"));False:C215;False:C215)
					CONDOR_ExportSAXCreateNode ($refXMLDoc;"nota";True:C214;CONDOR_ExportDataTransformer (KRL_GetFieldPointerByName ("[Cursos_SintesisAnual]P0"+String:C10($i)+"_Promedio_Nota"));False:C215;False:C215)
					CONDOR_ExportSAXCreateNode ($refXMLDoc;"puntos";True:C214;CONDOR_ExportDataTransformer (KRL_GetFieldPointerByName ("[Cursos_SintesisAnual]P0"+String:C10($i)+"_Promedio_Puntos"));False:C215;False:C215)
					CONDOR_ExportSAXCreateNode ($refXMLDoc;"simbolo";True:C214;CONDOR_ExportDataTransformer (KRL_GetFieldPointerByName ("[Cursos_SintesisAnual]P0"+String:C10($i)+"_Promedio_Simbolo"));False:C215;False:C215)
					CONDOR_ExportSAXCreateNode ($refXMLDoc;"literal";True:C214;CONDOR_ExportDataTransformer (KRL_GetFieldPointerByName ("[Cursos_SintesisAnual]P0"+String:C10($i)+"_Promedio_Literal"));False:C215;False:C215)
					SAX CLOSE XML ELEMENT:C854($refXMLDoc)
				End for 
				SAX CLOSE XML ELEMENT:C854($refXMLDoc)  //cierre promedios
				SAX CLOSE XML ELEMENT:C854($refXMLDoc)  //cierre historico
			End for 
			SAX CLOSE XML ELEMENT:C854($refXMLDoc)  //cierre historicos
		End if 
		SAX CLOSE XML ELEMENT:C854($refXMLDoc)  //cierre curso
		$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$indice/$size;__ ("Exportando curso ")+[Cursos:3]Curso:1+", "+String:C10($indice)+__ (" de ")+String:C10($size)+"...")
	End for 
	$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
	
	SN3_CloseXMLCompress ("";$vt_FileName;"sax";$refXMLDoc)
End if 
