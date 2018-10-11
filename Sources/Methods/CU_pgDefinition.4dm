//%attributes = {}
  // CU_pgDefinition()
  // Por: Alberto Bachler K.: 28-02-14, 17:01:46
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_LONGINT:C283($l_idProceso)

ARRAY TEXT:C222(<>aStdWhNme;0)
ARRAY TEXT:C222(<>aStdClass;0)
ARRAY LONGINT:C221(aStdID;0)
ARRAY LONGINT:C221(aLong1;0)
ARRAY LONGINT:C221(aLong2;0)
ARRAY INTEGER:C220(<>aStdNo;0)
ARRAY TEXT:C222(aPAName;0)
_O_ARRAY STRING:C218(41;aPAProf;0)
ARRAY LONGINT:C221(aPAId;0)
_O_ARRAY STRING:C218(10;aPACurso;0)
SET WINDOW TITLE:C213(__ ("Cursos"))
vs_profesorJefe:=""
CUv_mEvVal:=False:C215
modCdt:=False:C215
vb_ModDelegados:=False:C215

$l_idProceso::=IT_UThermometer (1;0;__ ("Leyendo alumnos, asignaturas y apoderados del curso..."))
If ([Cursos:3]Numero_del_curso:6=0)
	[Cursos:3]Nivel_Numero:7:=0
	[Cursos:3]Numero_del_curso:6:=SQ_SeqNumber (->[Cursos:3]Numero_del_curso:6)
	[Cursos:3]Jornada:32:=3
	[Cursos:3]cl_CodigoTipoEnseñanza:21:=-1
	CUi_CardNo:=1
	<>CUi_CardNo:=1
	ARRAY TEXT:C222(at_OrdenAsignaturas;0)
	ARRAY TEXT:C222(aSubjectName;0)
	ARRAY TEXT:C222(aSubjectTeacher;0)
	BLOB_Variables2Blob (->[Cursos:3]Orden_Subsectores:17;0;->at_OrdenAsignaturas;->aSubjectName)
	COMPRESS BLOB:C534([Cursos:3]Orden_Subsectores:17)
Else 
	CU_LoadSubjectsAndStudents 
End if 

If (Read only state:C362([Cursos:3]))
	KRL_ReloadInReadWriteMode (->[Cursos:3])
End if 

CU_SetInputFormObjects 
CU_LoadDelegados 
$l_idProceso::=IT_UThermometer (-2;$l_idProceso:)

RELATE ONE:C42([Cursos:3]Numero_del_profesor_jefe:2)
If (([Cursos:3]cl_CodigoTipoEnseñanza:21>=410) & ([Cursos:3]cl_CodigoTipoEnseñanza:21<=861))
	OBJECT SET VISIBLE:C603(*;"especialidadTP@";True:C214)
Else 
	OBJECT SET VISIBLE:C603(*;"especialidadTP@";False:C215)
End if 

xALSet_CU_AreaAlumnos 
xALSet_CU_AreaAsignaturas 
XALSet_CU_AreaDelegados 
AL_SetLine (xALP_Delegados;0)
AL_SetEnterable (xALP_Delegados;2;3;at_CUApoderados)

_O_DISABLE BUTTON:C193(bDelDelegado)
IT_SetButtonState (((USR_checkRights ("M";->[Cursos:3])) | (<>lUSR_RelatedTableUserID=[Cursos:3]Numero_del_profesor_jefe:2));->bAddDelegado)
IT_SetButtonState (USR_checkRights ("M";->[Cursos:3]);->bBWR_SaveRecord)
MNU_SetMenuItemState (USR_checkRights ("M";->[Cursos:3]);1;5)
FORM GOTO PAGE:C247(1)
HIGHLIGHT TEXT:C210([Cursos:3]Curso:1;3;3)

