//%attributes = {}
  //SN3_SendAlumnosXML

  //`======
  // Modified by: abachler (5/2/10)
vb_ConstantesModificadas:=True:C214
  //`======


C_BOOLEAN:C305($1;$2;$todos;$useArrays)
C_TIME:C306($refXMLDoc)
C_BLOB:C604($blob)

$todos:=True:C214
$useArrays:=False:C215

Case of 
	: (Count parameters:C259=1)
		$todos:=$1
	: (Count parameters:C259=2)
		$todos:=$1
		$useArrays:=$2
End case 
$currentErrorHandler:=SN3_SetErrorHandler ("set")

SN3_BuildSelections (SN3_DTi_Alumnos;$todos;$useArrays)
If (Records in selection:C76([Alumnos:2])>0)
	ARRAY LONGINT:C221($arrayLong;0)
	ARRAY LONGINT:C221($recNums;0)
	SELECTION TO ARRAY:C260([Alumnos:2];$recNums;[Alumnos:2]numero:1;$arrayLong)
	
	$size:=Size of array:C274($recNums)
	
	$vt_FileName:=SN3_CreateFile2Send ("crear";"";SN3_Alumnos;"sax";->$refXMLDoc)
	SN3_BuildFileHeader ($refXMLDoc;SN3_Alumnos;"alumnos";$todos;$useArrays;True:C214)
	$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;__ ("Generando documento con ")+String:C10($size)+__ (" registros de alumnos..."))
	READ ONLY:C145([Alumnos_SintesisAnual:210])
	For ($indice;1;$size)
		KRL_GotoRecord (->[Alumnos:2];$recNums{$indice};False:C215)
		$vt_name:=ST_GetCleanString ([Alumnos:2]Nombres:2+[Alumnos:2]Apellido_paterno:3+[Alumnos:2]Apellido_materno:4)
		If ($vt_name#"")
			SAX_CreateNode ($refXMLDoc;"alumno")  //por cerrar
			SAX_CreateNode ($refXMLDoc;"id";True:C214;String:C10([Alumnos:2]numero:1))
			SAX_CreateNode ($refXMLDoc;"idfamilia";True:C214;String:C10([Alumnos:2]Familia_Número:24))
			If ([Alumnos:2]RUT:5#"")
				SAX_CreateNode ($refXMLDoc;"idnacional";True:C214;[Alumnos:2]RUT:5;True:C214)
			Else 
				SAX_CreateNode ($refXMLDoc;"idnacional";True:C214;[Alumnos:2]NoPasaporte:87;True:C214)
			End if 
			SAX_CreateNode ($refXMLDoc;"nombres";True:C214;[Alumnos:2]Nombres:2;True:C214)
			SAX_CreateNode ($refXMLDoc;"appaterno";True:C214;[Alumnos:2]Apellido_paterno:3;True:C214)
			SAX_CreateNode ($refXMLDoc;"apmaterno";True:C214;[Alumnos:2]Apellido_materno:4;True:C214)
			SAX_CreateNode ($refXMLDoc;"nombrecompleto";True:C214;[Alumnos:2]apellidos_y_nombres:40;True:C214)
			SAX_CreateNode ($refXMLDoc;"sexo";True:C214;[Alumnos:2]Sexo:49;True:C214)  //mono sn3 cambio
			SAX_CreateNode ($refXMLDoc;"telefono";True:C214;[Alumnos:2]Telefono:17;True:C214)
			SAX_CreateNode ($refXMLDoc;"celular";True:C214;[Alumnos:2]Celular:95;True:C214)
			SAX_CreateNode ($refXMLDoc;"fechanacimiento";True:C214;SN3_MakeDateInmune2LocalFormat ([Alumnos:2]Fecha_de_nacimiento:7))
			SAX_CreateNode ($refXMLDoc;"direccion";True:C214;[Alumnos:2]Direccion:12;True:C214)
			SAX_CreateNode ($refXMLDoc;"comuna";True:C214;[Alumnos:2]Comuna:14;True:C214)
			SAX_CreateNode ($refXMLDoc;"ciudad";True:C214;[Alumnos:2]Ciudad:15;True:C214)  //mono sn3 cambio
			SAX_CreateNode ($refXMLDoc;"sector";True:C214;[Alumnos:2]Sector_Domicilio:80;True:C214)  //mono  11.7 ticket 123049
			SAX_CreateNode ($refXMLDoc;"email";True:C214;[Alumnos:2]eMAIL:68;True:C214)
			SAX_CreateNode ($refXMLDoc;"curso";True:C214;[Alumnos:2]curso:20)
			SAX_CreateNode ($refXMLDoc;"nivelnumero";True:C214;String:C10([Alumnos:2]nivel_numero:29))
			SAX_CreateNode ($refXMLDoc;"numeromatricula";True:C214;[Alumnos:2]numero_de_matricula:51)  //mono sn3 cambio
			SAX_CreateNode ($refXMLDoc;"idapocuentas";True:C214;String:C10([Alumnos:2]Apoderado_Cuentas_Número:28))
			SAX_CreateNode ($refXMLDoc;"idapoacademico";True:C214;String:C10([Alumnos:2]Apoderado_académico_Número:27))
			SAX_CreateNode ($refXMLDoc;"grupo";True:C214;[Alumnos:2]Grupo:11;True:C214)
			SAX_CreateNode ($refXMLDoc;"vivecon";True:C214;[Alumnos:2]Vive_con:81;True:C214)
			
			SET BLOB SIZE:C606($blob;0)
			PICTURE TO BLOB:C692([Alumnos:2]Fotografía:78;$blob;".jpg")
			SAX OPEN XML ELEMENT:C853($refXMLDoc;"foto")
			SAX ADD XML ELEMENT VALUE:C855($refXMLDoc;$blob)
			SAX CLOSE XML ELEMENT:C854($refXMLDoc)
			
			EV2_RegistrosDelAlumno ([Alumnos:2]numero:1;[Alumnos:2]nivel_numero:29)
			
			SAX_CreateNode ($refXMLDoc;"promedios")
			
			For ($promedios;1;5)
				$fieldPtr:=KRL_GetFieldPointerByName ("[Alumnos_SintesisAnual]P0"+String:C10($promedios)+"_PromedioInterno_Literal")
				$fieldPtr_R:=KRL_GetFieldPointerByName ("[Alumnos_SintesisAnual]P0"+String:C10($promedios)+"_PromedioInterno_Real")
				$fieldPtr_N:=KRL_GetFieldPointerByName ("[Alumnos_SintesisAnual]P0"+String:C10($promedios)+"_PromedioInterno_Nota")
				$fieldPtr_P:=KRL_GetFieldPointerByName ("[Alumnos_SintesisAnual]P0"+String:C10($promedios)+"_PromedioInterno_Puntos")
				$fieldPtr_S:=KRL_GetFieldPointerByName ("[Alumnos_SintesisAnual]P0"+String:C10($promedios)+"_PromedioInterno_Simbolo")
				
				SAX_CreateNode ($refXMLDoc;"promedio")
				SAX_CreateNode ($refXMLDoc;"valor";True:C214;$fieldPtr->)
				If ($fieldPtr_R->>=0)
					SAX_CreateNode ($refXMLDoc;"porcentaje";True:C214;EV2_Real_a_Literal ($fieldPtr_R->;Porcentaje))
					SAX_CreateNode ($refXMLDoc;"notanum";True:C214;EV2_Literal_Aplicacion (String:C10($fieldPtr_N->)))
					SAX_CreateNode ($refXMLDoc;"puntos";True:C214;EV2_Literal_Aplicacion (String:C10($fieldPtr_P->)))
					SAX_CreateNode ($refXMLDoc;"simbolo";True:C214;$fieldPtr_S->)
				Else 
					SAX_CreateNode ($refXMLDoc;"porcentaje";True:C214;$fieldPtr->)
					SAX_CreateNode ($refXMLDoc;"notanum";True:C214;$fieldPtr->)
					SAX_CreateNode ($refXMLDoc;"puntos";True:C214;$fieldPtr->)
					SAX_CreateNode ($refXMLDoc;"simbolo";True:C214;$fieldPtr->)
				End if 
				SAX_CreateNode ($refXMLDoc;"periodo";True:C214;String:C10($promedios))
				SAX CLOSE XML ELEMENT:C854($refXMLDoc)
			End for 
			
			For ($promedios;1;5)  //oficiales periodo
				
				$fieldPtr:=KRL_GetFieldPointerByName ("[Alumnos_SintesisAnual]P0"+String:C10($promedios)+"_PromedioOficial_Literal")
				$fieldPtr_R:=KRL_GetFieldPointerByName ("[Alumnos_SintesisAnual]P0"+String:C10($promedios)+"_PromedioOficial_Real")
				$fieldPtr_N:=KRL_GetFieldPointerByName ("[Alumnos_SintesisAnual]P0"+String:C10($promedios)+"_PromedioOficial_Nota")
				$fieldPtr_P:=KRL_GetFieldPointerByName ("[Alumnos_SintesisAnual]P0"+String:C10($promedios)+"_PromedioOficial_Puntos")
				$fieldPtr_S:=KRL_GetFieldPointerByName ("[Alumnos_SintesisAnual]P0"+String:C10($promedios)+"_PromedioOficial_Simbolo")
				
				SAX_CreateNode ($refXMLDoc;"promedio")
				SAX_CreateNode ($refXMLDoc;"valor";True:C214;$fieldPtr->)
				If ($fieldPtr_R->>=0)
					SAX_CreateNode ($refXMLDoc;"porcentaje";True:C214;EV2_Real_a_Literal ($fieldPtr_R->;Porcentaje))
					SAX_CreateNode ($refXMLDoc;"notanum";True:C214;EV2_Literal_Aplicacion (String:C10($fieldPtr_N->)))
					SAX_CreateNode ($refXMLDoc;"puntos";True:C214;EV2_Literal_Aplicacion (String:C10($fieldPtr_P->)))
					SAX_CreateNode ($refXMLDoc;"simbolo";True:C214;$fieldPtr_S->)
				Else 
					SAX_CreateNode ($refXMLDoc;"porcentaje";True:C214;$fieldPtr->)
					SAX_CreateNode ($refXMLDoc;"notanum";True:C214;$fieldPtr->)
					SAX_CreateNode ($refXMLDoc;"puntos";True:C214;$fieldPtr->)
					SAX_CreateNode ($refXMLDoc;"simbolo";True:C214;$fieldPtr->)
				End if 
				
				SAX_CreateNode ($refXMLDoc;"periodo";True:C214;String:C10($promedios)+"Oficial")
				SAX CLOSE XML ELEMENT:C854($refXMLDoc)
			End for 
			
			SAX_CreateNode ($refXMLDoc;"promedio")
			SAX_CreateNode ($refXMLDoc;"valor";True:C214;[Alumnos_SintesisAnual:210]PromedioAnualInterno_Literal:14)
			If ([Alumnos_SintesisAnual:210]PromedioAnualInterno_Real:10>=0)
				SAX_CreateNode ($refXMLDoc;"porcentaje";True:C214;EV2_Real_a_Literal ([Alumnos_SintesisAnual:210]PromedioAnualInterno_Real:10;Porcentaje))
				SAX_CreateNode ($refXMLDoc;"notanum";True:C214;EV2_Literal_Aplicacion (String:C10([Alumnos_SintesisAnual:210]PromedioAnualInterno_Nota:11)))
				SAX_CreateNode ($refXMLDoc;"puntos";True:C214;EV2_Literal_Aplicacion (String:C10([Alumnos_SintesisAnual:210]PromedioAnualInterno_Puntos:12)))
				SAX_CreateNode ($refXMLDoc;"simbolo";True:C214;[Alumnos_SintesisAnual:210]PromedioAnualInterno_Simbolo:13)
			Else 
				SAX_CreateNode ($refXMLDoc;"porcentaje";True:C214;[Alumnos_SintesisAnual:210]PromedioAnualInterno_Literal:14)
				SAX_CreateNode ($refXMLDoc;"notanum";True:C214;[Alumnos_SintesisAnual:210]PromedioAnualInterno_Literal:14)
				SAX_CreateNode ($refXMLDoc;"puntos";True:C214;[Alumnos_SintesisAnual:210]PromedioAnualInterno_Literal:14)
				SAX_CreateNode ($refXMLDoc;"simbolo";True:C214;[Alumnos_SintesisAnual:210]PromedioAnualInterno_Literal:14)
			End if 
			SAX_CreateNode ($refXMLDoc;"periodo";True:C214;"anual")
			SAX CLOSE XML ELEMENT:C854($refXMLDoc)
			
			  //Anual Oficial
			SAX_CreateNode ($refXMLDoc;"promedio")
			SAX_CreateNode ($refXMLDoc;"valor";True:C214;[Alumnos_SintesisAnual:210]PromedioAnualOficial_Literal:19)
			If ([Alumnos_SintesisAnual:210]PromedioAnualOficial_Real:15>=0)
				SAX_CreateNode ($refXMLDoc;"porcentaje";True:C214;EV2_Real_a_Literal ([Alumnos_SintesisAnual:210]PromedioAnualOficial_Real:15;Porcentaje))
				SAX_CreateNode ($refXMLDoc;"notanum";True:C214;EV2_Literal_Aplicacion (String:C10([Alumnos_SintesisAnual:210]PromedioAnualOficial_Nota:16)))
				SAX_CreateNode ($refXMLDoc;"puntos";True:C214;EV2_Literal_Aplicacion (String:C10([Alumnos_SintesisAnual:210]PromedioAnualOficial_Puntos:17)))
				SAX_CreateNode ($refXMLDoc;"simbolo";True:C214;[Alumnos_SintesisAnual:210]PromedioAnualOficial_Simbolo:18)
			Else 
				SAX_CreateNode ($refXMLDoc;"porcentaje";True:C214;[Alumnos_SintesisAnual:210]PromedioAnualOficial_Literal:19)
				SAX_CreateNode ($refXMLDoc;"notanum";True:C214;[Alumnos_SintesisAnual:210]PromedioAnualOficial_Literal:19)
				SAX_CreateNode ($refXMLDoc;"puntos";True:C214;[Alumnos_SintesisAnual:210]PromedioAnualOficial_Literal:19)
				SAX_CreateNode ($refXMLDoc;"simbolo";True:C214;[Alumnos_SintesisAnual:210]PromedioAnualOficial_Literal:19)
			End if 
			SAX_CreateNode ($refXMLDoc;"periodo";True:C214;"anualOficial")
			SAX CLOSE XML ELEMENT:C854($refXMLDoc)
			
			
			SAX_CreateNode ($refXMLDoc;"promedio")
			SAX_CreateNode ($refXMLDoc;"valor";True:C214;[Alumnos_SintesisAnual:210]PromedioFinalInterno_Literal:24)
			If ([Alumnos_SintesisAnual:210]PromedioFinalInterno_Real:20>=0)
				SAX_CreateNode ($refXMLDoc;"porcentaje";True:C214;EV2_Real_a_Literal ([Alumnos_SintesisAnual:210]PromedioFinalInterno_Real:20;Porcentaje))
				SAX_CreateNode ($refXMLDoc;"notanum";True:C214;EV2_Literal_Aplicacion (String:C10([Alumnos_SintesisAnual:210]PromedioFinalInterno_Nota:21)))
				SAX_CreateNode ($refXMLDoc;"puntos";True:C214;EV2_Literal_Aplicacion (String:C10([Alumnos_SintesisAnual:210]PromedioFinalInterno_Puntos:22)))
				SAX_CreateNode ($refXMLDoc;"simbolo";True:C214;[Alumnos_SintesisAnual:210]PromedioFinalInterno_Simbolo:23)
			Else 
				SAX_CreateNode ($refXMLDoc;"porcentaje";True:C214;[Alumnos_SintesisAnual:210]PromedioFinalInterno_Literal:24)
				SAX_CreateNode ($refXMLDoc;"notanum";True:C214;[Alumnos_SintesisAnual:210]PromedioFinalInterno_Literal:24)
				SAX_CreateNode ($refXMLDoc;"puntos";True:C214;[Alumnos_SintesisAnual:210]PromedioFinalInterno_Literal:24)
				SAX_CreateNode ($refXMLDoc;"simbolo";True:C214;[Alumnos_SintesisAnual:210]PromedioFinalInterno_Literal:24)
			End if 
			SAX_CreateNode ($refXMLDoc;"periodo";True:C214;"final")
			SAX CLOSE XML ELEMENT:C854($refXMLDoc)
			
			SAX_CreateNode ($refXMLDoc;"promedio")
			SAX_CreateNode ($refXMLDoc;"valor";True:C214;[Alumnos_SintesisAnual:210]PromedioFinalOficial_Literal:29)
			If ([Alumnos_SintesisAnual:210]PromedioFinalOficial_Real:25>=0)
				SAX_CreateNode ($refXMLDoc;"porcentaje";True:C214;EV2_Real_a_Literal ([Alumnos_SintesisAnual:210]PromedioFinalOficial_Real:25;Porcentaje))
				SAX_CreateNode ($refXMLDoc;"notanum";True:C214;EV2_Literal_Aplicacion (String:C10([Alumnos_SintesisAnual:210]PromedioFinalOficial_Nota:26)))
				SAX_CreateNode ($refXMLDoc;"puntos";True:C214;EV2_Literal_Aplicacion (String:C10([Alumnos_SintesisAnual:210]PromedioFinalOficial_Puntos:27)))
				SAX_CreateNode ($refXMLDoc;"simbolo";True:C214;[Alumnos_SintesisAnual:210]PromedioFinalOficial_Simbolo:28)
			Else 
				SAX_CreateNode ($refXMLDoc;"porcentaje";True:C214;[Alumnos_SintesisAnual:210]PromedioFinalOficial_Literal:29)
				SAX_CreateNode ($refXMLDoc;"notanum";True:C214;[Alumnos_SintesisAnual:210]PromedioFinalOficial_Literal:29)
				SAX_CreateNode ($refXMLDoc;"puntos";True:C214;[Alumnos_SintesisAnual:210]PromedioFinalOficial_Literal:29)
				SAX_CreateNode ($refXMLDoc;"simbolo";True:C214;[Alumnos_SintesisAnual:210]PromedioFinalOficial_Literal:29)
			End if 
			SAX_CreateNode ($refXMLDoc;"periodo";True:C214;"finalOficial")
			SAX CLOSE XML ELEMENT:C854($refXMLDoc)
			
			SAX CLOSE XML ELEMENT:C854($refXMLDoc)
			
			If (Records in selection:C76([Alumnos_Calificaciones:208])>0)
				SAX_CreateNode ($refXMLDoc;"asignaturas")
				ARRAY LONGINT:C221($al_AsigID;0)
				SELECTION TO ARRAY:C260([Alumnos_Calificaciones:208]ID_Asignatura:5;$al_AsigID)
				For ($i;1;Size of array:C274($al_AsigID))
					SAX_CreateNode ($refXMLDoc;"idasignatura";True:C214;String:C10($al_AsigID{$i}))
				End for 
				SAX CLOSE XML ELEMENT:C854($refXMLDoc)
			End if 
			
			PERIODOS_LoadData ([Alumnos:2]nivel_numero:29)
			QUERY:C277([Alumnos_Actividades:28];[Alumnos_Actividades:28]Alumno_Numero:1=[Alumnos:2]numero:1;*)
			QUERY:C277([Alumnos_Actividades:28]; & ;[Alumnos_Actividades:28]Año:3=<>gYear)
			If (Records in selection:C76([Alumnos_Actividades:28])>0)
				SAX_CreateNode ($refXMLDoc;"actividades")
				FIRST RECORD:C50([Alumnos_Actividades:28])
				While (Not:C34(End selection:C36([Alumnos_Actividades:28])))
					SAX_CreateNode ($refXMLDoc;"actividad")
					SAX_CreateNode ($refXMLDoc;"idactividad";True:C214;String:C10([Alumnos_Actividades:28]Actividad_numero:2))
					SAX_CreateNode ($refXMLDoc;"periodosinscritos")
					If ([Alumnos_Actividades:28]Periodos_Inscritos:44 ?? 0)
						For ($s;1;viSTR_Periodos_NumeroPeriodos)
							SAX_CreateNode ($refXMLDoc;"periodo";True:C214;String:C10($s))
						End for 
					Else 
						For ($s;1;5)
							If ([Alumnos_Actividades:28]Periodos_Inscritos:44 ?? $s)
								SAX_CreateNode ($refXMLDoc;"periodo";True:C214;String:C10($s))
							End if 
						End for 
					End if 
					SAX CLOSE XML ELEMENT:C854($refXMLDoc)
					SAX CLOSE XML ELEMENT:C854($refXMLDoc)
					NEXT RECORD:C51([Alumnos_Actividades:28])
				End while 
				SAX CLOSE XML ELEMENT:C854($refXMLDoc)
			End if 
			
			  //Para ficha internet
			SAX_CreateNode ($refXMLDoc;"nacidoen";True:C214;[Alumnos:2]Nacido_en:10;True:C214)
			SAX_CreateNode ($refXMLDoc;"nacionalidad";True:C214;[Alumnos:2]Nacionalidad:8;True:C214)
			SAX_CreateNode ($refXMLDoc;"sectordomicilio";True:C214;[Alumnos:2]Sector_Domicilio:80;True:C214)
			SAX_CreateNode ($refXMLDoc;"codpostal";True:C214;[Alumnos:2]Codigo_Postal:13;True:C214)
			SAX_CreateNode ($refXMLDoc;"religion";True:C214;[Alumnos:2]Religion:9;True:C214)
			
			SAX_CreateNode ($refXMLDoc;"fichamedica")  //cerrar!!!`Hay que poner marca en AL_fSaveSalud!!!
			
			  //para ficha medica por internet
			ARRAY TEXT:C222($aEnfermedad;0)
			ARRAY TEXT:C222($aHospDiagnostico;0)
			ARRAY DATE:C224($aHospFecha;0)
			ARRAY DATE:C224($aHospHasta;0)
			ARRAY TEXT:C222($aAlergiaTipo;0)
			ARRAY TEXT:C222($aAlergeno;0)
			ARRAY DATE:C224($aCMedico_Fecha;0)
			ARRAY TEXT:C222($aCMedico_Curso;0)
			ARRAY TEXT:C222($aCMedico_Edad;0)
			ARRAY INTEGER:C220($aCMedico_Talla;0)
			ARRAY REAL:C219($aCMedico_Peso;0)
			ARRAY TEXT:C222($aVacuna_Edad;0)
			ARRAY TEXT:C222($aVacuna_Enfermedad;0)
			ARRAY BOOLEAN:C223($aVacuna_SiNo;0)
			ARRAY LONGINT:C221($aAparatos_Year;0)
			ARRAY TEXT:C222($aAparatos_Curso;0)
			ARRAY TEXT:C222($aAparatos_Aparato;0)
			
			QUERY:C277([Alumnos_FichaMedica_Enfermedade:224];[Alumnos_FichaMedica_Enfermedade:224]id_alumno:3=[Alumnos:2]numero:1)
			SELECTION TO ARRAY:C260([Alumnos_FichaMedica_Enfermedade:224]Enfermedad:1;$aEnfermedad)
			SORT ARRAY:C229($aEnfermedad;>)
			SAX_CreateNode ($refXMLDoc;"enfermedades")
			For ($i;1;Size of array:C274($aEnfermedad))
				SAX_CreateNode ($refXMLDoc;"enfermedad";True:C214;$aEnfermedad{$i};True:C214)
			End for 
			SAX CLOSE XML ELEMENT:C854($refXMLDoc)
			
			
			
			QUERY:C277([Alumnos_FichaMedica_Alergias:223];[Alumnos_FichaMedica_Alergias:223]id_alumno:4=[Alumnos:2]numero:1)
			SELECTION TO ARRAY:C260([Alumnos_FichaMedica_Alergias:223]Tipo_alergia:1;$aAlergiaTipo;[Alumnos_FichaMedica_Alergias:223]Alergeno:2;$aAlergeno)
			SORT ARRAY:C229($aAlergiaTipo;$aAlergeno;>)
			SAX_CreateNode ($refXMLDoc;"alergias")
			For ($i;1;Size of array:C274($aAlergiaTipo))
				SAX_CreateNode ($refXMLDoc;"alergia")
				SAX_CreateNode ($refXMLDoc;"tipo";True:C214;$aAlergiaTipo{$i};True:C214)
				SAX_CreateNode ($refXMLDoc;"alergeno";True:C214;$aAlergeno{$i};True:C214)
				SAX CLOSE XML ELEMENT:C854($refXMLDoc)
			End for 
			SAX CLOSE XML ELEMENT:C854($refXMLDoc)
			
			
			
			QUERY:C277([Alumnos_FichaMedica_Hospitaliza:222];[Alumnos_FichaMedica_Hospitaliza:222]Id_Alumno:5=[Alumnos:2]numero:1)
			SELECTION TO ARRAY:C260([Alumnos_FichaMedica_Hospitaliza:222]Fecha:1;$aHospFecha;[Alumnos_FichaMedica_Hospitaliza:222]Diagnóstico:2;$aHospDiagnostico;[Alumnos_FichaMedica_Hospitaliza:222]Hasta:3;$aHospHasta)
			SORT ARRAY:C229($aHospFecha;$aHospHasta;$aHospDiagnostico;<)
			SAX_CreateNode ($refXMLDoc;"hospitalizaciones")
			For ($i;1;Size of array:C274($aHospFecha))
				SAX_CreateNode ($refXMLDoc;"hospitaliacion")
				SAX_CreateNode ($refXMLDoc;"desde";True:C214;SN3_MakeDateInmune2LocalFormat ($aHospFecha{$i}))
				SAX_CreateNode ($refXMLDoc;"hasta";True:C214;SN3_MakeDateInmune2LocalFormat ($aHospHasta{$i}))
				SAX_CreateNode ($refXMLDoc;"diagnostico";True:C214;$aHospDiagnostico{$i};True:C214)
				SAX CLOSE XML ELEMENT:C854($refXMLDoc)
			End for 
			SAX CLOSE XML ELEMENT:C854($refXMLDoc)
			
			
			
			
			QUERY:C277([Alumnos_FichaMedica_Aparatos_pr:226];[Alumnos_FichaMedica_Aparatos_pr:226]Id_alumno:6=[Alumnos:2]numero:1)
			SELECTION TO ARRAY:C260([Alumnos_FichaMedica_Aparatos_pr:226]Año:1;$aAparatos_Year;[Alumnos_FichaMedica_Aparatos_pr:226]Curso:3;$aAparatos_Curso;[Alumnos_FichaMedica_Aparatos_pr:226]Aparato:2;$aAparatos_Aparato)
			SORT ARRAY:C229($aAparatos_Year;$aAparatos_Curso;$aAparatos_Aparato;<)
			SAX_CreateNode ($refXMLDoc;"aparatos")
			For ($i;1;Size of array:C274($aAparatos_Year))
				SAX_CreateNode ($refXMLDoc;"aparato")
				SAX_CreateNode ($refXMLDoc;"agno";True:C214;String:C10($aAparatos_Year{$i}))
				SAX_CreateNode ($refXMLDoc;"curso";True:C214;$aAparatos_Curso{$i})
				SAX_CreateNode ($refXMLDoc;"aparato";True:C214;$aAparatos_Aparato{$i};True:C214)
				SAX CLOSE XML ELEMENT:C854($refXMLDoc)
			End for 
			SAX CLOSE XML ELEMENT:C854($refXMLDoc)
			
			
			
			
			QUERY:C277([Alumnos_Vacunas:101];[Alumnos_Vacunas:101]Numero_Alumno:1=[Alumnos_FichaMedica:13]Alumno_Numero:1;*)
			QUERY:C277([Alumnos_Vacunas:101]; & ;[Alumnos_Vacunas:101]Vacunado:5=True:C214)
			SELECTION TO ARRAY:C260([Alumnos_Vacunas:101]Edad:2;$aVacuna_edad;[Alumnos_Vacunas:101]Enfermedad:3;$aVacuna_Enfermedad;[Alumnos_Vacunas:101]Vacunado:5;$aVacuna_SiNo;[Alumnos_Vacunas:101]Meses:4;$aVacuna_meses)
			MULTI SORT ARRAY:C718($aVacuna_meses;>;$aVacuna_Enfermedad;>;$aVacuna_SiNo;>;$aVacuna_edad;>)
			SAX_CreateNode ($refXMLDoc;"vacunas")
			For ($i;1;Size of array:C274($aVacuna_meses))
				SAX_CreateNode ($refXMLDoc;"vacuna")
				SAX_CreateNode ($refXMLDoc;"enfermedad";True:C214;$aVacuna_Enfermedad{$i};True:C214)
				SAX_CreateNode ($refXMLDoc;"meses";True:C214;String:C10($aVacuna_meses{$i}))
				SAX CLOSE XML ELEMENT:C854($refXMLDoc)
			End for 
			SAX CLOSE XML ELEMENT:C854($refXMLDoc)
			SELECTION TO ARRAY:C260([Alumnos_ControlesMedicos:99]Fecha:2;$aCMedico_Fecha;[Alumnos_ControlesMedicos:99]Curso:3;$aCMedico_Curso;[Alumnos_ControlesMedicos:99]Edad:4;$aCMedico_Edad;[Alumnos_ControlesMedicos:99]Talla_cm:5;$aCMedico_Talla;[Alumnos_ControlesMedicos:99]Peso_kg:6;$aCMedico_Peso)
			SORT ARRAY:C229($aCMedico_Fecha;$aCMedico_Curso;$aCMedico_Edad;$aCMedico_Talla;$aCMedico_Peso;<)
			SAX_CreateNode ($refXMLDoc;"controles")
			For ($i;1;Size of array:C274($aCMedico_Fecha))
				SAX_CreateNode ($refXMLDoc;"control")
				SAX_CreateNode ($refXMLDoc;"fecha";True:C214;SN3_MakeDateInmune2LocalFormat ($aCMedico_Fecha{$i}))
				SAX_CreateNode ($refXMLDoc;"curso";True:C214;$aCMedico_Curso{$i})
				SAX_CreateNode ($refXMLDoc;"edad";True:C214;$aCMedico_Edad{$i})
				SAX_CreateNode ($refXMLDoc;"talla";True:C214;String:C10($aCMedico_Talla{$i}))
				SAX_CreateNode ($refXMLDoc;"peso";True:C214;String:C10($aCMedico_Peso{$i}))
				SAX CLOSE XML ELEMENT:C854($refXMLDoc)
			End for 
			SAX CLOSE XML ELEMENT:C854($refXMLDoc)
			
			QUERY:C277([Alumnos_FichaMedica:13];[Alumnos_FichaMedica:13]Alumno_Numero:1=[Alumnos:2]numero:1)
			
			SAX_CreateNode ($refXMLDoc;"observaciones";True:C214;[Alumnos_FichaMedica:13]Observaciones:3;True:C214)
			SAX_CreateNode ($refXMLDoc;"medicamentosautorizados";True:C214;[Alumnos_FichaMedica:13]Medicamentos_autorizados:11;True:C214)
			SAX_CreateNode ($refXMLDoc;"medicamentosprohibidos";True:C214;[Alumnos_FichaMedica:13]Medicamentos_prohibidos:17;True:C214)
			SAX_CreateNode ($refXMLDoc;"tratamientos";True:C214;[Alumnos_FichaMedica:13]Tratamientos:18;True:C214)
			SAX_CreateNode ($refXMLDoc;"dietas";True:C214;[Alumnos_FichaMedica:13]Dieta:19;True:C214)
			SAX_CreateNode ($refXMLDoc;"gruposanguineo";True:C214;[Alumnos_FichaMedica:13]GrupoSanguineo:2;True:C214)
			SAX_CreateNode ($refXMLDoc;"previsioninstitucion";True:C214;[Alumnos_FichaMedica:13]Previsión_institución:9;True:C214)
			SAX_CreateNode ($refXMLDoc;"previsioncodigo";True:C214;[Alumnos_FichaMedica:13]Prevision_Código:10;True:C214)
			
			SAX_CreateNode ($refXMLDoc;"contactosurgencia")
			SAX_CreateNode ($refXMLDoc;"contactourprincipal")
			SAX_CreateNode ($refXMLDoc;"nombre";True:C214;[Alumnos_FichaMedica:13]Urgencia_Contacto:4;True:C214)
			SAX_CreateNode ($refXMLDoc;"fonos";True:C214;[Alumnos_FichaMedica:13]Urgencia_Fonos:5;True:C214)
			SAX_CreateNode ($refXMLDoc;"convenio";True:C214;[Alumnos_FichaMedica:13]Urgencia_Convenio:6;True:C214)
			SAX_CreateNode ($refXMLDoc;"traslado";True:C214;[Alumnos_FichaMedica:13]Urgencia_Traslado:8;True:C214)
			SAX CLOSE XML ELEMENT:C854($refXMLDoc)
			SAX_CreateNode ($refXMLDoc;"otroscontactos")
			ARRAY TEXT:C222(aNombreContacto;0)
			ARRAY TEXT:C222(aTelContacto;0)
			ARRAY TEXT:C222(aRelacionContacto;0)
			$ref:="contactos.ALU."+String:C10([Alumnos:2]numero:1)
			$rn:=Find in field:C653([XShell_FatObjects:86]FatObjectName:1;$ref)
			If ($rn#-1)
				READ WRITE:C146([XShell_FatObjects:86])
				GOTO RECORD:C242([XShell_FatObjects:86];$rn)
				BLOB_Blob2Vars (->[XShell_FatObjects:86]BlobObject:2;0;->aNombreContacto;->aRelacionContacto;->aTelContacto)
			Else 
				CREATE RECORD:C68([XShell_FatObjects:86])
				[XShell_FatObjects:86]FatObjectName:1:=$ref
				BLOB_Variables2Blob (->[XShell_FatObjects:86]BlobObject:2;0;->aNombreContacto;->aRelacionContacto;->aTelContacto)
				SAVE RECORD:C53([XShell_FatObjects:86])
			End if 
			KRL_UnloadReadOnly (->[XShell_FatObjects:86])
			For ($i;1;Size of array:C274(aNombreContacto))
				SAX_CreateNode ($refXMLDoc;"contacto")
				SAX_CreateNode ($refXMLDoc;"nombre";True:C214;aNombreContacto{$i};True:C214)
				SAX_CreateNode ($refXMLDoc;"relacion";True:C214;aRelacionContacto{$i};True:C214)
				SAX_CreateNode ($refXMLDoc;"fonos";True:C214;aTelContacto{$i};True:C214)
				SAX CLOSE XML ELEMENT:C854($refXMLDoc)
			End for 
			SAX CLOSE XML ELEMENT:C854($refXMLDoc)
			SAX CLOSE XML ELEMENT:C854($refXMLDoc)
			ARRAY TEXT:C222(aNombreContacto;0)
			ARRAY TEXT:C222(aTelContacto;0)
			ARRAY TEXT:C222(aRelacionContacto;0)
			
			ARRAY TEXT:C222(aNombresMedicos;0)
			ARRAY TEXT:C222(aEspMedicos;0)
			ARRAY TEXT:C222(aTelMedicos;0)
			ARRAY TEXT:C222(aEMailMedicos;0)
			ARRAY LONGINT:C221(aIDMedico;0)
			  //$ref:="medicos.ALU."+String([Alumnos]Número)
			  //$rn:=Find in field([XShell_FatObjects]FatObjectName;$ref)
			  //If ($rn#-1)
			  //READ ONLY([XShell_FatObjects])
			  //GOTO RECORD([XShell_FatObjects];$rn)
			  //BLOB_Blob2Vars (->[XShell_FatObjects]BlobObject;0;->aIDMedico)
			  //Else 
			  //CREATE RECORD([XShell_FatObjects])
			  //[XShell_FatObjects]FatObjectName:=$ref
			  //BLOB_Variables2Blob (->[XShell_FatObjects]BlobObject;0;->aIDMedico)
			  //SAVE RECORD([XShell_FatObjects])
			  //End if 
			  //KRL_UnloadReadOnly (->[XShell_FatObjects])
			  //20140711  ASM  Ticket 134693
			QUERY:C277([xxSTR_Link_AlumnosMedicos:237];[xxSTR_Link_AlumnosMedicos:237]UUID_Alumno:2=[Alumnos:2]auto_uuid:72)
			KRL_RelateSelection (->[STR_Medicos:89]Auto_UUID:6;->[xxSTR_Link_AlumnosMedicos:237]UUID_Medico:3;"")
			SELECTION TO ARRAY:C260([STR_Medicos:89]ID:3;aIDMedico)
			AT_RedimArrays (Size of array:C274(aIDMedico);->aNombresMedicos;->aEspMedicos;->aTelMedicos;->aEMailMedicos)
			ARRAY LONGINT:C221($temp;0)
			For ($i;1;Size of array:C274(aIDMedico))
				$rn:=Find in field:C653([STR_Medicos:89]ID:3;aIDMedico{$i})
				If ($rn#-1)
					READ ONLY:C145([STR_Medicos:89])
					GOTO RECORD:C242([STR_Medicos:89];$rn)
					aNombresMedicos{$i}:=[STR_Medicos:89]Nombres:1
					aEspMedicos{$i}:=[STR_Medicos:89]Especialidad:2
					aTelMedicos{$i}:=[STR_Medicos:89]Telefono_movil:4
					aEMailMedicos{$i}:=[STR_Medicos:89]eMail:5
				Else 
					APPEND TO ARRAY:C911($temp;$i)
				End if 
			End for 
			If (Size of array:C274($temp)>0)
				For ($i;Size of array:C274($temp);1;-1)
					AT_Delete ($i;1;->aNombresMedicos;->aEspMedicos;->aTelMedicos;->aEMailMedicos)
				End for 
			End if 
			SAX_CreateNode ($refXMLDoc;"medicos")
			For ($i;1;Size of array:C274(aNombresMedicos))
				SAX_CreateNode ($refXMLDoc;"medico")
				SAX_CreateNode ($refXMLDoc;"nombre";True:C214;aNombresMedicos{$i};True:C214)
				SAX_CreateNode ($refXMLDoc;"especialidad";True:C214;aEspMedicos{$i};True:C214)
				SAX_CreateNode ($refXMLDoc;"fonos";True:C214;aTelMedicos{$i};True:C214)
				SAX_CreateNode ($refXMLDoc;"email";True:C214;aEMailMedicos{$i};True:C214)
				SAX CLOSE XML ELEMENT:C854($refXMLDoc)
			End for 
			SAX CLOSE XML ELEMENT:C854($refXMLDoc)
			ARRAY TEXT:C222(aNombresMedicos;0)
			ARRAY TEXT:C222(aEspMedicos;0)
			ARRAY TEXT:C222(aTelMedicos;0)
			ARRAY TEXT:C222(aEMailMedicos;0)
			ARRAY LONGINT:C221(aIDMedico;0)
			  //fin ficha mèdica
			SAX CLOSE XML ELEMENT:C854($refXMLDoc)
			  //fin ficha internet
			SAX CLOSE XML ELEMENT:C854($refXMLDoc)
		End if 
		$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$indice/$size)
	End for 
	$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
	SN3_CloseXMLCompress ("";$vt_FileName;"sax";$refXMLDoc)
	If (Error=0)
		SN3_ManejaReferencias ("eliminar";SN3_Alumnos;0;SNT_Accion_Actualizar)
		SN3_RegisterLogEntry (SN3_Log_FileGeneration;"Generación del documento con "+String:C10($size)+" registros de alumnos.")  //Ticket 199856
	Else 
		SN3_RegisterLogEntry (SN3_Log_Error;"El documento con registros de alumnos no pudo ser generado.";Error)
	End if 
End if 

SN3_SetErrorHandler ("clear";$currentErrorHandler)