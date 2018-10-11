//%attributes = {}
  // MÉTODO: AS_LoadStudentList
  // ----------------------------------------------------
  // Usuario (OS): Alberto Bachler
  // Fecha de creación: 26/12/11, 11:39:08
  // ----------------------------------------------------
  // DESCRIPCIÓN
  // Carga la lista de alumnos de una asignatura en el area externa xALP_StdList
  // en la página 1 del formularioInput de la asignatura
  //
  // PARÁMETROS
  // AS_LoadStudentList()
  // ----------------------------------------------------
C_LONGINT:C283($l_err)
C_TEXT:C284($t_ReferenciaDelArea)


  // DECLARACIONES E INICIALIZACIONES

  // CODIGO PRINCIPAL

  //C_LONGINT(<>viSTR_AgruparPorSexo) // 20181008 Patricio Aliaga Ticket N° 204363

EV2_RegistrosDeLaAsignatura ([Asignaturas:18]Numero:1)
SET FIELD RELATION:C919([Alumnos_Calificaciones:208]ID_Alumno:6;Automatic:K51:4;Structure configuration:K51:2)
SELECTION TO ARRAY:C260([Alumnos_Calificaciones:208];aNtaRecNum;[Alumnos_Calificaciones:208]ID_Alumno:6;aNtaIdAlumno;[Alumnos_Calificaciones:208]NoDeLista:10;aNtaOrden;[Alumnos:2]apellidos_y_nombres:40;aNtaStdNme;[Alumnos:2]curso:20;aNtaCurso;[Alumnos:2]Sexo:49;aSexoAlumnos)
SET FIELD RELATION:C919([Alumnos_Calificaciones:208]ID_Alumno:6;Automatic:K51:4;Structure configuration:K51:2)

ALP_RemoveAllArrays (xALP_StdList)
$l_err:=AL_SetArraysNam (xALP_StdList;1;6;"aNtaOrden";"aNtaStdNme";"aNtaCurso";"aNtaIdAlumno";"aNtaRecNum";"aSexoAlumnos")
AL_SetSort (xALP_StdList;1)
AL_SetFormat (xALP_StdList;1;"###0")
AL_SetMiscOpts (xALP_StdList;0;0;"\\";0;1)
If ([Asignaturas:18]Seleccion:17)
	AL_SetColOpts (xALP_StdList;0;0;0;3;0;0;0)
	AL_SetWidths (xALP_StdList;1;2;40;170;40)
	AL_SetHeaders (xALP_StdList;1;3;__ ("Nº");__ ("Nombre y apellidos");__ ("Curso"))
Else 
	AL_SetColOpts (xALP_StdList;0;0;0;3;0;0;0)
	AL_SetWidths (xALP_StdList;1;2;40;170)
	AL_SetHeaders (xALP_StdList;1;2;__ ("Nº");__ ("Nombre y apellidos"))
End if 
AL_SetDividers (xALP_StdList;"Black";"Light Gray";0;"Black";"Light Gray";0)
AL_SetRowOpts (xALP_StdList;1;1;1;0;0)
AL_SetHdrStyle (xALP_StdList;0;"Tahoma";9;1)
AL_SetStyle (xALP_StdList;0;"Tahoma";9;0)
AL_SetSortOpts (xALP_StdList;1;1;0;"";1)
AL_SetDrgOpts (xALP_StdList;1;30;1)
AL_SetHeight (xALP_StdList;1;6;1;4)
AL_SetScroll (xALP_StdList;0;-3)
ALP_SetDefaultAppareance (xALP_StdList)
ALP_SetAlternateLigneColor (xALP_StdList)
AL_SetMiscOpts (xALP_StdList;0;0;"\\";0;1)
$t_ReferenciaDelArea:=String:C10(xALP_StdList)
AL_SetDrgSrc (xALP_StdList;1;$t_ReferenciaDelArea)
AL_SetDrgDst (xALP_StdList;1;$t_ReferenciaDelArea)

  // 20181008 Patricio Aliaga Ticket N° 204363
C_OBJECT:C1216($o_obj;$o_in)
OB SET:C1220($o_in;"nivel";[Asignaturas:18]Numero_del_Nivel:6)
$o_obj:=STR_ordenNominas ("query";$o_in)
Case of 
	: (OB Get:C1224($o_obj;"UsaGenero";Is boolean:K8:9))
		C_LONGINT:C283($l_genero)
		$l_genero:=6
		If (OB Get:C1224($o_obj;"Genero";Is boolean:K8:9))
			$l_genero:=$l_genero*-1
		End if 
		Case of 
			: (OB Get:C1224($o_obj;"NdeOrden";Is boolean:K8:9))
				AL_SetSort (xALP_StdList;$l_genero;1)
			: (OB Get:C1224($o_obj;"CursoNombres";Is boolean:K8:9))
				AL_SetSort (xALP_StdList;$l_genero;3;2)
			: (OB Get:C1224($o_obj;"Nombres";Is boolean:K8:9))
				AL_SetSort (xALP_StdList;$l_genero;2)
		End case 
	: (OB Get:C1224($o_obj;"NdeOrden";Is boolean:K8:9))
		AL_SetSort (xALP_StdList;1)
	: (OB Get:C1224($o_obj;"CursoNombres";Is boolean:K8:9))
		AL_SetSort (xALP_StdList;3;2)
	: (OB Get:C1224($o_obj;"Nombres";Is boolean:K8:9))
		AL_SetSort (xALP_StdList;2)
End case 

  //If (<>viSTR_AgruparPorSexo=0)
  //Case of 
  //: (<>gOrdenNta=0)
  //AL_SetSort (xALP_StdList;3;2)
  //: (<>gOrdenNta=1)
  //AL_SetSort (xALP_StdList;1)
  //: (<>gOrdenNta=2)
  //AL_SetSort (xALP_StdList;2)
  //End case 
  //Else 
  //Case of 
  //: (<>gOrdenNta=0)
  //AL_SetSort (xALP_StdList;6;3;2)
  //: (<>gOrdenNta=1)
  //AL_SetSort (xALP_StdList;6;1)
  //: (<>gOrdenNta=2)
  //AL_SetSort (xALP_StdList;6;2)
  //End case 
  //End if 
ARRAY INTEGER:C220(alLines;0)
AL_SetSelect (xALP_StdList;alLines)