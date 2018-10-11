//%attributes = {}
  //ADTcfg_LoadSesionesEX

ARRAY LONGINT:C221(aLPST_SesionID;0)
ARRAY DATE:C224(adPst_ExamSesionsDate;0)
ARRAY INTEGER:C220(alADT_ExamAttendance;0)
ARRAY BOOLEAN:C223(abADT_ReservedPG;0)
ARRAY TEXT:C222(atADT_Place;0)
_O_ARRAY STRING:C218(80;asADT_Responsable;0)
ARRAY LONGINT:C221(alADT_Responsable_ID;0)
READ ONLY:C145([ADT_SesionesDeExamenes:123])
ALL RECORDS:C47([ADT_SesionesDeExamenes:123])
ORDER BY:C49([ADT_SesionesDeExamenes:123];[ADT_SesionesDeExamenes:123]Date_Session:2;>)
SELECTION TO ARRAY:C260([ADT_SesionesDeExamenes:123]ID:1;aLPST_SesionID;[ADT_SesionesDeExamenes:123]Date_Session:2;adPst_ExamSesionsDate;[ADT_SesionesDeExamenes:123]Attendance:4;alADT_ExamAttendance;[ADT_SesionesDeExamenes:123]ReservedPG:5;abADT_ReservedPG;[ADT_SesionesDeExamenes:123]Place:3;atADT_Place;[ADT_SesionesDeExamenes:123]ID_Responsable:7;alADT_Responsable_ID)
_O_ARRAY STRING:C218(80;asADT_Responsable;Size of array:C274(alADT_Responsable_ID))
$readOnlyState:=Read only state:C362([Profesores:4])
$rnProf:=Record number:C243([Profesores:4])
UNLOAD RECORD:C212([Profesores:4])
READ ONLY:C145([Profesores:4])
For ($i;1;Size of array:C274(alADT_Responsable_ID))
	$profesor:=Find in field:C653([Profesores:4]Numero:1;alADT_Responsable_ID{$i})
	If ($profesor#-1)
		GOTO RECORD:C242([Profesores:4];$profesor)
		asADT_Responsable{$i}:=[Profesores:4]Apellidos_y_nombres:28
	End if 
End for 
If ($readOnlyState)
	READ ONLY:C145([Profesores:4])
Else 
	READ WRITE:C146([Profesores:4])
End if 
If ($rnProf#-1)
	GOTO RECORD:C242([Profesores:4];$rnProf)
End if 