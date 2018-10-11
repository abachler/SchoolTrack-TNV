//%attributes = {}
  //PF_BeforeCard2

ARRAY TEXT:C222(at_CarreraProfesor_Puesto;0)
ARRAY DATE:C224(ad_CarreraProfesor_Fecha;0)
ARRAY TEXT:C222(at_TitulosProfesores;0)
QUERY:C277([Profesores_Titulos:216];[Profesores_Titulos:216]ID_Profesor:5=[Profesores:4]Numero:1)
SELECTION TO ARRAY:C260([Profesores_Titulos:216]Titulo:1;at_TitulosProfesores)
SF_Subtable2Array (->[Profesores:4]Carrera:16;->[Profesores]Carrera'Cargo;->at_CarreraProfesor_Puesto;->[Profesores]Carrera'Fecha;->ad_CarreraProfesor_Fecha)
SORT ARRAY:C229(ad_CarreraProfesor_Fecha;at_CarreraProfesor_Puesto;<)
READ ONLY:C145([Asignaturas:18])
QUERY:C277([Asignaturas:18];[Asignaturas:18]profesor_numero:4=[Profesores:4]Numero:1)
SELECTION TO ARRAY:C260([Asignaturas:18]Numero:1;aAsgNo;[Asignaturas:18]denominacion_interna:16;aAsgNm;[Asignaturas:18]Curso:5;aAsgCl)
AL_RemoveArrays (xALP_AsgLst;1;3)
$err:=AL_SetArraysNam (xALP_AsgLst;1;3;"aAsgNm";"aAsgCl";"aAsgNo")
AL_SetHeaders (xALP_AsgLst;1;2;__ ("Subsector");__ ("Curso"))
AL_SetSort (xALP_AsgLst;1)
AL_SetWidths (xALP_AsgLst;1;2;250;87)
ALP_SetDefaultAppareance (xALP_AsgLst;9;1;6;1;8)
AL_SetMiscOpts (xALP_AsgLst;0;0;"'";0;1)
AL_SetColOpts (xALP_AsgLst;0;0;0;1;0;0;0)
AL_SetRowOpts (xALP_AsgLst;0;1;0;0;0)
AL_SetStyle (xALP_AsgLst;0;"Tahoma";9;0)
AL_SetHdrStyle (xALP_AsgLst;0;"Tahoma";9;1)
AL_SetSortOpts (xALP_AsgLst;1;1;0;"";1)
AL_SetScroll (xALP_AsgLst;0;-3)
AL_SetSort (xALP_AsgLst;2;1)
AL_SetLine (xALP_AsgLst;0)

If (USR_IsGroupMember_by_GrpID (-15001))
	OBJECT SET VISIBLE:C603([Profesores:4]Es_Tutor:34;True:C214)
Else 
	OBJECT SET VISIBLE:C603([Profesores:4]Es_Tutor:34;False:C215)
End if 
If ([Profesores:4]Es_Tutor:34)
	SET LIST ITEM PROPERTIES:C386(hlTab_STR_profesores;3;True:C214;1;0)
Else 
	SET LIST ITEM PROPERTIES:C386(hlTab_STR_profesores;3;False:C215;1;0)
End if 

_O_DISABLE BUTTON:C193(bEliminarCarrera)
_O_DISABLE BUTTON:C193(bEliminarTitulo)